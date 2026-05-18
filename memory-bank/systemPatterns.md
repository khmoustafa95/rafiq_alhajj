# System Patterns

## Architecture: 4 layers, feature-first

Organize by **feature**, then by layer:

```
lib/
  features/
    <feature_name>/
      presentation/
        widgets/       # ONE public widget per file
        states/        # Freezed immutable states
        controllers/   # @riverpod Notifier / AsyncNotifier
      application/
        services/      # Use-cases, coordinates repos + UI
      domain/
        models/        # Pure business entities
      data/
        repositories/  # Abstract + concrete
        dtos/          # Serialization (json_serializable)
        data_sources/  # SupabaseClient calls
```

Shared cross-cutting code (if needed): `lib/core/` (routing, theme, l10n, errors) — **not created yet**.

## State management
- **Riverpod** with code generation: `@riverpod`, `Notifier`, `AsyncNotifier`.
- UI reads providers; controllers call application services.

## Routing
- **go_router** — declarative, typed routes (not integrated yet).

## Data flow
```
Widget → Controller → Service → Repository → DataSource → Supabase
                ↑                              ↓
              State                         DTO → Domain model
```

## Error handling
- Wrap network/DB in `try/catch`.
- Catch `PostgrestException` and `AuthException` explicitly from Supabase.

## UI rules
- Never hardcode colors — `Theme.of(context).colorScheme`.
- Never hardcode strings — `AppLocalizations.of(context)!.key`.
- Sizes via `flutter_screenutil` (`16.w`, `24.h`, `14.sp`, `RPadding()`).

## Code generation
- `freezed` + `json_serializable` for models/DTOs.
- Run `dart run build_runner build` after schema changes.

## Naming & files
- One **public** widget per file under `widgets/`.
- Private sub-widgets may live in the same file or sibling widget files.

## Current codebase reality
- Only `lib/main.dart` exists (Flutter default template).
- **No** feature folders, Riverpod, go_router, or Supabase yet.
- `main.dart` appears to have invalid syntax (`.fromSeed`, `.center`) — fix before first run.
