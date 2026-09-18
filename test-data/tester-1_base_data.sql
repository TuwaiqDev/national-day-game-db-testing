-- ============================================================
-- TESTER 1 — BASE DATA
-- ============================================================
-- Creates synthetic data for:
-- categories
-- questions
-- question_options
-- question_answer_keys
-- question_hints
-- ============================================================

INSERT INTO public.categories (
    id,
    name,
    slug,
    description,
    sort_order,
    is_active,
    created_at,
    updated_at
)
VALUES
(
    '10000000-0000-0000-0000-000000000001',
    'Saudi History',
    'saudi-history',
    'Questions about Saudi history and heritage.',
    1,
    true,
    NOW(),
    NOW()
),
(
    '10000000-0000-0000-0000-000000000002',
    'Saudi Culture',
    'saudi-culture',
    'Questions about Saudi culture and traditions.',
    2,
    true,
    NOW(),
    NOW()
);

-- ============================================================
-- QUESTIONS
-- ============================================================

INSERT INTO public.questions (
    id,
    category_id,
    question_text,
    image_url,
    sort_order,
    is_active,
    created_at,
    updated_at
)
VALUES
(
    '20000000-0000-0000-0000-000000000001',
    '10000000-0000-0000-0000-000000000001',
    'What is the capital city of Saudi Arabia?',
    NULL,
    1,
    true,
    NOW(),
    NOW()
),
(
    '20000000-0000-0000-0000-000000000002',
    '10000000-0000-0000-0000-000000000001',
    'In which year was the Kingdom of Saudi Arabia unified?',
    NULL,
    2,
    true,
    NOW(),
    NOW()
),
(
    '20000000-0000-0000-0000-000000000003',
    '10000000-0000-0000-0000-000000000002',
    'Which traditional Saudi garment is commonly worn by men?',
    NULL,
    1,
    true,
    NOW(),
    NOW()
);

-- ============================================================
-- QUESTION OPTIONS
-- ============================================================

INSERT INTO public.question_options (
    id,
    question_id,
    option_text,
    sort_order,
    created_at
)
VALUES
(
    '30000000-0000-0000-0000-000000000001',
    '20000000-0000-0000-0000-000000000001',
    'Riyadh',
    1,
    NOW()
),
(
    '30000000-0000-0000-0000-000000000002',
    '20000000-0000-0000-0000-000000000001',
    'Jeddah',
    2,
    NOW()
),
(
    '30000000-0000-0000-0000-000000000003',
    '20000000-0000-0000-0000-000000000001',
    'Dammam',
    3,
    NOW()
),
(
    '30000000-0000-0000-0000-000000000004',
    '20000000-0000-0000-0000-000000000002',
    '1932',
    1,
    NOW()
),
(
    '30000000-0000-0000-0000-000000000005',
    '20000000-0000-0000-0000-000000000002',
    '1945',
    2,
    NOW()
),
(
    '30000000-0000-0000-0000-000000000006',
    '20000000-0000-0000-0000-000000000002',
    '1950',
    3,
    NOW()
),
(
    '30000000-0000-0000-0000-000000000007',
    '20000000-0000-0000-0000-000000000003',
    'Thobe',
    1,
    NOW()
),
(
    '30000000-0000-0000-0000-000000000008',
    '20000000-0000-0000-0000-000000000003',
    'Bisht only',
    2,
    NOW()
),
(
    '30000000-0000-0000-0000-000000000009',
    '20000000-0000-0000-0000-000000000003',
    'Shemagh only',
    3,
    NOW()
);

-- ============================================================
-- CORRECT ANSWERS
-- ============================================================

INSERT INTO public.question_answer_keys (
    question_id,
    correct_option_id
)
VALUES
(
    '20000000-0000-0000-0000-000000000001',
    '30000000-0000-0000-0000-000000000001'
),
(
    '20000000-0000-0000-0000-000000000002',
    '30000000-0000-0000-0000-000000000004'
),
(
    '20000000-0000-0000-0000-000000000003',
    '30000000-0000-0000-0000-000000000007'
);

-- ============================================================
-- HINTS
-- ============================================================

INSERT INTO public.question_hints (
    id,
    question_id,
    hint_number,
    hint_text,
    is_active,
    created_at,
    updated_at
)
VALUES
(
    '40000000-0000-0000-0000-000000000001',
    '20000000-0000-0000-0000-000000000001',
    1,
    'It is the largest city in the central region.',
    true,
    NOW(),
    NOW()
),
(
    '40000000-0000-0000-0000-000000000002',
    '20000000-0000-0000-0000-000000000001',
    2,
    'It is also the capital of the Kingdom.',
    true,
    NOW(),
    NOW()
),
(
    '40000000-0000-0000-0000-000000000003',
    '20000000-0000-0000-0000-000000000002',
    1,
    'The Kingdom was officially unified in the 20th century.',
    true,
    NOW(),
    NOW()
),
(
    '40000000-0000-0000-0000-000000000004',
    '20000000-0000-0000-0000-000000000003',
    1,
    'It is a long traditional garment.',
    true,
    NOW(),
    NOW()
);
