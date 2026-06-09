-- Ordering / sequence question type for competition quizzes.

alter type public.competition_question_type add value if not exists 'ordering';

alter table public.competition_question_attempts
  alter column selected_option_id drop not null;

alter table public.competition_question_attempts
  add column if not exists selected_option_ids uuid[];

-- Guard: choice questions must not use the ordering RPC.
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

  if v_question.question_type = 'ordering' then
    raise exception 'Use submit_competition_ordering_answer for ordering questions';
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

create or replace function public.submit_competition_ordering_answer(
  p_question_id uuid,
  p_option_ids uuid[]
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
  v_entry public.competition_entries%rowtype;
  v_expected_ids uuid[];
  v_is_correct boolean;
  v_points integer;
  v_option_count integer;
  v_submitted_count integer;
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

  if v_question.question_type <> 'ordering' then
    raise exception 'Question is not an ordering type';
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

  select * into v_entry
  from public.competition_entries
  where competition_id = v_question.competition_id
    and profile_id = v_profile_id;

  if not found then
    raise exception 'Join competition first';
  end if;

  select count(*)::integer into v_option_count
  from public.competition_question_options
  where question_id = p_question_id;

  v_submitted_count := coalesce(array_length(p_option_ids, 1), 0);

  if v_submitted_count <> v_option_count then
    raise exception 'Invalid option count';
  end if;

  if exists (
    select 1
    from unnest(p_option_ids) as submitted(id)
    where not exists (
      select 1
      from public.competition_question_options o
      where o.id = submitted.id and o.question_id = p_question_id
    )
  ) then
    raise exception 'Invalid option id';
  end if;

  if (select count(distinct x) from unnest(p_option_ids) as t(x)) <> v_submitted_count then
    raise exception 'Duplicate option id';
  end if;

  select array_agg(id order by sort_order)
  into v_expected_ids
  from public.competition_question_options
  where question_id = p_question_id;

  v_is_correct := p_option_ids = v_expected_ids;
  v_points := case when v_is_correct then v_question.points else 0 end;

  insert into public.competition_question_attempts (
    question_id,
    profile_id,
    selected_option_id,
    selected_option_ids,
    is_correct,
    points_awarded
  )
  values (
    p_question_id,
    v_profile_id,
    p_option_ids[1],
    p_option_ids,
    v_is_correct,
    v_points
  );

  if v_points > 0 then
    update public.competition_entries
    set score = score + v_points
    where id = v_entry.id;
  end if;

  return jsonb_build_object(
    'is_correct', v_is_correct,
    'points_awarded', v_points,
    'explanation', v_question.explanation,
    'correct_option_ids', to_jsonb(v_expected_ids)
  );
end;
$$;

grant execute on function public.submit_competition_ordering_answer(uuid, uuid[])
  to authenticated;
