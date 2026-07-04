/**
 * Copies Firebase web client config from dart-defines into the built service
 * worker so FCM Web Push works on staging/production hosting.
 *
 * Usage:
 *   node scripts/patch-firebase-sw.mjs dart_defines.staging.json build/web/firebase-messaging-sw.js
 */

import { readFileSync, writeFileSync } from "node:fs";

const definesPath = process.argv[2];
const swPath = process.argv[3] ?? "web/firebase-messaging-sw.js";

if (!definesPath) {
  console.error(
    "Usage: node scripts/patch-firebase-sw.mjs <dart-defines.json> [service-worker.js]",
  );
  process.exit(1);
}

const defines = JSON.parse(readFileSync(definesPath, "utf8"));

const apiKey = defines.FIREBASE_API_KEY ?? "";
const authDomain = defines.FIREBASE_AUTH_DOMAIN ?? "";
const projectId = defines.FIREBASE_PROJECT_ID ?? "";
const storageBucket = defines.FIREBASE_STORAGE_BUCKET ?? "";
const messagingSenderId = defines.FIREBASE_MESSAGING_SENDER_ID ?? "";
const appId = defines.FIREBASE_WEB_APP_ID ?? defines.FIREBASE_APP_ID ?? "";

const required = [
  ["FIREBASE_API_KEY", apiKey],
  ["FIREBASE_AUTH_DOMAIN", authDomain],
  ["FIREBASE_PROJECT_ID", projectId],
  ["FIREBASE_STORAGE_BUCKET", storageBucket],
  ["FIREBASE_MESSAGING_SENDER_ID", messagingSenderId],
  ["FIREBASE_WEB_APP_ID or FIREBASE_APP_ID", appId],
];

const missing = required.filter(([, value]) => !value).map(([name]) => name);
if (missing.length > 0) {
  console.log(
    `Skipping service worker patch (missing: ${missing.join(", ")}). Web push stays disabled.`,
  );
  process.exit(0);
}

let sw = readFileSync(swPath, "utf8");

const block = `firebase.initializeApp({
  apiKey: '${apiKey}',
  authDomain: '${authDomain}',
  projectId: '${projectId}',
  storageBucket: '${storageBucket}',
  messagingSenderId: '${messagingSenderId}',
  appId: '${appId}',
});`;

sw = sw.replace(/firebase\.initializeApp\(\{[\s\S]*?\}\);/, block);
writeFileSync(swPath, sw, "utf8");
console.log(`Patched Firebase config in ${swPath}`);
