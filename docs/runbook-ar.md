# دليل تشغيل تطبيق رفيق الحج

دليل عملي لتشغيل المشروع محلياً وتجربة كل أدوار التطبيق (حاج، تقني مكتب، تقني ميداني، مسؤول).

> **تنبيه:** كلمات المرور أدناه للتطوير المحلي فقط. لا تستخدمها في الإنتاج.

---

## 1. المتطلبات

| الأداة | الغرض |
|--------|--------|
| [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart 3.11+) | بناء وتشغيل التطبيق |
| [Docker Desktop](https://www.docker.com/products/docker-desktop/) | تشغيل Supabase محلياً |
| [Supabase CLI](https://supabase.com/docs/guides/cli) | قاعدة البيانات، Auth، Edge Functions |
| Chrome (اختياري) | واجهة المشغل والمسؤول (ويب) |
| محاكي Android أو جهاز (اختياري) | الحاج + التقني الميداني |

تحقق من التثبيت:

```powershell
flutter doctor
docker --version
supabase --version
```

---

## 2. إعداد Supabase المحلي

من جذر المشروع `rafiq_alhajj`:

```powershell
# تأكد أن Docker Desktop يعمل
supabase start
supabase db reset
```

- `db reset` يطبّق كل migrations في `supabase/migrations/` ثم يشغّل `supabase/seed.sql` (محتوى عام، مجموعات، تفاصيل حجاج تجريبية).
- **مستخدمي Auth لا يُنشَؤون تلقائياً** — أنشئهم يدوياً في الخطوة 4.

### عناوين الخدمات المحلية

| الخدمة | العنوان |
|--------|---------|
| API (يستخدمه التطبيق) | `http://127.0.0.1:54321` |
| Supabase Studio | `http://127.0.0.1:54323` |
| قاعدة البيانات | `postgresql://postgres:postgres@127.0.0.1:54322/postgres` |

اعرض المفاتيح الحالية:

```powershell
supabase status
```

انسخ **anon key** من المخرجات إلى ملفات `dart_defines` (الخطوة التالية).

إيقاف / إعادة تشغيل:

```powershell
supabase stop
supabase start
```

---

## 3. ملفات تكوين Flutter (`dart-define`)

الملفات الحقيقية **غير مرفوعة على Git** (انظر `.gitignore`). أنشئها من القوالب:

### أ) سطح المكتب + Chrome + iOS Simulator

```powershell
Copy-Item dart_defines.local.example.json dart_defines.local.json
```

عدّل `dart_defines.local.json`:

```json
{
  "SUPABASE_URL": "http://127.0.0.1:54321",
  "SUPABASE_ANON_KEY": "<الصق anon key من supabase status>"
}
```

> المفتاح الافتراضي لبيئة Supabase المحلية غالباً:
> `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0`
>
> تحقق دائماً عبر `supabase status` بعد `supabase start`.

### ب) محاكي Android

المحاكي لا يصل إلى `127.0.0.1` على الجهاز المضيف؛ استخدم `10.0.2.2`:

```powershell
Copy-Item dart_defines.local.example.json dart_defines.android.local.json
```

```json
{
  "SUPABASE_URL": "http://10.0.2.2:54321",
  "SUPABASE_ANON_KEY": "<نفس anon key>"
}
```

بدون هذه الملفات يعمل التطبيق كضيف فقط (بدون تسجيل دخول/محتوى من Supabase) وستظهر رسالة أن Supabase غير مُعدّ.

---

## 4. حسابات التجربة (Auth)

كل الحسابات التالية تستخدم كلمة المرور:

### `demo123456`

نفّذ بعد `supabase db reset` (PowerShell — سطر واحد لكل مستخدم):

```powershell
supabase auth users create pilgrim@demo.local --password demo123456 --email-confirm

supabase auth users create operator@demo.local --password demo123456 --email-confirm --user-metadata "{\"role\":\"operator\",\"full_name\":\"محمد التقني\"}"

supabase auth users create admin@demo.local --password demo123456 --email-confirm --user-metadata "{\"role\":\"admin\",\"full_name\":\"خالد المسؤول\"}"
```

| البريد | كلمة المرور | الدور في `profiles` | المنصة المناسبة |
|--------|-------------|---------------------|-----------------|
| `pilgrim@demo.local` | `demo123456` | `pilgrim` | موبايل (Android/iOS) |
| `operator@demo.local` | `demo123456` | `operator` | ويب (مكتب) أو موبايل (ميدان) |
| `admin@demo.local` | `demo123456` | `admin` | ويب (لوحة تحليلات) |

- إنشاء المستخدم يفعّل تلقائياً صفاً في `public.profiles` (مشغّل `handle_new_user`).
- `seed.sql` يضيف بيانات لوجستية تجريبية لكل حاج موجود (جواز، فندق، حالة ميدانية `pending`، إلخ).

### إنشاء حاج جديد من واجهة المشغل

من `/operator/intake` يمكن تسجيل حاج جديد عبر Edge Function `create-pilgrim`. بعد الإرسال يظهر **حوار بالبريد وكلمة المرور المُولَّدة** — احفظهما للاختبار (مثال بريد: `pilgrim-xxxxxx@demo.local`).

---

## 5. تشغيل التطبيق

### تثبيت الحزم وتوليد الكود (مرة أو بعد تغيير `@riverpod` / `freezed`)

```powershell
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### من VS Code / Cursor

اختر إعداداً من `.vscode/launch.json`:

| الإعداد | الجهاز | ملف التكوين |
|---------|--------|-------------|
| `rafiq_alhajj (local Supabase)` | افتراضي | `dart_defines.local.json` |
| `rafiq_alhajj (Chrome web + local Supabase)` | Chrome | `dart_defines.local.json` |
| `rafiq_alhajj (Android emulator + local Supabase)` | محاكي Android | `dart_defines.android.local.json` |

### من الطرفية

```powershell
# ويب — مشغل المكتب + مسؤول
flutter run -d chrome --dart-define-from-file=dart_defines.local.json

# موبايل — حاج + تقني ميداني (محاكي)
flutter run --dart-define-from-file=dart_defines.android.local.json

# تحليل واختبارات
dart analyze
flutter test
```

---

## 6. ماذا تجرب على كل منصة؟

### أ) ويب (Chrome) — يبدأ عند `/operator/login`

| الهدف | الدخول | المسار بعد تسجيل الدخول |
|-------|--------|-------------------------|
| تسجيل حاج (US-05) | `operator@demo.local` | `/operator/intake` |
| لوحة تحليلات (US-07) | `admin@demo.local` | `/admin/dashboard` |
| رابط المسؤول من صفحة المشغل | — | زر **تسجيل دخول المسؤول** → `/admin/login` |

> مسارات التقني الميداني (`/operator/field/*`) **غير متاحة على الويب** — التوجيه يعيدك لصفحة المشغل.

### ب) موبايل — يبدأ عند `/` (الرئيسية)

| الهدف | كيف تصل | الحساب |
|-------|---------|--------|
| ضيف + محتوى عام + أدوات إسلامية | فتح التطبيق بدون دخول | — |
| تسجيل دخول حاج (US-03/04) | **تسجيل الدخول كحاج** → `/login` | `pilgrim@demo.local` |
| لوحة الحاج (مناسك + لوجستيات) | بعد الدخول → **رحلتي** `/pilgrim` | نفس الحساب |
| تقني ميداني (US-06) | **تسجيل التقني الميداني** → `/operator/field/login` | `operator@demo.local` |
| بحث وتحديث حالة حاج | بعد دخول الميدان → `/operator/field` | نفس حساب المشغل |

### ج) أدوات إسلامية (US-02) — `/tools`

| الأداة | ملاحظة |
|--------|--------|
| مواقيت الصلاة | يطلب إذن الموقع (GPS) |
| القبلة | بوصلة + موقع |
| القرآن / الأذكار | تعمل دون اتصال (بيانات مضمّنة) |

---

## 7. جدول المسارات السريع

| المسار | الوصف |
|--------|--------|
| `/` | الرئيسية (ضيف/حاج) |
| `/login` | دخول الحاج |
| `/pilgrim` | لوحة الحاج |
| `/tools` | مركز الأدوات الإسلامية |
| `/content/:id` | تفاصيل محتوى |
| `/operator/login` | دخول مشغل المكتب (ويب) |
| `/operator/intake` | استمارة تسجيل حاج |
| `/operator/field/login` | دخول التقني الميداني (موبايل) |
| `/operator/field` | قائمة بحث الحجاج |
| `/operator/field/:profileId` | تحديث حالة حاج |
| `/admin/login` | دخول المسؤول |
| `/admin/dashboard` | لوحة التحليلات |

---

## 8. بيانات تجريبية في قاعدة البيانات

بعد `db reset` + إنشاء `pilgrim@demo.local`:

- **مجموعات:** Makkah Group A، Madinah Group B
- **مكتبة المحتوى:** فيديوهات وأخبار عامة + محتوى `pilgrim_only`
- **تفاصيل الحاج:** جواز `P1234567`، إذن سفر `TP-2026-001`، فندق Makkah Towers، حالة ميدانية `pending`

راجع/عدّل من Studio: `http://127.0.0.1:54323` → جداول `profiles`, `pilgrim_details`, `content_library`, `groups`.

---

## 9. استكشاف الأخطاء الشائعة

| المشكلة | الحل |
|---------|------|
| `supabase status` يفشل / Docker pipe | شغّل **Docker Desktop** ثم `supabase start` |
| التطبيق بدون محتوى/دخول | أنشئ `dart_defines.local.json` ومرّر `--dart-define-from-file=...` |
| Android لا يتصل بـ Supabase | استخدم `10.0.2.2` في `dart_defines.android.local.json` |
| بريد أو كلمة مرور غير صحيحة | أعد إنشاء المستخدمين (الخطوة 4) بعد `db reset` |
| المسؤول يُوجَّه لصفحة المشغل | تأكد من `user-metadata` فيه `"role":"admin"` |
| التقني الميداني على الويب | استخدم **موبايل/محاكي** — المسارات الميدانية للموبايل فقط |
| أخطاء بعد تعديل Riverpod | `dart run build_runner build --delete-conflicting-outputs` |

---

## 10. مرجع أوامر سريع (نسخ ولصق)

```powershell
# بيئة كاملة من الصفر
supabase start
supabase db reset
supabase auth users create pilgrim@demo.local --password demo123456 --email-confirm
supabase auth users create operator@demo.local --password demo123456 --email-confirm --user-metadata "{\"role\":\"operator\",\"full_name\":\"محمد التقني\"}"
supabase auth users create admin@demo.local --password demo123456 --email-confirm --user-metadata "{\"role\":\"admin\",\"full_name\":\"خالد المسؤول\"}"

flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -d chrome --dart-define-from-file=dart_defines.local.json
```

---

## 11. ملفات مرتبطة في المستودع

| الملف | الغرض |
|-------|--------|
| `dart_defines.local.example.json` | قالب تكوين Supabase |
| `.vscode/launch.json` | إعدادات التشغيل في المحرر |
| `supabase/seed.sql` | بيانات تجريبية + تعليقات حسابات Auth |
| `lib/core/routing/app_routes.dart` | ثوابت المسارات |
| `memory-bank/activeContext.md` | سياق التطوير الحالي |

---

*آخر تحديث: 2026-05-21 — يغطي US-01 إلى US-07.*
