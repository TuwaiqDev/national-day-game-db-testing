--
-- PostgreSQL database dump
--

\restrict fUcsEyiMaWOfsbRGeZCGfuZNvOTAolUfNFkGKODBr3OmJY15Tq4vWo4UB6c5LrG

-- Dumped from database version 17.6
-- Dumped by pg_dump version 18.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: game_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.game_status AS ENUM (
    'category_selection',
    'in_progress',
    'completed',
    'abandoned'
);


--
-- Name: TYPE game_status; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE public.game_status IS 'Current status of a game session';


--
-- Name: player_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.player_status AS ENUM (
    'active',
    'blocked'
);


--
-- Name: TYPE player_status; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE public.player_status IS 'Status of the player account';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    slug character varying NOT NULL,
    description text NOT NULL,
    sort_order integer NOT NULL,
    is_active boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: game_answers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.game_answers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    game_session_id uuid NOT NULL,
    question_id uuid NOT NULL,
    selected_option_id uuid NOT NULL,
    is_correct boolean NOT NULL,
    points_earned integer NOT NULL,
    answered_at timestamp without time zone NOT NULL,
    time_spent_seconds integer
);


--
-- Name: game_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.game_events (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    game_session_id uuid NOT NULL,
    player_id uuid NOT NULL,
    event_type character varying NOT NULL,
    question_id uuid,
    metadata json,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: game_session_questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.game_session_questions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    game_session_id uuid NOT NULL,
    question_id uuid NOT NULL,
    question_number smallint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: game_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.game_sessions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    player_id uuid NOT NULL,
    category_id uuid,
    status public.game_status DEFAULT 'category_selection'::public.game_status NOT NULL,
    current_question_id uuid,
    current_question_number smallint DEFAULT '1'::smallint NOT NULL,
    total_questions smallint DEFAULT '5'::smallint NOT NULL,
    answered_questions smallint DEFAULT '0'::smallint NOT NULL,
    correct_answers smallint DEFAULT '0'::smallint NOT NULL,
    wrong_answers smallint DEFAULT '0'::smallint NOT NULL,
    score smallint DEFAULT '0'::smallint NOT NULL,
    hints_used smallint DEFAULT '0'::smallint NOT NULL,
    max_hints smallint DEFAULT '3'::smallint NOT NULL,
    question_started_at timestamp without time zone,
    question_deadline_at timestamp without time zone,
    started_at timestamp without time zone NOT NULL,
    completed_at timestamp without time zone,
    last_activity_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: hint_usages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hint_usages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    game_session_id uuid NOT NULL,
    question_id uuid NOT NULL,
    hint_id uuid NOT NULL,
    used_at timestamp without time zone NOT NULL
);


--
-- Name: players; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.players (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    email text,
    status public.player_status NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: question_answer_keys; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.question_answer_keys (
    question_id uuid NOT NULL,
    correct_option_id uuid NOT NULL
);


--
-- Name: question_hints; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.question_hints (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    question_id uuid NOT NULL,
    hint_number smallint NOT NULL,
    hint_text text NOT NULL,
    is_active boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: question_options; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.question_options (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    question_id uuid NOT NULL,
    option_text text NOT NULL,
    sort_order integer NOT NULL,
    created_at timestamp with time zone NOT NULL
);


--
-- Name: questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.questions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    category_id uuid NOT NULL,
    question_text text NOT NULL,
    image_url text,
    sort_order integer NOT NULL,
    is_active boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: game_answers game_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_answers
    ADD CONSTRAINT game_answers_pkey PRIMARY KEY (id);


--
-- Name: game_answers game_answers_session_question_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_answers
    ADD CONSTRAINT game_answers_session_question_key UNIQUE (game_session_id, question_id);


--
-- Name: game_events game_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_events
    ADD CONSTRAINT game_events_pkey PRIMARY KEY (id);


--
-- Name: game_session_questions game_session_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_session_questions
    ADD CONSTRAINT game_session_questions_pkey PRIMARY KEY (id);


--
-- Name: game_session_questions game_session_questions_session_number_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_session_questions
    ADD CONSTRAINT game_session_questions_session_number_key UNIQUE (game_session_id, question_number);


--
-- Name: game_session_questions game_session_questions_session_question_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_session_questions
    ADD CONSTRAINT game_session_questions_session_question_key UNIQUE (game_session_id, question_id);


--
-- Name: game_sessions game_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_sessions
    ADD CONSTRAINT game_sessions_pkey PRIMARY KEY (id);


--
-- Name: hint_usages hint_usages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hint_usages
    ADD CONSTRAINT hint_usages_pkey PRIMARY KEY (id);


--
-- Name: hint_usages hint_usages_session_hint_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hint_usages
    ADD CONSTRAINT hint_usages_session_hint_key UNIQUE (game_session_id, hint_id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: question_answer_keys question_answer_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.question_answer_keys
    ADD CONSTRAINT question_answer_keys_pkey PRIMARY KEY (question_id);


--
-- Name: question_hints question_hints_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.question_hints
    ADD CONSTRAINT question_hints_pkey PRIMARY KEY (id);


--
-- Name: question_hints question_hints_question_id_hint_number_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.question_hints
    ADD CONSTRAINT question_hints_question_id_hint_number_key UNIQUE (question_id, hint_number);


--
-- Name: question_options question_options_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.question_options
    ADD CONSTRAINT question_options_pkey PRIMARY KEY (id);


--
-- Name: question_options question_options_question_id_sort_order_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.question_options
    ADD CONSTRAINT question_options_question_id_sort_order_key UNIQUE (question_id, sort_order);


--
-- Name: questions questions_category_id_sort_order_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_category_id_sort_order_key UNIQUE (category_id, sort_order);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: game_answers game_answers_game_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_answers
    ADD CONSTRAINT game_answers_game_session_id_fkey FOREIGN KEY (game_session_id) REFERENCES public.game_sessions(id) ON DELETE CASCADE;


--
-- Name: game_answers game_answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_answers
    ADD CONSTRAINT game_answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: game_answers game_answers_selected_option_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_answers
    ADD CONSTRAINT game_answers_selected_option_id_fkey FOREIGN KEY (selected_option_id) REFERENCES public.question_options(id);


--
-- Name: game_events game_events_game_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_events
    ADD CONSTRAINT game_events_game_session_id_fkey FOREIGN KEY (game_session_id) REFERENCES public.game_sessions(id) ON DELETE CASCADE;


--
-- Name: game_events game_events_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_events
    ADD CONSTRAINT game_events_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- Name: game_events game_events_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_events
    ADD CONSTRAINT game_events_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: game_session_questions game_session_questions_game_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_session_questions
    ADD CONSTRAINT game_session_questions_game_session_id_fkey FOREIGN KEY (game_session_id) REFERENCES public.game_sessions(id) ON DELETE CASCADE;


--
-- Name: game_session_questions game_session_questions_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_session_questions
    ADD CONSTRAINT game_session_questions_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: game_sessions game_sessions_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_sessions
    ADD CONSTRAINT game_sessions_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: game_sessions game_sessions_current_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_sessions
    ADD CONSTRAINT game_sessions_current_question_id_fkey FOREIGN KEY (current_question_id) REFERENCES public.questions(id);


--
-- Name: game_sessions game_sessions_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_sessions
    ADD CONSTRAINT game_sessions_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- Name: hint_usages hint_usages_game_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hint_usages
    ADD CONSTRAINT hint_usages_game_session_id_fkey FOREIGN KEY (game_session_id) REFERENCES public.game_sessions(id) ON DELETE CASCADE;


--
-- Name: hint_usages hint_usages_hint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hint_usages
    ADD CONSTRAINT hint_usages_hint_id_fkey FOREIGN KEY (hint_id) REFERENCES public.question_hints(id);


--
-- Name: hint_usages hint_usages_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hint_usages
    ADD CONSTRAINT hint_usages_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: question_answer_keys question_answer_keys_correct_option_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.question_answer_keys
    ADD CONSTRAINT question_answer_keys_correct_option_id_fkey FOREIGN KEY (correct_option_id) REFERENCES public.question_options(id);


--
-- Name: question_answer_keys question_answer_keys_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.question_answer_keys
    ADD CONSTRAINT question_answer_keys_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: question_hints question_hints_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.question_hints
    ADD CONSTRAINT question_hints_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: question_options question_options_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.question_options
    ADD CONSTRAINT question_options_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: questions questions_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: categories; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;

--
-- Name: game_answers; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.game_answers ENABLE ROW LEVEL SECURITY;

--
-- Name: game_events; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.game_events ENABLE ROW LEVEL SECURITY;

--
-- Name: game_session_questions; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.game_session_questions ENABLE ROW LEVEL SECURITY;

--
-- Name: game_sessions; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.game_sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: hint_usages; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.hint_usages ENABLE ROW LEVEL SECURITY;

--
-- Name: players; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.players ENABLE ROW LEVEL SECURITY;

--
-- Name: question_answer_keys; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.question_answer_keys ENABLE ROW LEVEL SECURITY;

--
-- Name: question_hints; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.question_hints ENABLE ROW LEVEL SECURITY;

--
-- Name: question_options; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.question_options ENABLE ROW LEVEL SECURITY;

--
-- Name: questions; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.questions ENABLE ROW LEVEL SECURITY;

--
-- PostgreSQL database dump complete
--

\unrestrict fUcsEyiMaWOfsbRGeZCGfuZNvOTAolUfNFkGKODBr3OmJY15Tq4vWo4UB6c5LrG

