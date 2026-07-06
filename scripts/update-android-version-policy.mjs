/**
 * Syncs app_version_policies.android.latest_version to pubspec.yaml after a release.
 * Optionally sets store_url from ANDROID_DISTRIBUTION_INSTALL_URL.
 *
 * Requires SUPABASE_URL + SUPABASE_SERVICE_ROLE_KEY (same as seed-demo-users).
 */
import { readFileSync, existsSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { execSync } from "node:child_process";

const __dirname = dirname(fileURLToPath(import.meta.url));
const rootDir = join(__dirname, "..");

function readPubspecVersion() {
  return execSync("node ./scripts/read-pubspec-version.mjs", {
    cwd: rootDir,
    encoding: "utf8",
  }).trim();
}

function resolveServiceRoleKey() {
  if (process.env.SUPABASE_SERVICE_ROLE_KEY?.trim()) {
    return process.env.SUPABASE_SERVICE_ROLE_KEY.trim();
  }

  for (const relative of [".env.local", "supabase/.env"]) {
    const path = join(rootDir, relative);
    if (!existsSync(path)) continue;
    const text = readFileSync(path, "utf8");
    for (const line of text.split(/\r?\n/)) {
      const match = line.match(
        /^(SERVICE_ROLE_KEY|SUPABASE_SERVICE_ROLE_KEY)=(.+)$/,
      );
      if (match) {
        return match[2].trim().replace(/^["']|["']$/g, "");
      }
    }
  }

  return null;
}

function resolveSupabaseUrl() {
  if (process.env.SUPABASE_URL?.trim()) {
    return process.env.SUPABASE_URL.trim().replace(/\/$/, "");
  }

  for (const relative of [
    "config/dart-defines/web.staging.json",
    "config/dart-defines/android.staging.json",
    "dart_defines.staging.local.json",
    "dart_defines.android.staging.local.json",
    "dart_defines.staging.json",
  ]) {
    const path = join(rootDir, relative);
    if (!existsSync(path)) continue;
    const json = JSON.parse(readFileSync(path, "utf8"));
    if (json.SUPABASE_URL) {
      return json.SUPABASE_URL.replace(/\/$/, "");
    }
  }

  return null;
}

const supabaseUrl = resolveSupabaseUrl();
const serviceRoleKey = resolveServiceRoleKey();

if (!supabaseUrl || !serviceRoleKey) {
  console.error(
    "Set SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY to sync android version policy.",
  );
  process.exit(1);
}

const latestVersion = readPubspecVersion();
const storeUrl = (
  process.env.ANDROID_DISTRIBUTION_INSTALL_URL ??
  process.argv[2] ??
  ""
).trim();

const payload = {
  platform: "android",
  min_version: process.env.ANDROID_MIN_VERSION?.trim() || undefined,
  latest_version: latestVersion,
  updated_at: new Date().toISOString(),
};

if (storeUrl) {
  payload.store_url = storeUrl;
}

const body = Object.fromEntries(
  Object.entries(payload).filter(([, value]) => value !== undefined),
);

const response = await fetch(
  `${supabaseUrl}/rest/v1/app_version_policies?on_conflict=platform`,
  {
    method: "POST",
    headers: {
      apikey: serviceRoleKey,
      Authorization: `Bearer ${serviceRoleKey}`,
      "Content-Type": "application/json",
      Prefer: "resolution=merge-duplicates,return=representation",
    },
    body: JSON.stringify(body),
  },
);

if (!response.ok) {
  const text = await response.text();
  console.error(`Failed to update app_version_policies: ${response.status} ${text}`);
  process.exit(1);
}

const rows = await response.json();
const row = Array.isArray(rows) ? rows[0] : rows;
console.log(
  `Updated android version policy → latest_version=${row.latest_version}` +
    (row.store_url ? `, store_url=${row.store_url}` : ""),
);
