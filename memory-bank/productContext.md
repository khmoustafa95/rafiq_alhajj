# Product Context

## Problem space (inferred)
Hajj pilgrims often need structured guidance, reminders, and reliable information during a complex, high-stakes journey. A companion app can centralize rituals, schedules, location-aware help, and group coordination.

**Status:** Inferred from project name only — validate with product owner.

## Target users (TBD)
| Persona | Needs | Priority |
|---------|--------|----------|
| Pilgrim | Step-by-step ritual guidance, reminders, offline access | TBD |
| Group leader | Member visibility, messaging, shared itinerary | TBD |
| Admin / agency | Content management, user support | TBD |

## UX principles (from engineering standards)
- **Bilingual**: Arabic + English via `.arb` files; RTL must work correctly.
- **Accessible themes**: Explicit light and dark `ThemeData` / `ColorScheme`.
- **Responsive**: `flutter_screenutil` for spacing and typography across phone/tablet.
- **Calm, trustworthy UI**: Appropriate for religious travel (exact visual identity TBD).

## Success criteria (draft)
- Pilgrims can complete key Hajj flows without confusion (metrics TBD).
- App remains usable with poor connectivity (offline strategy TBD).
- Content and ritual steps are accurate and maintainable (CMS/source TBD).

## Content & compliance
- Religious accuracy and scholar review process — **not defined yet**.
- Privacy for location and personal data — **policy TBD**.
