import { readFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { execSync } from "node:child_process";
import { randomBytes } from "node:crypto";

const __dirname = dirname(fileURLToPath(import.meta.url));
const rootDir = join(__dirname, "..");

const email = process.env.ADMIN_EMAIL?.trim();
const password = process.env.ADMIN_PASSWORD?.trim();
const fullName = process.env.ADMIN_FULL_NAME?.trim() || "System Administrator";
const baseUrl = (
  process.env.SUPABASE_URL ?? "http://127.0.0.1:54321"
).replace(/\/$/, "");

function usage() {
  console.error(`
Bootstrap the first production super-admin account (run once after deploy).

Required environment variables:
  ADMIN_EMAIL              Admin login email
  SUPABASE_URL             Project URL (defaults to local)
  SUPABASE_SERVICE_ROLE_KEY  Service role key (never ship to clients)

Optional:
  ADMIN_PASSWORD           Strong password (auto-generated when omitted)
  ADMIN_FULL_NAME          Display name (default: System Administrator)

Example:
  SUPABASE_URL=https://<ref>.supabase.co \\
  SUPABASE_SERVICE_ROLE_KEY=<secret> \\
  ADMIN_EMAIL=admin@your-org.com \\
  ADMIN_PASSWORD='<strong-random>' \\
  node scripts/bootstrap-production-admin.mjs
`);
}

function getServiceRoleKey() {
  if (process.env.SUPABASE_SERVICE_ROLE_KEY) {
    return process.env.SUPABASE_SERVICE_ROLE_KEY.trim();
  }

  const envCandidates = [
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

function generatePassword(length = 20) {
  const chars =
    "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789!@#$%";
  const bytes = randomBytes(length);
  return Array.from(bytes, (b) => chars[b % chars.length]).join("");
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
      user_metadata: user.metadata,
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
      user_metadata: user.metadata,
    }),
  });

  if (!response.ok) {
    const body = await response.text();
    throw new Error(body);
  }
}

async function upsertProfile(userId, user, headers) {
  const response = await fetch(`${baseUrl}/rest/v1/profiles`, {
    method: "POST",
    headers: {
      ...headers,
      Prefer: "resolution=merge-duplicates,return=minimal",
    },
    body: JSON.stringify({
      id: userId,
      full_name: user.metadata.full_name,
      role: "admin",
      email: user.email,
      can_manage_admins: true,
      operator_permissions: null,
      is_active: true,
    }),
  });

  if (!response.ok) {
    const text = await response.text();
    throw new Error(`Profile upsert failed: ${text}`);
  }
}

if (!email) {
  usage();
  process.exit(1);
}

const key = getServiceRoleKey();
if (!key) {
  console.error(
    "Could not read SERVICE_ROLE_KEY. Set SUPABASE_SERVICE_ROLE_KEY or run supabase status -o env",
  );
  process.exit(1);
}

const resolvedPassword = password || generatePassword();
const user = {
  email,
  password: resolvedPassword,
  metadata: {
    role: "admin",
    full_name: fullName,
    can_manage_admins: true,
  },
};

const headers = {
  apikey: key,
  Authorization: `Bearer ${key}`,
  "Content-Type": "application/json; charset=utf-8",
};

const existing = (await listUsers(headers)).find(
  (entry) => entry.email?.toLowerCase() === email.toLowerCase(),
);

try {
  if (existing?.id) {
    await updateUser(existing.id, user, headers);
    await upsertProfile(existing.id, user, headers);
    console.log(`Updated super-admin ${email}`);
  } else {
    await createUser(user, headers);
    const created = (await listUsers(headers)).find(
      (entry) => entry.email?.toLowerCase() === email.toLowerCase(),
    );
    if (!created?.id) {
      throw new Error(`Created user not found: ${email}`);
    }
    await upsertProfile(created.id, user, headers);
    console.log(`Created super-admin ${email}`);
  }
} catch (error) {
  console.error(`Bootstrap failed: ${String(error?.message ?? error)}`);
  process.exit(1);
}

console.log("");
console.log("Super-admin credentials (store securely, share out-of-band):");
console.log(`  Email:    ${email}`);
console.log(`  Password: ${resolvedPassword}`);
console.log("");
console.log(
  "This account can promote operators to admin. Promoted admins cannot promote others.",
);
