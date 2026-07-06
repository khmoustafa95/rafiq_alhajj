#!/usr/bin/env node
/**
 * Prints staging QA context: URLs, accounts, and checklist path.
 * Usage: npm run qa:staging
 */

const checklist = 'docs/qa/staging-smoke-checklist.md';

console.log(`
Rafiq Al-Hajj — Staging QA
==========================

Web URL:     https://rafiq-alhajj-staging.web.app
Checklist:   ${checklist}

Before testing:
  1. npm run staging:setup-db     (migrations)
  2. npm run staging:seed-users   (demo accounts)
  3. Fill config/dart-defines/*.staging.json (Firebase, Supabase)

Demo password for all accounts: demo123456

Roles:
  admin@demo.local      → Admin dashboard, CMS, operators
  operator@demo.local   → Pilgrim registry (web)
  field@demo.local      → Field operator mobile
  pilgrim@demo.local    → Pilgrim app (push + offline tests)

Priority smoke paths:
  • Content offline: download topic → airplane mode → playback
  • Push: admin broadcast → pilgrim device tray + inbox tap
  • SOS: pilgrim raise → staff map live update
  • Import: operator Excel preview → upsert by passport

Open the checklist and mark each section before promoting to production.
`);
