-- ============================================================
-- TESTER 3 — GAMEPLAY RECORDS
-- ============================================================
-- Creates synthetic data for:
-- game_answers
-- hint_usages
-- game_events
-- ============================================================

-- ============================================================
-- PLAYER
-- ============================================================

INSERT INTO public.players (
    id,
    name,
    email,
    status,
    created_at,
    updated_at
)
VALUES
(
    '80000000-0000-0000-0000-000000000001',
    'TESTER3 Player 01',
    'tester3.player01@example.test',
    'active',
    NOW(),
    NOW()
);

-- ============================================================
-- GAME SESSION
-- ============================================================

INSERT INTO public.game_sessions (
    id,
    player_id,
    category_id,
    status,
    current_question_id,
    current_question_number,
    total_questions,
    answered_questions,
    correct_answers,
    wrong_answers,
    score,
    hints_used,
    max_hints,
    question_started_at,
    question_deadline_at,
    started_at,
    completed_at,
    last_activity_at,
    created_at
)
VALUES
(
    '90000000-0000-0000-0000-000000000001',
    '80000000-0000-0000-0000-000000000001',
    '10000000-0000-0000-0000-000000000001',
    'completed',
    NULL,
    2,
    2,
    2,
    1,
    1,
    10,
    1,
    3,
    NULL,
    NULL,
    NOW() - INTERVAL '20 minutes',
    NOW() - INTERVAL '10 minutes',
    NOW() - INTERVAL '10 minutes',
    NOW() - INTERVAL '20 minutes'
);

-- ============================================================
-- GAME ANSWERS
-- ============================================================

INSERT INTO public.game_answers (
    id,
    game_session_id,
    question_id,
    selected_option_id,
    is_correct,
    points_earned,
    answered_at,
    time_spent_seconds
)
VALUES
(
    '91000000-0000-0000-0000-000000000001',
    '90000000-0000-0000-0000-000000000001',
    '20000000-0000-0000-0000-000000000001',
    '30000000-0000-0000-0000-000000000001',
    true,
    10,
    NOW() - INTERVAL '18 minutes',
    8
),
(
    '91000000-0000-0000-0000-000000000002',
    '90000000-0000-0000-0000-000000000001',
    '20000000-0000-0000-0000-000000000002',
    '30000000-0000-0000-0000-000000000005',
    false,
    0,
    NOW() - INTERVAL '12 minutes',
    15
);

-- ============================================================
-- HINT USAGE
-- ============================================================

INSERT INTO public.hint_usages (
    id,
    game_session_id,
    question_id,
    hint_id,
    used_at
)
VALUES
(
    '92000000-0000-0000-0000-000000000001',
    '90000000-0000-0000-0000-000000000001',
    '20000000-0000-0000-0000-000000000002',
    '40000000-0000-0000-0000-000000000003',
    NOW() - INTERVAL '14 minutes'
);

-- ============================================================
-- GAME EVENTS
-- ============================================================

INSERT INTO public.game_events (
    id,
    game_session_id,
    player_id,
    event_type,
    question_id,
    metadata,
    created_at
)
VALUES
(
    '93000000-0000-0000-0000-000000000001',
    '90000000-0000-0000-0000-000000000001',
    '80000000-0000-0000-0000-000000000001',
    'game_started',
    NULL,
    '{"source":"tester-3","test_case":"game_start"}',
    NOW() - INTERVAL '20 minutes'
),
(
    '93000000-0000-0000-0000-000000000002',
    '90000000-0000-0000-0000-000000000001',
    '80000000-0000-0000-0000-000000000001',
    'question_answered',
    '20000000-0000-0000-0000-000000000001',
    '{"is_correct":true,"points":10}',
    NOW() - INTERVAL '18 minutes'
),
(
    '93000000-0000-0000-0000-000000000003',
    '90000000-0000-0000-0000-000000000001',
    '80000000-0000-0000-0000-000000000001',
    'hint_used',
    '20000000-0000-0000-0000-000000000002',
    '{"hint_number":1}',
    NOW() - INTERVAL '14 minutes'
),
(
    '93000000-0000-0000-0000-000000000004',
    '90000000-0000-0000-0000-000000000001',
    '80000000-0000-0000-0000-000000000001',
    'question_answered',
    '20000000-0000-0000-0000-000000000002',
    '{"is_correct":false,"points":0}',
    NOW() - INTERVAL '12 minutes'
),
(
    '93000000-0000-0000-0000-000000000005',
    '90000000-0000-0000-0000-000000000001',
    '80000000-0000-0000-0000-000000000001',
    'game_completed',
    NULL,
    '{"score":10,"correct_answers":1,"wrong_answers":1}',
    NOW() - INTERVAL '10 minutes'
);
