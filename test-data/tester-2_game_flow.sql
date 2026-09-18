-- ============================================================
-- TESTER 2 — GAME FLOW
-- ============================================================
-- Creates synthetic data for:
-- players
-- game_sessions
-- game_session_questions
-- ============================================================

-- ============================================================
-- PLAYERS
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
    '50000000-0000-0000-0000-000000000001',
    'TESTER2 Player 01',
    'tester2.player01@example.test',
    'active',
    NOW(),
    NOW()
),
(
    '50000000-0000-0000-0000-000000000002',
    'TESTER2 Player 02',
    'tester2.player02@example.test',
    'active',
    NOW(),
    NOW()
);

-- ============================================================
-- GAME SESSIONS
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
    '60000000-0000-0000-0000-000000000001',
    '50000000-0000-0000-0000-000000000001',
    '10000000-0000-0000-0000-000000000001',
    'in_progress',
    '20000000-0000-0000-0000-000000000001',
    1,
    2,
    0,
    0,
    0,
    0,
    0,
    3,
    NOW(),
    NOW() + INTERVAL '30 seconds',
    NOW(),
    NULL,
    NOW(),
    NOW()
),
(
    '60000000-0000-0000-0000-000000000002',
    '50000000-0000-0000-0000-000000000002',
    '10000000-0000-0000-0000-000000000002',
    'completed',
    NULL,
    2,
    2,
    2,
    2,
    0,
    20,
    0,
    3,
    NULL,
    NULL,
    NOW() - INTERVAL '10 minutes',
    NOW() - INTERVAL '5 minutes',
    NOW() - INTERVAL '5 minutes',
    NOW() - INTERVAL '10 minutes'
);

-- ============================================================
-- GAME SESSION QUESTIONS
-- ============================================================

INSERT INTO public.game_session_questions (
    id,
    game_session_id,
    question_id,
    question_number,
    created_at
)
VALUES
(
    '70000000-0000-0000-0000-000000000001',
    '60000000-0000-0000-0000-000000000001',
    '20000000-0000-0000-0000-000000000001',
    1,
    NOW()
),
(
    '70000000-0000-0000-0000-000000000002',
    '60000000-0000-0000-0000-000000000001',
    '20000000-0000-0000-0000-000000000002',
    2,
    NOW()
),
(
    '70000000-0000-0000-0000-000000000003',
    '60000000-0000-0000-0000-000000000002',
    '20000000-0000-0000-0000-000000000002',
    1,
    NOW()
),
(
    '70000000-0000-0000-0000-000000000004',
    '60000000-0000-0000-0000-000000000002',
    '20000000-0000-0000-0000-000000000003',
    2,
    NOW()
);
