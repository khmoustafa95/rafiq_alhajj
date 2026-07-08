#!/usr/bin/env node
/**
 * Verifies staging store-readiness configuration (dart-defines + edge fn sources).
 *
 * Usage:
 *   node scripts/verify-staging-store-setup.mjs
 */
import { existsSync, readFileSync } from "node:fs";
import { join } from "node:path";
import { fileURLToPath } from "node:url";
import {
  STAGING_LEGAL_URLS,
  STORE_EDGE_FUNCTIONS,
} from "./legal-urls.mjs";

const rootDir = join(fileURLToPath(new URL(".", import.meta.url)), "..");

let errors = 0;
let warnings = 0;

function error(message) {
  console.error(`ERROR: ${message}`);
  errors += 1;
}

function warn(message) {
  console.warn(`WARN: ${message}`);
  warnings += 1;
}

function ok(message) {
  console.log(`OK: ${message}`);
}

// 1. Legal web source files
for (const file of [
  "web/legal/privacy.html",
  "web/legal/terms.html",
  "web/legal/account-deletion.html",
]) {
  const path = join(rootDir, file);
  if (existsSync(path)) {
    ok(`source ${file}`);
  } else {
    error(`missing source ${file}`);
  }
}

// 2. Edge function sources
for (const fn of STORE_EDGE_FUNCTIONS) {
  const path = join(rootDir, "supabase/functions", fn, "index.ts");
  if (existsSync(path)) {
    ok(`edge fn source ${fn}`);
  } else {
    error(`missing edge fn ${fn}`);
  }
}

// 3. Staging example dart-defines include legal URLs
for (const platform of ["web", "android", "ios"]) {
  const examplePath = join(
    rootDir,
    "config/dart-defines",
    `${platform}.staging.example.json`,
  );
  if (!existsSync(examplePath)) {
    warn(`no ${platform}.staging.example.json`);
    continue;
  }
  const json = JSON.parse(readFileSync(examplePath, "utf8"));
  for (const [key, expected] of Object.entries(STAGING_LEGAL_URLS)) {
    if (json[key] !== expected) {
      warn(
        `${platform}.staging.example.json: ${key} should be ${expected} (got ${json[key] ?? "missing"})`,
      );
    } else {
      ok(`${platform}.staging.example.json ${key}`);
    }
  }
}

// 4. Optional secret files — warn if legal URLs missing when file exists
for (const platform of ["web", "android", "ios"]) {
  const secretPath = join(
    rootDir,
    "config/dart-defines",
    `${platform}.staging.json`,
  );
  if (!existsSync(secretPath)) {
    warn(`no secret ${platform}.staging.json (run npm run config:bootstrap)`);
    continue;
  }
  const json = JSON.parse(readFileSync(secretPath, "utf8"));
  for (const key of Object.keys(STAGING_LEGAL_URLS)) {
    if (!json[key]) {
      warn(`${platform}.staging.json missing ${key} — re-run bootstrap or copy from example`);
    }
  }
}

console.log("");
if (errors > 0) {
  console.error(`Failed: ${errors} error(s), ${warnings} warning(s)`);
  process.exit(1);
}

console.log(`Passed with ${warnings} warning(s).`);
if (warnings > 0) {
  console.log("Fix warnings before staging smoke test (legal links in dart-defines).");
}
