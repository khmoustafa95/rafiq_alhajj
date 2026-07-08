import { readFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { execSync } from "node:child_process";
import {
  applyStagingEnvToProcess,
  stagingEnvPath,
} from "./load-staging-env.mjs";

const __dirname = dirname(fileURLToPath(import.meta.url));
const rootDir = join(__dirname, "..");
const usersFile = join(__dirname, "seed-demo-users.json");

applyStagingEnvToProcess();

const baseUrl = (
  process.env.SUPABASE_URL ?? "http://127.0.0.1:54321"
).replace(/\/$/, "");

function getServiceRoleKey() {
  if (process.env.SUPABASE_SERVICE_ROLE_KEY) {
    return process.env.SUPABASE_SERVICE_ROLE_KEY.trim();
  }

  const envCandidates = [
    stagingEnvPath,
    join(rootDir, ".env.local"),
    join(rootDir, "supabase", ".env"),
  ];

  for (const envPath of envCandidates) {
    try {
      const text = readFileSync(envPath, "utf8");
      for (const line of text.split(/\r?\n/)) {
        const match = line.match(
          /^(SERVICE_ROLE_KEY|SUPABASE_SERVICE_ROLE_KEY)=(.+)$/,
        );
        if (match) {
          return match[2].trim().replace(/^["']|["']$/g, "");
        }
      }
    } catch {
      // try next file
    }
  }

  try {
    const status = execSync("supabase status -o env", {
      cwd: rootDir,
      encoding: "utf8",
      stdio: ["ignore", "pipe", "pipe"],
    });
    const patterns = [
      /SERVICE_ROLE_KEY="([^"]+)"/,
      /SERVICE_ROLE_KEY='([^']+)'/,
      /SERVICE_ROLE_KEY=([^\s\r\n]+)/,
      /SECRET_KEY="([^"]+)"/,
    ];
    for (const pattern of patterns) {
      const match = status.match(pattern);
      if (match) {
        return match[1];
      }
    }
  } catch {
    // fall through
  }

  return null;
}

async function listUsers(headers) {
  const response = await fetch(`${baseUrl}/auth/v1/admin/users`, { headers });
  if (!response.ok) {
    throw new Error(`Failed to list users: ${response.status}`);
  }
  const data = await response.json();
  return data.users ?? [];
}

async function createUser(user, headers) {
  const response = await fetch(`${baseUrl}/auth/v1/admin/users`, {
    method: "POST",
    headers,
    body: JSON.stringify({
      email: user.email,
      password: user.password,
      email_confirm: true,
      user_metadata: {
        ...user.metadata,
        ...(user.metadata?.role === "admin"
          ? { can_manage_admins: true }
          : {}),
      },
    }),
  });

  if (!response.ok) {
    const body = await response.text();
    throw new Error(body);
  }
}

async function updateUser(userId, user, headers) {
  const response = await fetch(`${baseUrl}/auth/v1/admin/users/${userId}`, {
    method: "PUT",
    headers,
    body: JSON.stringify({
      password: user.password,
      email_confirm: true,
      user_metadata: {
        ...user.metadata,
        ...(user.metadata?.role === "admin"
          ? { can_manage_admins: true }
          : {}),
      },
    }),
  });

  if (!response.ok) {
    const body = await response.text();
    throw new Error(body);
  }
}

async function upsertProfile(userId, user, headers) {
  const fullName = user.metadata?.full_name ?? user.email;
  const role = user.metadata?.role ?? "pilgrim";
  const body = {
    id: userId,
    full_name: fullName,
    role,
    email: user.email,
    can_manage_admins: role === "admin",
  };

  if (role === "operator") {
    body.operator_permissions = user.metadata?.operator_permissions ?? {
      can_register_pilgrims: true,
      can_manage_pilgrim_registry: true,
      can_use_field_tools: true,
      can_upload_documents: true,
    };
  }

  const response = await fetch(`${baseUrl}/rest/v1/profiles`, {
    method: "POST",
    headers: {
      ...headers,
      Prefer: "resolution=merge-duplicates,return=minimal",
    },
    body: JSON.stringify(body),
  });

  if (!response.ok) {
    const text = await response.text();
    throw new Error(`Profile upsert failed for ${user.email}: ${text}`);
  }
}

const key = getServiceRoleKey();
if (!key) {
  console.error(
    "Could not read SERVICE_ROLE_KEY. Run: supabase status -o env",
  );
  process.exit(1);
}

const headers = {
  apikey: key,
  Authorization: `Bearer ${key}`,
  "Content-Type": "application/json; charset=utf-8",
};

const users = JSON.parse(readFileSync(usersFile, "utf8"));
const existingByEmail = new Map(
  (await listUsers(headers)).map((user) => [user.email, user]),
);

for (const user of users) {
  const fullName = user.metadata?.full_name ?? "";
  const existing = existingByEmail.get(user.email);

  try {
    if (existing) {
      await updateUser(existing.id, user, headers);
      await upsertProfile(existing.id, user, headers);
      console.log(`Updated ${user.email} (${fullName})`);
      continue;
    }

    await createUser(user, headers);
    const created = (await listUsers(headers)).find(
      (entry) => entry.email === user.email,
    );
    if (!created?.id) {
      throw new Error(`Created user not found: ${user.email}`);
    }
    await upsertProfile(created.id, user, headers);
    console.log(`Created ${user.email} (${fullName})`);
  } catch (error) {
    const message = String(error?.message ?? error);
    if (/already|duplicate|exists/i.test(message)) {
      console.log(`Exists: ${user.email}`);
      const fallback = existing ?? (await listUsers(headers)).find(
        (entry) => entry.email === user.email,
      );
      if (fallback?.id) {
        try {
          await upsertProfile(fallback.id, user, headers);
        } catch (profileError) {
          console.warn(`Failed profile fix for ${user.email}: ${profileError}`);
        }
      }
    } else {
      console.warn(`Failed ${user.email}: ${message}`);
    }
  }
}

console.log("");
console.log("Demo password for all accounts: demo123456");
console.log("Pilgrim logins: pilgrim@demo.local … pilgrim12@demo.local");
console.log("Operator login: operator@demo.local");
console.log("Admin login: admin@demo.local");
console.log(
  "Note: pilgrim/trip demo data is seeded by supabase/seed.sql (Arabic).",
);
