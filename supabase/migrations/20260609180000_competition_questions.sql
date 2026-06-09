-- Competition quiz questions: multiple choice & true/false with server-side scoring.

create type public.competition_question_type as enum ('multiple_choice', 'true_false');

create table public.competition_questions (
  id uuid primary key default gen_random_uuid(),
  competition_id uuid not null references public.competitions (id) on delete cascade,
  sort_order integer not null default 0,
  question_type public.competition_question_type not null,
  prompt text not null,
  explanation text,
  points integer not null default 10 check (points > 0),
  created_at timestamptz not null default now()
);

create index competition_questions_competition_idx
  on public.competition_questions (competition_id, sort_order);

create table public.competition_question_options (
  id uuid primary key default gen_random_uuid(),
  question_id uuid not null references public.competition_questions (id) on delete cascade,
  sort_order integer not null default 0,
  label text not null,
  is_correct boolean not null default false
);

create index competition_question_options_question_idx
  on public.competition_question_options (question_id, sort_order);

create table public.competition_question_attempts (
  id uuid primary key default gen_random_uuid(),
  question_id uuid not null references public.competition_questions (id) on delete cascade,
  profile_id uuid not null references public.profiles (id) on delete cascade,
  selected_option_id uuid not null references public.competition_question_options (id) on delete cascade,
  is_correct boolean not null,
  points_awarded integer not null default 0 check (points_awarded >= 0),
  answered_at timestamptz not null default now(),
  unique (question_id, profile_id)
);

create index competition_question_attempts_profile_idx
  on public.competition_question_attempts (profile_id, question_id);

alter table public.competition_questions enable row level security;
alter table public.competition_question_options enable row level security;
alter table public.competition_question_attempts enable row level security;

-- Questions visible when parent competition is active and not ended.
create policy "Anyone reads active competition questions"
  on public.competition_questions
  for select
  to anon, authenticated
  using (
    exists (
      select 1
      from public.competitions c
      where c.id = competition_id
        and c.is_active
        and c.ends_at >= now()
    )
  );

create policy "Admins manage competition questions"
  on public.competition_questions
  for all
  to authenticated
  using (public.is_admin())
  with check (public.is_admin());

create policy "Anyone reads active competition question options"
  on public.competition_question_options
  for select
  to anon, authenticated
  using (
    exists (
      select 1
      from public.competition_questions q
      join public.competitions c on c.id = q.competition_id
      where q.id = question_id
        and c.is_active
        and c.ends_at >= now()
    )
  );

create policy "Admins manage competition question options"
  on public.competition_question_options
  for all
  to authenticated
  using (public.is_admin())
  with check (public.is_admin());

create policy "Pilgrims read own question attempts"
  on public.competition_question_attempts
  for select
  to authenticated
  using (profile_id = auth.uid());

create policy "Admins read all question attempts"
  on public.competition_question_attempts
  for select
  to authenticated
  using (public.is_admin());

-- Score updates happen only via RPC (security definer).
create or replace function public.submit_competition_answer(
  p_question_id uuid,
  p_option_id uuid
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_profile_id uuid := auth.uid();
  v_question public.competition_questions%rowtype;
  v_competition public.competitions%rowtype;
  v_option public.competition_question_options%rowtype;
  v_entry public.competition_entries%rowtype;
  v_points integer;
  v_correct_option_id uuid;
begin
  if v_profile_id is null then
    raise exception 'Not authenticated';
  end if;

  if not exists (
    select 1 from public.profiles where id = v_profile_id and role = 'pilgrim'
  ) then
    raise exception 'Pilgrim role required';
  end if;

  select * into v_question
  from public.competition_questions
  where id = p_question_id;

  if not found then
    raise exception 'Question not found';
  end if;

  select * into v_competition
  from public.competitions
  where id = v_question.competition_id;

  if not v_competition.is_active
    or now() < v_competition.starts_at
    or now() > v_competition.ends_at then
    raise exception 'Competition not open';
  end if;

  if exists (
    select 1
    from public.competition_question_attempts
    where question_id = p_question_id and profile_id = v_profile_id
  ) then
    raise exception 'Already answered';
  end if;

  select * into v_option
  from public.competition_question_options
  where id = p_option_id and question_id = p_question_id;

  if not found then
    raise exception 'Invalid option';
  end if;

  select * into v_entry
  from public.competition_entries
  where competition_id = v_question.competition_id
    and profile_id = v_profile_id;

  if not found then
    raise exception 'Join competition first';
  end if;

  v_points := case when v_option.is_correct then v_question.points else 0 end;

  insert into public.competition_question_attempts (
    question_id,
    profile_id,
    selected_option_id,
    is_correct,
    points_awarded
  )
  values (
    p_question_id,
    v_profile_id,
    p_option_id,
    v_option.is_correct,
    v_points
  );

  if v_points > 0 then
    update public.competition_entries
    set score = score + v_points
    where id = v_entry.id;
  end if;

  select id into v_correct_option_id
  from public.competition_question_options
  where question_id = p_question_id and is_correct
  limit 1;

  return jsonb_build_object(
    'is_correct', v_option.is_correct,
    'points_awarded', v_points,
    'explanation', v_question.explanation,
    'correct_option_id', v_correct_option_id
  );
end;
$$;

grant execute on function public.submit_competition_answer(uuid, uuid) to authenticated;

alter publication supabase_realtime add table public.competition_questions;
alter publication supabase_realtime add table public.competition_question_attempts;
