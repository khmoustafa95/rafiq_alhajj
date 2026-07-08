/**
 * Resolves the dart-defines JSON file for a platform + environment pair.
 *
 * Convention (enterprise layout):
 *   config/dart-defines/{platform}.{environment}.json        — secrets (gitignored)
 *   config/dart-defines/{platform}.{environment}.example.json — committed template
 *
 * Usage:
 *   node scripts/resolve-dart-defines.mjs <platform> <environment>
 *   node scripts/resolve-dart-defines.mjs web local --example
 *
 * Platforms:   web | android | android-device | ios
 * Environments: local | staging | production
 */
import { existsSync, readFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const rootDir = join(__dirname, "..");
const configDir = join(rootDir, "config", "dart-defines");

/** @type {Record<string, string[]>} */
const LEGACY_PATHS = {
  "web.local": ["dart_defines.web.local.json", "dart_defines.local.json"],
  "web.staging": ["dart_defines.web.staging.json", "dart_defines.staging.json", "dart_defines.staging.local.json"],
  "web.production": ["dart_defines.web.production.json", "dart_defines.production.json"],
  "android.local": ["dart_defines.android.local.json"],
  "android-device.local": [
    "dart_defines.android-device.local.json",
    "dart_defines.device.local.json",
  ],
  "android.staging": [
    "dart_defines.android.staging.json",
    "dart_defines.android.staging.local.json",
  ],
  "android.production": ["dart_defines.android.production.json"],
  "ios.local": ["dart_defines.ios.local.json"],
  "ios.staging": ["dart_defines.ios.staging.json"],
  "ios.production": ["dart_defines.ios.production.json"],
};

const VALID_PLATFORMS = new Set(["web", "android", "android-device", "ios"]);
const VALID_ENVIRONMENTS = new Set(["local", "staging", "production"]);

function canonicalPath(platform, environment, example = false) {
  const suffix = example ? ".example.json" : ".json";
  return join(configDir, `${platform}.${environment}${suffix}`);
}

function legacyCandidates(platform, environment) {
  const key = `${platform}.${environment}`;
  const relativePaths = LEGACY_PATHS[key] ?? [];
  return relativePaths.map((relative) => join(rootDir, relative));
}

export function resolveDartDefinesPath(platform, environment, options = {}) {
  const { example = false, allowMissing = false } = options;

  if (!VALID_PLATFORMS.has(platform)) {
    throw new Error(`Unknown platform "${platform}". Use: ${[...VALID_PLATFORMS].join(", ")}`);
  }
  if (!VALID_ENVIRONMENTS.has(environment)) {
    throw new Error(
      `Unknown environment "${environment}". Use: ${[...VALID_ENVIRONMENTS].join(", ")}`,
    );
  }

  const candidates = [
    canonicalPath(platform, environment, example),
    ...legacyCandidates(platform, environment),
  ];

  for (const path of candidates) {
    if (existsSync(path)) {
      return path;
    }
  }

  if (allowMissing) {
    return canonicalPath(platform, environment, example);
  }

  const template = canonicalPath(platform, environment, true);
  throw new Error(
    `Missing dart-defines for ${platform}/${environment}.\n` +
      `  Expected: ${canonicalPath(platform, environment)}\n` +
      `  Template: ${template}\n` +
      `  Run: npm run config:bootstrap`,
  );
}

function validateDefines(platform, environment, filePath) {
  const json = JSON.parse(readFileSync(filePath, "utf8"));

  if (!json.SUPABASE_URL || !json.SUPABASE_ANON_KEY) {
    throw new Error(`${filePath} is missing SUPABASE_URL or SUPABASE_ANON_KEY.`);
  }

  if (platform === "web" && environment !== "local") {
    if (!json.FIREBASE_WEB_APP_ID) {
      console.warn(`Warning: ${filePath} has no FIREBASE_WEB_APP_ID (web push disabled).`);
    }
  }

  if ((platform === "android" || platform === "android-device") && environment !== "local") {
    if (!json.FIREBASE_APP_ID || String(json.FIREBASE_APP_ID).includes(":web:")) {
      throw new Error(
        `${filePath} needs FIREBASE_APP_ID with an Android id (1:...:android:...).`,
      );
    }
  }

  if (environment === "staging" || environment === "production") {
    for (const key of [
      "PRIVACY_POLICY_URL",
      "TERMS_OF_SERVICE_URL",
      "ACCOUNT_DELETION_INFO_URL",
    ]) {
      if (!json[key]) {
        console.warn(`Warning: ${filePath} has no ${key} (store legal links disabled in app).`);
      }
    }
  }

  return json;
}

const platform = process.argv[2];
const environment = process.argv[3];
const flags = new Set(process.argv.slice(4));
const example = flags.has("--example");

const isCli = Boolean(process.argv[1]?.includes("resolve-dart-defines.mjs"));

if (!isCli) {
  // Imported as a module — skip CLI handling.
} else if (!platform || !environment) {
  console.error(
    "Usage: node scripts/resolve-dart-defines.mjs <platform> <environment> [--example]",
  );
  process.exit(1);
} else {
  try {
    const path = resolveDartDefinesPath(platform, environment, { example });
    if (!example && !flags.has("--no-validate")) {
      validateDefines(platform, environment, path);
    }
    process.stdout.write(path);
  } catch (error) {
    console.error(error instanceof Error ? error.message : error);
    process.exit(1);
  }
}
