import { readFileSync, existsSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const rootDir = join(dirname(fileURLToPath(import.meta.url)), "..");

if (process.env.FIREBASE_ANDROID_APP_ID?.trim()) {
  process.stdout.write(process.env.FIREBASE_ANDROID_APP_ID.trim());
  process.exit(0);
}

const googleServicesPath = join(rootDir, "android", "app", "google-services.json");
if (!existsSync(googleServicesPath)) {
  console.error(
    "Missing android/app/google-services.json and FIREBASE_ANDROID_APP_ID env var.",
  );
  process.exit(1);
}

const config = JSON.parse(readFileSync(googleServicesPath, "utf8"));
const clients = config.client ?? [];
const androidClient = clients.find(
  (entry) => entry.client_info?.android_client_info,
);

const appId = androidClient?.client_info?.mobilesdk_app_id;
if (!appId) {
  console.error("Could not find Android mobilesdk_app_id in google-services.json");
  process.exit(1);
}

process.stdout.write(appId);
