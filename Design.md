# Rafiq Al-Hajj — Design Specification

> **Status:** `APPLIED` (2026-06-06) — Phases 1–4 implemented; Phase 5 polish pending  
> **Reference:** Hajj Companion mockups (green/gold/indigo, card-based, Arabic-first)  
> **How to extend:** Edit sections below, set status to `READY`, then ask Cursor: **"Apply Design.md — Phase [N]"**

---

## 1. Design goals

### 1.1 Vision
A calm, premium Hajj companion that feels trustworthy and spiritually grounded — clean cards, deep green primary, gold accents, generous whitespace.

### 1.2 Problems addressed (previous design)
- Generic Material 3 seed theme (`#1B5E4B`) with no brand identity
- Home screen was a vertical list of outline buttons, not a dashboard
- No persistent mobile navigation
- Admin web used stacked buttons instead of a staff portal layout
- Notification and content lists used plain `ListTile`s

### 1.3 Design principles (ranked)
| Priority | Principle | Notes |
|----------|-----------|-------|
| 1 | Calm, card-based UI | White cards on `#F9FAFB` background, subtle borders + shadow |
| 2 | Arabic-first | Default locale Arabic; RTL via Flutter `Directionality` |
| 3 | Accessible touch targets | Buttons min 48dp; bottom nav icons in 48dp tap areas |
| 4 | Staff vs pilgrim separation | Mobile shell for pilgrims; sidebar shell for admin web |

### 1.4 Out of scope (unchanged by redesign)
- [x] Business logic / Supabase / auth flows
- [x] Route path constants (new `/profile` tab route added; existing paths kept)
- [x] Riverpod providers and data layer
- [x] RLS, edge functions, push notification pipeline

---

## 2. Brand & visual identity

### 2.1 Brand personality
| Attribute | Before | Applied |
|-----------|--------|---------|
| Tone | M3 default green seed | Deep forest green + gold — Hajj Companion |
| Density | Comfortable | Comfortable — 16.w horizontal padding on mobile |
| Decoration | Flat cards, 12px radius | Bordered cards, 12px radius, soft shadow |
| Motion | Minimal | Minimal — 200ms bottom-nav indicator; go_router defaults elsewhere |

### 2.2 Logo & app icon
| Asset | Status | Notes |
|-------|--------|-------|
| App icon | **Pending** | Still default Flutter icon |
| Wordmark | **Applied** | `HomeAppHeader` shows `appTitle` + avatar circle |
| Admin logo | **Applied** | Green mosque icon square in `StaffWebShell` sidebar |
| Splash screen | **Pending** | Not implemented |

### 2.3 Color palette

**Source of truth:** `lib/core/theme/app_colors.dart`

| Token | Hex | Usage |
|-------|-----|-------|
| Primary | `#065F46` | Buttons, active nav, accent bars |
| Primary dark | `#064E3B` | Prayer hero gradient, outlined button text |
| On primary | `#FFFFFF` | Text/icons on primary |
| Secondary (gold) | `#D4AF37` | Accents, urgent badges, outlined buttons, active prayer slot |
| Tertiary (indigo) | `#312E81` | Quick-action tile (Quran hub), admin stat accent |
| Background | `#F9FAFB` | Scaffold background |
| Surface | `#FFFFFF` | Cards, inputs, bottom nav |
| Surface muted | `#F3F4F6` | Quick-action tile backgrounds, inactive chips |
| Text primary | `#111827` | Headings, body |
| Text secondary | `#6B7280` | Captions, subtitles |
| Border / divider | `#E5E7EB` | Card borders, header divider |
| Success | `#059669` | Admin “connected” badge, published status |
| Warning | `#F59E0B` | — |
| Error | `#DC2626` | Validation, destructive actions |
| FAB gold | `#FFD54F` | Qibla FAB on notifications screen |

**Semantic accents** (notification cards, content):
| Meaning | Color | Usage |
|---------|-------|-------|
| Urgent / announcement | `#EF4444` | Notification left bar |
| Info / content | `#14B8A6` | Content-published notifications |
| Transport / system | `#8B5CF6` | System notifications |
| Ritual / success | `#059669` | Ritual update notifications |

**Dark mode:** ThemeData dark variant exists in `app_theme.dart` but visual system was designed for light mode first; dark tokens not fully audited.

### 2.4 Typography

**Font:** Inter via `google_fonts` package (`lib/core/theme/app_typography.dart`)

| Role | Size | Weight | Notes |
|------|------|--------|-------|
| Headline (H1) | 24sp | w700 | Screen titles, prayer name on hero |
| Title (H2) | 18–20sp | w600 | Section headers, card titles |
| Body | 14–16sp | regular | Descriptions; line-height 1.5 |
| Label / caption | 11–13sp | w500–w600 | Chips, timestamps, KPI labels |
| Arabic Quran | *system* | — | **Pending** — surah detail not restyled |

### 2.5 Spacing & shape

**ScreenUtil design size:** 375×812 (`AppConfig`)

| Token | Value | Where |
|-------|-------|-------|
| Screen padding | `16.w` | Home, notifications, tools hub |
| Card radius | `12px` (`AppDecorations.radiusMd`) | Cards, buttons, inputs |
| Large radius | `16px` (`radiusLg`) | Prayer hero, featured notification |
| Button min height | `48dp` | Filled / outlined buttons |
| Card elevation | `0` + border + `BoxShadow` blur 12 | `AppDecorations.card()` |
| Sidebar width (web) | `260.w` | `StaffWebShell` |

### 2.6 Icons
| Style | Applied |
|-------|---------|
| Icon set | Material rounded variants (`*_rounded`) |
| App bar / header | 20–22sp |
| Quick actions | 24sp in 48dp circle |
| Bottom nav | 22sp in 12px-radius primary pill when active |
| Illustrations | Mosque watermark on journey CTA (icon placeholder) |

---

## 3. Theme & component system

> **Hub:** `lib/core/theme/` — `app_theme.dart`, `app_colors.dart`, `app_typography.dart`, `app_decorations.dart`  
> **Shared widgets:** `lib/core/widgets/`

### 3.1 Theme mode
- [x] Light + dark `ThemeData` (system follows device; no in-app toggle)
- [x] Default experience optimized for **light mode**

### 3.2 Headers
| Component | File | Used when |
|-----------|------|-----------|
| `HomeAppHeader` | `home_app_header.dart` | Mobile shell screens (home, tools, notifications, profile) |
| `RafiqAppBar` | `rafiq_app_bar.dart` | Login, detail screens, staff mobile, web tools |
| `StaffWebHeader` | `staff_web_shell.dart` | Admin web content area top bar |

| Property | Applied value |
|----------|---------------|
| Background | `#FFFFFF` |
| Title alignment | Start (left in LTR, right in RTL) |
| Language switcher | Chip in `RafiqAppBar` / `StaffWebHeader` actions |
| Divider below header | 1px `#E5E7EB` on shell screens |

### 3.3 Buttons
| Variant | Style |
|---------|-------|
| Primary (Filled) | `#065F46` bg, white text, 12px radius, 48dp min height |
| Secondary (Outlined) | Gold border + gold text |
| Text | Primary green text, w600 |
| FAB | Gold `#FFD54F`, compass icon — notifications screen |

### 3.4 Cards
| Variant | File | Style |
|---------|------|-------|
| Base card | `AppDecorations.card()` | White, 1px border, soft shadow |
| Prayer hero | `prayer_times_hero_card.dart` | Green gradient, gold active slot |
| Journey CTA | `journey_cta_card.dart` | White card, gold left accent bar |
| Content featured | `content_card.dart` | Image gradient header, “Important” gold tag |
| Content horizontal | `content_card.dart` | Compact row + thumbnail placeholder |
| Notification | `notification_list_screen.dart` | Color left bar + icon square |
| Admin KPI | `StaffStatCard` in `staff_web_shell.dart` | Top accent stripe + icon square |
| CMS content | `admin_content_list_screen.dart` | Grid card with gradient header |

### 3.5 Inputs & forms
| Element | Status |
|---------|--------|
| Text fields | Themed via `inputDecorationTheme` (12px radius, filled white) |
| Login / intake forms | **Pending** — still use old layout inside new theme |

### 3.6 Navigation
| Pattern | Implementation |
|---------|----------------|
| Mobile primary nav | `PilgrimShellScreen` — `StatefulShellRoute.indexedStack` in `app_router.dart` |
| Web admin nav | `StaffWebShell` — `ShellRoute` wrapping admin routes on web |
| Deep links | Unchanged `AppRoutes` constants |
| Notification bell | `HomeAppHeader` action on home |

**Mobile bottom tabs:**
| Tab (EN) | Tab (AR) | Route | Icon |
|----------|----------|-------|------|
| Home | الرئيسية | `/` | `home_rounded` |
| Guidance | الإرشادات | `/tools` (+ child routes) | `menu_book_rounded` |
| Services | الخدمات | `/notifications` | `mosque_rounded` |
| Profile | الملف الشخصي | `/profile` | `person_outline_rounded` |

**Web admin sidebar:**
| Label (EN) | Route |
|------------|-------|
| Home | `/admin/dashboard` |
| Pilgrims | `/operator/pilgrims` |
| Content Management | `/admin/content` |
| Competitions | `/admin/competitions` |
| Notifications | `/admin/notifications/send` |

### 3.7 Feedback & states
| State | Treatment |
|-------|-----------|
| Loading | `CircularProgressIndicator` (primary color) |
| Empty | Centered text (no illustration yet) |
| Error | Centered text + retry button |
| Pull to refresh | Home feed, notifications, admin dashboard |

### 3.8 Shared components (implemented)
| Component | File | Screens |
|-----------|------|---------|
| `AppColors` | `app_colors.dart` | Global tokens |
| `AppTypography` | `app_typography.dart` | Global text theme |
| `AppDecorations` | `app_decorations.dart` | Card radius, shadow |
| `HomeAppHeader` | `home_app_header.dart` | Mobile shell |
| `PilgrimShellScreen` | `pilgrim_shell_screen.dart` | Mobile bottom nav |
| `StaffWebShell` | `staff_web_shell.dart` | Admin web sidebar |
| `StaffWebHeader` | `staff_web_shell.dart` | Admin web page header |
| `StaffStatCard` | `staff_web_shell.dart` | Admin dashboard KPIs |
| `PrayerTimesHeroCard` | `prayer_times_hero_card.dart` | Home |
| `QuickActionTiles` | `quick_action_tiles.dart` | Home |
| `JourneyCtaCard` | `journey_cta_card.dart` | Home (guests only) |

---

## 4. Layout & responsive behavior

### 4.1 Breakpoints
| Breakpoint | Width | Behavior |
|------------|-------|----------|
| Phone | < 600 | Single column, bottom nav shell |
| Tablet | 600–1024 | ScreenUtil scaling; admin KPI row when > 700px |
| Desktop (web) | > 1024 | 260px sidebar + fluid content; CMS 4-column grid (> 900px) |

### 4.2 RTL / Arabic
- [x] Default locale Arabic (`LocaleController`)
- [x] Flutter auto-mirrors layout in RTL
- [x] Admin sidebar flips to right edge in RTL (`StaffWebShell`)
- [ ] Custom chevron mirroring audit on all screens
- [x] Quran text RTL (existing)

### 4.3 Platform-specific
| Platform | Notes |
|----------|-------|
| Android | Bottom nav shell; prayer hero uses GPS schedule |
| iOS | Same shell (not separately tested) |
| Web admin | Sidebar + grid CMS; operator routes unchanged |
| Web pilgrim | No bottom shell — flat routes |

---

## 5. Screen-by-screen status

> `✅ Redesign` · `🔄 Refresh` (theme only) · `⏳ Pending` · `—` Skip

### 5.1 Public / pilgrim (mobile-first)

| Screen | Route | File | Status | Notes |
|--------|-------|------|--------|-------|
| Home | `/` | `home_screen.dart` | ✅ | Prayer hero, quick actions, journey CTA, news cards |
| Profile | `/profile` | `profile_screen.dart` | ✅ | New tab; guest login CTA / pilgrim menu |
| Login | `/login` | `login_screen.dart` | 🔄 | Inherits theme; layout not redesigned |
| Content detail | `/content/:id` | `content_detail_screen.dart` | 🔄 | Theme only |
| Notifications | `/notifications` | `notification_list_screen.dart` | ✅ | Hero, chips, accent cards, Qibla FAB |
| Pilgrim dashboard | `/pilgrim` | `pilgrim_dashboard_screen.dart` | ⏳ | Accessible from profile; old layout |

### 5.2 Islamic tools

| Screen | Route | File | Status | Notes |
|--------|-------|------|--------|-------|
| Tools hub | `/tools` | `islamic_tools_hub_screen.dart` | ✅ | Card list in shell; `HomeAppHeader` |
| Prayer times | `/tools/prayer-times` | `prayer_times_screen.dart` | 🔄 | Theme only |
| Qibla | `/tools/qibla` | `qibla_screen.dart` | 🔄 | Theme only |
| Quran list | `/tools/quran` | `quran_surah_list_screen.dart` | 🔄 | Theme only |
| Quran surah | `/tools/quran/:n` | `quran_surah_detail_screen.dart` | 🔄 | Theme only |
| Adhkar | `/tools/adhkar` | `adhkar_screen.dart` | 🔄 | Theme only |

### 5.3 Competitions

| Screen | Route | File | Status |
|--------|-------|------|--------|
| List | `/competitions` | `competitions_list_screen.dart` | 🔄 |
| Detail | `/competitions/:id` | `competition_detail_screen.dart` | 🔄 |

### 5.4 Operator (web)

| Screen | Route | File | Status |
|--------|-------|------|--------|
| Operator login | `/operator/login` | `operator_login_screen.dart` | 🔄 |
| Intake | `/operator/intake` | `operator_intake_screen.dart` | 🔄 |
| Pilgrim list | `/operator/pilgrims` | `operator_pilgrim_list_screen.dart` | 🔄 |
| Pilgrim detail | `/operator/pilgrims/:id` | `operator_pilgrim_detail_screen.dart` | 🔄 |

### 5.5 Field operator (mobile)

| Screen | Route | File | Status |
|--------|-------|------|--------|
| Field login | `/operator/field/login` | `field_operator_login_screen.dart` | 🔄 |
| Field home | `/operator/field` | `field_operator_home_screen.dart` | 🔄 |
| Field pilgrim | `/operator/field/:id` | `field_operator_pilgrim_screen.dart` | 🔄 |

### 5.6 Admin (web)

| Screen | Route | File | Status | Notes |
|--------|-------|------|--------|-------|
| Admin login | `/admin/login` | `admin_login_screen.dart` | 🔄 | Outside shell |
| Dashboard | `/admin/dashboard` | `admin_dashboard_screen.dart` | ✅ | KPI cards, sidebar, charts |
| Content CMS | `/admin/content` | `admin_content_list_screen.dart` | ✅ | Grid cards + add placeholder |
| Content edit | `/admin/content/...` | `admin_content_edit_screen.dart` | 🔄 | Form layout unchanged |
| Competitions admin | `/admin/competitions` | `admin_competitions_list_screen.dart` | 🔄 | In shell; list not grid |
| Send notification | `/admin/notifications/send` | `admin_notification_broadcast_screen.dart` | 🔄 | In shell |

### 5.7 System screens

| Screen | File | Status |
|--------|------|--------|
| 404 | `route_not_found_screen.dart` | 🔄 |
| Bootstrap failure | `bootstrap_failure_app.dart` | 🔄 |

---

## 6. Motion & interaction

| Interaction | Applied |
|-------------|---------|
| Bottom nav selection | 200ms `AnimatedContainer` on icon background |
| Page transitions | go_router defaults |
| Ritual checkbox | Unchanged optimistic update |
| Language switcher | Bottom sheet (existing) |
| Chart animations | fl_chart defaults on admin dashboard |

---

## 7. Implementation record

### 7.1 Phases
| Phase | Status | Scope |
|-------|--------|-------|
| **1 — Foundation** | ✅ Done | `AppColors`, `AppTypography`, `AppDecorations`, `app_theme.dart`, `google_fonts` |
| **2 — Pilgrim shell** | ✅ Done | `PilgrimShellScreen`, home redesign, profile tab, router shell |
| **3 — Content & notifications** | ✅ Done | `ContentCard` layouts, notification hero + chips |
| **4 — Staff web** | ✅ Done | `StaffWebShell`, admin dashboard KPIs, CMS grid |
| **5 — Polish** | ⏳ Pending | Login/intake forms, pilgrim dashboard, splash, app icon, empty-state art, dark mode audit |

### 7.2 Key files changed
```
lib/core/theme/app_colors.dart
lib/core/theme/app_typography.dart
lib/core/theme/app_decorations.dart
lib/core/theme/app_theme.dart
lib/core/widgets/home_app_header.dart
lib/core/widgets/pilgrim_shell_screen.dart
lib/core/widgets/staff_web_shell.dart
lib/core/routing/app_router.dart
lib/core/routing/app_routes.dart          # + /profile
lib/features/home/presentation/widgets/
lib/features/profile/presentation/widgets/profile_screen.dart
lib/features/notifications/presentation/widgets/notification_list_screen.dart
lib/features/content/presentation/widgets/content_card.dart
lib/features/content/presentation/widgets/content_section.dart
lib/features/islamic_tools/presentation/widgets/islamic_tools_hub_screen.dart
lib/features/islamic_tools/presentation/utils/prayer_times_utils.dart
lib/features/admin_analytics/presentation/widgets/admin_dashboard_screen.dart
lib/features/admin_content/presentation/widgets/admin_content_list_screen.dart
lib/l10n/app_en.arb
lib/l10n/app_ar.arb
pubspec.yaml                              # google_fonts
test/widget_test.dart
```

---

## 8. Copy & localization (added)

| Key | English | Arabic | Where |
|-----|---------|--------|-------|
| `navHome` | Home | الرئيسية | Bottom nav |
| `navGuidance` | Guidance | الإرشادات | Bottom nav |
| `navServices` | Services | الخدمات | Bottom nav |
| `navProfile` | Profile | الملف الشخصي | Bottom nav |
| `homeNextPrayer` | Next Prayer | الصلاة القادمة | Prayer hero |
| `homePrayerLocation` | Makkah, KSA | مكة، السعودية | Prayer hero |
| `homeJourneyTitle` | Begin Your Sacred Journey | ابدأ رحلتك المقدسة | Journey CTA |
| `homeJourneyBody` | Register now… | سجّل الآن… | Journey CTA |
| `homeRegisterNow` | Register Now | سجّل الآن | Journey CTA |
| `homeNewsSeeAll` | See All → | عرض الكل ← | News section |
| `contentImportantTag` | Important | مهم | Featured news card |
| `contentHoursAgo` | {hours} Hours Ago | منذ {hours} ساعة | News timestamp |
| `profileGuestTitle` | Guest | زائر | Profile tab |
| `profileGuestBody` | Sign in to access… | سجّل الدخول… | Profile tab |
| `notificationsLatestUpdates` | Latest Updates | آخر المستجدات | Notifications |
| `notificationsFilterAll` | All | الكل | Filter chips |
| `notificationsFilterGeneral` | General News | أخبار عامة | Filter chips |
| `notificationsFilterUrgent` | Urgent Alerts | تنبيهات عاجلة | Filter chips |
| `notificationsUrgentBadge` | Urgent Alert! | تنبيه عاجل! | Featured card |
| `notificationsMinutesAgo` | {minutes} min ago | منذ {minutes} دقيقة | Featured card |
| `staffNavHome` | Home | الرئيسية | Admin sidebar |
| `staffNavPilgrims` | Pilgrims | الحجاج | Admin sidebar |
| `staffNavContent` | Content Management | إدارة المحتوى | Admin sidebar |
| `staffNavCompetitions` | Competitions | المسابقات | Admin sidebar |
| `staffNavNotifications` | Notifications | الإشعارات | Admin sidebar |
| `staffPortalSubtitle` | Admin Portal | بوابة المسؤول | Sidebar header |
| `staffConnectedStatus` | Connected | متصل بالخدمة | Dashboard badge |
| `staffActiveNow` | Active now | نشط الآن | KPI badge |
| `staffStable` | Stable | مستقر | KPI badge |

---

## 9. References

| Reference | Location | Borrowed |
|-----------|----------|----------|
| Hajj Companion home mockup | User-provided screenshots (2026-06-06) | Prayer hero, quick actions, journey CTA, bottom nav |
| Design system board | User-provided screenshots | Color palette, Inter typography, button styles |
| Notifications screen | User-provided screenshots | Hero card, filter chips, accent notification cards |
| Admin dashboard (AR) | User-provided screenshots | Sidebar RTL, KPI cards, connection badge |
| Hajj CMS dashboard | User-provided screenshots | Content grid, stat cards, sidebar nav |

**Screenshots:** Cursor workspace assets folder (session images)

---

## 10. Acceptance checklist

| Item | Status |
|------|--------|
| Light theme matches §2.3 | ✅ |
| Dark theme fully audited | ⏳ |
| Arabic RTL on P0 screens (home, notifications, shell) | ✅ |
| Touch targets ≥ 48dp on mobile buttons | ✅ |
| WCAG AA contrast (body text) | ⏳ Not formally tested |
| `dart analyze` — no warnings | ✅ (info lints only) |
| Widget tests pass | ✅ `test/widget_test.dart` |
| No auth/route regressions | ✅ Paths preserved |
| Web admin usable at 1280px | ✅ |
| Language switcher on staff/header screens | ✅ |

---

## 11. Next steps (Phase 5 backlog)

1. **Login / staff login screens** — centered card layout matching journey CTA style
2. **Pilgrim dashboard** — ritual checklist cards with green/gold progress accents
3. **Operator intake** — multi-step form with new input styling
4. **Real content images** — use `mediaUrl` from `content_library` in `ContentCard`
5. **App icon + splash** — green mosque mark on `#065F46`
6. **Empty states** — illustrations for notifications, content, competitions
7. **Dark mode** — audit `AppColors` for dark surfaces
8. **404 / bootstrap** — branded error screens

To apply the next phase:
```
Apply Design.md — Phase 5
```

---

*Last updated: 2026-06-06 — Applied theme primary `#065F46`, secondary `#D4AF37`, tertiary `#312E81`.*
