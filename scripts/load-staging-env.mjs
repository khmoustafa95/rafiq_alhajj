import { existsSync, readFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const rootDir = join(__dirname, "..");

export const stagingEnvPath = join(rootDir, "config", ".env.staging.local");

/** @param {string} text */
export function parseEnvFile(text) {
  /** @type {Record<string, string>} */
  const result = {};
  for (const line of text.split(/\r?\n/)) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith("#")) continue;
    const eq = trimmed.indexOf("=");
    if (eq === -1) continue;
    const key = trimmed.slice(0, eq).trim();
    let value = trimmed.slice(eq + 1).trim();
    if (
      (value.startsWith('"') && value.endsWith('"')) ||
      (value.startsWith("'") && value.endsWith("'"))
    ) {
      value = value.slice(1, -1);
    }
    if (value) result[key] = value;
  }
  return result;
}

/** @param {string | undefined} url */
export function deriveProjectRefFromUrl(url) {
  const match = url?.match(/https:\/\/([^.]+)\.supabase\.co/i);
  return match?.[1] ?? null;
}

/** @returns {Record<string, string>} */
export function loadStagingEnv() {
  /** @type {Record<string, string>} */
  const env = {};

  if (existsSync(stagingEnvPath)) {
    Object.assign(env, parseEnvFile(readFileSync(stagingEnvPath, "utf8")));
  }

  const webStagingPath = join(
    rootDir,
    "config",
    "dart-defines",
    "web.staging.json",
  );
  if (existsSync(webStagingPath)) {
    try {
      const json = JSON.parse(readFileSync(webStagingPath, "utf8"));
      if (!env.SUPABASE_URL && json.SUPABASE_URL) {
        env.SUPABASE_URL = String(json.SUPABASE_URL).replace(/\/$/, "");
      }
      if (!env.SUPABASE_PROJECT_REF && env.SUPABASE_URL) {
        const ref = deriveProjectRefFromUrl(env.SUPABASE_URL);
        if (ref) env.SUPABASE_PROJECT_REF = ref;
      }
    } catch {
      // ignore invalid JSON
    }
  }

  if (!env.SUPABASE_URL && env.SUPABASE_PROJECT_REF) {
    env.SUPABASE_URL = `https://${env.SUPABASE_PROJECT_REF}.supabase.co`;
  }

  return env;
}

/**
 * Fills process.env from staging config when a key is not already set.
 * @returns {Record<string, string>}
 */
export function applyStagingEnvToProcess() {
  const env = loadStagingEnv();
  for (const [key, value] of Object.entries(env)) {
    if (!process.env[key]?.trim()) {
      process.env[key] = value;
    }
  }
  return env;
}
