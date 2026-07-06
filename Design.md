# Rafiq Al-Hajj — Design Specification

> **Status:** `APPLIED` — Hajj Companion visual system is live across the app (light mode).
> **Audience:** Designer agents continuing the work. This file is the **current-state source of truth** for visual language, components, navigation, and per-screen status.
> **Reference:** Hajj Companion mockups (deep green / gold / indigo, card-based, Arabic-first, RTL).
> **How to extend:** Edit the relevant section, set the screen/phase to `READY`, then ask Cursor: **"Apply Design.md — <area>"**. Do **not** change business logic, routes, providers, RLS, or edge functions when applying visual work.

---

## 0. How to read this doc (for designer agents)

- **Tokens are code.** Every color/spacing/typography value below maps to a file in `lib/core/theme/`. Never hardcode a hex or size in a widget — always use `AppColors`, `AppTypography` (via `Theme.of(context).textTheme`), `AppDecorations`, and `flutter_screenutil` extensions (`16.w`, `12.h`, `14.sp`, `20.r`).
- **One public widget per file** under `widgets/`; private sub-widgets (prefixed `_`) live in the same file.
- **Arabic-first, RTL.** Default locale is Arabic. Use `PositionedDirectional`, `EdgeInsetsDirectional`, start/end alignment — never left/right. All copy comes from `AppLocalizations.of(context)`; never hardcode strings.
- **Two shells.** Pilgrims use a mobile bottom-bar shell; staff (operator/admin) use a web sidebar shell. Keep them visually distinct.

---

## 1. Design goals

### 1.1 Vision
A calm, premium Hajj companion that feels trustworthy and spiritually grounded — clean white cards on a soft grey canvas, deep green primary, gold accents, indigo for "journey/learning", generous whitespace.

### 1.2 Design principles (ranked)
| Priority | Principle | Notes |
| --- | --- | --- |
| 1 | Calm, card-based UI | White cards on `#F9FAFB`, 1px border + soft shadow, 12–20px radius |
| 2 | Arabic-first / RTL | Default locale Arabic; layout auto-mirrors; directional widgets only |
| 3 | Accessible touch targets | Buttons ≥ 48dp; bottom-bar icons in comfortable tap areas |
| 4 | Staff vs pilgrim separation | Mobile bottom-bar shell for pilgrims; sidebar web shell for staff |
| 5 | Gradient accents for hero moments | Green→indigo / green gradients reserved for hero cards & tiles |

### 1.3 Out of scope for visual work
- Business logic / Supabase / auth flows / RLS / edge functions
- Route path constants and Riverpod providers / data layer
- Push notification pipeline

---

## 2. Brand & visual identity

### 2.1 Brand personality
| Attribute | Applied |
| --- | --- |
| Tone | Deep forest green + gold, indigo for journey/learning — Hajj Companion |
| Density | Comfortable — `16.w`–`20.w` horizontal padding on mobile |
| Decoration | Bordered white cards, 12–20px radius, soft shadow (blur 12, y+4) |
| Motion | Restrained — animated bottom bar notch/selection; go_router defaults elsewhere |

### 2.2 Logo & app icon
| Asset | Status | Notes |
| --- | --- | --- |
| App icon | **Pending** | Still default Flutter icon |
| Splash screen | **Pending** | Not implemented |
| Wordmark | **Applied** | `HomeAppHeader` shows title + avatar circle |
| Admin logo | **Applied** | Green mosque icon square in `StaffWebShell` sidebar |

### 2.3 Color palette

**Source of truth:** `lib/core/theme/app_colors.dart` (`abstract final class AppColors`)

| Token | Hex | Usage |
| --- | --- | --- |
| `primary` | `#065F46` | Buttons, active nav, accent bars, gradients |
| `primaryDark` | `#064E3B` | Prayer hero gradient end, outlined button text |
| `onPrimary` | `#FFFFFF` | Text/icons on primary |
| `secondary` (gold) | `#D4AF37` | Accents, urgent badges, outlined buttons, active prayer slot, home FAB when active |
| `onSecondary` | `#065F46` | Text/icons on gold |
| `tertiary` (indigo) | `#312E81` | Journey/learning gradients, Quran hub tile, admin stat accent |
| `onTertiary` | `#FFFFFF` | Text/icons on indigo |
| `background` | `#F9FAFB` | Scaffold background |
| `surface` | `#FFFFFF` | Cards, inputs, bottom bar, sidebar |
| `surfaceMuted` | `#F3F4F6` | Quick-action tile backgrounds, inactive chips |
| `textPrimary` | `#111827` | Headings, body |
| `textSecondary` | `#6B7280` | Captions, subtitles, inactive icons |
| `textOnDark` | `#FFFFFF` | Text on gradient/dark surfaces |
| `textMutedOnDark` | `#D1FAE5` | Secondary text on gradient heroes |
| `border` / `divider` | `#E5E7EB` | Card borders, header dividers |
| `success` | `#059669` | Connected badge, published status, ritual success |
| `warning` | `#F59E0B` | Warning states |
| `error` | `#DC2626` | Validation, destructive actions |
| `info` | `#3B82F6` | Informational accents |
| `fabGold` | `#FFD54F` | Qibla FAB on notifications screen |
| `fabGoldIcon` | `#5D4037` | Icon on the gold FAB |
| `chipInactive` | `#F3F4F6` | Inactive filter chip bg |
| `chipInactiveText` | `#374151` | Inactive filter chip text |
| `shadow` | `#1A000000` | Card / bar shadows |

**Semantic accents** (notification & content cards):
| Meaning | Color | Token |
| --- | --- | --- |
| Urgent / announcement | `#EF4444` | `accentRed` |
| Info / content | `#14B8A6` | `accentTeal` |
| Transport / system | `#8B5CF6` | `accentPurple` |
| Ritual / success | `#059669` | `success` |

**Dark mode:** A dark `ThemeData` variant exists in `app_theme.dart`, but the system was designed light-first; dark tokens are **not fully audited** (see backlog).

### 2.4 Typography

**Font:** Bundled `ThemeData` text theme (system font). `lib/core/theme/app_typography.dart` builds the `TextTheme` from `ThemeData(brightness).textTheme` and overrides sizes/weights/colors.
> **Note:** `google_fonts` (Inter via CDN) was **removed** to fix offline/Zone startup crashes. Do not reintroduce a network font. If a brand font is desired, bundle it as an asset.

| Role | TextTheme slot | Size | Weight |
| --- | --- | --- | --- |
| Display | `displaySmall` | default | w700, line-height 1.2 |
| Headline H1 | `headlineMedium` | 24 | w700, lh 1.25 |
| Headline H2 | `headlineSmall` | 20 | w700, lh 1.3 |
| Title L | `titleLarge` | 18 | w600 |
| Title M | `titleMedium` | 16 | w600 |
| Title S | `titleSmall` | 14 | w600 |
| Body L | `bodyLarge` | 16 | regular, lh 1.5 (primary color) |
| Body M | `bodyMedium` | 14 | regular, lh 1.5 (secondary color) |
| Body S | `bodySmall` | 12 | regular, lh 1.4 (secondary color) |
| Label L | `labelLarge` | 14 | w600 |
| Label M | `labelMedium` | 12 | w500 (secondary) |
| Label S | `labelSmall` | 11 | w500 (secondary) |

### 2.5 Spacing & shape

**ScreenUtil design size:** 375×812 (`AppConfig`). **Source:** `lib/core/theme/app_decorations.dart`

| Token | Value | Where |
| --- | --- | --- |
| `radiusSm` | `8` | Small chips, compact controls |
| `radiusMd` | `12` | Cards, buttons, inputs (default) |
| `radiusLg` | `16` | Prayer hero, service tiles, featured cards |
| `radiusXl` | `20` | Hero gradient panels (services/journey) |
| `cardShadow` | blur 12, offset (0, 4), `#1A000000` | `AppDecorations.card()` |
| Screen padding | `16.w`–`20.w` | Mobile screens |
| Button min height | `48dp` | Filled / outlined buttons |
| Sidebar width (web) | `260.w` | `StaffWebShell` |

### 2.6 Icons
| Context | Treatment |
| --- | --- |
| Icon set | Material **rounded / outlined** variants (`*_rounded`, `*_outlined`) |
| Bottom bar | 26sp; active = primary, inactive = `textSecondary` |
| Home FAB | `home_rounded`, 30–34sp, center-docked in the bar notch |
| Service / quick-action tiles | 24–28sp inside gradient or muted square |
| Hero watermark | Large faint `mosque_rounded` (alpha ~0.12) bottom-end of gradient heroes |

---

## 3. Theme & component system

> **Hub:** `lib/core/theme/` — `app_theme.dart`, `app_colors.dart`, `app_typography.dart`, `app_decorations.dart`
> **Shared widgets:** `lib/core/widgets/`

### 3.1 Theme mode
- Light + dark `ThemeData` (follows device; no in-app toggle).
- Default experience optimized for **light mode**.

### 3.2 Headers
| Component | File | Used when |
| --- | --- | --- |
| `HomeAppHeader` | `home_app_header.dart` | Mobile shell screens (home, guidance, services, notifications, profile) — title + avatar + optional actions, 1px divider below |
| `RafiqAppBar` | `rafiq_app_bar.dart` | Login, detail/inner screens, staff mobile, web tools |
| `StaffWebHeader` | `staff_web_shell.dart` | Admin/operator web content top bar |

Header background `#FFFFFF`, start-aligned title, language switcher chip in `RafiqAppBar` / `StaffWebHeader` actions.

### 3.3 Buttons
| Variant | Style |
| --- | --- |
| Primary (Filled) | `primary` bg, white text, 12px radius, 48dp min height |
| Secondary (Outlined) | Gold border + gold text |
| Text | Primary green text, w600 |
| FAB (notifications) | Gold `fabGold`, compass icon `fabGoldIcon` |
| Home FAB (shell) | Center-docked; gold when on Home, green otherwise; circular |

### 3.4 Cards
| Variant | File | Style |
| --- | --- | --- |
| Base card | `AppDecorations.card()` | White, 1px border, soft shadow |
| Prayer hero | `prayer_times_hero_card.dart` | Green gradient, gold active prayer slot |
| Services hero | `services_hub_screen.dart` | **Green→indigo** gradient panel, gold badge, mosque watermark |
| Service tile | `services_hub_screen.dart` | White card + gradient icon square + chevron |
| Journey CTA | `journey_cta_card.dart` | White card, gold left accent bar (guests) |
| Content featured | `content_card.dart` | Image gradient header, gold "Important" tag |
| Content horizontal | `content_card.dart` | Compact row + thumbnail |
| Topic card | `content_topic_card.dart` | Thematic media series entry |
| Notification | `notification_list_screen.dart` | Color left bar + icon square |
| Admin KPI | `StaffStatCard` (`staff_web_shell.dart`) | Top accent stripe + icon square |
| CMS / data | `StaffDataTable`, grid cards | Sortable/paginated tables + grid cards |

### 3.5 Inputs & forms
| Element | Status |
| --- | --- |
| Text fields | Themed via `inputDecorationTheme` (12px radius, filled white) |
| Staff web forms | `StaffWebPage` + form-section pattern, responsive grid, sticky action bar |
| Login / intake mobile forms | 🔄 inherit theme; layout not fully redesigned |

### 3.6 Navigation

**Mobile shell — `PilgrimShellScreen`** (`pilgrim_shell_screen.dart`): `StatefulShellRoute.indexedStack` with an **`AnimatedBottomNavigationBar` + center-docked Home FAB** (notched bar). 5 branches; Home is the center FAB.

| Position | Tab (EN / AR) | Route | Icon |
| --- | --- | --- | --- |
| Bar slot 1 | Guidance / الإرشادات | `/tools` (+ children) | `menu_book_rounded` |
| Bar slot 2 | Services / الخدمات | `/services` (hub) | `mosque_rounded` |
| **Center FAB** | Home / الرئيسية | `/` | `home_rounded` |
| Bar slot 3 | Notifications / الإشعارات | `/notifications` | `notifications_outlined` |
| Bar slot 4 | Profile / الملف الشخصي | `/profile` | `person_outline_rounded` |

> Bar styling: height 68, 28px end corners, `verySmoothEdge` notch, center gap, surface bg, upward shadow.

**Web staff shell — `StaffWebShell`** (`ShellRoute`, flips to right edge in RTL). Sidebar nav differs by role:

*Admin sidebar:*
| Label (EN / AR) | Route | Icon |
| --- | --- | --- |
| Home / الرئيسية | `/admin/dashboard` | `home_rounded` |
| Pilgrims / الحجاج | `/operator/pilgrims` | `people_outline_rounded` |
| Operators / المشغّلون | `/admin/operators` | `badge_outlined` |
| Groups / المجموعات | `/admin/groups` | `groups_outlined` |
| Trips / الرحلات | `/admin/trips` | `flight_takeoff_outlined` |
| Content Management / إدارة المحتوى | `/admin/content` | `article_outlined` |
| Competitions / المسابقات | `/admin/competitions` | `emoji_events_outlined` |
| Notifications / الإشعارات | `/admin/notifications/send` | `campaign_outlined` |
| Settings / الإعدادات | `/admin/settings` | `settings_outlined` |

*Operator sidebar:* Register pilgrim / تسجيل حاج (`/operator/intake`), Pilgrims / الحجاج (`/operator/pilgrims`).

### 3.7 Feedback & states
| State | Treatment |
| --- | --- |
| Loading | `CircularProgressIndicator` (primary); list skeletons where built (e.g. `ContentTopicsSectionSkeleton`) |
| Empty | Centered text (no illustration yet — backlog) |
| Error | Centered text + retry button |
| Pull to refresh | Home feed, notifications, admin dashboard |
| Toast | `NotificationToastHost` SnackBar for in-app notifications |

### 3.8 Shared / reusable components
| Component | File | Used in |
| --- | --- | --- |
| `AppColors` / `AppTypography` / `AppDecorations` | `core/theme/*` | Global tokens |
| `HomeAppHeader` | `home_app_header.dart` | Mobile shell screens |
| `PilgrimShellScreen` | `pilgrim_shell_screen.dart` | Mobile bottom-bar shell |
| `StaffWebShell` / `StaffWebHeader` / `StaffWebPage` | `staff_web_shell.dart` | Staff web layout |
| `StaffStatCard` | `staff_web_shell.dart` | Admin dashboard KPIs |
| `StaffDataTable` | staff web data tables | Operators, pilgrims, content, competitions lists |
| `PrayerTimesHeroCard` | `prayer_times_hero_card.dart` | Home |
| `QuickActionTiles` | `quick_action_tiles.dart` | Home |
| `JourneyCtaCard` | `journey_cta_card.dart` | Home (guests) |
| `ServicesHubScreen` tiles/hero | `services_hub_screen.dart` | Services tab |
| `EducationalMediaViewer` | content/journey | Shared video/audio/image media series viewer |
| `TripSelector` | `trips/.../trip_selector.dart` | Active-trip switcher (field operator; available for operator list) |
| `LanguageSwitcherFab` | global | AR/EN bottom-sheet picker |

---

## 4. Layout & responsive behavior

### 4.1 Breakpoints
| Breakpoint | Width | Behavior |
| --- | --- | --- |
| Phone | < 600 | Single column, bottom-bar shell |
| Tablet | 600–1024 | ScreenUtil scaling; admin KPI row > 700px |
| Desktop (web) | > 1024 | 260px sidebar + fluid content; CMS 4-col grid > 900px; staff login split hero/form ≥ 900px |

### 4.2 RTL / Arabic
- Default locale Arabic (`LocaleController`, persisted); global language switcher.
- Layout auto-mirrors; admin sidebar flips to the right edge.
- Use directional widgets everywhere; ❗ chevron-mirroring audit on all screens still **pending**.

### 4.3 Platform
| Platform | Notes |
| --- | --- |
| Android | Bottom-bar shell; native audio (`audioplayers`); prayer hero uses GPS schedule |
| iOS | Same shell (not separately tested) |
| Web (pilgrim) | Flat routes, no bottom shell |
| Web (staff) | Sidebar + grid/tables; operator + admin portals |

---

## 5. Screen-by-screen status

> `✅ Redesigned` · `🔄 Theme-only` · `⏳ Pending` · `—` Skip

### 5.1 Public / pilgrim (mobile-first)
| Screen | Route | File | Status | Notes |
| --- | --- | --- | --- | --- |
| Home | `/` | `home_screen.dart` | ✅ | Prayer hero, quick actions, topics carousel, journey CTA (guests), news cards |
| Services hub | `/services` | `services_hub_screen.dart` | ✅ | Green→indigo hero + gradient service tiles (My Hajj Journey, Competitions) |
| Profile | `/profile` | `profile_screen.dart` | ✅ | Guest login CTA / pilgrim menu; single pilgrim-login button |
| Notifications | `/notifications` | `notification_list_screen.dart` | ✅ | Featured hero, filter chips, accent cards, Qibla FAB; guest public feed |
| Hajj journey path | `/journey` | `hajj_journey_path_screen.dart` | ✅ | Duolingo-style ritual path |
| Ritual detail | `/journey/:ritualKey` | `hajj_ritual_detail_screen.dart` | ✅ | Video/audio/image media series |
| Content topics list | `/content/topics` | content topics | ✅ | Thematic media series |
| Topic detail | `/content/topics/:id` | content topics | ✅ | Media series viewer |
| Content lists | `/content/videos`,`/content/news` | `content_list_screen.dart` | 🔄 | Theme only |
| Content detail | `/content/:id` | `content_detail_screen.dart` | 🔄 | Theme only |
| Login | `/login` | `login_screen.dart` | 🔄 | Inherits theme; layout not redesigned |
| Pilgrim dashboard | `/pilgrim` | `pilgrim_dashboard_screen.dart` | ⏳ | Old layout; reached from profile |

### 5.2 Islamic tools (Guidance tab)
| Screen | Route | Status |
| --- | --- | --- |
| Tools hub | `/tools` | ✅ Card list in shell + `HomeAppHeader` |
| Prayer times | `/tools/prayer-times` | 🔄 |
| Qibla | `/tools/qibla` | 🔄 |
| Quran list / surah | `/tools/quran`, `/tools/quran/:n` | 🔄 (Arabic Quran styling pending) |
| Adhkar | `/tools/adhkar` | 🔄 |
| Virtual tour | `/tools/virtual-tour` | 🔄 Pannellum panorama + flutter_map |

### 5.3 Competitions
| Screen | Route | Status |
| --- | --- | --- |
| List | `/competitions` | ✅ Learning-path style |
| Detail | `/competitions/:id` | ✅ |
| Quiz | `/competitions/:id/quiz` | ✅ Segmented progress, option cards, feedback banner |

### 5.4 Operator (web)
| Screen | Route | Status |
| --- | --- | --- |
| Operator login | `/operator/login` | 🔄 Split hero/form scaffold |
| Intake (register pilgrim) | `/operator/intake` | 🔄 In `StaffWebPage` form sections |
| Pilgrim list | `/operator/pilgrims` | 🔄 `StaffDataTable`, filters, bulk group assign |
| Pilgrim detail | `/operator/pilgrims/:pilgrimId` | 🔄 Logistics edit (keyed by `pilgrimId`) |

### 5.5 Field operator (mobile)
| Screen | Route | Status |
| --- | --- | --- |
| Field login | `/operator/field/login` | 🔄 |
| Field home | `/operator/field` | 🔄 Stats dashboard + status filters + `TripSelector` |
| Field pilgrims / pilgrim | `/operator/field/pilgrims`, `/operator/field/:profileId` | 🔄 Full profile + status updates |

### 5.6 Admin (web)
| Screen | Route | File | Status | Notes |
| --- | --- | --- | --- | --- |
| Admin login | `/admin/login` | `admin_login_screen.dart` | 🔄 Split scaffold, outside shell |
| Dashboard | `/admin/dashboard` | `admin_dashboard_screen.dart` | ✅ KPI cards, charts (`fl_chart`), connection badge |
| Content CMS | `/admin/content` (+ new/edit) | `admin_content_*` | ✅ Grid cards; edit form 🔄 |
| Content topics CMS | `/admin/content/topics` (+ new/edit) | content topics admin | ✅ |
| Hajj journey CMS | `/admin/hajj-journey` (+ `:ritualKey/edit`) | `admin_hajj_journey_*` | ✅ |
| Competitions admin | `/admin/competitions` (+ new/edit) | `admin_competitions_*` | 🔄 In shell; list + question editor |
| Operators | `/admin/operators` (+ new/edit) | `admin_operators` | 🔄 CRUD + **group-access** section (read / read+write per group) |
| Groups | `/admin/groups` (+ new/edit) | `admin_groups` | 🔄 CRUD + members + logo upload |
| Trips | `/admin/trips`, `/admin/trips/:id/offices` | `trips` | 🔄 Trip CRUD + office participation |
| Settings | `/admin/settings` | `admin_settings` | 🔄 Global config |
| Send notification | `/admin/notifications/send` | broadcast | 🔄 In shell |

### 5.7 System screens
| Screen | File | Status |
| --- | --- | --- |
| 404 | `route_not_found_screen.dart` | 🔄 |
| Bootstrap failure | `bootstrap_failure_app.dart` | 🔄 |

---

## 6. Motion & interaction
| Interaction | Applied |
| --- | --- |
| Bottom bar | `AnimatedBottomNavigationBar` notch + 280ms splash; center Home FAB scales/recolors when active |
| Page transitions | go_router defaults |
| Ritual checkbox | Optimistic update |
| Language switcher | Bottom-sheet picker |
| Charts | `fl_chart` defaults on admin dashboard |
| Quiz | Segmented progress + feedback banner; drag-reorder for ordering questions |

---

## 7. Tech & packages relevant to design
| Concern | Package / file |
| --- | --- |
| Responsiveness | `flutter_screenutil` (`.w/.h/.sp/.r`, design 375×812) |
| Bottom bar | `animated_bottom_navigation_bar` |
| Charts | `fl_chart` |
| Maps / panorama | `flutter_map` (OSM), Pannellum WebView (virtual tour) |
| Media | `audioplayers` (native audio), WebView fallback (web), Dio cache for offline media |
| Offline detection | `connectivity_plus` |
| Routing | `go_router` (shells + branches) |
| State | Riverpod (`@riverpod` codegen) |
| Localization | `flutter_localizations` + ARB (`app_en.arb` / `app_ar.arb`); regen with `flutter gen-l10n` |

---

## 8. Acceptance checklist
| Item | Status |
| --- | --- |
| Light theme matches §2.3 | ✅ |
| Dark theme fully audited | ⏳ |
| Arabic RTL on P0 screens (home, services, notifications, shell) | ✅ |
| Touch targets ≥ 48dp on mobile buttons | ✅ |
| WCAG AA contrast (body text) | ⏳ Not formally tested |
| `flutter analyze` clean | ✅ (info lints only) |
| No auth/route regressions | ✅ Paths preserved |
| Web staff usable at 1280px | ✅ |
| Language switcher on staff/header screens | ✅ |

---

## 9. Backlog (next visual work)
1. **Login / staff login & mobile forms** — full redesign matching hero-card style.
2. **Pilgrim dashboard** — ritual checklist cards with green/gold progress accents.
3. **Operator intake & staff forms** — multi-step layout polish on the `StaffWebPage` pattern.
4. **App icon + splash** — green mosque mark on `#065F46`.
5. **Empty-state illustrations** — notifications, content, competitions, pilgrim lists.
6. **Dark mode audit** — verify `AppColors` dark surfaces + gradient heroes.
7. **RTL chevron audit** — ensure all directional icons mirror.
8. **404 / bootstrap** — branded error screens.
9. **Arabic Quran typography** — restyle surah detail.

To apply the next item:
```
Apply Design.md — <screen or backlog item>
```

---

## 10. References
| Reference | Borrowed |
| --- | --- |
| Hajj Companion home mockup | Prayer hero, quick actions, journey CTA, bottom nav |
| Design system board | Color palette, typography, button styles |
| Notifications mockup | Hero card, filter chips, accent cards |
| Admin dashboard (AR) | Sidebar RTL, KPI cards, connection badge |
| Hajj CMS dashboard | Content grid, stat cards, sidebar nav |

**Screenshots:** Cursor workspace session assets.

---

*Current state reflects the live Hajj Companion visual system: bottom-bar shell with center Home FAB, services hub, hajj journey path, content topics, and the staff web portal (pilgrims / operators / groups / trips / content / competitions / notifications / settings). Bundled font (no CDN). Last reviewed: 2026-06-20.*
