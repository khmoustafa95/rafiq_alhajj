# Active Context

> **Read this file at the start of every session.**

## Current focus
**Competition ordering questions** — drag-to-order steps with server-side validation.

## Recent changes (2026-06-09, late)
- **`ordering` question type:** migration `20260609200000_competition_ordering_questions.sql`, RPC `submit_competition_ordering_answer`, pilgrim `CompetitionQuizOrderingList`, admin reorderable step editor.

## Recent changes (2026-06-09, pm)
- **Visual learning path:** Zigzag lesson nodes (`CompetitionLearningPath`, `CompetitionLessonNode`, `CompetitionPathConnector`) with completed / current / locked states.
- **List screen:** Hero banner + responsive 1–2 column grid cards (`CompetitionListCard`).
- **Detail screen:** Gradient progress header with ring, path map, polished leaderboard, join CTA card.
- **Quiz screen:** Segmented top progress, option cards A–D, animated feedback bottom banner, completion celebration.
- **Shared:** `CompetitionPageConstraint` (max 720–960px) for tablet/web.

## Next steps
1. Hot restart — verify list, detail path, and quiz flow on phone + wide web viewport.
2. Optional: streak badge, lesson titles on path nodes, confetti animation on quiz complete.
3. Apply migration if not yet: `supabase db reset` or `migration up`.

## Key paths
| Concern | Location |
|---------|----------|
| Learning path | `lib/features/competitions/presentation/widgets/competition_learning_path.dart` |
| Quiz UX | `lib/features/competitions/presentation/widgets/competition_quiz_screen.dart` |
| Detail UI | `lib/features/competitions/presentation/widgets/competition_detail_screen.dart` |
| List UI | `lib/features/competitions/presentation/widgets/competitions_list_screen.dart` |
