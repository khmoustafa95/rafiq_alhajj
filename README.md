# rafiq_alhajj

تطبيق Flutter لرفيق الحج — حاج، مشغل مكتب (ويب)، تقني ميداني (موبايل)، ومسؤول (لوحة تحليلات ويب).

## دليل التشغيل

**[دليل التشغيل بالعربية](docs/runbook-ar.md)** — أوامر التشغيل، حسابات التجربة (`demo123456`)، إعداد Supabase المحلي، والمسارات لكل دور.

### بداية سريعة (أمر واحد)

```powershell
# إعداد قاعدة البيانات (مرة أو بعد تغيير migrations)
npm run setup

# ويب — مشغل + مسؤول
npm run dev

# أندرويد — حاج + تقني ميداني
npm run dev:android
```

أو مباشرة: `.\scripts\dev-chrome.ps1` / `.\scripts\dev-android.ps1`

انسخ `dart_defines.local.json` و `dart_defines.android.local.json` من ملفات `.example` (انظر الدليل).
