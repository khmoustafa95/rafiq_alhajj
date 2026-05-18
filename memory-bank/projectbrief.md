# Project Brief — rafiq_alhajj

## Overview
**Rafiq Al-Hajj** (`rafiq_alhajj`) is a Flutter mobile application. The name implies a **Hajj companion** product (رفيق = companion). Product requirements beyond the name are **not yet documented** — confirm with stakeholders.

## Goals (planned)
- Enterprise-grade Flutter app with maintainable, feature-first architecture.
- Offline-capable or sync-friendly flows where appropriate (TBD per feature).
- Arabic/English localization support (per `.cursorrules`).
- Backend via **Supabase** (local Docker dev, production TBD).

## Scope (current)
- **Greenfield**: default Flutter counter template only.
- No feature modules, no Supabase wiring, no planned stack packages in `pubspec.yaml` yet.

## Constraints
- Follow **4-layer, feature-first** architecture (see `systemPatterns.md`).
- One public widget per file; DRY; no hardcoded strings or colors.
- Target SDK: Dart `^3.11.4`.

## Out of scope (for now)
- Production deployment pipeline
- App Store / Play Store release configuration beyond default templates

## Open questions
- [ ] Confirm target users (pilgrims, guides, agencies)?
- [ ] Core MVP feature list (rituals, maps, groups, documents, etc.)?
- [ ] Auth model (phone, email, guest)?
- [ ] Primary markets and default locale?
