/**
 * Creates secret dart-defines files from templates when they do not exist yet.
 * Also migrates legacy root-level dart_defines*.json files into config/dart-defines/.
 */
import { copyFileSync, existsSync, mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { resolveDartDefinesPath } from "./resolve-dart-defines.mjs";
import { STAGING_LEGAL_URLS } from "./legal-urls.mjs";

const __dirname = dirname(fileURLToPath(import.meta.url));
const rootDir = join(__dirname, "..");
const configDir = join(rootDir, "config", "dart-defines");

const MATRIX = [
  ["web", "local"],
  ["web", "staging"],
  ["web", "production"],
  ["android", "local"],
  ["android-device", "local"],
  ["android", "staging"],
  ["android", "production"],
  ["ios", "local"],
  ["ios", "staging"],
  ["ios", "production"],
];

/** @type {Record<string, string[]>} */
const MIGRATION_SOURCES = {
  "web.local": ["dart_defines.local.json"],
  "web.staging": ["dart_defines.staging.local.json", "dart_defines.staging.json"],
  "android.local": ["dart_defines.android.local.json"],
  "android-device.local": ["dart_defines.device.local.json"],
  "android.staging": ["dart_defines.android.staging.local.json"],
};

function mergeJson(base, overlay) {
  return { ...base, ...overlay };
}

function loadJson(path) {
  return JSON.parse(readFileSync(path, "utf8"));
}

function migrateLegacy(platform, environment) {
  const target = join(configDir, `${platform}.${environment}.json`);
  if (existsSync(target)) {
    return false;
  }

  const sources = MIGRATION_SOURCES[`${platform}.${environment}`] ?? [];
  let merged = null;

  for (const relative of sources) {
    const sourcePath = join(rootDir, relative);
    if (!existsSync(sourcePath)) continue;
    merged = merged ? mergeJson(merged, loadJson(sourcePath)) : loadJson(sourcePath);
  }

  if (!merged) {
    return false;
  }

  if (!merged.APP_ENV) {
    merged.APP_ENV = environment;
  }
  if (!merged.APP_PLATFORM) {
    merged.APP_PLATFORM = platform;
  }

  writeFileSync(target, `${JSON.stringify(merged, null, 2)}\n`, "utf8");
  console.log(`Migrated → config/dart-defines/${platform}.${environment}.json`);
  return true;
}

function healAndroidStagingFromWeb() {
  const androidPath = join(configDir, "android.staging.json");
  const webPath = join(configDir, "web.staging.json");
  if (!existsSync(androidPath) || !existsSync(webPath)) return;

  const android = loadJson(androidPath);
  const web = loadJson(webPath);
  let changed = false;

  const sharedKeys = [
    "SUPABASE_URL",
    "SUPABASE_ANON_KEY",
    "CRASH_REPORTING_ENABLED",
    "FIREBASE_PROJECT_ID",
    "FIREBASE_API_KEY",
    "FIREBASE_MESSAGING_SENDER_ID",
  ];

  for (const key of sharedKeys) {
    const value = android[key];
    const placeholder =
      value === undefined ||
      value === "" ||
      String(value).startsWith("your-") ||
      String(value).includes("xxxxxxxx");
    if (placeholder && web[key]) {
      android[key] = web[key];
      changed = true;
    }
  }

  if (changed) {
    writeFileSync(androidPath, `${JSON.stringify(android, null, 2)}\n`, "utf8");
    console.log("Healed android.staging.json from web.staging.json (shared Supabase/Firebase fields).");
  }
}

function healStagingLegalUrls() {
  for (const platform of ["web", "android", "ios"]) {
    const secretPath = join(configDir, `${platform}.staging.json`);
    if (!existsSync(secretPath)) continue;

    const json = loadJson(secretPath);
    let changed = false;

    for (const [key, value] of Object.entries(STAGING_LEGAL_URLS)) {
      if (!json[key]) {
        json[key] = value;
        changed = true;
      }
    }

    if (changed) {
      writeFileSync(secretPath, `${JSON.stringify(json, null, 2)}\n`, "utf8");
      console.log(`Added staging legal URLs → ${platform}.staging.json`);
    }
  }
}

mkdirSync(configDir, { recursive: true });

let created = 0;
let migrated = 0;

for (const [platform, environment] of MATRIX) {
  if (migrateLegacy(platform, environment)) {
    migrated += 1;
    continue;
  }

  const secretPath = join(configDir, `${platform}.${environment}.json`);
  const examplePath = join(configDir, `${platform}.${environment}.example.json`);

  if (existsSync(secretPath)) {
    continue;
  }

  if (!existsSync(examplePath)) {
    console.warn(`Skip ${platform}.${environment}: no example template.`);
    continue;
  }

  copyFileSync(examplePath, secretPath);
  console.log(`Created config/dart-defines/${platform}.${environment}.json from template.`);
  created += 1;
}

healAndroidStagingFromWeb();
healStagingLegalUrls();

const stagingEnvExample = join(rootDir, "config", ".env.staging.example");
const stagingEnvSecret = join(rootDir, "config", ".env.staging.local");
if (!existsSync(stagingEnvSecret) && existsSync(stagingEnvExample)) {
  copyFileSync(stagingEnvExample, stagingEnvSecret);
  console.log("Created config/.env.staging.local from template.");
}

console.log("");
console.log(`Bootstrap complete. migrated=${migrated}, created=${created}`);
console.log("Edit secrets in config/dart-defines/*.json (never commit them).");
console.log("For staging CLI scripts, edit config/.env.staging.local (never commit).");
