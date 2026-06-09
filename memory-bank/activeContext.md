# Active Context

> **Read this file at the start of every session.**

## Current focus
**Hajj journey restructure** — services hub, profile/registry split, CMS-backed ritual path.

## Recent changes (2026-06-09, night)
- **Navigation:** تبويب الخدمات (`/services`) يعرض مركز خدمات: رحلة حجّي، المسابقات، الإشعارات. أُزيلت من الملف الشخصي.
- **Profile:** يعرض فقط بيانات التسجيل (`PilgrimProfileSections`) + تسجيل الخروج.
- **Hajj journey feature:** `lib/features/hajj_journey/` — مسار تعليمي (نمط المسابقة)، صفحة تفاصيل نسك مع وسائط (فيديو/صوت/صور + سلايدات)، زر «تم الإنجاز».
- **DB:** migration `20260609210000_hajj_journey_cms.sql` — `hajj_journey_steps`, `hajj_journey_media` + بيانات تجريبية لعشر مناسك.
- **Admin:** `/admin/hajj-journey` — تحرير الشرح والوسائط لكل نسك.
- **Routes:** `/journey`, `/journey/:ritualKey`; `/pilgrim` يعيد التوجيه إلى `/journey`.

## Next steps
1. تطبيق migration على Supabase: `supabase migration up` أو `db reset`.
2. Hot restart للتطبيق — اختبار: الخدمات → رحلة حجّي → نسك → وسائط → تم الإنجاز.
3. اختبار لوحة المسؤول: تحرير نسك وإضافة وسائط.
4. اختياري: realtime invalidation لجداول `hajj_journey_*`.

## Key paths
| Concern | Location |
|---------|----------|
| Services hub | `lib/features/services/presentation/widgets/services_hub_screen.dart` |
| Journey path | `lib/features/hajj_journey/presentation/widgets/hajj_journey_path_screen.dart` |
| Ritual detail | `lib/features/hajj_journey/presentation/widgets/hajj_ritual_detail_screen.dart` |
| Media viewer | `lib/features/hajj_journey/presentation/widgets/hajj_ritual_media_viewer.dart` |
| Admin CMS | `lib/features/hajj_journey/presentation/widgets/admin_hajj_journey_*.dart` |
| Profile | `lib/features/profile/presentation/widgets/profile_screen.dart` |
