#!/usr/bin/env node
/**
 * Verifies legal HTML pages are present in a Flutter web build output.
 *
 * Usage:
 *   node scripts/verify-legal-build.mjs [buildDir]
 */
import { existsSync } from "node:fs";
import { join } from "node:path";

const buildDir = process.argv[2] ?? join(process.cwd(), "build", "web");
const required = [
  "legal/privacy.html",
  "legal/terms.html",
  "legal/account-deletion.html",
];

let missing = 0;
for (const relative of required) {
  const path = join(buildDir, relative);
  if (!existsSync(path)) {
    console.error(`Missing: ${path}`);
    missing += 1;
  } else {
    console.log(`OK: ${relative}`);
  }
}

if (missing > 0) {
  console.error(`\n${missing} legal page(s) missing under ${buildDir}`);
  process.exit(1);
}

console.log(`\nAll ${required.length} legal pages present in ${buildDir}`);
