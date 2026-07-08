#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEFINES="${1:-$ROOT/config/dart-defines/ios.production.json}"

if [[ ! -f "$DEFINES" ]]; then
  echo "Missing $DEFINES — copy from config/dart-defines/ios.production.example.json"
  exit 1
fi

if [[ ! -f "$ROOT/ios/Runner/GoogleService-Info.plist" ]]; then
  echo "Missing ios/Runner/GoogleService-Info.plist — download from Firebase Console for com.rafiqalhajj.app"
  exit 1
fi

cd "$ROOT"
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter pub run flutter_launcher_icons

flutter build ipa --release --dart-define-from-file="$DEFINES"
echo "IPA build complete — open Xcode Organizer or build/ios/ipa for upload."
