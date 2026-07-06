import { readFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const rootDir = join(dirname(fileURLToPath(import.meta.url)), "..");
const pubspec = readFileSync(join(rootDir, "pubspec.yaml"), "utf8");
const match = pubspec.match(/^version:\s*([0-9]+\.[0-9]+\.[0-9]+)\+(\d+)/m);

if (!match) {
  console.error("Could not parse version from pubspec.yaml");
  process.exit(1);
}

const [, versionName, buildNumber] = match;
if (process.argv.includes("--build-number")) {
  process.stdout.write(buildNumber);
} else {
  process.stdout.write(versionName);
}
