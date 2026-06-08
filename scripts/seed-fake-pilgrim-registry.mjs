import { readFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";
import { execSync } from "node:child_process";

const __dirname = dirname(fileURLToPath(import.meta.url));
const registryFile = join(__dirname, "fake-pilgrim-registry.json");

/**
 * Upserts varied demo pilgrim_details for field-operator / analytics testing.
 * Requires auth users + profiles to exist (run after seed-demo-users.mjs).
 */
export async function seedFakePilgrimRegistry(headers, baseUrl) {
  const entries = JSON.parse(readFileSync(registryFile, "utf8"));

  const usersResponse = await fetch(`${baseUrl}/auth/v1/admin/users`, {
    headers,
  });
  if (!usersResponse.ok) {
    throw new Error(`Failed to list users: ${usersResponse.status}`);
  }

  const usersByEmail = new Map(
    (await usersResponse.json()).users.map((user) => [user.email, user]),
  );

  let seeded = 0;
  let skipped = 0;

  for (const entry of entries) {
    const user = usersByEmail.get(entry.email);
    if (!user?.id) {
      console.warn(`Skip registry (no auth user): ${entry.email}`);
      skipped++;
      continue;
    }

    const profileId = user.id;

    if (entry.group_id) {
      const groupResponse = await fetch(
        `${baseUrl}/rest/v1/profiles?id=eq.${profileId}`,
        {
          method: "PATCH",
          headers: {
            ...headers,
            Prefer: "return=minimal",
          },
          body: JSON.stringify({ group_id: entry.group_id }),
        },
      );
      if (!groupResponse.ok) {
        const body = await groupResponse.text();
        throw new Error(`Group update failed for ${entry.email}: ${body}`);
      }
    }

    const payload = {
      profile_id: profileId,
      ...entry.registry,
      updated_at: new Date().toISOString(),
    };

    const upsertResponse = await fetch(
      `${baseUrl}/rest/v1/pilgrim_details?on_conflict=profile_id`,
      {
        method: "POST",
        headers: {
          ...headers,
          Prefer: "resolution=merge-duplicates,return=minimal",
        },
        body: JSON.stringify(payload),
      },
    );

    if (!upsertResponse.ok) {
      const body = await upsertResponse.text();
      throw new Error(`Registry upsert failed for ${entry.email}: ${body}`);
    }

    const status = entry.registry.field_status ?? "unknown";
    console.log(`Registry: ${entry.email} [${status}]`);
    seeded++;
  }

  console.log("");
  console.log(
    `Fake pilgrim registry: ${seeded} upserted` +
      (skipped ? `, ${skipped} skipped (create users first)` : ""),
  );
}

function getServiceRoleKey() {
  const rootDir = join(__dirname, "..");
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
    for (const pattern of [
      /SERVICE_ROLE_KEY="([^"]+)"/,
      /SERVICE_ROLE_KEY='([^']+)'/,
      /SERVICE_ROLE_KEY=([^\s\r\n]+)/,
      /SECRET_KEY="([^"]+)"/,
    ]) {
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

const isMain =
  process.argv[1] &&
  import.meta.url === pathToFileURL(process.argv[1]).href;

if (isMain) {
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

  await seedFakePilgrimRegistry(headers, "http://127.0.0.1:54321");
}
