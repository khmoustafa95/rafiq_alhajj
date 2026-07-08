#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEFINES="${1:-$ROOT/config/dart-defines/android.production.json}"

if [[ ! -f "$DEFINES" ]]; then
  echo "Missing $DEFINES — copy from config/dart-defines/android.production.example.json"
  exit 1
fi

if [[ ! -f "$ROOT/android/key.properties" ]]; then
  echo "Missing android/key.properties — copy from android/key.properties.example and create upload keystore."
  exit 1
fi

if [[ ! -f "$ROOT/android/app/google-services.json" ]]; then
  echo "Missing android/app/google-services.json — download from Firebase Console for com.rafiqalhajj.app"
  exit 1
fi

cd "$ROOT"
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter pub run flutter_launcher_icons

flutter build appbundle --release --dart-define-from-file="$DEFINES"
echo "AAB: build/app/outputs/bundle/release/app-release.aab"
