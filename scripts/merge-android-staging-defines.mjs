/**
 * @deprecated Use resolve-dart-defines.mjs directly.
 * Copies android.staging defines to argv[2] when provided.
 */
import { copyFileSync } from "node:fs";
import { spawnSync } from "node:child_process";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const rootDir = join(dirname(fileURLToPath(import.meta.url)), "..");
const outputPath = process.argv[2];

const result = spawnSync(
  "node",
  ["./scripts/resolve-dart-defines.mjs", "android", "staging"],
  { cwd: rootDir, encoding: "utf8" },
);

if (result.status !== 0) {
  process.stderr.write(result.stderr || result.stdout);
  process.exit(result.status ?? 1);
}

const sourcePath = result.stdout.trim();

if (outputPath) {
  copyFileSync(sourcePath, outputPath);
} else {
  process.stdout.write(sourcePath);
}
