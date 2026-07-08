# دليل تشغيل تطبيق رفيق الحج

دليل عملي لتشغيل المشروع محلياً وتجربة كل أدوار التطبيق (حاج، تقني مكتب، تقني ميداني، مسؤول).

> **نقل التعديلات إلى Staging؟** راجع **[دليل التنقل بين البيئات](environments-workflow-ar.md)** — سيناريوهات مبسطة (كود فقط، migrations، نشر يدوي/تلقائي).

> **تنبيه:** كلمات المرور أدناه للتطوير المحلي فقط. لا تستخدمها في الإنتاج.

---

## 1. المتطلبات

| الأداة | الغرض |
| --- | --- |
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
| --- | --- |
| API (يستخدمه التطبيق) | `http://127.0.0.1:55321` |
| Supabase Studio | `http://127.0.0.1:55323` |
| قاعدة البيانات | `postgresql://postgres:postgres@127.0.0.1:55322/postgres` |

اعرض المفاتيح الحالية:

```powershell
supabase status
supabase status -o env
```

من `status -o env` انسخ `ANON_KEY` و`API_URL` إلى ملفات `dart_defines` (الخطوة التالية).  
(في الواجهة الجديدة قد يظهر **Publishable key** — التطبيق يحتاج قيمة `ANON_KEY` من الأمر أعلاه.)

إيقاف / إعادة تشغيل:

```powershell
supabase stop
supabase start
```

---

## 3. ملفات تكوين Flutter (`dart-define`)

**النمط المعتمد:** ملف مستقل لكل **منصة × بيئة** تحت `config/dart-defines/`.

```powershell
npm run config:bootstrap
```

| السيناريو | الملف السري (gitignored) | القالب |
| --- | --- | --- |
| Web · محلي | `config/dart-defines/web.local.json` | `web.local.example.json` |
| Web · staging | `config/dart-defines/web.staging.json` | `web.staging.example.json` |
| Android محاكي · محلي | `config/dart-defines/android.local.json` | `android.local.example.json` |
| Android جهاز · محلي | `config/dart-defines/android-device.local.json` | `android-device.local.example.json` |
| Android · staging | `config/dart-defines/android.staging.json` | `android.staging.example.json` |

### Web / iOS Simulator · Supabase محلي

عدّل `config/dart-defines/web.local.json`:

```json
{
  "APP_ENV": "local",
  "APP_PLATFORM": "web",
  "SUPABASE_URL": "http://127.0.0.1:55321",
  "SUPABASE_ANON_KEY": "<من supabase status>"
}
```

### Android Emulator · Supabase محلي

المحاكي لا يصل إلى `127.0.0.1` على الجهاز المضيف؛ استخدم `10.0.2.2` في `config/dart-defines/android.local.json`:

```json
{
  "APP_ENV": "local",
  "APP_PLATFORM": "android",
  "SUPABASE_URL": "http://10.0.2.2:55321",
  "SUPABASE_ANON_KEY": "<نفس anon key>"
}
```

**ذاكرة المحاكي:** في وضع Debug يستهلك Flutter ~400–500 MB. يُفضَّل **4096 MB RAM** على الأقل (Device Manager → Edit AVD → RAM).

### Android جهاز حقيقي · Supabase محلي

في `config/dart-defines/android-device.local.json` استبدل `192.168.0.100` بـ IP جهازك من `ipconfig` (نفس شبكة Wi‑Fi).

بدون هذه الملفات يعمل التطبيق كضيف فقط. راجع `config/dart-defines/README.md`.

---

## 4. حسابات التجربة (Auth)

كل الحسابات التالية تستخدم كلمة المرور:

### `demo123456`

**الطريقة أ — سكربت (موصى بها):**

```powershell
npm run setup:users
```

يقرأ الحسابات من `scripts/seed-demo-users.json` (UTF-8) لتفادي مشاكل العربية في PowerShell.

**الطريقة ب — Supabase Studio (يدوي):**  
افتح `http://127.0.0.1:55323` → **Authentication** → **Users** → **Add user** → أدخل البريد وكلمة المرور `demo123456` وفعّل **Auto Confirm User**.  
للمشغل والمسؤول أضف في **User Metadata** (JSON):

```json
{"role":"operator","full_name":"محمد التقني"}
```

```json
{"role":"admin","full_name":"خالد المسؤول"}
```

**الطريقة ج — CLI (إن وُجدت في إصدارك):**

```powershell
supabase auth users create pilgrim@demo.local --password demo123456 --email-confirm
# ... (قد لا تكون متاحة في CLI 2.90 — استخدم Studio)
```

| البريد | كلمة المرور | الدور في `profiles` | المنصة المناسبة |
| --- | --- | --- | --- |
| `pilgrim@demo.local` | `demo123456` | `pilgrim` | موبايل (Android/iOS) |
| `operator@demo.local` | `demo123456` | `operator` | ويب (مكتب) أو موبايل (ميدان) |
| `admin@demo.local` | `demo123456` | `admin` | ويب (لوحة تحليلات) |

- إنشاء المستخدم يفعّل تلقائياً صفاً في `public.profiles` (مشغّل `handle_new_user`).
- `seed.sql` يضيف بيانات لوجستية تجريبية لكل حاج موجود (جواز، فندق، حالة ميدانية `pending`، إلخ).

### إنشاء حاج جديد من واجهة المشغل

من `/operator/intake` يمكن تسجيل حاج جديد عبر Edge Function `create-pilgrim`. بعد الإرسال يظهر **حوار بالبريد وكلمة المرور المُولَّدة** — احفظهما للاختبار (مثال بريد: `pilgrim-xxxxxx@demo.local`).

---

## 5. تشغيل التطبيق

### أمر واحد (موصى به)

```powershell
npm run setup    # supabase db reset + seed + إنشاء حسابات التجربة تلقائياً
npm run setup:users   # إعادة إنشاء الحسابات فقط (بعد reset)
npm run dev      # Supabase + Flutter Chrome (مشغل/مسؤول)
npm run dev:android   # Supabase + Flutter Android (حاج/ميداني)
```

أو: `.\scripts\dev-chrome.ps1` / `.\scripts\dev-android.ps1`

### تثبيت الحزم وتوليد الكود (مرة أو بعد تغيير `@riverpod` / `freezed`)

```powershell
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### من VS Code / Cursor

اختر إعداداً من `.vscode/launch.json` (منصة × بيئة):

| الإعداد | السيناريو | ملف التكوين |
| --- | --- | --- |
| `Web · Local` | Chrome + Supabase محلي | `config/dart-defines/web.local.json` |
| `Web · Staging` | Chrome + Supabase سحابي | `config/dart-defines/web.staging.json` |
| `Android Emulator · Local` | محاكي + Supabase محلي | `config/dart-defines/android.local.json` |
| `Android Device · Local` | جهاز حقيقي + Supabase محلي | `config/dart-defines/android-device.local.json` |
| `Android · Staging` | جهاز/محاكي + Staging | `config/dart-defines/android.staging.json` |

أول مرة: `npm run config:bootstrap` ثم عدّل الملفات في `config/dart-defines/`.

### من الطرفية

```powershell
npm run dev:web              # web · local
npm run dev:android          # android emulator · local
npm run dev:android:device   # physical device · local
npm run dev:web:staging      # web · staging
npm run dev:android:staging  # android · staging

# أو يدوياً
flutter run -d chrome --dart-define-from-file=config/dart-defines/web.local.json
flutter run --dart-define-from-file=config/dart-defines/android.local.json

# تحليل واختبارات
dart analyze
flutter test
```

---

## 6. ماذا تجرب على كل منصة؟

### أ) ويب (Chrome) — يبدأ عند `/operator/login`

| الهدف | الدخول | المسار بعد تسجيل الدخول |
| --- | --- | --- |
| تسجيل حاج (US-05) | `operator@demo.local` | `/operator/intake` |
| قائمة الحجاج (US-09) | `operator@demo.local` | `/operator/pilgrims` (أيقونة المجموعة في شريط التسجيل) |
| لوحة تحليلات (US-07) | `admin@demo.local` | `/admin/dashboard` |
| إدارة المحتوى (US-08) | `admin@demo.local` | `/admin/content` (من زر «إدارة مكتبة المحتوى» في اللوحة) |
| إدارة المسابقات (US-10) | `admin@demo.local` | `/admin/competitions` |
| المسابقات (US-10) | `pilgrim@demo.local` (موبايل) | `/competitions` من الرئيسية |
| رابط المسؤول من صفحة المشغل | — | زر **تسجيل دخول المسؤول** → `/admin/login` |

> مسارات التقني الميداني (`/operator/field/*`) **غير متاحة على الويب** — التوجيه يعيدك لصفحة المشغل.

### ب) موبايل — يبدأ عند `/` (الرئيسية)

| الهدف | كيف تصل | الحساب |
| --- | --- | --- |
| ضيف + محتوى عام + أدوات إسلامية | فتح التطبيق بدون دخول | — |
| تسجيل دخول حاج (US-03/04) | **تسجيل الدخول كحاج** → `/login` | `pilgrim@demo.local` |
| لوحة الحاج (مناسك + لوجستيات) | بعد الدخول → **رحلتي** `/pilgrim` | نفس الحساب |
| تقني ميداني (US-06) | **تسجيل التقني الميداني** → `/operator/field/login` | `operator@demo.local` |
| بحث وتحديث حالة حاج | بعد دخول الميدان → `/operator/field` | نفس حساب المشغل |

### ج) أدوات إسلامية (US-02) — `/tools`

| الأداة | ملاحظة |
| --- | --- |
| مواقيت الصلاة | يطلب إذن الموقع (GPS) |
| القبلة | بوصلة + موقع |
| القرآن / الأذكار | تعمل دون اتصال (بيانات مضمّنة) |

---

## 7. جدول المسارات السريع

| المسار | الوصف |
| --- | --- |
| `/` | الرئيسية (ضيف/حاج) |
| `/login` | دخول الحاج |
| `/pilgrim` | لوحة الحاج |
| `/tools` | مركز الأدوات الإسلامية |
| `/content/:id` | تفاصيل محتوى |
| `/operator/login` | دخول مشغل المكتب (ويب) |
| `/operator/intake` | استمارة تسجيل حاج |
| `/operator/pilgrims` | قائمة الحجاج المسجّلين |
| `/operator/pilgrims/:profileId` | عرض/تعديل لوجستيات حاج |
| `/operator/field/login` | دخول التقني الميداني (موبايل) |
| `/operator/field` | قائمة بحث الحجاج |
| `/operator/field/:profileId` | تحديث حالة حاج |
| `/admin/login` | دخول المسؤول |
| `/admin/dashboard` | لوحة التحليلات |
| `/admin/content` | إدارة مكتبة المحتوى (CMS) |
| `/admin/content/new` | إضافة محتوى |
| `/admin/content/:id/edit` | تعديل محتوى |
| `/admin/competitions` | إدارة المسابقات |
| `/competitions` | قائمة المسابقات (حاج/ضيف) |
| `/competitions/:id` | تفاصيل + لوحة المتصدرين |

---

## 8. بيانات تجريبية في قاعدة البيانات

بعد `db reset` + إنشاء `pilgrim@demo.local`:

- **مجموعات:** Makkah Group A، Madinah Group B
- **مكتبة المحتوى:** فيديوهات وأخبار عامة + محتوى `pilgrim_only`
- **تفاصيل الحاج:** جواز `P1234567`، إذن سفر `TP-2026-001`، فندق Makkah Towers، حالة ميدانية `pending`

راجع/عدّل من Studio: `http://127.0.0.1:55323` → جداول `profiles`, `pilgrim_details`, `content_library`, `groups`.

---

## 9. استكشاف الأخطاء الشائعة

| المشكلة | الحل |
| --- | --- |
| `supabase status` يفشل / Docker pipe | شغّل **Docker Desktop** ثم `supabase start` |
| `No such container: supabase_db_rafiq_alhajj` | لم يُشغَّل مشروع هذا المجلد — نفّذ `supabase start` من جذر `rafiq_alhajj` |
| `port is already allocated` | مشروع Supabase آخر يعمل — أوقفه: `supabase stop --project-id <other>` ثم `supabase start` هنا |
| `forbidden by its access permissions` على 54322 | Windows/Hyper-V حجز النطاق `54290-54389` — المشروع يستخدم منافذ `5532x` (انظر `supabase/config.toml`) |
| التطبيق بدون محتوى/دخول | أنشئ `dart_defines.local.json` ومرّر `--dart-define-from-file=...` |
| Android لا يتصل بـ Supabase | استخدم `10.0.2.2` في `dart_defines.android.local.json` |
| بريد أو كلمة مرور غير صحيحة | أعد إنشاء المستخدمين (الخطوة 4) بعد `db reset` |
| المسؤول يُوجَّه لصفحة المشغل | تأكد من `user-metadata` فيه `"role":"admin"` |
| التقني الميداني على الويب | استخدم **موبايل/محاكي** — المسارات الميدانية للموبايل فقط |
| أخطاء بعد تعديل Riverpod | `dart run build_runner build --delete-conflicting-outputs` |
| `Lost connection to device` بعد التشغيل | المحاكي قتل التطبيق لنفاد الذاكرة (OOM). زِد RAM المحاكي إلى 4 GB+، أو شغّل على جهاز حقيقي. تحقق: `adb logcat -d \| Select-String lowmemorykiller,rafiq_alhajj` — إن ظهر `Kill 'com.example.rafiq_alhajj'` فالسبب OOM وليس خطأ في الكود |

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

## 11. إشعارات Push (FCM) — المرحلة 3

1. أنشئ مشروع Firebase وأضف تطبيق Android/iOS.
2. ضع `google-services.json` في `android/app/` (انظر `google-services.json.example`).
3. أضف مفاتيح `FIREBASE_*` إلى `dart_defines.android.local.json` (انظر `dart_defines.android.local.example.json`).
4. عيّن أسرار Edge Function: `FIREBASE_SERVICE_ACCOUNT_JSON` و `PUSH_WEBHOOK_SECRET` (انظر `supabase/.env.example`).
5. `supabase db reset` ثم سجّل دخول حاج على الموبايل — يُحفظ الرمز في `device_tokens`.
6. من لوحة المسؤول: **إرسال إشعار** — يصل Push خارج التطبيق.

التفاصيل بالإنجليزية: [push-notifications-setup.md](./push-notifications-setup.md).

---

## 12. ملفات مرتبطة في المستودع

| الملف / الأداة | الغرض |
| --- | --- |
| `config/.env.staging.example` | قالب أسرار Staging لسكربتات CLI |
| `config/.env.staging.local` | أسرارك الفعلية (gitignored) |
| `config/dart-defines/*.example.json` | قوالب تكوين التطبيق |
| `docs/push-notifications-setup.md` | إعداد FCM و Edge Function |
| `.vscode/launch.json` | إعدادات التشغيل في المحرر |
| `supabase/seed.sql` | بيانات تجريبية + تعليقات حسابات Auth |
| `lib/core/routing/app_routes.dart` | ثوابت المسارات |
| `memory-bank/activeContext.md` | سياق التطوير الحالي |
| `docs/staging-setup-ar.md` | نشر Staging مجاني + رابط ثابت للعميل |
| `docs/environments-workflow-ar.md` | التنقل بين البيئات ونقل التعديلات (محلي → Staging) |

---

*آخر تحديث: 2026-07-07 — يشمل دليل التنقل بين البيئات.*
