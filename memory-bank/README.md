# Memory Bank — rafiq_alhajj

Persistent project context for AI-assisted development across sessions.

## Files

| File | Purpose | Update frequency |
| --- | --- | --- |
| [projectbrief.md](./projectbrief.md) | Goals, scope, constraints | When product scope changes |
| [productContext.md](./productContext.md) | UX, users, product rationale | When product/UX decisions change |
| [systemPatterns.md](./systemPatterns.md) | Architecture, conventions, patterns | When structure or patterns change |
| [techContext.md](./techContext.md) | Stack, tooling, local setup | When dependencies or dev env change |
| [activeContext.md](./activeContext.md) | Current focus, recent work, next steps | **Every session / after each task** |
| [progress.md](./progress.md) | Done / in progress / blocked / known issues | **After each completed task** |

## Agent workflow

### Session start
1. Read `activeContext.md` and `progress.md`.
2. Skim `systemPatterns.md` and `techContext.md` if implementing features.

### After completing a task
1. Update `activeContext.md` — what changed, what’s next.
2. Update `progress.md` — check off items, add blockers/issues.
3. Update `systemPatterns.md` or `techContext.md` only if architecture or stack changed.
4. Update `projectbrief.md` or `productContext.md` only if scope or product direction changed.

### Last updated
2026-05-18 — Memory Bank initialized.
