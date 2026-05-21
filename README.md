# rafiq_alhajj

تطبيق Flutter لرفيق الحج — حاج، مشغل مكتب (ويب)، تقني ميداني (موبايل)، ومسؤول (لوحة تحليلات ويب).

## دليل التشغيل

**[دليل التشغيل بالعربية](docs/runbook-ar.md)** — أوامر التشغيل، حسابات التجربة (`demo123456`)، إعداد Supabase المحلي، والمسارات لكل دور.

### بداية سريعة

```bash
supabase start && supabase db reset
# أنشئ dart_defines.local.json من dart_defines.local.example.json (انظر الدليل)
flutter run -d chrome --dart-define-from-file=dart_defines.local.json
```
