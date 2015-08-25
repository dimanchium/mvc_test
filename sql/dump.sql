--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = uuid_lt,
    LEFTARG = uuid,
    RIGHTARG = uuid,
    COMMUTATOR = OPERATOR(pg_catalog.>),
    NEGATOR = OPERATOR(pg_catalog.>=)
);


ALTER OPERATOR public.< (uuid, uuid) OWNER TO postgres;

--
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = uuid_le,
    LEFTARG = uuid,
    RIGHTARG = uuid,
    COMMUTATOR = OPERATOR(pg_catalog.>=),
    NEGATOR = OPERATOR(pg_catalog.>)
);


ALTER OPERATOR public.<= (uuid, uuid) OWNER TO postgres;

--
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = uuid_ne,
    LEFTARG = uuid,
    RIGHTARG = uuid,
    NEGATOR = OPERATOR(pg_catalog.=)
);


ALTER OPERATOR public.<> (uuid, uuid) OWNER TO postgres;

--
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = uuid_eq,
    LEFTARG = uuid,
    RIGHTARG = uuid,
    NEGATOR = OPERATOR(pg_catalog.<>)
);


ALTER OPERATOR public.= (uuid, uuid) OWNER TO postgres;

--
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = uuid_gt,
    LEFTARG = uuid,
    RIGHTARG = uuid,
    COMMUTATOR = OPERATOR(pg_catalog.<),
    NEGATOR = OPERATOR(pg_catalog.<=)
);


ALTER OPERATOR public.> (uuid, uuid) OWNER TO postgres;

--
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = uuid_ge,
    LEFTARG = uuid,
    RIGHTARG = uuid,
    COMMUTATOR = OPERATOR(pg_catalog.<=),
    NEGATOR = OPERATOR(pg_catalog.<)
);


ALTER OPERATOR public.>= (uuid, uuid) OWNER TO postgres;

--
-- Name: module_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE module_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.module_id_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_module; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_module (
    module_id smallint DEFAULT nextval('module_id_seq'::regclass) NOT NULL,
    module_title character varying(50) NOT NULL,
    module_action character varying(15),
    module_enabled boolean DEFAULT true,
    module_weight smallint DEFAULT 0,
    CONSTRAINT module_title_check CHECK (((module_title)::text <> ''::text))
);


ALTER TABLE public.auth_module OWNER TO postgres;

--
-- Name: TABLE auth_module; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE auth_module IS 'Авторизация. Справочник модулей';


--
-- Name: COLUMN auth_module.module_weight; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN auth_module.module_weight IS 'Вес модуля';


--
-- Name: permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE;


ALTER TABLE public.permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_permission (
    permission_id smallint DEFAULT nextval('permission_id_seq'::regclass) NOT NULL,
    permission_name character(20),
    permission_description character(100),
    module_id smallint
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: TABLE auth_permission; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE auth_permission IS 'Авторизация. Список прав на доступ.';


--
-- Name: COLUMN auth_permission.permission_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN auth_permission.permission_id IS 'Идентификатор права на доступ';


--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_id_seq OWNER TO postgres;

--
-- Name: auth_role; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_role (
    role_id smallint DEFAULT nextval('role_id_seq'::regclass) NOT NULL,
    role_description character(32) NOT NULL,
    role_weight smallint
);


ALTER TABLE public.auth_role OWNER TO postgres;

--
-- Name: TABLE auth_role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE auth_role IS 'Авториазция. Список ролей';


--
-- Name: COLUMN auth_role.role_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN auth_role.role_id IS 'Идентификатор роли';


--
-- Name: COLUMN auth_role.role_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN auth_role.role_description IS 'Описание роли';


--
-- Name: COLUMN auth_role.role_weight; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN auth_role.role_weight IS 'Вес роли';


--
-- Name: auth_role_permission; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_role_permission (
    role_id smallint,
    permission_id smallint,
    allowed boolean DEFAULT true
);


ALTER TABLE public.auth_role_permission OWNER TO postgres;

--
-- Name: TABLE auth_role_permission; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE auth_role_permission IS 'Авторизация. Таблица отношений роль-право на доступ';


--
-- Name: auth_role_person; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE auth_role_person (
    role_id smallint NOT NULL,
    person_id smallint NOT NULL
);


ALTER TABLE public.auth_role_person OWNER TO postgres;

--
-- Name: TABLE auth_role_person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE auth_role_person IS 'Авторизация. Таблица отношений роль-пользователь';


--
-- Name: ban; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ban (
    ip character(15) NOT NULL,
    time_start integer,
    time_end integer
);


ALTER TABLE public.ban OWNER TO postgres;

--
-- Name: TABLE ban; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE ban IS 'Забаненные ip
';


--
-- Name: contract_fact; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE contract_fact (
    contract_id integer NOT NULL,
    person_id integer,
    patr_id smallint,
    position_id smallint,
    program_id integer,
    beg_date_id smallint,
    end_date_id smallint,
    decree_no character(16),
    sign_person_id integer,
    contract_person_id integer,
    st_year_id smallint,
    lang_1_id smallint,
    lang_2_id smallint
);


ALTER TABLE public.contract_fact OWNER TO postgres;

--
-- Name: TABLE contract_fact; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE contract_fact IS 'Назначение/перевод  на должность';


--
-- Name: COLUMN contract_fact.person_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN contract_fact.person_id IS 'Персона - получатель образовательных услуг сотрудник';


--
-- Name: COLUMN contract_fact.patr_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN contract_fact.patr_id IS 'ID подразделения';


--
-- Name: COLUMN contract_fact.contract_person_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN contract_fact.contract_person_id IS 'Пермона - вторая сторона контракта (Заказчик)';


--
-- Name: contract_fact_contract_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE contract_fact_contract_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contract_fact_contract_id_seq OWNER TO postgres;

--
-- Name: contract_fact_contract_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE contract_fact_contract_id_seq OWNED BY contract_fact.contract_id;


--
-- Name: disc_var_detail; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE disc_var_detail (
    discipline_id integer NOT NULL,
    specific_id smallint NOT NULL,
    lesson_type_id smallint NOT NULL,
    lesson_num smallint NOT NULL,
    lesson_title character(200),
    lesson_comment character(200)
);


ALTER TABLE public.disc_var_detail OWNER TO postgres;

--
-- Name: TABLE disc_var_detail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE disc_var_detail IS 'Детальное описание учебного плана по дисцмплине. Номер занятия, тема и т.п.
';


--
-- Name: COLUMN disc_var_detail.discipline_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN disc_var_detail.discipline_id IS 'ID дисциплины';


--
-- Name: COLUMN disc_var_detail.specific_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN disc_var_detail.specific_id IS 'ID спецификации курса';


--
-- Name: COLUMN disc_var_detail.lesson_type_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN disc_var_detail.lesson_type_id IS 'ID типа занятия/контрольного мероприятия';


--
-- Name: COLUMN disc_var_detail.lesson_num; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN disc_var_detail.lesson_num IS 'Номер занятия';


--
-- Name: COLUMN disc_var_detail.lesson_title; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN disc_var_detail.lesson_title IS 'Тема занятия';


--
-- Name: COLUMN disc_var_detail.lesson_comment; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN disc_var_detail.lesson_comment IS 'Коментарии к занятию';


--
-- Name: disc_var_summary; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE disc_var_summary (
    discipline_id integer NOT NULL,
    specific_id smallint NOT NULL,
    lesson_type_id smallint NOT NULL,
    lesson_count smallint,
    beg_date_id smallint,
    end_date_id smallint,
    in_use_flg boolean
);


ALTER TABLE public.disc_var_summary OWNER TO postgres;

--
-- Name: TABLE disc_var_summary; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE disc_var_summary IS 'Таблица описывает варианты планов учебных дисциплин. Описывает для каждого варианта плана количество занятий(контрольных мероприятий) в учебных парах
';


--
-- Name: COLUMN disc_var_summary.discipline_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN disc_var_summary.discipline_id IS 'ID дисциплины';


--
-- Name: COLUMN disc_var_summary.specific_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN disc_var_summary.specific_id IS 'ID спецификации курса';


--
-- Name: COLUMN disc_var_summary.lesson_type_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN disc_var_summary.lesson_type_id IS 'ID типа занятия/контрольного мероприятия';


--
-- Name: COLUMN disc_var_summary.lesson_count; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN disc_var_summary.lesson_count IS 'количество занятий в академических парах';


--
-- Name: COLUMN disc_var_summary.beg_date_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN disc_var_summary.beg_date_id IS 'Дата начала действия записи';


--
-- Name: COLUMN disc_var_summary.end_date_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN disc_var_summary.end_date_id IS 'Дата окончания действия';


--
-- Name: COLUMN disc_var_summary.in_use_flg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN disc_var_summary.in_use_flg IS 'Используется ли в "актуальных" учебных планах';


--
-- Name: journal_fact; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE journal_fact (
    el_schedule_id integer NOT NULL,
    student_id integer NOT NULL,
    check_mark smallint,
    upd_dt date,
    user_id integer,
    ref_doc_id integer
);


ALTER TABLE public.journal_fact OWNER TO postgres;

--
-- Name: TABLE journal_fact; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE journal_fact IS 'Записи журнала посещений/оценок';


--
-- Name: COLUMN journal_fact.el_schedule_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN journal_fact.el_schedule_id IS 'ID элемента расписания';


--
-- Name: COLUMN journal_fact.student_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN journal_fact.student_id IS 'ID студента';


--
-- Name: COLUMN journal_fact.check_mark; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN journal_fact.check_mark IS 'отметка о занятии';


--
-- Name: COLUMN journal_fact.upd_dt; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN journal_fact.upd_dt IS 'Дата/время измения';


--
-- Name: COLUMN journal_fact.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN journal_fact.user_id IS 'ID пользователя';


--
-- Name: COLUMN journal_fact.ref_doc_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN journal_fact.ref_doc_id IS 'документ основание';


--
-- Name: journal_hist; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE journal_hist (
    el_schedule_id integer NOT NULL,
    student_id integer NOT NULL,
    check_mark smallint NOT NULL,
    upd_dt date,
    user_id integer,
    ref_doc_id integer
);


ALTER TABLE public.journal_hist OWNER TO postgres;

--
-- Name: TABLE journal_hist; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE journal_hist IS 'Исторические записи журнала. Таблица заполняется из триггера (при изменении записи журнала - сюда копируется старое состояние записи)';


--
-- Name: lu_day; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lu_day (
    day_id smallint NOT NULL,
    day_desc date,
    st_semestr_id smallint,
    month_id smallint,
    week_of_semestr_id smallint,
    day_description character(32),
    day_of_week_id smallint,
    day_of_week_desc character(16),
    holiday_ind boolean,
    day_of_month smallint,
    day_of_year smallint,
    lm_day smallint,
    lq_day smallint,
    ly_day smallint
);


ALTER TABLE public.lu_day OWNER TO postgres;

--
-- Name: TABLE lu_day; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lu_day IS 'Календарный день';


--
-- Name: lu_discipline; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lu_discipline (
    patr_id smallint,
    discipline_id integer NOT NULL,
    discipline_desc character(64),
    discipline_short_desc character(4)
);


ALTER TABLE public.lu_discipline OWNER TO postgres;

--
-- Name: TABLE lu_discipline; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lu_discipline IS 'Перечень учебных дисциплин';


--
-- Name: COLUMN lu_discipline.patr_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_discipline.patr_id IS 'ID подразделения - читающая кафедра';


--
-- Name: lu_discipline_discipline_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lu_discipline_discipline_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lu_discipline_discipline_id_seq OWNER TO postgres;

--
-- Name: lu_discipline_discipline_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE lu_discipline_discipline_id_seq OWNED BY lu_discipline.discipline_id;


--
-- Name: lu_education_form; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lu_education_form (
    education_form_id smallint NOT NULL,
    education_form_desc character(32)
);


ALTER TABLE public.lu_education_form OWNER TO postgres;

--
-- Name: TABLE lu_education_form; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lu_education_form IS 'Справочник. Формы обучения';


--
-- Name: lu_language; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lu_language (
    lang_id smallint DEFAULT nextval('module_id_seq'::regclass) NOT NULL,
    lang_desc character(32)
);


ALTER TABLE public.lu_language OWNER TO postgres;

--
-- Name: TABLE lu_language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lu_language IS 'Справочник. Языки.';


--
-- Name: lu_lesson; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lu_lesson (
    lesson_id smallint,
    lesson_desc character(8),
    lesson_beg time without time zone,
    lesson_end time without time zone
);


ALTER TABLE public.lu_lesson OWNER TO postgres;

--
-- Name: TABLE lu_lesson; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lu_lesson IS 'Справочник. Описание учебных пар';


--
-- Name: lu_lesson_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lu_lesson_type (
    lesson_type_id smallint NOT NULL,
    lesson_type_desc character(64)
);


ALTER TABLE public.lu_lesson_type OWNER TO postgres;

--
-- Name: TABLE lu_lesson_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lu_lesson_type IS 'Справочник. Тип зпнятия/контрольного мероприятия';


--
-- Name: COLUMN lu_lesson_type.lesson_type_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_lesson_type.lesson_type_id IS 'ID типа занятия/контрольного мероприятия';


--
-- Name: COLUMN lu_lesson_type.lesson_type_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_lesson_type.lesson_type_desc IS 'Описание типа занятия/контрольного мероприятия (лекция, семинар, лаба, дз, и т.п.)';


--
-- Name: lu_month; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lu_month (
    quarter_id smallint,
    month_of_year_id smallint,
    month_id smallint NOT NULL,
    month_desc character(24),
    month_duration smallint,
    prev_month_id smallint,
    lq_month_id smallint,
    ly_month_id smallint
);


ALTER TABLE public.lu_month OWNER TO postgres;

--
-- Name: TABLE lu_month; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lu_month IS 'Справочник. Календарные месяцы.';


--
-- Name: lu_month_of_year; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lu_month_of_year (
    month_of_year_id smallint NOT NULL,
    month_of_year_desc character(10)
);


ALTER TABLE public.lu_month_of_year OWNER TO postgres;

--
-- Name: TABLE lu_month_of_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lu_month_of_year IS 'Справочник. Месяцы года.';


--
-- Name: lu_part_level; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lu_part_level (
    part_level_id smallint NOT NULL,
    part_level_desc character(64)
);


ALTER TABLE public.lu_part_level OWNER TO postgres;

--
-- Name: TABLE lu_part_level; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lu_part_level IS 'Справочник. Уровень в иерархии: университет/институт/факультет/кафедра';


--
-- Name: COLUMN lu_part_level.part_level_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_part_level.part_level_id IS 'ID уровня иерархии';


--
-- Name: COLUMN lu_part_level.part_level_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_part_level.part_level_desc IS 'Описание уровня иерархии';


--
-- Name: lu_position; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lu_position (
    position_id smallint NOT NULL,
    position_desc character(32)
);


ALTER TABLE public.lu_position OWNER TO postgres;

--
-- Name: TABLE lu_position; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lu_position IS 'Справочник. Сильно упрощенная должность: Студент, Аспирант, Староста,  Преподаватель, Административный сотрудник...';


--
-- Name: lu_progcontent; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lu_progcontent (
    recbookrow_id integer NOT NULL,
    program_id integer,
    discipline_id integer,
    specific_id smallint,
    lesson_type_id smallint,
    lesson_count smallint,
    course smallint,
    semestr smallint,
    final_control_type smallint
);


ALTER TABLE public.lu_progcontent OWNER TO postgres;

--
-- Name: TABLE lu_progcontent; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lu_progcontent IS 'Содержание конкретных учебных программ подготовки по специальностям университета. Условно, эту таблицу можно считать набором шаблонов зачеток по специальностям, т.к. опеисывает, какой предмет  на каком курсе читается и в каком объеме.';


--
-- Name: COLUMN lu_progcontent.lesson_type_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_progcontent.lesson_type_id IS 'ID типа занятия/контрольного мероприятия';


--
-- Name: COLUMN lu_progcontent.lesson_count; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_progcontent.lesson_count IS 'Количество занятий (в учебных парах)';


--
-- Name: COLUMN lu_progcontent.course; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_progcontent.course IS 'Номер курса, на котором читается дисциплина';


--
-- Name: COLUMN lu_progcontent.semestr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_progcontent.semestr IS 'Номер семестра на котором читается дисциплина';


--
-- Name: lu_program; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lu_program (
    patr_id smallint,
    speciality_id smallint,
    program_id integer NOT NULL,
    education_form_id smallint,
    semestr_number smallint,
    beg_date_id smallint,
    end_date_id smallint,
    in_use_flg boolean
);


ALTER TABLE public.lu_program OWNER TO postgres;

--
-- Name: TABLE lu_program; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lu_program IS 'Справочник. Программы подготовки.';


--
-- Name: COLUMN lu_program.patr_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_program.patr_id IS 'ID подразделения - выпускающая кафедра';


--
-- Name: lu_program_program_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lu_program_program_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lu_program_program_id_seq OWNER TO postgres;

--
-- Name: lu_program_program_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE lu_program_program_id_seq OWNED BY lu_program.program_id;


--
-- Name: lu_quarter; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lu_quarter (
    year_id smallint,
    quarter_id smallint NOT NULL,
    quarter_desc character(32),
    quarter_duration smallint,
    prev_quarter_id smallint,
    ly_quarter_id smallint
);


ALTER TABLE public.lu_quarter OWNER TO postgres;

--
-- Name: TABLE lu_quarter; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lu_quarter IS 'Справочник. Кварталы.';


--
-- Name: COLUMN lu_quarter.year_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_quarter.year_id IS 'ID года';


--
-- Name: COLUMN lu_quarter.quarter_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_quarter.quarter_id IS 'ID квартала';


--
-- Name: COLUMN lu_quarter.quarter_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_quarter.quarter_desc IS 'Описание';


--
-- Name: COLUMN lu_quarter.quarter_duration; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_quarter.quarter_duration IS 'Продолжитольность квартала в днях';


--
-- Name: COLUMN lu_quarter.prev_quarter_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_quarter.prev_quarter_id IS 'Ссылка на предыдущий квартал';


--
-- Name: COLUMN lu_quarter.ly_quarter_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_quarter.ly_quarter_id IS 'Соответствующий квартал прошлого года';


--
-- Name: lu_speciality; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lu_speciality (
    speciality_id smallint NOT NULL,
    speciality_desc character(64)
);


ALTER TABLE public.lu_speciality OWNER TO postgres;

--
-- Name: TABLE lu_speciality; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lu_speciality IS 'Справочник. Специальность подготовки';


--
-- Name: lu_specific; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lu_specific (
    specific_id smallint NOT NULL,
    specific_desc character(64)
);


ALTER TABLE public.lu_specific OWNER TO postgres;

--
-- Name: TABLE lu_specific; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lu_specific IS 'Справочник. Особенность/вариант программы учебной дисциплины';


--
-- Name: lu_st_semestr; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lu_st_semestr (
    st_year_id smallint,
    st_semestr_id smallint NOT NULL,
    st_semestr_desc character(32)
);


ALTER TABLE public.lu_st_semestr OWNER TO postgres;

--
-- Name: TABLE lu_st_semestr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lu_st_semestr IS 'Справочник. Учебный семестр';


--
-- Name: lu_st_year; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lu_st_year (
    st_year_id smallint NOT NULL,
    st_year_desc character(24)
);


ALTER TABLE public.lu_st_year OWNER TO postgres;

--
-- Name: TABLE lu_st_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lu_st_year IS 'Справочник. Учебный год';


--
-- Name: lu_structure; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lu_structure (
    patr_id smallint NOT NULL,
    parent_id smallint,
    part_desc character(64),
    beg_date_id smallint,
    end_date_id smallint,
    part_level_id smallint
);


ALTER TABLE public.lu_structure OWNER TO postgres;

--
-- Name: TABLE lu_structure; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lu_structure IS 'Справочник. Структура университета (упрещенная)';


--
-- Name: COLUMN lu_structure.patr_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_structure.patr_id IS 'ID подразделения';


--
-- Name: COLUMN lu_structure.parent_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_structure.parent_id IS 'Ссылка на вышестоящее подразделение';


--
-- Name: COLUMN lu_structure.part_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_structure.part_desc IS 'Описание подразделения';


--
-- Name: COLUMN lu_structure.beg_date_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_structure.beg_date_id IS 'Дата начала действия записи';


--
-- Name: COLUMN lu_structure.end_date_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_structure.end_date_id IS 'Дата окончания действия записи';


--
-- Name: COLUMN lu_structure.part_level_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_structure.part_level_id IS 'уровень записи в иерархии';


--
-- Name: lu_week_of_semestr; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lu_week_of_semestr (
    week_of_semestr_id smallint NOT NULL,
    week_of_semestr_desc character(24)
);


ALTER TABLE public.lu_week_of_semestr OWNER TO postgres;

--
-- Name: TABLE lu_week_of_semestr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lu_week_of_semestr IS 'Справочник. Неделя семестра.';


--
-- Name: lu_year; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lu_year (
    year_id smallint NOT NULL,
    year_desc character(4),
    is_leap_year boolean,
    year_duration smallint,
    prev_year_id smallint
);


ALTER TABLE public.lu_year OWNER TO postgres;

--
-- Name: TABLE lu_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE lu_year IS 'Справочник. Календарный год';


--
-- Name: COLUMN lu_year.year_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_year.year_id IS 'ID года';


--
-- Name: COLUMN lu_year.year_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_year.year_desc IS 'Описание года';


--
-- Name: COLUMN lu_year.year_duration; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_year.year_duration IS 'Продолжительность года в днях';


--
-- Name: COLUMN lu_year.prev_year_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lu_year.prev_year_id IS 'Ссылка на предыдущий год';


--
-- Name: person; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE person (
    person_id integer NOT NULL,
    first_name character(32),
    father_name character(32),
    second_name character(32),
    birth_date date,
    birth_addr character(128),
    fact_addr character(128),
    username character(16),
    pass character(32),
    gender character(1),
    email character(100)
);


ALTER TABLE public.person OWNER TO postgres;

--
-- Name: TABLE person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE person IS 'Физические лица';


--
-- Name: COLUMN person.person_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN person.person_id IS 'ID физического лица';


--
-- Name: COLUMN person.first_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN person.first_name IS 'Имя';


--
-- Name: COLUMN person.father_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN person.father_name IS 'Отчество';


--
-- Name: COLUMN person.second_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN person.second_name IS 'Фамилия';


--
-- Name: COLUMN person.birth_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN person.birth_date IS 'Дата рождения';


--
-- Name: COLUMN person.birth_addr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN person.birth_addr IS 'Место рождения';


--
-- Name: COLUMN person.fact_addr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN person.fact_addr IS 'Фактический адрес';


--
-- Name: COLUMN person.username; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN person.username IS 'Имя пользователя в системе ';


--
-- Name: COLUMN person.pass; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN person.pass IS 'Пароль доступа к системе электронного университета';


--
-- Name: COLUMN person.gender; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN person.gender IS 'Пол';


--
-- Name: COLUMN person.email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN person.email IS 'Эл. почта';


--
-- Name: person_doc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE person_doc (
    person_id integer,
    doc_type smallint,
    doc_series character(10),
    doc_number character(20),
    doc_beg_date_id smallint,
    doc_end_date_id smallint,
    doc_issuer character(128),
    doc_kp character(8),
    doc_addr character(128)
);


ALTER TABLE public.person_doc OWNER TO postgres;

--
-- Name: TABLE person_doc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE person_doc IS 'Документ удостоверяющий личность';


--
-- Name: COLUMN person_doc.person_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN person_doc.person_id IS 'ID физического лица';


--
-- Name: COLUMN person_doc.doc_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN person_doc.doc_type IS 'Тип документа (паспорт РФ, удостоверение личности офицера, паспорт ин. государства и т.д.)';


--
-- Name: COLUMN person_doc.doc_series; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN person_doc.doc_series IS 'Серия документа';


--
-- Name: COLUMN person_doc.doc_number; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN person_doc.doc_number IS 'Номер документа';


--
-- Name: COLUMN person_doc.doc_beg_date_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN person_doc.doc_beg_date_id IS 'Дата начала действия документа';


--
-- Name: COLUMN person_doc.doc_end_date_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN person_doc.doc_end_date_id IS 'Дата окончания действия документа';


--
-- Name: COLUMN person_doc.doc_issuer; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN person_doc.doc_issuer IS 'Кем выдан';


--
-- Name: COLUMN person_doc.doc_kp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN person_doc.doc_kp IS 'Код подразделения';


--
-- Name: COLUMN person_doc.doc_addr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN person_doc.doc_addr IS 'Адрес регистрации';


--
-- Name: person_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE person_person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.person_person_id_seq OWNER TO postgres;

--
-- Name: person_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE person_person_id_seq OWNED BY person.person_id;


--
-- Name: schedule; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE schedule (
    el_schedule_id integer NOT NULL,
    date_id smallint,
    end_date_id smallint,
    lesson_id smallint,
    discipline_id integer,
    teacher_id integer,
    flow_id integer,
    classroom_id smallint,
    lesson_type smallint,
    is_closed boolean
);


ALTER TABLE public.schedule OWNER TO postgres;

--
-- Name: TABLE schedule; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE schedule IS 'Расписание занятий';


--
-- Name: COLUMN schedule.el_schedule_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schedule.el_schedule_id IS 'ID элемента расписания';


--
-- Name: COLUMN schedule.date_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schedule.date_id IS 'ID  (стартовой) даты  занятия/контрольного мероприятия';


--
-- Name: COLUMN schedule.end_date_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schedule.end_date_id IS 'ID  датыокончания  занятия/контрольного мероприятия (если применимо)';


--
-- Name: COLUMN schedule.lesson_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schedule.lesson_id IS 'номер пары';


--
-- Name: COLUMN schedule.discipline_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schedule.discipline_id IS 'ID учебной дисциплины';


--
-- Name: COLUMN schedule.teacher_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schedule.teacher_id IS 'ID преподавателя';


--
-- Name: COLUMN schedule.flow_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schedule.flow_id IS 'ID потока/группы';


--
-- Name: COLUMN schedule.classroom_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schedule.classroom_id IS 'ID аудитории';


--
-- Name: COLUMN schedule.lesson_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schedule.lesson_type IS 'тип занятия/контрольного мероприятия';


--
-- Name: COLUMN schedule.is_closed; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schedule.is_closed IS 'Признак закрытия ведомости';


--
-- Name: spec_day_list; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE spec_day_list (
    day_id smallint,
    day_desc date,
    spec_desc character(64),
    holiday_ind boolean
);


ALTER TABLE public.spec_day_list OWNER TO postgres;

--
-- Name: TABLE spec_day_list; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE spec_day_list IS 'Описание/примечание для конкретного дня. Наименование праздника или указание о переносе вых. дня.';


--
-- Name: st_flow; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE st_flow (
    flow_id integer NOT NULL,
    flow_desc character(64),
    beg_date_id smallint,
    end_date_id smallint
);


ALTER TABLE public.st_flow OWNER TO postgres;

--
-- Name: TABLE st_flow; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE st_flow IS 'Учебный поток';


--
-- Name: st_flow_content; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE st_flow_content (
    flow_id integer,
    group_id integer
);


ALTER TABLE public.st_flow_content OWNER TO postgres;

--
-- Name: TABLE st_flow_content; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE st_flow_content IS 'Состав учебного потока.';


--
-- Name: st_flow_flow_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE st_flow_flow_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.st_flow_flow_id_seq OWNER TO postgres;

--
-- Name: st_flow_flow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE st_flow_flow_id_seq OWNED BY st_flow.flow_id;


--
-- Name: st_group; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE st_group (
    group_id integer NOT NULL,
    group_desc character(16),
    patr_id smallint,
    program_id integer,
    st_year_id smallint,
    cur_st_year_id smallint,
    year_cnt smallint,
    semestr_cnt smallint,
    stuff_cnt smallint,
    stuff_add smallint,
    decree_no character(24)
);


ALTER TABLE public.st_group OWNER TO postgres;

--
-- Name: TABLE st_group; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE st_group IS 'Учебные группы';


--
-- Name: COLUMN st_group.patr_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN st_group.patr_id IS 'Выпускающая кафедра';


--
-- Name: COLUMN st_group.st_year_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN st_group.st_year_id IS 'Год набора (учебный)';


--
-- Name: COLUMN st_group.cur_st_year_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN st_group.cur_st_year_id IS 'Текущий учебный год';


--
-- Name: COLUMN st_group.year_cnt; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN st_group.year_cnt IS 'Год обучения';


--
-- Name: COLUMN st_group.semestr_cnt; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN st_group.semestr_cnt IS 'Семестр обучения';


--
-- Name: COLUMN st_group.stuff_cnt; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN st_group.stuff_cnt IS 'списочный состав';


--
-- Name: COLUMN st_group.stuff_add; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN st_group.stuff_add IS 'количество "вольных" слушателей';


--
-- Name: st_group_content; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE st_group_content (
    contract_id integer NOT NULL,
    group_id integer NOT NULL,
    user_id integer,
    upd_dt date,
    semestr_id smallint
);


ALTER TABLE public.st_group_content OWNER TO postgres;

--
-- Name: TABLE st_group_content; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE st_group_content IS 'Состав учебных групп';


--
-- Name: st_group_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE st_group_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.st_group_group_id_seq OWNER TO postgres;

--
-- Name: st_group_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE st_group_group_id_seq OWNED BY st_group.group_id;


--
-- Name: st_group_hist; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE st_group_hist (
    contract_id integer,
    group_id integer,
    semestr_id smallint,
    beg_date_id smallint,
    ens_date_id smallint,
    user_id integer,
    prev_user_id integer
);


ALTER TABLE public.st_group_hist OWNER TO postgres;

--
-- Name: TABLE st_group_hist; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE st_group_hist IS 'Состав учебных групп история';


--
-- Name: contract_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contract_fact ALTER COLUMN contract_id SET DEFAULT nextval('contract_fact_contract_id_seq'::regclass);


--
-- Name: discipline_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lu_discipline ALTER COLUMN discipline_id SET DEFAULT nextval('lu_discipline_discipline_id_seq'::regclass);


--
-- Name: program_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lu_program ALTER COLUMN program_id SET DEFAULT nextval('lu_program_program_id_seq'::regclass);


--
-- Name: person_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY person ALTER COLUMN person_id SET DEFAULT nextval('person_person_id_seq'::regclass);


--
-- Name: flow_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY st_flow ALTER COLUMN flow_id SET DEFAULT nextval('st_flow_flow_id_seq'::regclass);


--
-- Name: group_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY st_group ALTER COLUMN group_id SET DEFAULT nextval('st_group_group_id_seq'::regclass);


--
-- Data for Name: auth_module; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_module (module_id, module_title, module_action, module_enabled, module_weight) FROM stdin;
2	Тестовый модуль	test	t	0
1	Производственный календарь	calendar	t	10
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_permission (permission_id, permission_name, permission_description, module_id) FROM stdin;
1	calendar_view       	Просмотр календаря                                                                                  	1
\.


--
-- Data for Name: auth_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_role (role_id, role_description, role_weight) FROM stdin;
2	Тест                            	50
1	Администратор                   	100
\.


--
-- Data for Name: auth_role_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_role_permission (role_id, permission_id, allowed) FROM stdin;
1	1	t
\.


--
-- Data for Name: auth_role_person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY auth_role_person (role_id, person_id) FROM stdin;
1	1
2	2
\.


--
-- Data for Name: ban; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ban (ip, time_start, time_end) FROM stdin;
192.168.65.4   	1418584361	1418595161
\.


--
-- Data for Name: contract_fact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY contract_fact (contract_id, person_id, patr_id, position_id, program_id, beg_date_id, end_date_id, decree_no, sign_person_id, contract_person_id, st_year_id, lang_1_id, lang_2_id) FROM stdin;
\.


--
-- Name: contract_fact_contract_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('contract_fact_contract_id_seq', 1, false);


--
-- Data for Name: disc_var_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY disc_var_detail (discipline_id, specific_id, lesson_type_id, lesson_num, lesson_title, lesson_comment) FROM stdin;
\.


--
-- Data for Name: disc_var_summary; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY disc_var_summary (discipline_id, specific_id, lesson_type_id, lesson_count, beg_date_id, end_date_id, in_use_flg) FROM stdin;
\.


--
-- Data for Name: journal_fact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY journal_fact (el_schedule_id, student_id, check_mark, upd_dt, user_id, ref_doc_id) FROM stdin;
\.


--
-- Data for Name: journal_hist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY journal_hist (el_schedule_id, student_id, check_mark, upd_dt, user_id, ref_doc_id) FROM stdin;
\.


--
-- Data for Name: lu_day; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lu_day (day_id, day_desc, st_semestr_id, month_id, week_of_semestr_id, day_description, day_of_week_id, day_of_week_desc, holiday_ind, day_of_month, day_of_year, lm_day, lq_day, ly_day) FROM stdin;
2	2010-01-02	\N	1	\N	2010-01-02                      	6	суббота         	t	2	2	\N	\N	\N
4	2010-01-04	\N	1	\N	2010-01-04                      	1	понедельник     	f	4	4	\N	\N	\N
5	2010-01-05	\N	1	\N	2010-01-05                      	2	вторник         	f	5	5	\N	\N	\N
6	2010-01-06	\N	1	\N	2010-01-06                      	3	среда           	f	6	6	\N	\N	\N
7	2010-01-07	\N	1	\N	2010-01-07                      	4	четверг         	f	7	7	\N	\N	\N
8	2010-01-08	\N	1	\N	2010-01-08                      	5	пятница         	f	8	8	\N	\N	\N
9	2010-01-09	\N	1	\N	2010-01-09                      	6	суббота         	t	9	9	\N	\N	\N
11	2010-01-11	\N	1	\N	2010-01-11                      	1	понедельник     	f	11	11	\N	\N	\N
12	2010-01-12	\N	1	\N	2010-01-12                      	2	вторник         	f	12	12	\N	\N	\N
13	2010-01-13	\N	1	\N	2010-01-13                      	3	среда           	f	13	13	\N	\N	\N
14	2010-01-14	\N	1	\N	2010-01-14                      	4	четверг         	f	14	14	\N	\N	\N
15	2010-01-15	\N	1	\N	2010-01-15                      	5	пятница         	f	15	15	\N	\N	\N
16	2010-01-16	\N	1	\N	2010-01-16                      	6	суббота         	t	16	16	\N	\N	\N
18	2010-01-18	\N	1	\N	2010-01-18                      	1	понедельник     	f	18	18	\N	\N	\N
19	2010-01-19	\N	1	\N	2010-01-19                      	2	вторник         	f	19	19	\N	\N	\N
20	2010-01-20	\N	1	\N	2010-01-20                      	3	среда           	f	20	20	\N	\N	\N
21	2010-01-21	\N	1	\N	2010-01-21                      	4	четверг         	f	21	21	\N	\N	\N
22	2010-01-22	\N	1	\N	2010-01-22                      	5	пятница         	f	22	22	\N	\N	\N
23	2010-01-23	\N	1	\N	2010-01-23                      	6	суббота         	t	23	23	\N	\N	\N
25	2010-01-25	\N	1	\N	2010-01-25                      	1	понедельник     	f	25	25	\N	\N	\N
26	2010-01-26	\N	1	\N	2010-01-26                      	2	вторник         	f	26	26	\N	\N	\N
27	2010-01-27	\N	1	\N	2010-01-27                      	3	среда           	f	27	27	\N	\N	\N
28	2010-01-28	\N	1	\N	2010-01-28                      	4	четверг         	f	28	28	\N	\N	\N
29	2010-01-29	\N	1	\N	2010-01-29                      	5	пятница         	f	29	29	\N	\N	\N
30	2010-01-30	\N	1	\N	2010-01-30                      	6	суббота         	t	30	30	\N	\N	\N
32	2010-02-01	\N	2	\N	2010-02-01                      	1	понедельник     	f	1	32	1	\N	\N
33	2010-02-02	\N	2	\N	2010-02-02                      	2	вторник         	f	2	33	2	\N	\N
34	2010-02-03	\N	2	\N	2010-02-03                      	3	среда           	f	3	34	3	\N	\N
35	2010-02-04	\N	2	\N	2010-02-04                      	4	четверг         	f	4	35	4	\N	\N
36	2010-02-05	\N	2	\N	2010-02-05                      	5	пятница         	f	5	36	5	\N	\N
37	2010-02-06	\N	2	\N	2010-02-06                      	6	суббота         	t	6	37	6	\N	\N
39	2010-02-08	\N	2	\N	2010-02-08                      	1	понедельник     	f	8	39	8	\N	\N
40	2010-02-09	\N	2	\N	2010-02-09                      	2	вторник         	f	9	40	9	\N	\N
41	2010-02-10	\N	2	\N	2010-02-10                      	3	среда           	f	10	41	10	\N	\N
42	2010-02-11	\N	2	\N	2010-02-11                      	4	четверг         	f	11	42	11	\N	\N
43	2010-02-12	\N	2	\N	2010-02-12                      	5	пятница         	f	12	43	12	\N	\N
44	2010-02-13	\N	2	\N	2010-02-13                      	6	суббота         	t	13	44	13	\N	\N
46	2010-02-15	\N	2	\N	2010-02-15                      	1	понедельник     	f	15	46	15	\N	\N
47	2010-02-16	\N	2	\N	2010-02-16                      	2	вторник         	f	16	47	16	\N	\N
48	2010-02-17	\N	2	\N	2010-02-17                      	3	среда           	f	17	48	17	\N	\N
49	2010-02-18	\N	2	\N	2010-02-18                      	4	четверг         	f	18	49	18	\N	\N
50	2010-02-19	\N	2	\N	2010-02-19                      	5	пятница         	f	19	50	19	\N	\N
51	2010-02-20	\N	2	\N	2010-02-20                      	6	суббота         	t	20	51	20	\N	\N
53	2010-02-22	\N	2	\N	2010-02-22                      	1	понедельник     	f	22	53	22	\N	\N
54	2010-02-23	\N	2	\N	2010-02-23                      	2	вторник         	f	23	54	23	\N	\N
55	2010-02-24	\N	2	\N	2010-02-24                      	3	среда           	f	24	55	24	\N	\N
56	2010-02-25	\N	2	\N	2010-02-25                      	4	четверг         	f	25	56	25	\N	\N
57	2010-02-26	\N	2	\N	2010-02-26                      	5	пятница         	f	26	57	26	\N	\N
58	2010-02-27	\N	2	\N	2010-02-27                      	6	суббота         	t	27	58	27	\N	\N
60	2010-03-01	\N	3	\N	2010-03-01                      	1	понедельник     	f	1	60	32	\N	\N
61	2010-03-02	\N	3	\N	2010-03-02                      	2	вторник         	f	2	61	33	\N	\N
62	2010-03-03	\N	3	\N	2010-03-03                      	3	среда           	f	3	62	34	\N	\N
63	2010-03-04	\N	3	\N	2010-03-04                      	4	четверг         	f	4	63	35	\N	\N
64	2010-03-05	\N	3	\N	2010-03-05                      	5	пятница         	f	5	64	36	\N	\N
65	2010-03-06	\N	3	\N	2010-03-06                      	6	суббота         	t	6	65	37	\N	\N
67	2010-03-08	\N	3	\N	2010-03-08                      	1	понедельник     	f	8	67	39	\N	\N
68	2010-03-09	\N	3	\N	2010-03-09                      	2	вторник         	f	9	68	40	\N	\N
69	2010-03-10	\N	3	\N	2010-03-10                      	3	среда           	f	10	69	41	\N	\N
1	2010-01-01	\N	1	\N	2010-01-01                      	5	пятница         	f	1	1	\N	\N	\N
70	2010-03-11	\N	3	\N	2010-03-11                      	4	четверг         	f	11	70	42	\N	\N
71	2010-03-12	\N	3	\N	2010-03-12                      	5	пятница         	f	12	71	43	\N	\N
72	2010-03-13	\N	3	\N	2010-03-13                      	6	суббота         	t	13	72	44	\N	\N
74	2010-03-15	\N	3	\N	2010-03-15                      	1	понедельник     	f	15	74	46	\N	\N
75	2010-03-16	\N	3	\N	2010-03-16                      	2	вторник         	f	16	75	47	\N	\N
76	2010-03-17	\N	3	\N	2010-03-17                      	3	среда           	f	17	76	48	\N	\N
77	2010-03-18	\N	3	\N	2010-03-18                      	4	четверг         	f	18	77	49	\N	\N
78	2010-03-19	\N	3	\N	2010-03-19                      	5	пятница         	f	19	78	50	\N	\N
79	2010-03-20	\N	3	\N	2010-03-20                      	6	суббота         	t	20	79	51	\N	\N
81	2010-03-22	\N	3	\N	2010-03-22                      	1	понедельник     	f	22	81	53	\N	\N
82	2010-03-23	\N	3	\N	2010-03-23                      	2	вторник         	f	23	82	54	\N	\N
83	2010-03-24	\N	3	\N	2010-03-24                      	3	среда           	f	24	83	55	\N	\N
84	2010-03-25	\N	3	\N	2010-03-25                      	4	четверг         	f	25	84	56	\N	\N
85	2010-03-26	\N	3	\N	2010-03-26                      	5	пятница         	f	26	85	57	\N	\N
86	2010-03-27	\N	3	\N	2010-03-27                      	6	суббота         	t	27	86	58	\N	\N
88	2010-03-29	\N	3	\N	2010-03-29                      	1	понедельник     	f	29	88	59	\N	\N
89	2010-03-30	\N	3	\N	2010-03-30                      	2	вторник         	f	30	89	59	\N	\N
90	2010-03-31	\N	3	\N	2010-03-31                      	3	среда           	f	31	90	59	\N	\N
91	2010-04-01	\N	4	\N	2010-04-01                      	4	четверг         	f	1	91	60	1	\N
92	2010-04-02	\N	4	\N	2010-04-02                      	5	пятница         	f	2	92	61	2	\N
93	2010-04-03	\N	4	\N	2010-04-03                      	6	суббота         	t	3	93	62	3	\N
95	2010-04-05	\N	4	\N	2010-04-05                      	1	понедельник     	f	5	95	64	5	\N
96	2010-04-06	\N	4	\N	2010-04-06                      	2	вторник         	f	6	96	65	6	\N
97	2010-04-07	\N	4	\N	2010-04-07                      	3	среда           	f	7	97	66	7	\N
98	2010-04-08	\N	4	\N	2010-04-08                      	4	четверг         	f	8	98	67	8	\N
99	2010-04-09	\N	4	\N	2010-04-09                      	5	пятница         	f	9	99	68	9	\N
100	2010-04-10	\N	4	\N	2010-04-10                      	6	суббота         	t	10	100	69	10	\N
102	2010-04-12	\N	4	\N	2010-04-12                      	1	понедельник     	f	12	102	71	12	\N
103	2010-04-13	\N	4	\N	2010-04-13                      	2	вторник         	f	13	103	72	13	\N
104	2010-04-14	\N	4	\N	2010-04-14                      	3	среда           	f	14	104	73	14	\N
105	2010-04-15	\N	4	\N	2010-04-15                      	4	четверг         	f	15	105	74	15	\N
106	2010-04-16	\N	4	\N	2010-04-16                      	5	пятница         	f	16	106	75	16	\N
107	2010-04-17	\N	4	\N	2010-04-17                      	6	суббота         	t	17	107	76	17	\N
109	2010-04-19	\N	4	\N	2010-04-19                      	1	понедельник     	f	19	109	78	19	\N
110	2010-04-20	\N	4	\N	2010-04-20                      	2	вторник         	f	20	110	79	20	\N
111	2010-04-21	\N	4	\N	2010-04-21                      	3	среда           	f	21	111	80	21	\N
112	2010-04-22	\N	4	\N	2010-04-22                      	4	четверг         	f	22	112	81	22	\N
113	2010-04-23	\N	4	\N	2010-04-23                      	5	пятница         	f	23	113	82	23	\N
114	2010-04-24	\N	4	\N	2010-04-24                      	6	суббота         	t	24	114	83	24	\N
116	2010-04-26	\N	4	\N	2010-04-26                      	1	понедельник     	f	26	116	85	26	\N
117	2010-04-27	\N	4	\N	2010-04-27                      	2	вторник         	f	27	117	86	27	\N
118	2010-04-28	\N	4	\N	2010-04-28                      	3	среда           	f	28	118	87	28	\N
119	2010-04-29	\N	4	\N	2010-04-29                      	4	четверг         	f	29	119	88	29	\N
120	2010-04-30	\N	4	\N	2010-04-30                      	5	пятница         	f	30	120	89	30	\N
121	2010-05-01	\N	5	\N	2010-05-01                      	6	суббота         	t	1	121	91	32	\N
123	2010-05-03	\N	5	\N	2010-05-03                      	1	понедельник     	f	3	123	93	34	\N
124	2010-05-04	\N	5	\N	2010-05-04                      	2	вторник         	f	4	124	94	35	\N
125	2010-05-05	\N	5	\N	2010-05-05                      	3	среда           	f	5	125	95	36	\N
126	2010-05-06	\N	5	\N	2010-05-06                      	4	четверг         	f	6	126	96	37	\N
127	2010-05-07	\N	5	\N	2010-05-07                      	5	пятница         	f	7	127	97	38	\N
128	2010-05-08	\N	5	\N	2010-05-08                      	6	суббота         	t	8	128	98	39	\N
130	2010-05-10	\N	5	\N	2010-05-10                      	1	понедельник     	f	10	130	100	41	\N
131	2010-05-11	\N	5	\N	2010-05-11                      	2	вторник         	f	11	131	101	42	\N
132	2010-05-12	\N	5	\N	2010-05-12                      	3	среда           	f	12	132	102	43	\N
133	2010-05-13	\N	5	\N	2010-05-13                      	4	четверг         	f	13	133	103	44	\N
134	2010-05-14	\N	5	\N	2010-05-14                      	5	пятница         	f	14	134	104	45	\N
135	2010-05-15	\N	5	\N	2010-05-15                      	6	суббота         	t	15	135	105	46	\N
137	2010-05-17	\N	5	\N	2010-05-17                      	1	понедельник     	f	17	137	107	48	\N
138	2010-05-18	\N	5	\N	2010-05-18                      	2	вторник         	f	18	138	108	49	\N
139	2010-05-19	\N	5	\N	2010-05-19                      	3	среда           	f	19	139	109	50	\N
140	2010-05-20	\N	5	\N	2010-05-20                      	4	четверг         	f	20	140	110	51	\N
141	2010-05-21	\N	5	\N	2010-05-21                      	5	пятница         	f	21	141	111	52	\N
142	2010-05-22	\N	5	\N	2010-05-22                      	6	суббота         	t	22	142	112	53	\N
144	2010-05-24	\N	5	\N	2010-05-24                      	1	понедельник     	f	24	144	114	55	\N
145	2010-05-25	\N	5	\N	2010-05-25                      	2	вторник         	f	25	145	115	56	\N
146	2010-05-26	\N	5	\N	2010-05-26                      	3	среда           	f	26	146	116	57	\N
147	2010-05-27	\N	5	\N	2010-05-27                      	4	четверг         	f	27	147	117	58	\N
148	2010-05-28	\N	5	\N	2010-05-28                      	5	пятница         	f	28	148	118	59	\N
149	2010-05-29	\N	5	\N	2010-05-29                      	6	суббота         	t	29	149	119	59	\N
151	2010-05-31	\N	5	\N	2010-05-31                      	1	понедельник     	f	31	151	120	59	\N
152	2010-06-01	\N	6	\N	2010-06-01                      	2	вторник         	f	1	152	121	60	\N
153	2010-06-02	\N	6	\N	2010-06-02                      	3	среда           	f	2	153	122	61	\N
154	2010-06-03	\N	6	\N	2010-06-03                      	4	четверг         	f	3	154	123	62	\N
155	2010-06-04	\N	6	\N	2010-06-04                      	5	пятница         	f	4	155	124	63	\N
156	2010-06-05	\N	6	\N	2010-06-05                      	6	суббота         	t	5	156	125	64	\N
158	2010-06-07	\N	6	\N	2010-06-07                      	1	понедельник     	f	7	158	127	66	\N
159	2010-06-08	\N	6	\N	2010-06-08                      	2	вторник         	f	8	159	128	67	\N
160	2010-06-09	\N	6	\N	2010-06-09                      	3	среда           	f	9	160	129	68	\N
161	2010-06-10	\N	6	\N	2010-06-10                      	4	четверг         	f	10	161	130	69	\N
162	2010-06-11	\N	6	\N	2010-06-11                      	5	пятница         	f	11	162	131	70	\N
163	2010-06-12	\N	6	\N	2010-06-12                      	6	суббота         	t	12	163	132	71	\N
165	2010-06-14	\N	6	\N	2010-06-14                      	1	понедельник     	f	14	165	134	73	\N
166	2010-06-15	\N	6	\N	2010-06-15                      	2	вторник         	f	15	166	135	74	\N
167	2010-06-16	\N	6	\N	2010-06-16                      	3	среда           	f	16	167	136	75	\N
168	2010-06-17	\N	6	\N	2010-06-17                      	4	четверг         	f	17	168	137	76	\N
169	2010-06-18	\N	6	\N	2010-06-18                      	5	пятница         	f	18	169	138	77	\N
170	2010-06-19	\N	6	\N	2010-06-19                      	6	суббота         	t	19	170	139	78	\N
172	2010-06-21	\N	6	\N	2010-06-21                      	1	понедельник     	f	21	172	141	80	\N
173	2010-06-22	\N	6	\N	2010-06-22                      	2	вторник         	f	22	173	142	81	\N
174	2010-06-23	\N	6	\N	2010-06-23                      	3	среда           	f	23	174	143	82	\N
175	2010-06-24	\N	6	\N	2010-06-24                      	4	четверг         	f	24	175	144	83	\N
176	2010-06-25	\N	6	\N	2010-06-25                      	5	пятница         	f	25	176	145	84	\N
177	2010-06-26	\N	6	\N	2010-06-26                      	6	суббота         	t	26	177	146	85	\N
179	2010-06-28	\N	6	\N	2010-06-28                      	1	понедельник     	f	28	179	148	87	\N
180	2010-06-29	\N	6	\N	2010-06-29                      	2	вторник         	f	29	180	149	88	\N
181	2010-06-30	\N	6	\N	2010-06-30                      	3	среда           	f	30	181	150	89	\N
182	2010-07-01	\N	7	\N	2010-07-01                      	4	четверг         	f	1	182	152	91	\N
183	2010-07-02	\N	7	\N	2010-07-02                      	5	пятница         	f	2	183	153	92	\N
184	2010-07-03	\N	7	\N	2010-07-03                      	6	суббота         	t	3	184	154	93	\N
186	2010-07-05	\N	7	\N	2010-07-05                      	1	понедельник     	f	5	186	156	95	\N
187	2010-07-06	\N	7	\N	2010-07-06                      	2	вторник         	f	6	187	157	96	\N
188	2010-07-07	\N	7	\N	2010-07-07                      	3	среда           	f	7	188	158	97	\N
189	2010-07-08	\N	7	\N	2010-07-08                      	4	четверг         	f	8	189	159	98	\N
190	2010-07-09	\N	7	\N	2010-07-09                      	5	пятница         	f	9	190	160	99	\N
191	2010-07-10	\N	7	\N	2010-07-10                      	6	суббота         	t	10	191	161	100	\N
193	2010-07-12	\N	7	\N	2010-07-12                      	1	понедельник     	f	12	193	163	102	\N
194	2010-07-13	\N	7	\N	2010-07-13                      	2	вторник         	f	13	194	164	103	\N
195	2010-07-14	\N	7	\N	2010-07-14                      	3	среда           	f	14	195	165	104	\N
196	2010-07-15	\N	7	\N	2010-07-15                      	4	четверг         	f	15	196	166	105	\N
197	2010-07-16	\N	7	\N	2010-07-16                      	5	пятница         	f	16	197	167	106	\N
198	2010-07-17	\N	7	\N	2010-07-17                      	6	суббота         	t	17	198	168	107	\N
200	2010-07-19	\N	7	\N	2010-07-19                      	1	понедельник     	f	19	200	170	109	\N
201	2010-07-20	\N	7	\N	2010-07-20                      	2	вторник         	f	20	201	171	110	\N
202	2010-07-21	\N	7	\N	2010-07-21                      	3	среда           	f	21	202	172	111	\N
203	2010-07-22	\N	7	\N	2010-07-22                      	4	четверг         	f	22	203	173	112	\N
204	2010-07-23	\N	7	\N	2010-07-23                      	5	пятница         	f	23	204	174	113	\N
205	2010-07-24	\N	7	\N	2010-07-24                      	6	суббота         	t	24	205	175	114	\N
207	2010-07-26	\N	7	\N	2010-07-26                      	1	понедельник     	f	26	207	177	116	\N
208	2010-07-27	\N	7	\N	2010-07-27                      	2	вторник         	f	27	208	178	117	\N
209	2010-07-28	\N	7	\N	2010-07-28                      	3	среда           	f	28	209	179	118	\N
210	2010-07-29	\N	7	\N	2010-07-29                      	4	четверг         	f	29	210	180	119	\N
211	2010-07-30	\N	7	\N	2010-07-30                      	5	пятница         	f	30	211	181	120	\N
212	2010-07-31	\N	7	\N	2010-07-31                      	6	суббота         	t	31	212	181	120	\N
214	2010-08-02	\N	8	\N	2010-08-02                      	1	понедельник     	f	2	214	183	122	\N
215	2010-08-03	\N	8	\N	2010-08-03                      	2	вторник         	f	3	215	184	123	\N
216	2010-08-04	\N	8	\N	2010-08-04                      	3	среда           	f	4	216	185	124	\N
217	2010-08-05	\N	8	\N	2010-08-05                      	4	четверг         	f	5	217	186	125	\N
218	2010-08-06	\N	8	\N	2010-08-06                      	5	пятница         	f	6	218	187	126	\N
219	2010-08-07	\N	8	\N	2010-08-07                      	6	суббота         	t	7	219	188	127	\N
221	2010-08-09	\N	8	\N	2010-08-09                      	1	понедельник     	f	9	221	190	129	\N
222	2010-08-10	\N	8	\N	2010-08-10                      	2	вторник         	f	10	222	191	130	\N
223	2010-08-11	\N	8	\N	2010-08-11                      	3	среда           	f	11	223	192	131	\N
224	2010-08-12	\N	8	\N	2010-08-12                      	4	четверг         	f	12	224	193	132	\N
225	2010-08-13	\N	8	\N	2010-08-13                      	5	пятница         	f	13	225	194	133	\N
226	2010-08-14	\N	8	\N	2010-08-14                      	6	суббота         	t	14	226	195	134	\N
228	2010-08-16	\N	8	\N	2010-08-16                      	1	понедельник     	f	16	228	197	136	\N
229	2010-08-17	\N	8	\N	2010-08-17                      	2	вторник         	f	17	229	198	137	\N
230	2010-08-18	\N	8	\N	2010-08-18                      	3	среда           	f	18	230	199	138	\N
231	2010-08-19	\N	8	\N	2010-08-19                      	4	четверг         	f	19	231	200	139	\N
232	2010-08-20	\N	8	\N	2010-08-20                      	5	пятница         	f	20	232	201	140	\N
233	2010-08-21	\N	8	\N	2010-08-21                      	6	суббота         	t	21	233	202	141	\N
235	2010-08-23	\N	8	\N	2010-08-23                      	1	понедельник     	f	23	235	204	143	\N
236	2010-08-24	\N	8	\N	2010-08-24                      	2	вторник         	f	24	236	205	144	\N
237	2010-08-25	\N	8	\N	2010-08-25                      	3	среда           	f	25	237	206	145	\N
238	2010-08-26	\N	8	\N	2010-08-26                      	4	четверг         	f	26	238	207	146	\N
239	2010-08-27	\N	8	\N	2010-08-27                      	5	пятница         	f	27	239	208	147	\N
240	2010-08-28	\N	8	\N	2010-08-28                      	6	суббота         	t	28	240	209	148	\N
242	2010-08-30	\N	8	\N	2010-08-30                      	1	понедельник     	f	30	242	211	150	\N
243	2010-08-31	\N	8	\N	2010-08-31                      	2	вторник         	f	31	243	212	151	\N
244	2010-09-01	\N	9	\N	2010-09-01                      	3	среда           	f	1	244	213	152	\N
245	2010-09-02	\N	9	\N	2010-09-02                      	4	четверг         	f	2	245	214	153	\N
246	2010-09-03	\N	9	\N	2010-09-03                      	5	пятница         	f	3	246	215	154	\N
247	2010-09-04	\N	9	\N	2010-09-04                      	6	суббота         	t	4	247	216	155	\N
249	2010-09-06	\N	9	\N	2010-09-06                      	1	понедельник     	f	6	249	218	157	\N
250	2010-09-07	\N	9	\N	2010-09-07                      	2	вторник         	f	7	250	219	158	\N
251	2010-09-08	\N	9	\N	2010-09-08                      	3	среда           	f	8	251	220	159	\N
252	2010-09-09	\N	9	\N	2010-09-09                      	4	четверг         	f	9	252	221	160	\N
253	2010-09-10	\N	9	\N	2010-09-10                      	5	пятница         	f	10	253	222	161	\N
254	2010-09-11	\N	9	\N	2010-09-11                      	6	суббота         	t	11	254	223	162	\N
256	2010-09-13	\N	9	\N	2010-09-13                      	1	понедельник     	f	13	256	225	164	\N
257	2010-09-14	\N	9	\N	2010-09-14                      	2	вторник         	f	14	257	226	165	\N
258	2010-09-15	\N	9	\N	2010-09-15                      	3	среда           	f	15	258	227	166	\N
259	2010-09-16	\N	9	\N	2010-09-16                      	4	четверг         	f	16	259	228	167	\N
260	2010-09-17	\N	9	\N	2010-09-17                      	5	пятница         	f	17	260	229	168	\N
261	2010-09-18	\N	9	\N	2010-09-18                      	6	суббота         	t	18	261	230	169	\N
263	2010-09-20	\N	9	\N	2010-09-20                      	1	понедельник     	f	20	263	232	171	\N
264	2010-09-21	\N	9	\N	2010-09-21                      	2	вторник         	f	21	264	233	172	\N
265	2010-09-22	\N	9	\N	2010-09-22                      	3	среда           	f	22	265	234	173	\N
266	2010-09-23	\N	9	\N	2010-09-23                      	4	четверг         	f	23	266	235	174	\N
267	2010-09-24	\N	9	\N	2010-09-24                      	5	пятница         	f	24	267	236	175	\N
268	2010-09-25	\N	9	\N	2010-09-25                      	6	суббота         	t	25	268	237	176	\N
270	2010-09-27	\N	9	\N	2010-09-27                      	1	понедельник     	f	27	270	239	178	\N
271	2010-09-28	\N	9	\N	2010-09-28                      	2	вторник         	f	28	271	240	179	\N
272	2010-09-29	\N	9	\N	2010-09-29                      	3	среда           	f	29	272	241	180	\N
273	2010-09-30	\N	9	\N	2010-09-30                      	4	четверг         	f	30	273	242	181	\N
274	2010-10-01	\N	10	\N	2010-10-01                      	5	пятница         	f	1	274	244	182	\N
275	2010-10-02	\N	10	\N	2010-10-02                      	6	суббота         	t	2	275	245	183	\N
277	2010-10-04	\N	10	\N	2010-10-04                      	1	понедельник     	f	4	277	247	185	\N
278	2010-10-05	\N	10	\N	2010-10-05                      	2	вторник         	f	5	278	248	186	\N
279	2010-10-06	\N	10	\N	2010-10-06                      	3	среда           	f	6	279	249	187	\N
280	2010-10-07	\N	10	\N	2010-10-07                      	4	четверг         	f	7	280	250	188	\N
281	2010-10-08	\N	10	\N	2010-10-08                      	5	пятница         	f	8	281	251	189	\N
282	2010-10-09	\N	10	\N	2010-10-09                      	6	суббота         	t	9	282	252	190	\N
284	2010-10-11	\N	10	\N	2010-10-11                      	1	понедельник     	f	11	284	254	192	\N
285	2010-10-12	\N	10	\N	2010-10-12                      	2	вторник         	f	12	285	255	193	\N
286	2010-10-13	\N	10	\N	2010-10-13                      	3	среда           	f	13	286	256	194	\N
287	2010-10-14	\N	10	\N	2010-10-14                      	4	четверг         	f	14	287	257	195	\N
288	2010-10-15	\N	10	\N	2010-10-15                      	5	пятница         	f	15	288	258	196	\N
289	2010-10-16	\N	10	\N	2010-10-16                      	6	суббота         	t	16	289	259	197	\N
291	2010-10-18	\N	10	\N	2010-10-18                      	1	понедельник     	f	18	291	261	199	\N
292	2010-10-19	\N	10	\N	2010-10-19                      	2	вторник         	f	19	292	262	200	\N
293	2010-10-20	\N	10	\N	2010-10-20                      	3	среда           	f	20	293	263	201	\N
294	2010-10-21	\N	10	\N	2010-10-21                      	4	четверг         	f	21	294	264	202	\N
295	2010-10-22	\N	10	\N	2010-10-22                      	5	пятница         	f	22	295	265	203	\N
296	2010-10-23	\N	10	\N	2010-10-23                      	6	суббота         	t	23	296	266	204	\N
298	2010-10-25	\N	10	\N	2010-10-25                      	1	понедельник     	f	25	298	268	206	\N
299	2010-10-26	\N	10	\N	2010-10-26                      	2	вторник         	f	26	299	269	207	\N
300	2010-10-27	\N	10	\N	2010-10-27                      	3	среда           	f	27	300	270	208	\N
301	2010-10-28	\N	10	\N	2010-10-28                      	4	четверг         	f	28	301	271	209	\N
302	2010-10-29	\N	10	\N	2010-10-29                      	5	пятница         	f	29	302	272	210	\N
303	2010-10-30	\N	10	\N	2010-10-30                      	6	суббота         	t	30	303	273	211	\N
305	2010-11-01	\N	11	\N	2010-11-01                      	1	понедельник     	f	1	305	274	213	\N
306	2010-11-02	\N	11	\N	2010-11-02                      	2	вторник         	f	2	306	275	214	\N
307	2010-11-03	\N	11	\N	2010-11-03                      	3	среда           	f	3	307	276	215	\N
308	2010-11-04	\N	11	\N	2010-11-04                      	4	четверг         	f	4	308	277	216	\N
309	2010-11-05	\N	11	\N	2010-11-05                      	5	пятница         	f	5	309	278	217	\N
310	2010-11-06	\N	11	\N	2010-11-06                      	6	суббота         	t	6	310	279	218	\N
312	2010-11-08	\N	11	\N	2010-11-08                      	1	понедельник     	f	8	312	281	220	\N
313	2010-11-09	\N	11	\N	2010-11-09                      	2	вторник         	f	9	313	282	221	\N
314	2010-11-10	\N	11	\N	2010-11-10                      	3	среда           	f	10	314	283	222	\N
315	2010-11-11	\N	11	\N	2010-11-11                      	4	четверг         	f	11	315	284	223	\N
316	2010-11-12	\N	11	\N	2010-11-12                      	5	пятница         	f	12	316	285	224	\N
317	2010-11-13	\N	11	\N	2010-11-13                      	6	суббота         	t	13	317	286	225	\N
319	2010-11-15	\N	11	\N	2010-11-15                      	1	понедельник     	f	15	319	288	227	\N
320	2010-11-16	\N	11	\N	2010-11-16                      	2	вторник         	f	16	320	289	228	\N
321	2010-11-17	\N	11	\N	2010-11-17                      	3	среда           	f	17	321	290	229	\N
322	2010-11-18	\N	11	\N	2010-11-18                      	4	четверг         	f	18	322	291	230	\N
323	2010-11-19	\N	11	\N	2010-11-19                      	5	пятница         	f	19	323	292	231	\N
324	2010-11-20	\N	11	\N	2010-11-20                      	6	суббота         	t	20	324	293	232	\N
326	2010-11-22	\N	11	\N	2010-11-22                      	1	понедельник     	f	22	326	295	234	\N
327	2010-11-23	\N	11	\N	2010-11-23                      	2	вторник         	f	23	327	296	235	\N
328	2010-11-24	\N	11	\N	2010-11-24                      	3	среда           	f	24	328	297	236	\N
329	2010-11-25	\N	11	\N	2010-11-25                      	4	четверг         	f	25	329	298	237	\N
330	2010-11-26	\N	11	\N	2010-11-26                      	5	пятница         	f	26	330	299	238	\N
331	2010-11-27	\N	11	\N	2010-11-27                      	6	суббота         	t	27	331	300	239	\N
333	2010-11-29	\N	11	\N	2010-11-29                      	1	понедельник     	f	29	333	302	241	\N
334	2010-11-30	\N	11	\N	2010-11-30                      	2	вторник         	f	30	334	303	242	\N
335	2010-12-01	\N	12	\N	2010-12-01                      	3	среда           	f	1	335	305	244	\N
336	2010-12-02	\N	12	\N	2010-12-02                      	4	четверг         	f	2	336	306	245	\N
337	2010-12-03	\N	12	\N	2010-12-03                      	5	пятница         	f	3	337	307	246	\N
338	2010-12-04	\N	12	\N	2010-12-04                      	6	суббота         	t	4	338	308	247	\N
340	2010-12-06	\N	12	\N	2010-12-06                      	1	понедельник     	f	6	340	310	249	\N
341	2010-12-07	\N	12	\N	2010-12-07                      	2	вторник         	f	7	341	311	250	\N
342	2010-12-08	\N	12	\N	2010-12-08                      	3	среда           	f	8	342	312	251	\N
343	2010-12-09	\N	12	\N	2010-12-09                      	4	четверг         	f	9	343	313	252	\N
344	2010-12-10	\N	12	\N	2010-12-10                      	5	пятница         	f	10	344	314	253	\N
345	2010-12-11	\N	12	\N	2010-12-11                      	6	суббота         	t	11	345	315	254	\N
347	2010-12-13	\N	12	\N	2010-12-13                      	1	понедельник     	f	13	347	317	256	\N
348	2010-12-14	\N	12	\N	2010-12-14                      	2	вторник         	f	14	348	318	257	\N
349	2010-12-15	\N	12	\N	2010-12-15                      	3	среда           	f	15	349	319	258	\N
350	2010-12-16	\N	12	\N	2010-12-16                      	4	четверг         	f	16	350	320	259	\N
351	2010-12-17	\N	12	\N	2010-12-17                      	5	пятница         	f	17	351	321	260	\N
352	2010-12-18	\N	12	\N	2010-12-18                      	6	суббота         	t	18	352	322	261	\N
354	2010-12-20	\N	12	\N	2010-12-20                      	1	понедельник     	f	20	354	324	263	\N
355	2010-12-21	\N	12	\N	2010-12-21                      	2	вторник         	f	21	355	325	264	\N
356	2010-12-22	\N	12	\N	2010-12-22                      	3	среда           	f	22	356	326	265	\N
357	2010-12-23	\N	12	\N	2010-12-23                      	4	четверг         	f	23	357	327	266	\N
358	2010-12-24	\N	12	\N	2010-12-24                      	5	пятница         	f	24	358	328	267	\N
359	2010-12-25	\N	12	\N	2010-12-25                      	6	суббота         	t	25	359	329	268	\N
361	2010-12-27	\N	12	\N	2010-12-27                      	1	понедельник     	f	27	361	331	270	\N
362	2010-12-28	\N	12	\N	2010-12-28                      	2	вторник         	f	28	362	332	271	\N
363	2010-12-29	\N	12	\N	2010-12-29                      	3	среда           	f	29	363	333	272	\N
364	2010-12-30	\N	12	\N	2010-12-30                      	4	четверг         	f	30	364	334	273	\N
365	2010-12-31	\N	12	\N	2010-12-31                      	5	пятница         	f	31	365	334	273	\N
366	2011-01-01	\N	13	\N	2011-01-01                      	6	суббота         	t	1	1	335	274	1
368	2011-01-03	\N	13	\N	2011-01-03                      	1	понедельник     	f	3	3	337	276	3
369	2011-01-04	\N	13	\N	2011-01-04                      	2	вторник         	f	4	4	338	277	4
370	2011-01-05	\N	13	\N	2011-01-05                      	3	среда           	f	5	5	339	278	5
371	2011-01-06	\N	13	\N	2011-01-06                      	4	четверг         	f	6	6	340	279	6
372	2011-01-07	\N	13	\N	2011-01-07                      	5	пятница         	f	7	7	341	280	7
373	2011-01-08	\N	13	\N	2011-01-08                      	6	суббота         	t	8	8	342	281	8
375	2011-01-10	\N	13	\N	2011-01-10                      	1	понедельник     	f	10	10	344	283	10
376	2011-01-11	\N	13	\N	2011-01-11                      	2	вторник         	f	11	11	345	284	11
377	2011-01-12	\N	13	\N	2011-01-12                      	3	среда           	f	12	12	346	285	12
378	2011-01-13	\N	13	\N	2011-01-13                      	4	четверг         	f	13	13	347	286	13
379	2011-01-14	\N	13	\N	2011-01-14                      	5	пятница         	f	14	14	348	287	14
380	2011-01-15	\N	13	\N	2011-01-15                      	6	суббота         	t	15	15	349	288	15
382	2011-01-17	\N	13	\N	2011-01-17                      	1	понедельник     	f	17	17	351	290	17
383	2011-01-18	\N	13	\N	2011-01-18                      	2	вторник         	f	18	18	352	291	18
384	2011-01-19	\N	13	\N	2011-01-19                      	3	среда           	f	19	19	353	292	19
385	2011-01-20	\N	13	\N	2011-01-20                      	4	четверг         	f	20	20	354	293	20
386	2011-01-21	\N	13	\N	2011-01-21                      	5	пятница         	f	21	21	355	294	21
387	2011-01-22	\N	13	\N	2011-01-22                      	6	суббота         	t	22	22	356	295	22
389	2011-01-24	\N	13	\N	2011-01-24                      	1	понедельник     	f	24	24	358	297	24
390	2011-01-25	\N	13	\N	2011-01-25                      	2	вторник         	f	25	25	359	298	25
391	2011-01-26	\N	13	\N	2011-01-26                      	3	среда           	f	26	26	360	299	26
392	2011-01-27	\N	13	\N	2011-01-27                      	4	четверг         	f	27	27	361	300	27
393	2011-01-28	\N	13	\N	2011-01-28                      	5	пятница         	f	28	28	362	301	28
394	2011-01-29	\N	13	\N	2011-01-29                      	6	суббота         	t	29	29	363	302	29
396	2011-01-31	\N	13	\N	2011-01-31                      	1	понедельник     	f	31	31	365	304	31
397	2011-02-01	\N	14	\N	2011-02-01                      	2	вторник         	f	1	32	366	305	32
398	2011-02-02	\N	14	\N	2011-02-02                      	3	среда           	f	2	33	367	306	33
399	2011-02-03	\N	14	\N	2011-02-03                      	4	четверг         	f	3	34	368	307	34
400	2011-02-04	\N	14	\N	2011-02-04                      	5	пятница         	f	4	35	369	308	35
401	2011-02-05	\N	14	\N	2011-02-05                      	6	суббота         	t	5	36	370	309	36
403	2011-02-07	\N	14	\N	2011-02-07                      	1	понедельник     	f	7	38	372	311	38
404	2011-02-08	\N	14	\N	2011-02-08                      	2	вторник         	f	8	39	373	312	39
405	2011-02-09	\N	14	\N	2011-02-09                      	3	среда           	f	9	40	374	313	40
406	2011-02-10	\N	14	\N	2011-02-10                      	4	четверг         	f	10	41	375	314	41
407	2011-02-11	\N	14	\N	2011-02-11                      	5	пятница         	f	11	42	376	315	42
408	2011-02-12	\N	14	\N	2011-02-12                      	6	суббота         	t	12	43	377	316	43
410	2011-02-14	\N	14	\N	2011-02-14                      	1	понедельник     	f	14	45	379	318	45
411	2011-02-15	\N	14	\N	2011-02-15                      	2	вторник         	f	15	46	380	319	46
412	2011-02-16	\N	14	\N	2011-02-16                      	3	среда           	f	16	47	381	320	47
413	2011-02-17	\N	14	\N	2011-02-17                      	4	четверг         	f	17	48	382	321	48
414	2011-02-18	\N	14	\N	2011-02-18                      	5	пятница         	f	18	49	383	322	49
415	2011-02-19	\N	14	\N	2011-02-19                      	6	суббота         	t	19	50	384	323	50
417	2011-02-21	\N	14	\N	2011-02-21                      	1	понедельник     	f	21	52	386	325	52
418	2011-02-22	\N	14	\N	2011-02-22                      	2	вторник         	f	22	53	387	326	53
419	2011-02-23	\N	14	\N	2011-02-23                      	3	среда           	f	23	54	388	327	54
420	2011-02-24	\N	14	\N	2011-02-24                      	4	четверг         	f	24	55	389	328	55
421	2011-02-25	\N	14	\N	2011-02-25                      	5	пятница         	f	25	56	390	329	56
422	2011-02-26	\N	14	\N	2011-02-26                      	6	суббота         	t	26	57	391	330	57
424	2011-02-28	\N	14	\N	2011-02-28                      	1	понедельник     	f	28	59	393	332	59
425	2011-03-01	\N	15	\N	2011-03-01                      	2	вторник         	f	1	60	397	335	60
426	2011-03-02	\N	15	\N	2011-03-02                      	3	среда           	f	2	61	398	336	61
427	2011-03-03	\N	15	\N	2011-03-03                      	4	четверг         	f	3	62	399	337	62
428	2011-03-04	\N	15	\N	2011-03-04                      	5	пятница         	f	4	63	400	338	63
429	2011-03-05	\N	15	\N	2011-03-05                      	6	суббота         	t	5	64	401	339	64
431	2011-03-07	\N	15	\N	2011-03-07                      	1	понедельник     	f	7	66	403	341	66
432	2011-03-08	\N	15	\N	2011-03-08                      	2	вторник         	f	8	67	404	342	67
433	2011-03-09	\N	15	\N	2011-03-09                      	3	среда           	f	9	68	405	343	68
434	2011-03-10	\N	15	\N	2011-03-10                      	4	четверг         	f	10	69	406	344	69
435	2011-03-11	\N	15	\N	2011-03-11                      	5	пятница         	f	11	70	407	345	70
436	2011-03-12	\N	15	\N	2011-03-12                      	6	суббота         	t	12	71	408	346	71
438	2011-03-14	\N	15	\N	2011-03-14                      	1	понедельник     	f	14	73	410	348	73
439	2011-03-15	\N	15	\N	2011-03-15                      	2	вторник         	f	15	74	411	349	74
440	2011-03-16	\N	15	\N	2011-03-16                      	3	среда           	f	16	75	412	350	75
441	2011-03-17	\N	15	\N	2011-03-17                      	4	четверг         	f	17	76	413	351	76
442	2011-03-18	\N	15	\N	2011-03-18                      	5	пятница         	f	18	77	414	352	77
443	2011-03-19	\N	15	\N	2011-03-19                      	6	суббота         	t	19	78	415	353	78
445	2011-03-21	\N	15	\N	2011-03-21                      	1	понедельник     	f	21	80	417	355	80
446	2011-03-22	\N	15	\N	2011-03-22                      	2	вторник         	f	22	81	418	356	81
447	2011-03-23	\N	15	\N	2011-03-23                      	3	среда           	f	23	82	419	357	82
448	2011-03-24	\N	15	\N	2011-03-24                      	4	четверг         	f	24	83	420	358	83
449	2011-03-25	\N	15	\N	2011-03-25                      	5	пятница         	f	25	84	421	359	84
450	2011-03-26	\N	15	\N	2011-03-26                      	6	суббота         	t	26	85	422	360	85
452	2011-03-28	\N	15	\N	2011-03-28                      	1	понедельник     	f	28	87	424	362	87
453	2011-03-29	\N	15	\N	2011-03-29                      	2	вторник         	f	29	88	424	363	88
454	2011-03-30	\N	15	\N	2011-03-30                      	3	среда           	f	30	89	424	364	89
455	2011-03-31	\N	15	\N	2011-03-31                      	4	четверг         	f	31	90	424	365	90
456	2011-04-01	\N	16	\N	2011-04-01                      	5	пятница         	f	1	91	425	366	91
457	2011-04-02	\N	16	\N	2011-04-02                      	6	суббота         	t	2	92	426	367	92
459	2011-04-04	\N	16	\N	2011-04-04                      	1	понедельник     	f	4	94	428	369	94
460	2011-04-05	\N	16	\N	2011-04-05                      	2	вторник         	f	5	95	429	370	95
461	2011-04-06	\N	16	\N	2011-04-06                      	3	среда           	f	6	96	430	371	96
462	2011-04-07	\N	16	\N	2011-04-07                      	4	четверг         	f	7	97	431	372	97
463	2011-04-08	\N	16	\N	2011-04-08                      	5	пятница         	f	8	98	432	373	98
464	2011-04-09	\N	16	\N	2011-04-09                      	6	суббота         	t	9	99	433	374	99
466	2011-04-11	\N	16	\N	2011-04-11                      	1	понедельник     	f	11	101	435	376	101
467	2011-04-12	\N	16	\N	2011-04-12                      	2	вторник         	f	12	102	436	377	102
468	2011-04-13	\N	16	\N	2011-04-13                      	3	среда           	f	13	103	437	378	103
469	2011-04-14	\N	16	\N	2011-04-14                      	4	четверг         	f	14	104	438	379	104
470	2011-04-15	\N	16	\N	2011-04-15                      	5	пятница         	f	15	105	439	380	105
471	2011-04-16	\N	16	\N	2011-04-16                      	6	суббота         	t	16	106	440	381	106
473	2011-04-18	\N	16	\N	2011-04-18                      	1	понедельник     	f	18	108	442	383	108
474	2011-04-19	\N	16	\N	2011-04-19                      	2	вторник         	f	19	109	443	384	109
475	2011-04-20	\N	16	\N	2011-04-20                      	3	среда           	f	20	110	444	385	110
476	2011-04-21	\N	16	\N	2011-04-21                      	4	четверг         	f	21	111	445	386	111
477	2011-04-22	\N	16	\N	2011-04-22                      	5	пятница         	f	22	112	446	387	112
478	2011-04-23	\N	16	\N	2011-04-23                      	6	суббота         	t	23	113	447	388	113
480	2011-04-25	\N	16	\N	2011-04-25                      	1	понедельник     	f	25	115	449	390	115
481	2011-04-26	\N	16	\N	2011-04-26                      	2	вторник         	f	26	116	450	391	116
482	2011-04-27	\N	16	\N	2011-04-27                      	3	среда           	f	27	117	451	392	117
483	2011-04-28	\N	16	\N	2011-04-28                      	4	четверг         	f	28	118	452	393	118
484	2011-04-29	\N	16	\N	2011-04-29                      	5	пятница         	f	29	119	453	394	119
485	2011-04-30	\N	16	\N	2011-04-30                      	6	суббота         	t	30	120	454	395	120
487	2011-05-02	\N	17	\N	2011-05-02                      	1	понедельник     	f	2	122	457	398	122
488	2011-05-03	\N	17	\N	2011-05-03                      	2	вторник         	f	3	123	458	399	123
489	2011-05-04	\N	17	\N	2011-05-04                      	3	среда           	f	4	124	459	400	124
490	2011-05-05	\N	17	\N	2011-05-05                      	4	четверг         	f	5	125	460	401	125
491	2011-05-06	\N	17	\N	2011-05-06                      	5	пятница         	f	6	126	461	402	126
492	2011-05-07	\N	17	\N	2011-05-07                      	6	суббота         	t	7	127	462	403	127
494	2011-05-09	\N	17	\N	2011-05-09                      	1	понедельник     	f	9	129	464	405	129
495	2011-05-10	\N	17	\N	2011-05-10                      	2	вторник         	f	10	130	465	406	130
496	2011-05-11	\N	17	\N	2011-05-11                      	3	среда           	f	11	131	466	407	131
497	2011-05-12	\N	17	\N	2011-05-12                      	4	четверг         	f	12	132	467	408	132
498	2011-05-13	\N	17	\N	2011-05-13                      	5	пятница         	f	13	133	468	409	133
499	2011-05-14	\N	17	\N	2011-05-14                      	6	суббота         	t	14	134	469	410	134
501	2011-05-16	\N	17	\N	2011-05-16                      	1	понедельник     	f	16	136	471	412	136
502	2011-05-17	\N	17	\N	2011-05-17                      	2	вторник         	f	17	137	472	413	137
503	2011-05-18	\N	17	\N	2011-05-18                      	3	среда           	f	18	138	473	414	138
504	2011-05-19	\N	17	\N	2011-05-19                      	4	четверг         	f	19	139	474	415	139
505	2011-05-20	\N	17	\N	2011-05-20                      	5	пятница         	f	20	140	475	416	140
506	2011-05-21	\N	17	\N	2011-05-21                      	6	суббота         	t	21	141	476	417	141
508	2011-05-23	\N	17	\N	2011-05-23                      	1	понедельник     	f	23	143	478	419	143
509	2011-05-24	\N	17	\N	2011-05-24                      	2	вторник         	f	24	144	479	420	144
510	2011-05-25	\N	17	\N	2011-05-25                      	3	среда           	f	25	145	480	421	145
511	2011-05-26	\N	17	\N	2011-05-26                      	4	четверг         	f	26	146	481	422	146
512	2011-05-27	\N	17	\N	2011-05-27                      	5	пятница         	f	27	147	482	423	147
513	2011-05-28	\N	17	\N	2011-05-28                      	6	суббота         	t	28	148	483	424	148
515	2011-05-30	\N	17	\N	2011-05-30                      	1	понедельник     	f	30	150	485	424	150
516	2011-05-31	\N	17	\N	2011-05-31                      	2	вторник         	f	31	151	485	424	151
517	2011-06-01	\N	18	\N	2011-06-01                      	3	среда           	f	1	152	486	425	152
518	2011-06-02	\N	18	\N	2011-06-02                      	4	четверг         	f	2	153	487	426	153
519	2011-06-03	\N	18	\N	2011-06-03                      	5	пятница         	f	3	154	488	427	154
520	2011-06-04	\N	18	\N	2011-06-04                      	6	суббота         	t	4	155	489	428	155
522	2011-06-06	\N	18	\N	2011-06-06                      	1	понедельник     	f	6	157	491	430	157
523	2011-06-07	\N	18	\N	2011-06-07                      	2	вторник         	f	7	158	492	431	158
524	2011-06-08	\N	18	\N	2011-06-08                      	3	среда           	f	8	159	493	432	159
525	2011-06-09	\N	18	\N	2011-06-09                      	4	четверг         	f	9	160	494	433	160
526	2011-06-10	\N	18	\N	2011-06-10                      	5	пятница         	f	10	161	495	434	161
527	2011-06-11	\N	18	\N	2011-06-11                      	6	суббота         	t	11	162	496	435	162
529	2011-06-13	\N	18	\N	2011-06-13                      	1	понедельник     	f	13	164	498	437	164
530	2011-06-14	\N	18	\N	2011-06-14                      	2	вторник         	f	14	165	499	438	165
531	2011-06-15	\N	18	\N	2011-06-15                      	3	среда           	f	15	166	500	439	166
532	2011-06-16	\N	18	\N	2011-06-16                      	4	четверг         	f	16	167	501	440	167
533	2011-06-17	\N	18	\N	2011-06-17                      	5	пятница         	f	17	168	502	441	168
534	2011-06-18	\N	18	\N	2011-06-18                      	6	суббота         	t	18	169	503	442	169
536	2011-06-20	\N	18	\N	2011-06-20                      	1	понедельник     	f	20	171	505	444	171
537	2011-06-21	\N	18	\N	2011-06-21                      	2	вторник         	f	21	172	506	445	172
538	2011-06-22	\N	18	\N	2011-06-22                      	3	среда           	f	22	173	507	446	173
539	2011-06-23	\N	18	\N	2011-06-23                      	4	четверг         	f	23	174	508	447	174
540	2011-06-24	\N	18	\N	2011-06-24                      	5	пятница         	f	24	175	509	448	175
541	2011-06-25	\N	18	\N	2011-06-25                      	6	суббота         	t	25	176	510	449	176
543	2011-06-27	\N	18	\N	2011-06-27                      	1	понедельник     	f	27	178	512	451	178
544	2011-06-28	\N	18	\N	2011-06-28                      	2	вторник         	f	28	179	513	452	179
545	2011-06-29	\N	18	\N	2011-06-29                      	3	среда           	f	29	180	514	453	180
546	2011-06-30	\N	18	\N	2011-06-30                      	4	четверг         	f	30	181	515	454	181
547	2011-07-01	\N	19	\N	2011-07-01                      	5	пятница         	f	1	182	517	456	182
548	2011-07-02	\N	19	\N	2011-07-02                      	6	суббота         	t	2	183	518	457	183
550	2011-07-04	\N	19	\N	2011-07-04                      	1	понедельник     	f	4	185	520	459	185
551	2011-07-05	\N	19	\N	2011-07-05                      	2	вторник         	f	5	186	521	460	186
552	2011-07-06	\N	19	\N	2011-07-06                      	3	среда           	f	6	187	522	461	187
553	2011-07-07	\N	19	\N	2011-07-07                      	4	четверг         	f	7	188	523	462	188
554	2011-07-08	\N	19	\N	2011-07-08                      	5	пятница         	f	8	189	524	463	189
555	2011-07-09	\N	19	\N	2011-07-09                      	6	суббота         	t	9	190	525	464	190
557	2011-07-11	\N	19	\N	2011-07-11                      	1	понедельник     	f	11	192	527	466	192
558	2011-07-12	\N	19	\N	2011-07-12                      	2	вторник         	f	12	193	528	467	193
559	2011-07-13	\N	19	\N	2011-07-13                      	3	среда           	f	13	194	529	468	194
560	2011-07-14	\N	19	\N	2011-07-14                      	4	четверг         	f	14	195	530	469	195
561	2011-07-15	\N	19	\N	2011-07-15                      	5	пятница         	f	15	196	531	470	196
562	2011-07-16	\N	19	\N	2011-07-16                      	6	суббота         	t	16	197	532	471	197
564	2011-07-18	\N	19	\N	2011-07-18                      	1	понедельник     	f	18	199	534	473	199
565	2011-07-19	\N	19	\N	2011-07-19                      	2	вторник         	f	19	200	535	474	200
566	2011-07-20	\N	19	\N	2011-07-20                      	3	среда           	f	20	201	536	475	201
567	2011-07-21	\N	19	\N	2011-07-21                      	4	четверг         	f	21	202	537	476	202
568	2011-07-22	\N	19	\N	2011-07-22                      	5	пятница         	f	22	203	538	477	203
569	2011-07-23	\N	19	\N	2011-07-23                      	6	суббота         	t	23	204	539	478	204
571	2011-07-25	\N	19	\N	2011-07-25                      	1	понедельник     	f	25	206	541	480	206
572	2011-07-26	\N	19	\N	2011-07-26                      	2	вторник         	f	26	207	542	481	207
573	2011-07-27	\N	19	\N	2011-07-27                      	3	среда           	f	27	208	543	482	208
574	2011-07-28	\N	19	\N	2011-07-28                      	4	четверг         	f	28	209	544	483	209
575	2011-07-29	\N	19	\N	2011-07-29                      	5	пятница         	f	29	210	545	484	210
576	2011-07-30	\N	19	\N	2011-07-30                      	6	суббота         	t	30	211	546	485	211
578	2011-08-01	\N	20	\N	2011-08-01                      	1	понедельник     	f	1	213	547	486	213
579	2011-08-02	\N	20	\N	2011-08-02                      	2	вторник         	f	2	214	548	487	214
580	2011-08-03	\N	20	\N	2011-08-03                      	3	среда           	f	3	215	549	488	215
581	2011-08-04	\N	20	\N	2011-08-04                      	4	четверг         	f	4	216	550	489	216
582	2011-08-05	\N	20	\N	2011-08-05                      	5	пятница         	f	5	217	551	490	217
583	2011-08-06	\N	20	\N	2011-08-06                      	6	суббота         	t	6	218	552	491	218
585	2011-08-08	\N	20	\N	2011-08-08                      	1	понедельник     	f	8	220	554	493	220
586	2011-08-09	\N	20	\N	2011-08-09                      	2	вторник         	f	9	221	555	494	221
587	2011-08-10	\N	20	\N	2011-08-10                      	3	среда           	f	10	222	556	495	222
588	2011-08-11	\N	20	\N	2011-08-11                      	4	четверг         	f	11	223	557	496	223
589	2011-08-12	\N	20	\N	2011-08-12                      	5	пятница         	f	12	224	558	497	224
590	2011-08-13	\N	20	\N	2011-08-13                      	6	суббота         	t	13	225	559	498	225
592	2011-08-15	\N	20	\N	2011-08-15                      	1	понедельник     	f	15	227	561	500	227
593	2011-08-16	\N	20	\N	2011-08-16                      	2	вторник         	f	16	228	562	501	228
594	2011-08-17	\N	20	\N	2011-08-17                      	3	среда           	f	17	229	563	502	229
595	2011-08-18	\N	20	\N	2011-08-18                      	4	четверг         	f	18	230	564	503	230
596	2011-08-19	\N	20	\N	2011-08-19                      	5	пятница         	f	19	231	565	504	231
597	2011-08-20	\N	20	\N	2011-08-20                      	6	суббота         	t	20	232	566	505	232
599	2011-08-22	\N	20	\N	2011-08-22                      	1	понедельник     	f	22	234	568	507	234
600	2011-08-23	\N	20	\N	2011-08-23                      	2	вторник         	f	23	235	569	508	235
601	2011-08-24	\N	20	\N	2011-08-24                      	3	среда           	f	24	236	570	509	236
602	2011-08-25	\N	20	\N	2011-08-25                      	4	четверг         	f	25	237	571	510	237
603	2011-08-26	\N	20	\N	2011-08-26                      	5	пятница         	f	26	238	572	511	238
604	2011-08-27	\N	20	\N	2011-08-27                      	6	суббота         	t	27	239	573	512	239
606	2011-08-29	\N	20	\N	2011-08-29                      	1	понедельник     	f	29	241	575	514	241
607	2011-08-30	\N	20	\N	2011-08-30                      	2	вторник         	f	30	242	576	515	242
608	2011-08-31	\N	20	\N	2011-08-31                      	3	среда           	f	31	243	577	516	243
609	2011-09-01	\N	21	\N	2011-09-01                      	4	четверг         	f	1	244	578	517	244
610	2011-09-02	\N	21	\N	2011-09-02                      	5	пятница         	f	2	245	579	518	245
611	2011-09-03	\N	21	\N	2011-09-03                      	6	суббота         	t	3	246	580	519	246
613	2011-09-05	\N	21	\N	2011-09-05                      	1	понедельник     	f	5	248	582	521	248
614	2011-09-06	\N	21	\N	2011-09-06                      	2	вторник         	f	6	249	583	522	249
615	2011-09-07	\N	21	\N	2011-09-07                      	3	среда           	f	7	250	584	523	250
616	2011-09-08	\N	21	\N	2011-09-08                      	4	четверг         	f	8	251	585	524	251
617	2011-09-09	\N	21	\N	2011-09-09                      	5	пятница         	f	9	252	586	525	252
618	2011-09-10	\N	21	\N	2011-09-10                      	6	суббота         	t	10	253	587	526	253
620	2011-09-12	\N	21	\N	2011-09-12                      	1	понедельник     	f	12	255	589	528	255
621	2011-09-13	\N	21	\N	2011-09-13                      	2	вторник         	f	13	256	590	529	256
622	2011-09-14	\N	21	\N	2011-09-14                      	3	среда           	f	14	257	591	530	257
623	2011-09-15	\N	21	\N	2011-09-15                      	4	четверг         	f	15	258	592	531	258
624	2011-09-16	\N	21	\N	2011-09-16                      	5	пятница         	f	16	259	593	532	259
625	2011-09-17	\N	21	\N	2011-09-17                      	6	суббота         	t	17	260	594	533	260
627	2011-09-19	\N	21	\N	2011-09-19                      	1	понедельник     	f	19	262	596	535	262
628	2011-09-20	\N	21	\N	2011-09-20                      	2	вторник         	f	20	263	597	536	263
629	2011-09-21	\N	21	\N	2011-09-21                      	3	среда           	f	21	264	598	537	264
630	2011-09-22	\N	21	\N	2011-09-22                      	4	четверг         	f	22	265	599	538	265
631	2011-09-23	\N	21	\N	2011-09-23                      	5	пятница         	f	23	266	600	539	266
632	2011-09-24	\N	21	\N	2011-09-24                      	6	суббота         	t	24	267	601	540	267
634	2011-09-26	\N	21	\N	2011-09-26                      	1	понедельник     	f	26	269	603	542	269
635	2011-09-27	\N	21	\N	2011-09-27                      	2	вторник         	f	27	270	604	543	270
636	2011-09-28	\N	21	\N	2011-09-28                      	3	среда           	f	28	271	605	544	271
637	2011-09-29	\N	21	\N	2011-09-29                      	4	четверг         	f	29	272	606	545	272
638	2011-09-30	\N	21	\N	2011-09-30                      	5	пятница         	f	30	273	607	546	273
639	2011-10-01	\N	22	\N	2011-10-01                      	6	суббота         	t	1	274	609	547	274
641	2011-10-03	\N	22	\N	2011-10-03                      	1	понедельник     	f	3	276	611	549	276
642	2011-10-04	\N	22	\N	2011-10-04                      	2	вторник         	f	4	277	612	550	277
643	2011-10-05	\N	22	\N	2011-10-05                      	3	среда           	f	5	278	613	551	278
644	2011-10-06	\N	22	\N	2011-10-06                      	4	четверг         	f	6	279	614	552	279
645	2011-10-07	\N	22	\N	2011-10-07                      	5	пятница         	f	7	280	615	553	280
646	2011-10-08	\N	22	\N	2011-10-08                      	6	суббота         	t	8	281	616	554	281
648	2011-10-10	\N	22	\N	2011-10-10                      	1	понедельник     	f	10	283	618	556	283
649	2011-10-11	\N	22	\N	2011-10-11                      	2	вторник         	f	11	284	619	557	284
650	2011-10-12	\N	22	\N	2011-10-12                      	3	среда           	f	12	285	620	558	285
651	2011-10-13	\N	22	\N	2011-10-13                      	4	четверг         	f	13	286	621	559	286
652	2011-10-14	\N	22	\N	2011-10-14                      	5	пятница         	f	14	287	622	560	287
653	2011-10-15	\N	22	\N	2011-10-15                      	6	суббота         	t	15	288	623	561	288
655	2011-10-17	\N	22	\N	2011-10-17                      	1	понедельник     	f	17	290	625	563	290
656	2011-10-18	\N	22	\N	2011-10-18                      	2	вторник         	f	18	291	626	564	291
657	2011-10-19	\N	22	\N	2011-10-19                      	3	среда           	f	19	292	627	565	292
658	2011-10-20	\N	22	\N	2011-10-20                      	4	четверг         	f	20	293	628	566	293
659	2011-10-21	\N	22	\N	2011-10-21                      	5	пятница         	f	21	294	629	567	294
660	2011-10-22	\N	22	\N	2011-10-22                      	6	суббота         	t	22	295	630	568	295
662	2011-10-24	\N	22	\N	2011-10-24                      	1	понедельник     	f	24	297	632	570	297
663	2011-10-25	\N	22	\N	2011-10-25                      	2	вторник         	f	25	298	633	571	298
664	2011-10-26	\N	22	\N	2011-10-26                      	3	среда           	f	26	299	634	572	299
665	2011-10-27	\N	22	\N	2011-10-27                      	4	четверг         	f	27	300	635	573	300
666	2011-10-28	\N	22	\N	2011-10-28                      	5	пятница         	f	28	301	636	574	301
667	2011-10-29	\N	22	\N	2011-10-29                      	6	суббота         	t	29	302	637	575	302
669	2011-10-31	\N	22	\N	2011-10-31                      	1	понедельник     	f	31	304	638	577	304
670	2011-11-01	\N	23	\N	2011-11-01                      	2	вторник         	f	1	305	639	578	305
671	2011-11-02	\N	23	\N	2011-11-02                      	3	среда           	f	2	306	640	579	306
672	2011-11-03	\N	23	\N	2011-11-03                      	4	четверг         	f	3	307	641	580	307
673	2011-11-04	\N	23	\N	2011-11-04                      	5	пятница         	f	4	308	642	581	308
674	2011-11-05	\N	23	\N	2011-11-05                      	6	суббота         	t	5	309	643	582	309
676	2011-11-07	\N	23	\N	2011-11-07                      	1	понедельник     	f	7	311	645	584	311
677	2011-11-08	\N	23	\N	2011-11-08                      	2	вторник         	f	8	312	646	585	312
678	2011-11-09	\N	23	\N	2011-11-09                      	3	среда           	f	9	313	647	586	313
679	2011-11-10	\N	23	\N	2011-11-10                      	4	четверг         	f	10	314	648	587	314
680	2011-11-11	\N	23	\N	2011-11-11                      	5	пятница         	f	11	315	649	588	315
681	2011-11-12	\N	23	\N	2011-11-12                      	6	суббота         	t	12	316	650	589	316
683	2011-11-14	\N	23	\N	2011-11-14                      	1	понедельник     	f	14	318	652	591	318
684	2011-11-15	\N	23	\N	2011-11-15                      	2	вторник         	f	15	319	653	592	319
685	2011-11-16	\N	23	\N	2011-11-16                      	3	среда           	f	16	320	654	593	320
686	2011-11-17	\N	23	\N	2011-11-17                      	4	четверг         	f	17	321	655	594	321
687	2011-11-18	\N	23	\N	2011-11-18                      	5	пятница         	f	18	322	656	595	322
688	2011-11-19	\N	23	\N	2011-11-19                      	6	суббота         	t	19	323	657	596	323
690	2011-11-21	\N	23	\N	2011-11-21                      	1	понедельник     	f	21	325	659	598	325
691	2011-11-22	\N	23	\N	2011-11-22                      	2	вторник         	f	22	326	660	599	326
692	2011-11-23	\N	23	\N	2011-11-23                      	3	среда           	f	23	327	661	600	327
693	2011-11-24	\N	23	\N	2011-11-24                      	4	четверг         	f	24	328	662	601	328
694	2011-11-25	\N	23	\N	2011-11-25                      	5	пятница         	f	25	329	663	602	329
695	2011-11-26	\N	23	\N	2011-11-26                      	6	суббота         	t	26	330	664	603	330
697	2011-11-28	\N	23	\N	2011-11-28                      	1	понедельник     	f	28	332	666	605	332
698	2011-11-29	\N	23	\N	2011-11-29                      	2	вторник         	f	29	333	667	606	333
699	2011-11-30	\N	23	\N	2011-11-30                      	3	среда           	f	30	334	668	607	334
700	2011-12-01	\N	24	\N	2011-12-01                      	4	четверг         	f	1	335	670	609	335
701	2011-12-02	\N	24	\N	2011-12-02                      	5	пятница         	f	2	336	671	610	336
702	2011-12-03	\N	24	\N	2011-12-03                      	6	суббота         	t	3	337	672	611	337
704	2011-12-05	\N	24	\N	2011-12-05                      	1	понедельник     	f	5	339	674	613	339
705	2011-12-06	\N	24	\N	2011-12-06                      	2	вторник         	f	6	340	675	614	340
706	2011-12-07	\N	24	\N	2011-12-07                      	3	среда           	f	7	341	676	615	341
707	2011-12-08	\N	24	\N	2011-12-08                      	4	четверг         	f	8	342	677	616	342
708	2011-12-09	\N	24	\N	2011-12-09                      	5	пятница         	f	9	343	678	617	343
709	2011-12-10	\N	24	\N	2011-12-10                      	6	суббота         	t	10	344	679	618	344
711	2011-12-12	\N	24	\N	2011-12-12                      	1	понедельник     	f	12	346	681	620	346
712	2011-12-13	\N	24	\N	2011-12-13                      	2	вторник         	f	13	347	682	621	347
713	2011-12-14	\N	24	\N	2011-12-14                      	3	среда           	f	14	348	683	622	348
714	2011-12-15	\N	24	\N	2011-12-15                      	4	четверг         	f	15	349	684	623	349
715	2011-12-16	\N	24	\N	2011-12-16                      	5	пятница         	f	16	350	685	624	350
716	2011-12-17	\N	24	\N	2011-12-17                      	6	суббота         	t	17	351	686	625	351
718	2011-12-19	\N	24	\N	2011-12-19                      	1	понедельник     	f	19	353	688	627	353
719	2011-12-20	\N	24	\N	2011-12-20                      	2	вторник         	f	20	354	689	628	354
720	2011-12-21	\N	24	\N	2011-12-21                      	3	среда           	f	21	355	690	629	355
721	2011-12-22	\N	24	\N	2011-12-22                      	4	четверг         	f	22	356	691	630	356
722	2011-12-23	\N	24	\N	2011-12-23                      	5	пятница         	f	23	357	692	631	357
723	2011-12-24	\N	24	\N	2011-12-24                      	6	суббота         	t	24	358	693	632	358
725	2011-12-26	\N	24	\N	2011-12-26                      	1	понедельник     	f	26	360	695	634	360
726	2011-12-27	\N	24	\N	2011-12-27                      	2	вторник         	f	27	361	696	635	361
727	2011-12-28	\N	24	\N	2011-12-28                      	3	среда           	f	28	362	697	636	362
728	2011-12-29	\N	24	\N	2011-12-29                      	4	четверг         	f	29	363	698	637	363
729	2011-12-30	\N	24	\N	2011-12-30                      	5	пятница         	f	30	364	699	638	364
730	2011-12-31	\N	24	\N	2011-12-31                      	6	суббота         	t	31	365	699	638	365
732	2012-01-02	\N	25	\N	2012-01-02                      	1	понедельник     	f	2	2	701	640	367
733	2012-01-03	\N	25	\N	2012-01-03                      	2	вторник         	f	3	3	702	641	368
734	2012-01-04	\N	25	\N	2012-01-04                      	3	среда           	f	4	4	703	642	369
735	2012-01-05	\N	25	\N	2012-01-05                      	4	четверг         	f	5	5	704	643	370
736	2012-01-06	\N	25	\N	2012-01-06                      	5	пятница         	f	6	6	705	644	371
737	2012-01-07	\N	25	\N	2012-01-07                      	6	суббота         	t	7	7	706	645	372
739	2012-01-09	\N	25	\N	2012-01-09                      	1	понедельник     	f	9	9	708	647	374
740	2012-01-10	\N	25	\N	2012-01-10                      	2	вторник         	f	10	10	709	648	375
741	2012-01-11	\N	25	\N	2012-01-11                      	3	среда           	f	11	11	710	649	376
742	2012-01-12	\N	25	\N	2012-01-12                      	4	четверг         	f	12	12	711	650	377
743	2012-01-13	\N	25	\N	2012-01-13                      	5	пятница         	f	13	13	712	651	378
744	2012-01-14	\N	25	\N	2012-01-14                      	6	суббота         	t	14	14	713	652	379
746	2012-01-16	\N	25	\N	2012-01-16                      	1	понедельник     	f	16	16	715	654	381
747	2012-01-17	\N	25	\N	2012-01-17                      	2	вторник         	f	17	17	716	655	382
748	2012-01-18	\N	25	\N	2012-01-18                      	3	среда           	f	18	18	717	656	383
749	2012-01-19	\N	25	\N	2012-01-19                      	4	четверг         	f	19	19	718	657	384
750	2012-01-20	\N	25	\N	2012-01-20                      	5	пятница         	f	20	20	719	658	385
751	2012-01-21	\N	25	\N	2012-01-21                      	6	суббота         	t	21	21	720	659	386
753	2012-01-23	\N	25	\N	2012-01-23                      	1	понедельник     	f	23	23	722	661	388
754	2012-01-24	\N	25	\N	2012-01-24                      	2	вторник         	f	24	24	723	662	389
755	2012-01-25	\N	25	\N	2012-01-25                      	3	среда           	f	25	25	724	663	390
756	2012-01-26	\N	25	\N	2012-01-26                      	4	четверг         	f	26	26	725	664	391
757	2012-01-27	\N	25	\N	2012-01-27                      	5	пятница         	f	27	27	726	665	392
758	2012-01-28	\N	25	\N	2012-01-28                      	6	суббота         	t	28	28	727	666	393
760	2012-01-30	\N	25	\N	2012-01-30                      	1	понедельник     	f	30	30	729	668	395
761	2012-01-31	\N	25	\N	2012-01-31                      	2	вторник         	f	31	31	730	669	396
762	2012-02-01	\N	26	\N	2012-02-01                      	3	среда           	f	1	32	731	670	397
763	2012-02-02	\N	26	\N	2012-02-02                      	4	четверг         	f	2	33	732	671	398
764	2012-02-03	\N	26	\N	2012-02-03                      	5	пятница         	f	3	34	733	672	399
765	2012-02-04	\N	26	\N	2012-02-04                      	6	суббота         	t	4	35	734	673	400
767	2012-02-06	\N	26	\N	2012-02-06                      	1	понедельник     	f	6	37	736	675	402
768	2012-02-07	\N	26	\N	2012-02-07                      	2	вторник         	f	7	38	737	676	403
769	2012-02-08	\N	26	\N	2012-02-08                      	3	среда           	f	8	39	738	677	404
770	2012-02-09	\N	26	\N	2012-02-09                      	4	четверг         	f	9	40	739	678	405
771	2012-02-10	\N	26	\N	2012-02-10                      	5	пятница         	f	10	41	740	679	406
772	2012-02-11	\N	26	\N	2012-02-11                      	6	суббота         	t	11	42	741	680	407
774	2012-02-13	\N	26	\N	2012-02-13                      	1	понедельник     	f	13	44	743	682	409
775	2012-02-14	\N	26	\N	2012-02-14                      	2	вторник         	f	14	45	744	683	410
776	2012-02-15	\N	26	\N	2012-02-15                      	3	среда           	f	15	46	745	684	411
777	2012-02-16	\N	26	\N	2012-02-16                      	4	четверг         	f	16	47	746	685	412
778	2012-02-17	\N	26	\N	2012-02-17                      	5	пятница         	f	17	48	747	686	413
779	2012-02-18	\N	26	\N	2012-02-18                      	6	суббота         	t	18	49	748	687	414
781	2012-02-20	\N	26	\N	2012-02-20                      	1	понедельник     	f	20	51	750	689	416
782	2012-02-21	\N	26	\N	2012-02-21                      	2	вторник         	f	21	52	751	690	417
783	2012-02-22	\N	26	\N	2012-02-22                      	3	среда           	f	22	53	752	691	418
784	2012-02-23	\N	26	\N	2012-02-23                      	4	четверг         	f	23	54	753	692	419
785	2012-02-24	\N	26	\N	2012-02-24                      	5	пятница         	f	24	55	754	693	420
786	2012-02-25	\N	26	\N	2012-02-25                      	6	суббота         	t	25	56	755	694	421
788	2012-02-27	\N	26	\N	2012-02-27                      	1	понедельник     	f	27	58	757	696	423
789	2012-02-28	\N	26	\N	2012-02-28                      	2	вторник         	f	28	59	758	697	424
790	2012-02-29	\N	26	\N	2012-02-29                      	3	среда           	f	29	60	759	698	424
791	2012-03-01	\N	27	\N	2012-03-01                      	4	четверг         	f	1	61	762	700	425
792	2012-03-02	\N	27	\N	2012-03-02                      	5	пятница         	f	2	62	763	701	426
793	2012-03-03	\N	27	\N	2012-03-03                      	6	суббота         	t	3	63	764	702	427
795	2012-03-05	\N	27	\N	2012-03-05                      	1	понедельник     	f	5	65	766	704	429
796	2012-03-06	\N	27	\N	2012-03-06                      	2	вторник         	f	6	66	767	705	430
797	2012-03-07	\N	27	\N	2012-03-07                      	3	среда           	f	7	67	768	706	431
798	2012-03-08	\N	27	\N	2012-03-08                      	4	четверг         	f	8	68	769	707	432
799	2012-03-09	\N	27	\N	2012-03-09                      	5	пятница         	f	9	69	770	708	433
800	2012-03-10	\N	27	\N	2012-03-10                      	6	суббота         	t	10	70	771	709	434
802	2012-03-12	\N	27	\N	2012-03-12                      	1	понедельник     	f	12	72	773	711	436
803	2012-03-13	\N	27	\N	2012-03-13                      	2	вторник         	f	13	73	774	712	437
804	2012-03-14	\N	27	\N	2012-03-14                      	3	среда           	f	14	74	775	713	438
805	2012-03-15	\N	27	\N	2012-03-15                      	4	четверг         	f	15	75	776	714	439
806	2012-03-16	\N	27	\N	2012-03-16                      	5	пятница         	f	16	76	777	715	440
807	2012-03-17	\N	27	\N	2012-03-17                      	6	суббота         	t	17	77	778	716	441
809	2012-03-19	\N	27	\N	2012-03-19                      	1	понедельник     	f	19	79	780	718	443
810	2012-03-20	\N	27	\N	2012-03-20                      	2	вторник         	f	20	80	781	719	444
811	2012-03-21	\N	27	\N	2012-03-21                      	3	среда           	f	21	81	782	720	445
812	2012-03-22	\N	27	\N	2012-03-22                      	4	четверг         	f	22	82	783	721	446
813	2012-03-23	\N	27	\N	2012-03-23                      	5	пятница         	f	23	83	784	722	447
814	2012-03-24	\N	27	\N	2012-03-24                      	6	суббота         	t	24	84	785	723	448
816	2012-03-26	\N	27	\N	2012-03-26                      	1	понедельник     	f	26	86	787	725	450
817	2012-03-27	\N	27	\N	2012-03-27                      	2	вторник         	f	27	87	788	726	451
818	2012-03-28	\N	27	\N	2012-03-28                      	3	среда           	f	28	88	789	727	452
819	2012-03-29	\N	27	\N	2012-03-29                      	4	четверг         	f	29	89	790	728	453
820	2012-03-30	\N	27	\N	2012-03-30                      	5	пятница         	f	30	90	790	729	454
821	2012-03-31	\N	27	\N	2012-03-31                      	6	суббота         	t	31	91	790	730	455
823	2012-04-02	\N	28	\N	2012-04-02                      	1	понедельник     	f	2	93	792	732	457
824	2012-04-03	\N	28	\N	2012-04-03                      	2	вторник         	f	3	94	793	733	458
825	2012-04-04	\N	28	\N	2012-04-04                      	3	среда           	f	4	95	794	734	459
826	2012-04-05	\N	28	\N	2012-04-05                      	4	четверг         	f	5	96	795	735	460
827	2012-04-06	\N	28	\N	2012-04-06                      	5	пятница         	f	6	97	796	736	461
828	2012-04-07	\N	28	\N	2012-04-07                      	6	суббота         	t	7	98	797	737	462
830	2012-04-09	\N	28	\N	2012-04-09                      	1	понедельник     	f	9	100	799	739	464
831	2012-04-10	\N	28	\N	2012-04-10                      	2	вторник         	f	10	101	800	740	465
832	2012-04-11	\N	28	\N	2012-04-11                      	3	среда           	f	11	102	801	741	466
833	2012-04-12	\N	28	\N	2012-04-12                      	4	четверг         	f	12	103	802	742	467
834	2012-04-13	\N	28	\N	2012-04-13                      	5	пятница         	f	13	104	803	743	468
835	2012-04-14	\N	28	\N	2012-04-14                      	6	суббота         	t	14	105	804	744	469
837	2012-04-16	\N	28	\N	2012-04-16                      	1	понедельник     	f	16	107	806	746	471
838	2012-04-17	\N	28	\N	2012-04-17                      	2	вторник         	f	17	108	807	747	472
839	2012-04-18	\N	28	\N	2012-04-18                      	3	среда           	f	18	109	808	748	473
840	2012-04-19	\N	28	\N	2012-04-19                      	4	четверг         	f	19	110	809	749	474
841	2012-04-20	\N	28	\N	2012-04-20                      	5	пятница         	f	20	111	810	750	475
842	2012-04-21	\N	28	\N	2012-04-21                      	6	суббота         	t	21	112	811	751	476
844	2012-04-23	\N	28	\N	2012-04-23                      	1	понедельник     	f	23	114	813	753	478
845	2012-04-24	\N	28	\N	2012-04-24                      	2	вторник         	f	24	115	814	754	479
846	2012-04-25	\N	28	\N	2012-04-25                      	3	среда           	f	25	116	815	755	480
847	2012-04-26	\N	28	\N	2012-04-26                      	4	четверг         	f	26	117	816	756	481
848	2012-04-27	\N	28	\N	2012-04-27                      	5	пятница         	f	27	118	817	757	482
849	2012-04-28	\N	28	\N	2012-04-28                      	6	суббота         	t	28	119	818	758	483
851	2012-04-30	\N	28	\N	2012-04-30                      	1	понедельник     	f	30	121	820	760	485
852	2012-05-01	\N	29	\N	2012-05-01                      	2	вторник         	f	1	122	822	762	486
853	2012-05-02	\N	29	\N	2012-05-02                      	3	среда           	f	2	123	823	763	487
854	2012-05-03	\N	29	\N	2012-05-03                      	4	четверг         	f	3	124	824	764	488
855	2012-05-04	\N	29	\N	2012-05-04                      	5	пятница         	f	4	125	825	765	489
856	2012-05-05	\N	29	\N	2012-05-05                      	6	суббота         	t	5	126	826	766	490
858	2012-05-07	\N	29	\N	2012-05-07                      	1	понедельник     	f	7	128	828	768	492
859	2012-05-08	\N	29	\N	2012-05-08                      	2	вторник         	f	8	129	829	769	493
860	2012-05-09	\N	29	\N	2012-05-09                      	3	среда           	f	9	130	830	770	494
861	2012-05-10	\N	29	\N	2012-05-10                      	4	четверг         	f	10	131	831	771	495
862	2012-05-11	\N	29	\N	2012-05-11                      	5	пятница         	f	11	132	832	772	496
863	2012-05-12	\N	29	\N	2012-05-12                      	6	суббота         	t	12	133	833	773	497
865	2012-05-14	\N	29	\N	2012-05-14                      	1	понедельник     	f	14	135	835	775	499
866	2012-05-15	\N	29	\N	2012-05-15                      	2	вторник         	f	15	136	836	776	500
867	2012-05-16	\N	29	\N	2012-05-16                      	3	среда           	f	16	137	837	777	501
868	2012-05-17	\N	29	\N	2012-05-17                      	4	четверг         	f	17	138	838	778	502
869	2012-05-18	\N	29	\N	2012-05-18                      	5	пятница         	f	18	139	839	779	503
870	2012-05-19	\N	29	\N	2012-05-19                      	6	суббота         	t	19	140	840	780	504
872	2012-05-21	\N	29	\N	2012-05-21                      	1	понедельник     	f	21	142	842	782	506
873	2012-05-22	\N	29	\N	2012-05-22                      	2	вторник         	f	22	143	843	783	507
874	2012-05-23	\N	29	\N	2012-05-23                      	3	среда           	f	23	144	844	784	508
875	2012-05-24	\N	29	\N	2012-05-24                      	4	четверг         	f	24	145	845	785	509
876	2012-05-25	\N	29	\N	2012-05-25                      	5	пятница         	f	25	146	846	786	510
877	2012-05-26	\N	29	\N	2012-05-26                      	6	суббота         	t	26	147	847	787	511
879	2012-05-28	\N	29	\N	2012-05-28                      	1	понедельник     	f	28	149	849	789	513
880	2012-05-29	\N	29	\N	2012-05-29                      	2	вторник         	f	29	150	850	790	514
881	2012-05-30	\N	29	\N	2012-05-30                      	3	среда           	f	30	151	851	790	515
882	2012-05-31	\N	29	\N	2012-05-31                      	4	четверг         	f	31	152	851	790	516
883	2012-06-01	\N	30	\N	2012-06-01                      	5	пятница         	f	1	153	852	791	517
884	2012-06-02	\N	30	\N	2012-06-02                      	6	суббота         	t	2	154	853	792	518
886	2012-06-04	\N	30	\N	2012-06-04                      	1	понедельник     	f	4	156	855	794	520
887	2012-06-05	\N	30	\N	2012-06-05                      	2	вторник         	f	5	157	856	795	521
888	2012-06-06	\N	30	\N	2012-06-06                      	3	среда           	f	6	158	857	796	522
889	2012-06-07	\N	30	\N	2012-06-07                      	4	четверг         	f	7	159	858	797	523
890	2012-06-08	\N	30	\N	2012-06-08                      	5	пятница         	f	8	160	859	798	524
891	2012-06-09	\N	30	\N	2012-06-09                      	6	суббота         	t	9	161	860	799	525
893	2012-06-11	\N	30	\N	2012-06-11                      	1	понедельник     	f	11	163	862	801	527
894	2012-06-12	\N	30	\N	2012-06-12                      	2	вторник         	f	12	164	863	802	528
895	2012-06-13	\N	30	\N	2012-06-13                      	3	среда           	f	13	165	864	803	529
896	2012-06-14	\N	30	\N	2012-06-14                      	4	четверг         	f	14	166	865	804	530
897	2012-06-15	\N	30	\N	2012-06-15                      	5	пятница         	f	15	167	866	805	531
898	2012-06-16	\N	30	\N	2012-06-16                      	6	суббота         	t	16	168	867	806	532
900	2012-06-18	\N	30	\N	2012-06-18                      	1	понедельник     	f	18	170	869	808	534
901	2012-06-19	\N	30	\N	2012-06-19                      	2	вторник         	f	19	171	870	809	535
902	2012-06-20	\N	30	\N	2012-06-20                      	3	среда           	f	20	172	871	810	536
903	2012-06-21	\N	30	\N	2012-06-21                      	4	четверг         	f	21	173	872	811	537
904	2012-06-22	\N	30	\N	2012-06-22                      	5	пятница         	f	22	174	873	812	538
905	2012-06-23	\N	30	\N	2012-06-23                      	6	суббота         	t	23	175	874	813	539
907	2012-06-25	\N	30	\N	2012-06-25                      	1	понедельник     	f	25	177	876	815	541
908	2012-06-26	\N	30	\N	2012-06-26                      	2	вторник         	f	26	178	877	816	542
909	2012-06-27	\N	30	\N	2012-06-27                      	3	среда           	f	27	179	878	817	543
910	2012-06-28	\N	30	\N	2012-06-28                      	4	четверг         	f	28	180	879	818	544
911	2012-06-29	\N	30	\N	2012-06-29                      	5	пятница         	f	29	181	880	819	545
912	2012-06-30	\N	30	\N	2012-06-30                      	6	суббота         	t	30	182	881	820	546
914	2012-07-02	\N	31	\N	2012-07-02                      	1	понедельник     	f	2	184	884	823	548
915	2012-07-03	\N	31	\N	2012-07-03                      	2	вторник         	f	3	185	885	824	549
916	2012-07-04	\N	31	\N	2012-07-04                      	3	среда           	f	4	186	886	825	550
917	2012-07-05	\N	31	\N	2012-07-05                      	4	четверг         	f	5	187	887	826	551
918	2012-07-06	\N	31	\N	2012-07-06                      	5	пятница         	f	6	188	888	827	552
919	2012-07-07	\N	31	\N	2012-07-07                      	6	суббота         	t	7	189	889	828	553
921	2012-07-09	\N	31	\N	2012-07-09                      	1	понедельник     	f	9	191	891	830	555
922	2012-07-10	\N	31	\N	2012-07-10                      	2	вторник         	f	10	192	892	831	556
923	2012-07-11	\N	31	\N	2012-07-11                      	3	среда           	f	11	193	893	832	557
924	2012-07-12	\N	31	\N	2012-07-12                      	4	четверг         	f	12	194	894	833	558
925	2012-07-13	\N	31	\N	2012-07-13                      	5	пятница         	f	13	195	895	834	559
926	2012-07-14	\N	31	\N	2012-07-14                      	6	суббота         	t	14	196	896	835	560
928	2012-07-16	\N	31	\N	2012-07-16                      	1	понедельник     	f	16	198	898	837	562
929	2012-07-17	\N	31	\N	2012-07-17                      	2	вторник         	f	17	199	899	838	563
930	2012-07-18	\N	31	\N	2012-07-18                      	3	среда           	f	18	200	900	839	564
931	2012-07-19	\N	31	\N	2012-07-19                      	4	четверг         	f	19	201	901	840	565
932	2012-07-20	\N	31	\N	2012-07-20                      	5	пятница         	f	20	202	902	841	566
933	2012-07-21	\N	31	\N	2012-07-21                      	6	суббота         	t	21	203	903	842	567
935	2012-07-23	\N	31	\N	2012-07-23                      	1	понедельник     	f	23	205	905	844	569
936	2012-07-24	\N	31	\N	2012-07-24                      	2	вторник         	f	24	206	906	845	570
937	2012-07-25	\N	31	\N	2012-07-25                      	3	среда           	f	25	207	907	846	571
938	2012-07-26	\N	31	\N	2012-07-26                      	4	четверг         	f	26	208	908	847	572
939	2012-07-27	\N	31	\N	2012-07-27                      	5	пятница         	f	27	209	909	848	573
940	2012-07-28	\N	31	\N	2012-07-28                      	6	суббота         	t	28	210	910	849	574
942	2012-07-30	\N	31	\N	2012-07-30                      	1	понедельник     	f	30	212	912	851	576
943	2012-07-31	\N	31	\N	2012-07-31                      	2	вторник         	f	31	213	912	851	577
944	2012-08-01	\N	32	\N	2012-08-01                      	3	среда           	f	1	214	913	852	578
945	2012-08-02	\N	32	\N	2012-08-02                      	4	четверг         	f	2	215	914	853	579
946	2012-08-03	\N	32	\N	2012-08-03                      	5	пятница         	f	3	216	915	854	580
947	2012-08-04	\N	32	\N	2012-08-04                      	6	суббота         	t	4	217	916	855	581
949	2012-08-06	\N	32	\N	2012-08-06                      	1	понедельник     	f	6	219	918	857	583
950	2012-08-07	\N	32	\N	2012-08-07                      	2	вторник         	f	7	220	919	858	584
951	2012-08-08	\N	32	\N	2012-08-08                      	3	среда           	f	8	221	920	859	585
952	2012-08-09	\N	32	\N	2012-08-09                      	4	четверг         	f	9	222	921	860	586
953	2012-08-10	\N	32	\N	2012-08-10                      	5	пятница         	f	10	223	922	861	587
954	2012-08-11	\N	32	\N	2012-08-11                      	6	суббота         	t	11	224	923	862	588
956	2012-08-13	\N	32	\N	2012-08-13                      	1	понедельник     	f	13	226	925	864	590
957	2012-08-14	\N	32	\N	2012-08-14                      	2	вторник         	f	14	227	926	865	591
958	2012-08-15	\N	32	\N	2012-08-15                      	3	среда           	f	15	228	927	866	592
959	2012-08-16	\N	32	\N	2012-08-16                      	4	четверг         	f	16	229	928	867	593
960	2012-08-17	\N	32	\N	2012-08-17                      	5	пятница         	f	17	230	929	868	594
961	2012-08-18	\N	32	\N	2012-08-18                      	6	суббота         	t	18	231	930	869	595
963	2012-08-20	\N	32	\N	2012-08-20                      	1	понедельник     	f	20	233	932	871	597
964	2012-08-21	\N	32	\N	2012-08-21                      	2	вторник         	f	21	234	933	872	598
965	2012-08-22	\N	32	\N	2012-08-22                      	3	среда           	f	22	235	934	873	599
966	2012-08-23	\N	32	\N	2012-08-23                      	4	четверг         	f	23	236	935	874	600
967	2012-08-24	\N	32	\N	2012-08-24                      	5	пятница         	f	24	237	936	875	601
968	2012-08-25	\N	32	\N	2012-08-25                      	6	суббота         	t	25	238	937	876	602
970	2012-08-27	\N	32	\N	2012-08-27                      	1	понедельник     	f	27	240	939	878	604
971	2012-08-28	\N	32	\N	2012-08-28                      	2	вторник         	f	28	241	940	879	605
972	2012-08-29	\N	32	\N	2012-08-29                      	3	среда           	f	29	242	941	880	606
973	2012-08-30	\N	32	\N	2012-08-30                      	4	четверг         	f	30	243	942	881	607
974	2012-08-31	\N	32	\N	2012-08-31                      	5	пятница         	f	31	244	943	882	608
975	2012-09-01	\N	33	\N	2012-09-01                      	6	суббота         	t	1	245	944	883	609
977	2012-09-03	\N	33	\N	2012-09-03                      	1	понедельник     	f	3	247	946	885	611
978	2012-09-04	\N	33	\N	2012-09-04                      	2	вторник         	f	4	248	947	886	612
979	2012-09-05	\N	33	\N	2012-09-05                      	3	среда           	f	5	249	948	887	613
980	2012-09-06	\N	33	\N	2012-09-06                      	4	четверг         	f	6	250	949	888	614
981	2012-09-07	\N	33	\N	2012-09-07                      	5	пятница         	f	7	251	950	889	615
982	2012-09-08	\N	33	\N	2012-09-08                      	6	суббота         	t	8	252	951	890	616
984	2012-09-10	\N	33	\N	2012-09-10                      	1	понедельник     	f	10	254	953	892	618
985	2012-09-11	\N	33	\N	2012-09-11                      	2	вторник         	f	11	255	954	893	619
986	2012-09-12	\N	33	\N	2012-09-12                      	3	среда           	f	12	256	955	894	620
987	2012-09-13	\N	33	\N	2012-09-13                      	4	четверг         	f	13	257	956	895	621
988	2012-09-14	\N	33	\N	2012-09-14                      	5	пятница         	f	14	258	957	896	622
989	2012-09-15	\N	33	\N	2012-09-15                      	6	суббота         	t	15	259	958	897	623
991	2012-09-17	\N	33	\N	2012-09-17                      	1	понедельник     	f	17	261	960	899	625
992	2012-09-18	\N	33	\N	2012-09-18                      	2	вторник         	f	18	262	961	900	626
993	2012-09-19	\N	33	\N	2012-09-19                      	3	среда           	f	19	263	962	901	627
994	2012-09-20	\N	33	\N	2012-09-20                      	4	четверг         	f	20	264	963	902	628
995	2012-09-21	\N	33	\N	2012-09-21                      	5	пятница         	f	21	265	964	903	629
996	2012-09-22	\N	33	\N	2012-09-22                      	6	суббота         	t	22	266	965	904	630
998	2012-09-24	\N	33	\N	2012-09-24                      	1	понедельник     	f	24	268	967	906	632
999	2012-09-25	\N	33	\N	2012-09-25                      	2	вторник         	f	25	269	968	907	633
1000	2012-09-26	\N	33	\N	2012-09-26                      	3	среда           	f	26	270	969	908	634
1001	2012-09-27	\N	33	\N	2012-09-27                      	4	четверг         	f	27	271	970	909	635
1002	2012-09-28	\N	33	\N	2012-09-28                      	5	пятница         	f	28	272	971	910	636
1003	2012-09-29	\N	33	\N	2012-09-29                      	6	суббота         	t	29	273	972	911	637
1005	2012-10-01	\N	34	\N	2012-10-01                      	1	понедельник     	f	1	275	975	913	639
1006	2012-10-02	\N	34	\N	2012-10-02                      	2	вторник         	f	2	276	976	914	640
1007	2012-10-03	\N	34	\N	2012-10-03                      	3	среда           	f	3	277	977	915	641
1008	2012-10-04	\N	34	\N	2012-10-04                      	4	четверг         	f	4	278	978	916	642
1009	2012-10-05	\N	34	\N	2012-10-05                      	5	пятница         	f	5	279	979	917	643
1010	2012-10-06	\N	34	\N	2012-10-06                      	6	суббота         	t	6	280	980	918	644
1012	2012-10-08	\N	34	\N	2012-10-08                      	1	понедельник     	f	8	282	982	920	646
1013	2012-10-09	\N	34	\N	2012-10-09                      	2	вторник         	f	9	283	983	921	647
1014	2012-10-10	\N	34	\N	2012-10-10                      	3	среда           	f	10	284	984	922	648
1015	2012-10-11	\N	34	\N	2012-10-11                      	4	четверг         	f	11	285	985	923	649
1016	2012-10-12	\N	34	\N	2012-10-12                      	5	пятница         	f	12	286	986	924	650
1017	2012-10-13	\N	34	\N	2012-10-13                      	6	суббота         	t	13	287	987	925	651
1019	2012-10-15	\N	34	\N	2012-10-15                      	1	понедельник     	f	15	289	989	927	653
1020	2012-10-16	\N	34	\N	2012-10-16                      	2	вторник         	f	16	290	990	928	654
1021	2012-10-17	\N	34	\N	2012-10-17                      	3	среда           	f	17	291	991	929	655
1022	2012-10-18	\N	34	\N	2012-10-18                      	4	четверг         	f	18	292	992	930	656
1023	2012-10-19	\N	34	\N	2012-10-19                      	5	пятница         	f	19	293	993	931	657
1024	2012-10-20	\N	34	\N	2012-10-20                      	6	суббота         	t	20	294	994	932	658
1026	2012-10-22	\N	34	\N	2012-10-22                      	1	понедельник     	f	22	296	996	934	660
1027	2012-10-23	\N	34	\N	2012-10-23                      	2	вторник         	f	23	297	997	935	661
1028	2012-10-24	\N	34	\N	2012-10-24                      	3	среда           	f	24	298	998	936	662
1029	2012-10-25	\N	34	\N	2012-10-25                      	4	четверг         	f	25	299	999	937	663
1030	2012-10-26	\N	34	\N	2012-10-26                      	5	пятница         	f	26	300	1000	938	664
1031	2012-10-27	\N	34	\N	2012-10-27                      	6	суббота         	t	27	301	1001	939	665
1033	2012-10-29	\N	34	\N	2012-10-29                      	1	понедельник     	f	29	303	1003	941	667
1034	2012-10-30	\N	34	\N	2012-10-30                      	2	вторник         	f	30	304	1004	942	668
1035	2012-10-31	\N	34	\N	2012-10-31                      	3	среда           	f	31	305	1004	943	669
1036	2012-11-01	\N	35	\N	2012-11-01                      	4	четверг         	f	1	306	1005	944	670
1037	2012-11-02	\N	35	\N	2012-11-02                      	5	пятница         	f	2	307	1006	945	671
1038	2012-11-03	\N	35	\N	2012-11-03                      	6	суббота         	t	3	308	1007	946	672
1040	2012-11-05	\N	35	\N	2012-11-05                      	1	понедельник     	f	5	310	1009	948	674
1041	2012-11-06	\N	35	\N	2012-11-06                      	2	вторник         	f	6	311	1010	949	675
1042	2012-11-07	\N	35	\N	2012-11-07                      	3	среда           	f	7	312	1011	950	676
1043	2012-11-08	\N	35	\N	2012-11-08                      	4	четверг         	f	8	313	1012	951	677
1044	2012-11-09	\N	35	\N	2012-11-09                      	5	пятница         	f	9	314	1013	952	678
1045	2012-11-10	\N	35	\N	2012-11-10                      	6	суббота         	t	10	315	1014	953	679
1047	2012-11-12	\N	35	\N	2012-11-12                      	1	понедельник     	f	12	317	1016	955	681
1048	2012-11-13	\N	35	\N	2012-11-13                      	2	вторник         	f	13	318	1017	956	682
1049	2012-11-14	\N	35	\N	2012-11-14                      	3	среда           	f	14	319	1018	957	683
1050	2012-11-15	\N	35	\N	2012-11-15                      	4	четверг         	f	15	320	1019	958	684
1051	2012-11-16	\N	35	\N	2012-11-16                      	5	пятница         	f	16	321	1020	959	685
1052	2012-11-17	\N	35	\N	2012-11-17                      	6	суббота         	t	17	322	1021	960	686
1054	2012-11-19	\N	35	\N	2012-11-19                      	1	понедельник     	f	19	324	1023	962	688
1055	2012-11-20	\N	35	\N	2012-11-20                      	2	вторник         	f	20	325	1024	963	689
1056	2012-11-21	\N	35	\N	2012-11-21                      	3	среда           	f	21	326	1025	964	690
1057	2012-11-22	\N	35	\N	2012-11-22                      	4	четверг         	f	22	327	1026	965	691
1058	2012-11-23	\N	35	\N	2012-11-23                      	5	пятница         	f	23	328	1027	966	692
1059	2012-11-24	\N	35	\N	2012-11-24                      	6	суббота         	t	24	329	1028	967	693
1061	2012-11-26	\N	35	\N	2012-11-26                      	1	понедельник     	f	26	331	1030	969	695
1062	2012-11-27	\N	35	\N	2012-11-27                      	2	вторник         	f	27	332	1031	970	696
1063	2012-11-28	\N	35	\N	2012-11-28                      	3	среда           	f	28	333	1032	971	697
1064	2012-11-29	\N	35	\N	2012-11-29                      	4	четверг         	f	29	334	1033	972	698
1065	2012-11-30	\N	35	\N	2012-11-30                      	5	пятница         	f	30	335	1034	973	699
1066	2012-12-01	\N	36	\N	2012-12-01                      	6	суббота         	t	1	336	1036	975	700
1068	2012-12-03	\N	36	\N	2012-12-03                      	1	понедельник     	f	3	338	1038	977	702
1069	2012-12-04	\N	36	\N	2012-12-04                      	2	вторник         	f	4	339	1039	978	703
1070	2012-12-05	\N	36	\N	2012-12-05                      	3	среда           	f	5	340	1040	979	704
1071	2012-12-06	\N	36	\N	2012-12-06                      	4	четверг         	f	6	341	1041	980	705
1072	2012-12-07	\N	36	\N	2012-12-07                      	5	пятница         	f	7	342	1042	981	706
1073	2012-12-08	\N	36	\N	2012-12-08                      	6	суббота         	t	8	343	1043	982	707
1075	2012-12-10	\N	36	\N	2012-12-10                      	1	понедельник     	f	10	345	1045	984	709
1076	2012-12-11	\N	36	\N	2012-12-11                      	2	вторник         	f	11	346	1046	985	710
1077	2012-12-12	\N	36	\N	2012-12-12                      	3	среда           	f	12	347	1047	986	711
1078	2012-12-13	\N	36	\N	2012-12-13                      	4	четверг         	f	13	348	1048	987	712
1079	2012-12-14	\N	36	\N	2012-12-14                      	5	пятница         	f	14	349	1049	988	713
1080	2012-12-15	\N	36	\N	2012-12-15                      	6	суббота         	t	15	350	1050	989	714
1082	2012-12-17	\N	36	\N	2012-12-17                      	1	понедельник     	f	17	352	1052	991	716
1083	2012-12-18	\N	36	\N	2012-12-18                      	2	вторник         	f	18	353	1053	992	717
1084	2012-12-19	\N	36	\N	2012-12-19                      	3	среда           	f	19	354	1054	993	718
1085	2012-12-20	\N	36	\N	2012-12-20                      	4	четверг         	f	20	355	1055	994	719
1086	2012-12-21	\N	36	\N	2012-12-21                      	5	пятница         	f	21	356	1056	995	720
1087	2012-12-22	\N	36	\N	2012-12-22                      	6	суббота         	t	22	357	1057	996	721
1089	2012-12-24	\N	36	\N	2012-12-24                      	1	понедельник     	f	24	359	1059	998	723
1090	2012-12-25	\N	36	\N	2012-12-25                      	2	вторник         	f	25	360	1060	999	724
1091	2012-12-26	\N	36	\N	2012-12-26                      	3	среда           	f	26	361	1061	1000	725
1092	2012-12-27	\N	36	\N	2012-12-27                      	4	четверг         	f	27	362	1062	1001	726
1093	2012-12-28	\N	36	\N	2012-12-28                      	5	пятница         	f	28	363	1063	1002	727
1094	2012-12-29	\N	36	\N	2012-12-29                      	6	суббота         	t	29	364	1064	1003	728
1096	2012-12-31	\N	36	\N	2012-12-31                      	1	понедельник     	f	31	366	1065	1004	730
1097	2013-01-01	\N	37	\N	2013-01-01                      	2	вторник         	f	1	1	1066	1005	731
1098	2013-01-02	\N	37	\N	2013-01-02                      	3	среда           	f	2	2	1067	1006	732
1099	2013-01-03	\N	37	\N	2013-01-03                      	4	четверг         	f	3	3	1068	1007	733
1100	2013-01-04	\N	37	\N	2013-01-04                      	5	пятница         	f	4	4	1069	1008	734
1101	2013-01-05	\N	37	\N	2013-01-05                      	6	суббота         	t	5	5	1070	1009	735
1103	2013-01-07	\N	37	\N	2013-01-07                      	1	понедельник     	f	7	7	1072	1011	737
1104	2013-01-08	\N	37	\N	2013-01-08                      	2	вторник         	f	8	8	1073	1012	738
1105	2013-01-09	\N	37	\N	2013-01-09                      	3	среда           	f	9	9	1074	1013	739
1106	2013-01-10	\N	37	\N	2013-01-10                      	4	четверг         	f	10	10	1075	1014	740
1107	2013-01-11	\N	37	\N	2013-01-11                      	5	пятница         	f	11	11	1076	1015	741
1108	2013-01-12	\N	37	\N	2013-01-12                      	6	суббота         	t	12	12	1077	1016	742
1110	2013-01-14	\N	37	\N	2013-01-14                      	1	понедельник     	f	14	14	1079	1018	744
1111	2013-01-15	\N	37	\N	2013-01-15                      	2	вторник         	f	15	15	1080	1019	745
1112	2013-01-16	\N	37	\N	2013-01-16                      	3	среда           	f	16	16	1081	1020	746
1113	2013-01-17	\N	37	\N	2013-01-17                      	4	четверг         	f	17	17	1082	1021	747
1114	2013-01-18	\N	37	\N	2013-01-18                      	5	пятница         	f	18	18	1083	1022	748
1115	2013-01-19	\N	37	\N	2013-01-19                      	6	суббота         	t	19	19	1084	1023	749
1117	2013-01-21	\N	37	\N	2013-01-21                      	1	понедельник     	f	21	21	1086	1025	751
1118	2013-01-22	\N	37	\N	2013-01-22                      	2	вторник         	f	22	22	1087	1026	752
1119	2013-01-23	\N	37	\N	2013-01-23                      	3	среда           	f	23	23	1088	1027	753
1120	2013-01-24	\N	37	\N	2013-01-24                      	4	четверг         	f	24	24	1089	1028	754
1121	2013-01-25	\N	37	\N	2013-01-25                      	5	пятница         	f	25	25	1090	1029	755
1122	2013-01-26	\N	37	\N	2013-01-26                      	6	суббота         	t	26	26	1091	1030	756
1124	2013-01-28	\N	37	\N	2013-01-28                      	1	понедельник     	f	28	28	1093	1032	758
1125	2013-01-29	\N	37	\N	2013-01-29                      	2	вторник         	f	29	29	1094	1033	759
1126	2013-01-30	\N	37	\N	2013-01-30                      	3	среда           	f	30	30	1095	1034	760
1127	2013-01-31	\N	37	\N	2013-01-31                      	4	четверг         	f	31	31	1096	1035	761
1128	2013-02-01	\N	38	\N	2013-02-01                      	5	пятница         	f	1	32	1097	1036	762
1129	2013-02-02	\N	38	\N	2013-02-02                      	6	суббота         	t	2	33	1098	1037	763
1131	2013-02-04	\N	38	\N	2013-02-04                      	1	понедельник     	f	4	35	1100	1039	765
1132	2013-02-05	\N	38	\N	2013-02-05                      	2	вторник         	f	5	36	1101	1040	766
1133	2013-02-06	\N	38	\N	2013-02-06                      	3	среда           	f	6	37	1102	1041	767
1134	2013-02-07	\N	38	\N	2013-02-07                      	4	четверг         	f	7	38	1103	1042	768
1135	2013-02-08	\N	38	\N	2013-02-08                      	5	пятница         	f	8	39	1104	1043	769
1136	2013-02-09	\N	38	\N	2013-02-09                      	6	суббота         	t	9	40	1105	1044	770
1138	2013-02-11	\N	38	\N	2013-02-11                      	1	понедельник     	f	11	42	1107	1046	772
1139	2013-02-12	\N	38	\N	2013-02-12                      	2	вторник         	f	12	43	1108	1047	773
1140	2013-02-13	\N	38	\N	2013-02-13                      	3	среда           	f	13	44	1109	1048	774
1141	2013-02-14	\N	38	\N	2013-02-14                      	4	четверг         	f	14	45	1110	1049	775
1142	2013-02-15	\N	38	\N	2013-02-15                      	5	пятница         	f	15	46	1111	1050	776
1143	2013-02-16	\N	38	\N	2013-02-16                      	6	суббота         	t	16	47	1112	1051	777
1145	2013-02-18	\N	38	\N	2013-02-18                      	1	понедельник     	f	18	49	1114	1053	779
1146	2013-02-19	\N	38	\N	2013-02-19                      	2	вторник         	f	19	50	1115	1054	780
1147	2013-02-20	\N	38	\N	2013-02-20                      	3	среда           	f	20	51	1116	1055	781
1148	2013-02-21	\N	38	\N	2013-02-21                      	4	четверг         	f	21	52	1117	1056	782
1149	2013-02-22	\N	38	\N	2013-02-22                      	5	пятница         	f	22	53	1118	1057	783
1150	2013-02-23	\N	38	\N	2013-02-23                      	6	суббота         	t	23	54	1119	1058	784
1152	2013-02-25	\N	38	\N	2013-02-25                      	1	понедельник     	f	25	56	1121	1060	786
1153	2013-02-26	\N	38	\N	2013-02-26                      	2	вторник         	f	26	57	1122	1061	787
1154	2013-02-27	\N	38	\N	2013-02-27                      	3	среда           	f	27	58	1123	1062	788
1155	2013-02-28	\N	38	\N	2013-02-28                      	4	четверг         	f	28	59	1124	1063	789
1156	2013-03-01	\N	39	\N	2013-03-01                      	5	пятница         	f	1	60	1128	1066	791
1157	2013-03-02	\N	39	\N	2013-03-02                      	6	суббота         	t	2	61	1129	1067	792
1159	2013-03-04	\N	39	\N	2013-03-04                      	1	понедельник     	f	4	63	1131	1069	794
1160	2013-03-05	\N	39	\N	2013-03-05                      	2	вторник         	f	5	64	1132	1070	795
1161	2013-03-06	\N	39	\N	2013-03-06                      	3	среда           	f	6	65	1133	1071	796
1162	2013-03-07	\N	39	\N	2013-03-07                      	4	четверг         	f	7	66	1134	1072	797
1163	2013-03-08	\N	39	\N	2013-03-08                      	5	пятница         	f	8	67	1135	1073	798
1164	2013-03-09	\N	39	\N	2013-03-09                      	6	суббота         	t	9	68	1136	1074	799
1166	2013-03-11	\N	39	\N	2013-03-11                      	1	понедельник     	f	11	70	1138	1076	801
1167	2013-03-12	\N	39	\N	2013-03-12                      	2	вторник         	f	12	71	1139	1077	802
1168	2013-03-13	\N	39	\N	2013-03-13                      	3	среда           	f	13	72	1140	1078	803
1169	2013-03-14	\N	39	\N	2013-03-14                      	4	четверг         	f	14	73	1141	1079	804
1170	2013-03-15	\N	39	\N	2013-03-15                      	5	пятница         	f	15	74	1142	1080	805
1171	2013-03-16	\N	39	\N	2013-03-16                      	6	суббота         	t	16	75	1143	1081	806
1173	2013-03-18	\N	39	\N	2013-03-18                      	1	понедельник     	f	18	77	1145	1083	808
1174	2013-03-19	\N	39	\N	2013-03-19                      	2	вторник         	f	19	78	1146	1084	809
1175	2013-03-20	\N	39	\N	2013-03-20                      	3	среда           	f	20	79	1147	1085	810
1176	2013-03-21	\N	39	\N	2013-03-21                      	4	четверг         	f	21	80	1148	1086	811
1177	2013-03-22	\N	39	\N	2013-03-22                      	5	пятница         	f	22	81	1149	1087	812
1178	2013-03-23	\N	39	\N	2013-03-23                      	6	суббота         	t	23	82	1150	1088	813
1180	2013-03-25	\N	39	\N	2013-03-25                      	1	понедельник     	f	25	84	1152	1090	815
1181	2013-03-26	\N	39	\N	2013-03-26                      	2	вторник         	f	26	85	1153	1091	816
1182	2013-03-27	\N	39	\N	2013-03-27                      	3	среда           	f	27	86	1154	1092	817
1183	2013-03-28	\N	39	\N	2013-03-28                      	4	четверг         	f	28	87	1155	1093	818
1184	2013-03-29	\N	39	\N	2013-03-29                      	5	пятница         	f	29	88	1155	1094	819
1185	2013-03-30	\N	39	\N	2013-03-30                      	6	суббота         	t	30	89	1155	1095	820
1187	2013-04-01	\N	40	\N	2013-04-01                      	1	понедельник     	f	1	91	1156	1097	822
1188	2013-04-02	\N	40	\N	2013-04-02                      	2	вторник         	f	2	92	1157	1098	823
1189	2013-04-03	\N	40	\N	2013-04-03                      	3	среда           	f	3	93	1158	1099	824
1190	2013-04-04	\N	40	\N	2013-04-04                      	4	четверг         	f	4	94	1159	1100	825
1191	2013-04-05	\N	40	\N	2013-04-05                      	5	пятница         	f	5	95	1160	1101	826
1192	2013-04-06	\N	40	\N	2013-04-06                      	6	суббота         	t	6	96	1161	1102	827
1194	2013-04-08	\N	40	\N	2013-04-08                      	1	понедельник     	f	8	98	1163	1104	829
1195	2013-04-09	\N	40	\N	2013-04-09                      	2	вторник         	f	9	99	1164	1105	830
1196	2013-04-10	\N	40	\N	2013-04-10                      	3	среда           	f	10	100	1165	1106	831
1197	2013-04-11	\N	40	\N	2013-04-11                      	4	четверг         	f	11	101	1166	1107	832
1198	2013-04-12	\N	40	\N	2013-04-12                      	5	пятница         	f	12	102	1167	1108	833
1199	2013-04-13	\N	40	\N	2013-04-13                      	6	суббота         	t	13	103	1168	1109	834
1201	2013-04-15	\N	40	\N	2013-04-15                      	1	понедельник     	f	15	105	1170	1111	836
1202	2013-04-16	\N	40	\N	2013-04-16                      	2	вторник         	f	16	106	1171	1112	837
1203	2013-04-17	\N	40	\N	2013-04-17                      	3	среда           	f	17	107	1172	1113	838
1204	2013-04-18	\N	40	\N	2013-04-18                      	4	четверг         	f	18	108	1173	1114	839
1205	2013-04-19	\N	40	\N	2013-04-19                      	5	пятница         	f	19	109	1174	1115	840
1206	2013-04-20	\N	40	\N	2013-04-20                      	6	суббота         	t	20	110	1175	1116	841
1208	2013-04-22	\N	40	\N	2013-04-22                      	1	понедельник     	f	22	112	1177	1118	843
1209	2013-04-23	\N	40	\N	2013-04-23                      	2	вторник         	f	23	113	1178	1119	844
1210	2013-04-24	\N	40	\N	2013-04-24                      	3	среда           	f	24	114	1179	1120	845
1211	2013-04-25	\N	40	\N	2013-04-25                      	4	четверг         	f	25	115	1180	1121	846
1212	2013-04-26	\N	40	\N	2013-04-26                      	5	пятница         	f	26	116	1181	1122	847
1213	2013-04-27	\N	40	\N	2013-04-27                      	6	суббота         	t	27	117	1182	1123	848
1215	2013-04-29	\N	40	\N	2013-04-29                      	1	понедельник     	f	29	119	1184	1125	850
1216	2013-04-30	\N	40	\N	2013-04-30                      	2	вторник         	f	30	120	1185	1126	851
1217	2013-05-01	\N	41	\N	2013-05-01                      	3	среда           	f	1	121	1187	1128	852
1218	2013-05-02	\N	41	\N	2013-05-02                      	4	четверг         	f	2	122	1188	1129	853
1219	2013-05-03	\N	41	\N	2013-05-03                      	5	пятница         	f	3	123	1189	1130	854
1220	2013-05-04	\N	41	\N	2013-05-04                      	6	суббота         	t	4	124	1190	1131	855
1222	2013-05-06	\N	41	\N	2013-05-06                      	1	понедельник     	f	6	126	1192	1133	857
1223	2013-05-07	\N	41	\N	2013-05-07                      	2	вторник         	f	7	127	1193	1134	858
1224	2013-05-08	\N	41	\N	2013-05-08                      	3	среда           	f	8	128	1194	1135	859
1225	2013-05-09	\N	41	\N	2013-05-09                      	4	четверг         	f	9	129	1195	1136	860
1226	2013-05-10	\N	41	\N	2013-05-10                      	5	пятница         	f	10	130	1196	1137	861
1227	2013-05-11	\N	41	\N	2013-05-11                      	6	суббота         	t	11	131	1197	1138	862
1229	2013-05-13	\N	41	\N	2013-05-13                      	1	понедельник     	f	13	133	1199	1140	864
1230	2013-05-14	\N	41	\N	2013-05-14                      	2	вторник         	f	14	134	1200	1141	865
1231	2013-05-15	\N	41	\N	2013-05-15                      	3	среда           	f	15	135	1201	1142	866
1232	2013-05-16	\N	41	\N	2013-05-16                      	4	четверг         	f	16	136	1202	1143	867
1233	2013-05-17	\N	41	\N	2013-05-17                      	5	пятница         	f	17	137	1203	1144	868
1234	2013-05-18	\N	41	\N	2013-05-18                      	6	суббота         	t	18	138	1204	1145	869
1236	2013-05-20	\N	41	\N	2013-05-20                      	1	понедельник     	f	20	140	1206	1147	871
1237	2013-05-21	\N	41	\N	2013-05-21                      	2	вторник         	f	21	141	1207	1148	872
1238	2013-05-22	\N	41	\N	2013-05-22                      	3	среда           	f	22	142	1208	1149	873
1239	2013-05-23	\N	41	\N	2013-05-23                      	4	четверг         	f	23	143	1209	1150	874
1240	2013-05-24	\N	41	\N	2013-05-24                      	5	пятница         	f	24	144	1210	1151	875
1241	2013-05-25	\N	41	\N	2013-05-25                      	6	суббота         	t	25	145	1211	1152	876
1243	2013-05-27	\N	41	\N	2013-05-27                      	1	понедельник     	f	27	147	1213	1154	878
1244	2013-05-28	\N	41	\N	2013-05-28                      	2	вторник         	f	28	148	1214	1155	879
1245	2013-05-29	\N	41	\N	2013-05-29                      	3	среда           	f	29	149	1215	1155	880
1246	2013-05-30	\N	41	\N	2013-05-30                      	4	четверг         	f	30	150	1216	1155	881
1247	2013-05-31	\N	41	\N	2013-05-31                      	5	пятница         	f	31	151	1216	1155	882
1248	2013-06-01	\N	42	\N	2013-06-01                      	6	суббота         	t	1	152	1217	1156	883
1250	2013-06-03	\N	42	\N	2013-06-03                      	1	понедельник     	f	3	154	1219	1158	885
1251	2013-06-04	\N	42	\N	2013-06-04                      	2	вторник         	f	4	155	1220	1159	886
1252	2013-06-05	\N	42	\N	2013-06-05                      	3	среда           	f	5	156	1221	1160	887
1253	2013-06-06	\N	42	\N	2013-06-06                      	4	четверг         	f	6	157	1222	1161	888
1254	2013-06-07	\N	42	\N	2013-06-07                      	5	пятница         	f	7	158	1223	1162	889
1255	2013-06-08	\N	42	\N	2013-06-08                      	6	суббота         	t	8	159	1224	1163	890
1257	2013-06-10	\N	42	\N	2013-06-10                      	1	понедельник     	f	10	161	1226	1165	892
1258	2013-06-11	\N	42	\N	2013-06-11                      	2	вторник         	f	11	162	1227	1166	893
1259	2013-06-12	\N	42	\N	2013-06-12                      	3	среда           	f	12	163	1228	1167	894
1260	2013-06-13	\N	42	\N	2013-06-13                      	4	четверг         	f	13	164	1229	1168	895
1261	2013-06-14	\N	42	\N	2013-06-14                      	5	пятница         	f	14	165	1230	1169	896
1262	2013-06-15	\N	42	\N	2013-06-15                      	6	суббота         	t	15	166	1231	1170	897
1264	2013-06-17	\N	42	\N	2013-06-17                      	1	понедельник     	f	17	168	1233	1172	899
1265	2013-06-18	\N	42	\N	2013-06-18                      	2	вторник         	f	18	169	1234	1173	900
1266	2013-06-19	\N	42	\N	2013-06-19                      	3	среда           	f	19	170	1235	1174	901
1267	2013-06-20	\N	42	\N	2013-06-20                      	4	четверг         	f	20	171	1236	1175	902
1268	2013-06-21	\N	42	\N	2013-06-21                      	5	пятница         	f	21	172	1237	1176	903
1269	2013-06-22	\N	42	\N	2013-06-22                      	6	суббота         	t	22	173	1238	1177	904
1271	2013-06-24	\N	42	\N	2013-06-24                      	1	понедельник     	f	24	175	1240	1179	906
1272	2013-06-25	\N	42	\N	2013-06-25                      	2	вторник         	f	25	176	1241	1180	907
1273	2013-06-26	\N	42	\N	2013-06-26                      	3	среда           	f	26	177	1242	1181	908
1274	2013-06-27	\N	42	\N	2013-06-27                      	4	четверг         	f	27	178	1243	1182	909
1275	2013-06-28	\N	42	\N	2013-06-28                      	5	пятница         	f	28	179	1244	1183	910
1276	2013-06-29	\N	42	\N	2013-06-29                      	6	суббота         	t	29	180	1245	1184	911
1278	2013-07-01	\N	43	\N	2013-07-01                      	1	понедельник     	f	1	182	1248	1187	913
1279	2013-07-02	\N	43	\N	2013-07-02                      	2	вторник         	f	2	183	1249	1188	914
1280	2013-07-03	\N	43	\N	2013-07-03                      	3	среда           	f	3	184	1250	1189	915
1281	2013-07-04	\N	43	\N	2013-07-04                      	4	четверг         	f	4	185	1251	1190	916
1282	2013-07-05	\N	43	\N	2013-07-05                      	5	пятница         	f	5	186	1252	1191	917
1283	2013-07-06	\N	43	\N	2013-07-06                      	6	суббота         	t	6	187	1253	1192	918
1285	2013-07-08	\N	43	\N	2013-07-08                      	1	понедельник     	f	8	189	1255	1194	920
1286	2013-07-09	\N	43	\N	2013-07-09                      	2	вторник         	f	9	190	1256	1195	921
1287	2013-07-10	\N	43	\N	2013-07-10                      	3	среда           	f	10	191	1257	1196	922
1288	2013-07-11	\N	43	\N	2013-07-11                      	4	четверг         	f	11	192	1258	1197	923
1289	2013-07-12	\N	43	\N	2013-07-12                      	5	пятница         	f	12	193	1259	1198	924
1290	2013-07-13	\N	43	\N	2013-07-13                      	6	суббота         	t	13	194	1260	1199	925
1292	2013-07-15	\N	43	\N	2013-07-15                      	1	понедельник     	f	15	196	1262	1201	927
1293	2013-07-16	\N	43	\N	2013-07-16                      	2	вторник         	f	16	197	1263	1202	928
1294	2013-07-17	\N	43	\N	2013-07-17                      	3	среда           	f	17	198	1264	1203	929
1295	2013-07-18	\N	43	\N	2013-07-18                      	4	четверг         	f	18	199	1265	1204	930
1296	2013-07-19	\N	43	\N	2013-07-19                      	5	пятница         	f	19	200	1266	1205	931
1297	2013-07-20	\N	43	\N	2013-07-20                      	6	суббота         	t	20	201	1267	1206	932
1299	2013-07-22	\N	43	\N	2013-07-22                      	1	понедельник     	f	22	203	1269	1208	934
1300	2013-07-23	\N	43	\N	2013-07-23                      	2	вторник         	f	23	204	1270	1209	935
1301	2013-07-24	\N	43	\N	2013-07-24                      	3	среда           	f	24	205	1271	1210	936
1302	2013-07-25	\N	43	\N	2013-07-25                      	4	четверг         	f	25	206	1272	1211	937
1303	2013-07-26	\N	43	\N	2013-07-26                      	5	пятница         	f	26	207	1273	1212	938
1304	2013-07-27	\N	43	\N	2013-07-27                      	6	суббота         	t	27	208	1274	1213	939
1306	2013-07-29	\N	43	\N	2013-07-29                      	1	понедельник     	f	29	210	1276	1215	941
1307	2013-07-30	\N	43	\N	2013-07-30                      	2	вторник         	f	30	211	1277	1216	942
1308	2013-07-31	\N	43	\N	2013-07-31                      	3	среда           	f	31	212	1277	1216	943
1309	2013-08-01	\N	44	\N	2013-08-01                      	4	четверг         	f	1	213	1278	1217	944
1310	2013-08-02	\N	44	\N	2013-08-02                      	5	пятница         	f	2	214	1279	1218	945
1311	2013-08-03	\N	44	\N	2013-08-03                      	6	суббота         	t	3	215	1280	1219	946
1313	2013-08-05	\N	44	\N	2013-08-05                      	1	понедельник     	f	5	217	1282	1221	948
1314	2013-08-06	\N	44	\N	2013-08-06                      	2	вторник         	f	6	218	1283	1222	949
1315	2013-08-07	\N	44	\N	2013-08-07                      	3	среда           	f	7	219	1284	1223	950
1316	2013-08-08	\N	44	\N	2013-08-08                      	4	четверг         	f	8	220	1285	1224	951
1317	2013-08-09	\N	44	\N	2013-08-09                      	5	пятница         	f	9	221	1286	1225	952
1318	2013-08-10	\N	44	\N	2013-08-10                      	6	суббота         	t	10	222	1287	1226	953
1320	2013-08-12	\N	44	\N	2013-08-12                      	1	понедельник     	f	12	224	1289	1228	955
1321	2013-08-13	\N	44	\N	2013-08-13                      	2	вторник         	f	13	225	1290	1229	956
1322	2013-08-14	\N	44	\N	2013-08-14                      	3	среда           	f	14	226	1291	1230	957
1323	2013-08-15	\N	44	\N	2013-08-15                      	4	четверг         	f	15	227	1292	1231	958
1324	2013-08-16	\N	44	\N	2013-08-16                      	5	пятница         	f	16	228	1293	1232	959
1325	2013-08-17	\N	44	\N	2013-08-17                      	6	суббота         	t	17	229	1294	1233	960
1327	2013-08-19	\N	44	\N	2013-08-19                      	1	понедельник     	f	19	231	1296	1235	962
1328	2013-08-20	\N	44	\N	2013-08-20                      	2	вторник         	f	20	232	1297	1236	963
1329	2013-08-21	\N	44	\N	2013-08-21                      	3	среда           	f	21	233	1298	1237	964
1330	2013-08-22	\N	44	\N	2013-08-22                      	4	четверг         	f	22	234	1299	1238	965
1331	2013-08-23	\N	44	\N	2013-08-23                      	5	пятница         	f	23	235	1300	1239	966
1332	2013-08-24	\N	44	\N	2013-08-24                      	6	суббота         	t	24	236	1301	1240	967
1334	2013-08-26	\N	44	\N	2013-08-26                      	1	понедельник     	f	26	238	1303	1242	969
1335	2013-08-27	\N	44	\N	2013-08-27                      	2	вторник         	f	27	239	1304	1243	970
1336	2013-08-28	\N	44	\N	2013-08-28                      	3	среда           	f	28	240	1305	1244	971
1337	2013-08-29	\N	44	\N	2013-08-29                      	4	четверг         	f	29	241	1306	1245	972
1338	2013-08-30	\N	44	\N	2013-08-30                      	5	пятница         	f	30	242	1307	1246	973
1339	2013-08-31	\N	44	\N	2013-08-31                      	6	суббота         	t	31	243	1308	1247	974
1341	2013-09-02	\N	45	\N	2013-09-02                      	1	понедельник     	f	2	245	1310	1249	976
1342	2013-09-03	\N	45	\N	2013-09-03                      	2	вторник         	f	3	246	1311	1250	977
1343	2013-09-04	\N	45	\N	2013-09-04                      	3	среда           	f	4	247	1312	1251	978
1344	2013-09-05	\N	45	\N	2013-09-05                      	4	четверг         	f	5	248	1313	1252	979
1345	2013-09-06	\N	45	\N	2013-09-06                      	5	пятница         	f	6	249	1314	1253	980
1346	2013-09-07	\N	45	\N	2013-09-07                      	6	суббота         	t	7	250	1315	1254	981
1348	2013-09-09	\N	45	\N	2013-09-09                      	1	понедельник     	f	9	252	1317	1256	983
1349	2013-09-10	\N	45	\N	2013-09-10                      	2	вторник         	f	10	253	1318	1257	984
1350	2013-09-11	\N	45	\N	2013-09-11                      	3	среда           	f	11	254	1319	1258	985
1351	2013-09-12	\N	45	\N	2013-09-12                      	4	четверг         	f	12	255	1320	1259	986
1352	2013-09-13	\N	45	\N	2013-09-13                      	5	пятница         	f	13	256	1321	1260	987
1353	2013-09-14	\N	45	\N	2013-09-14                      	6	суббота         	t	14	257	1322	1261	988
1355	2013-09-16	\N	45	\N	2013-09-16                      	1	понедельник     	f	16	259	1324	1263	990
1356	2013-09-17	\N	45	\N	2013-09-17                      	2	вторник         	f	17	260	1325	1264	991
1357	2013-09-18	\N	45	\N	2013-09-18                      	3	среда           	f	18	261	1326	1265	992
1358	2013-09-19	\N	45	\N	2013-09-19                      	4	четверг         	f	19	262	1327	1266	993
1359	2013-09-20	\N	45	\N	2013-09-20                      	5	пятница         	f	20	263	1328	1267	994
1360	2013-09-21	\N	45	\N	2013-09-21                      	6	суббота         	t	21	264	1329	1268	995
1362	2013-09-23	\N	45	\N	2013-09-23                      	1	понедельник     	f	23	266	1331	1270	997
1363	2013-09-24	\N	45	\N	2013-09-24                      	2	вторник         	f	24	267	1332	1271	998
1364	2013-09-25	\N	45	\N	2013-09-25                      	3	среда           	f	25	268	1333	1272	999
1365	2013-09-26	\N	45	\N	2013-09-26                      	4	четверг         	f	26	269	1334	1273	1000
1366	2013-09-27	\N	45	\N	2013-09-27                      	5	пятница         	f	27	270	1335	1274	1001
1367	2013-09-28	\N	45	\N	2013-09-28                      	6	суббота         	t	28	271	1336	1275	1002
1369	2013-09-30	\N	45	\N	2013-09-30                      	1	понедельник     	f	30	273	1338	1277	1004
1370	2013-10-01	\N	46	\N	2013-10-01                      	2	вторник         	f	1	274	1340	1278	1005
1371	2013-10-02	\N	46	\N	2013-10-02                      	3	среда           	f	2	275	1341	1279	1006
1372	2013-10-03	\N	46	\N	2013-10-03                      	4	четверг         	f	3	276	1342	1280	1007
1373	2013-10-04	\N	46	\N	2013-10-04                      	5	пятница         	f	4	277	1343	1281	1008
1374	2013-10-05	\N	46	\N	2013-10-05                      	6	суббота         	t	5	278	1344	1282	1009
1376	2013-10-07	\N	46	\N	2013-10-07                      	1	понедельник     	f	7	280	1346	1284	1011
1377	2013-10-08	\N	46	\N	2013-10-08                      	2	вторник         	f	8	281	1347	1285	1012
1378	2013-10-09	\N	46	\N	2013-10-09                      	3	среда           	f	9	282	1348	1286	1013
1379	2013-10-10	\N	46	\N	2013-10-10                      	4	четверг         	f	10	283	1349	1287	1014
1380	2013-10-11	\N	46	\N	2013-10-11                      	5	пятница         	f	11	284	1350	1288	1015
1381	2013-10-12	\N	46	\N	2013-10-12                      	6	суббота         	t	12	285	1351	1289	1016
1383	2013-10-14	\N	46	\N	2013-10-14                      	1	понедельник     	f	14	287	1353	1291	1018
1384	2013-10-15	\N	46	\N	2013-10-15                      	2	вторник         	f	15	288	1354	1292	1019
1385	2013-10-16	\N	46	\N	2013-10-16                      	3	среда           	f	16	289	1355	1293	1020
1386	2013-10-17	\N	46	\N	2013-10-17                      	4	четверг         	f	17	290	1356	1294	1021
1387	2013-10-18	\N	46	\N	2013-10-18                      	5	пятница         	f	18	291	1357	1295	1022
1388	2013-10-19	\N	46	\N	2013-10-19                      	6	суббота         	t	19	292	1358	1296	1023
1390	2013-10-21	\N	46	\N	2013-10-21                      	1	понедельник     	f	21	294	1360	1298	1025
1391	2013-10-22	\N	46	\N	2013-10-22                      	2	вторник         	f	22	295	1361	1299	1026
1392	2013-10-23	\N	46	\N	2013-10-23                      	3	среда           	f	23	296	1362	1300	1027
1393	2013-10-24	\N	46	\N	2013-10-24                      	4	четверг         	f	24	297	1363	1301	1028
1394	2013-10-25	\N	46	\N	2013-10-25                      	5	пятница         	f	25	298	1364	1302	1029
1395	2013-10-26	\N	46	\N	2013-10-26                      	6	суббота         	t	26	299	1365	1303	1030
1397	2013-10-28	\N	46	\N	2013-10-28                      	1	понедельник     	f	28	301	1367	1305	1032
1398	2013-10-29	\N	46	\N	2013-10-29                      	2	вторник         	f	29	302	1368	1306	1033
1399	2013-10-30	\N	46	\N	2013-10-30                      	3	среда           	f	30	303	1369	1307	1034
1400	2013-10-31	\N	46	\N	2013-10-31                      	4	четверг         	f	31	304	1369	1308	1035
1401	2013-11-01	\N	47	\N	2013-11-01                      	5	пятница         	f	1	305	1370	1309	1036
1402	2013-11-02	\N	47	\N	2013-11-02                      	6	суббота         	t	2	306	1371	1310	1037
1404	2013-11-04	\N	47	\N	2013-11-04                      	1	понедельник     	f	4	308	1373	1312	1039
1405	2013-11-05	\N	47	\N	2013-11-05                      	2	вторник         	f	5	309	1374	1313	1040
1406	2013-11-06	\N	47	\N	2013-11-06                      	3	среда           	f	6	310	1375	1314	1041
1407	2013-11-07	\N	47	\N	2013-11-07                      	4	четверг         	f	7	311	1376	1315	1042
1408	2013-11-08	\N	47	\N	2013-11-08                      	5	пятница         	f	8	312	1377	1316	1043
1409	2013-11-09	\N	47	\N	2013-11-09                      	6	суббота         	t	9	313	1378	1317	1044
1411	2013-11-11	\N	47	\N	2013-11-11                      	1	понедельник     	f	11	315	1380	1319	1046
1412	2013-11-12	\N	47	\N	2013-11-12                      	2	вторник         	f	12	316	1381	1320	1047
1413	2013-11-13	\N	47	\N	2013-11-13                      	3	среда           	f	13	317	1382	1321	1048
1414	2013-11-14	\N	47	\N	2013-11-14                      	4	четверг         	f	14	318	1383	1322	1049
1415	2013-11-15	\N	47	\N	2013-11-15                      	5	пятница         	f	15	319	1384	1323	1050
1416	2013-11-16	\N	47	\N	2013-11-16                      	6	суббота         	t	16	320	1385	1324	1051
1418	2013-11-18	\N	47	\N	2013-11-18                      	1	понедельник     	f	18	322	1387	1326	1053
1419	2013-11-19	\N	47	\N	2013-11-19                      	2	вторник         	f	19	323	1388	1327	1054
1420	2013-11-20	\N	47	\N	2013-11-20                      	3	среда           	f	20	324	1389	1328	1055
1421	2013-11-21	\N	47	\N	2013-11-21                      	4	четверг         	f	21	325	1390	1329	1056
1422	2013-11-22	\N	47	\N	2013-11-22                      	5	пятница         	f	22	326	1391	1330	1057
1423	2013-11-23	\N	47	\N	2013-11-23                      	6	суббота         	t	23	327	1392	1331	1058
1425	2013-11-25	\N	47	\N	2013-11-25                      	1	понедельник     	f	25	329	1394	1333	1060
1426	2013-11-26	\N	47	\N	2013-11-26                      	2	вторник         	f	26	330	1395	1334	1061
1427	2013-11-27	\N	47	\N	2013-11-27                      	3	среда           	f	27	331	1396	1335	1062
1428	2013-11-28	\N	47	\N	2013-11-28                      	4	четверг         	f	28	332	1397	1336	1063
1429	2013-11-29	\N	47	\N	2013-11-29                      	5	пятница         	f	29	333	1398	1337	1064
1430	2013-11-30	\N	47	\N	2013-11-30                      	6	суббота         	t	30	334	1399	1338	1065
1432	2013-12-02	\N	48	\N	2013-12-02                      	1	понедельник     	f	2	336	1402	1341	1067
1433	2013-12-03	\N	48	\N	2013-12-03                      	2	вторник         	f	3	337	1403	1342	1068
1434	2013-12-04	\N	48	\N	2013-12-04                      	3	среда           	f	4	338	1404	1343	1069
1435	2013-12-05	\N	48	\N	2013-12-05                      	4	четверг         	f	5	339	1405	1344	1070
1436	2013-12-06	\N	48	\N	2013-12-06                      	5	пятница         	f	6	340	1406	1345	1071
1437	2013-12-07	\N	48	\N	2013-12-07                      	6	суббота         	t	7	341	1407	1346	1072
1439	2013-12-09	\N	48	\N	2013-12-09                      	1	понедельник     	f	9	343	1409	1348	1074
1440	2013-12-10	\N	48	\N	2013-12-10                      	2	вторник         	f	10	344	1410	1349	1075
1441	2013-12-11	\N	48	\N	2013-12-11                      	3	среда           	f	11	345	1411	1350	1076
1442	2013-12-12	\N	48	\N	2013-12-12                      	4	четверг         	f	12	346	1412	1351	1077
1443	2013-12-13	\N	48	\N	2013-12-13                      	5	пятница         	f	13	347	1413	1352	1078
1444	2013-12-14	\N	48	\N	2013-12-14                      	6	суббота         	t	14	348	1414	1353	1079
1446	2013-12-16	\N	48	\N	2013-12-16                      	1	понедельник     	f	16	350	1416	1355	1081
1447	2013-12-17	\N	48	\N	2013-12-17                      	2	вторник         	f	17	351	1417	1356	1082
1448	2013-12-18	\N	48	\N	2013-12-18                      	3	среда           	f	18	352	1418	1357	1083
1449	2013-12-19	\N	48	\N	2013-12-19                      	4	четверг         	f	19	353	1419	1358	1084
1450	2013-12-20	\N	48	\N	2013-12-20                      	5	пятница         	f	20	354	1420	1359	1085
1451	2013-12-21	\N	48	\N	2013-12-21                      	6	суббота         	t	21	355	1421	1360	1086
1453	2013-12-23	\N	48	\N	2013-12-23                      	1	понедельник     	f	23	357	1423	1362	1088
1454	2013-12-24	\N	48	\N	2013-12-24                      	2	вторник         	f	24	358	1424	1363	1089
1455	2013-12-25	\N	48	\N	2013-12-25                      	3	среда           	f	25	359	1425	1364	1090
1456	2013-12-26	\N	48	\N	2013-12-26                      	4	четверг         	f	26	360	1426	1365	1091
1457	2013-12-27	\N	48	\N	2013-12-27                      	5	пятница         	f	27	361	1427	1366	1092
1458	2013-12-28	\N	48	\N	2013-12-28                      	6	суббота         	t	28	362	1428	1367	1093
1460	2013-12-30	\N	48	\N	2013-12-30                      	1	понедельник     	f	30	364	1430	1369	1095
1461	2013-12-31	\N	48	\N	2013-12-31                      	2	вторник         	f	31	365	1430	1369	1096
1462	2014-01-01	\N	49	\N	2014-01-01                      	3	среда           	f	1	1	1431	1370	1097
1463	2014-01-02	\N	49	\N	2014-01-02                      	4	четверг         	f	2	2	1432	1371	1098
1464	2014-01-03	\N	49	\N	2014-01-03                      	5	пятница         	f	3	3	1433	1372	1099
1465	2014-01-04	\N	49	\N	2014-01-04                      	6	суббота         	t	4	4	1434	1373	1100
1467	2014-01-06	\N	49	\N	2014-01-06                      	1	понедельник     	f	6	6	1436	1375	1102
1468	2014-01-07	\N	49	\N	2014-01-07                      	2	вторник         	f	7	7	1437	1376	1103
1469	2014-01-08	\N	49	\N	2014-01-08                      	3	среда           	f	8	8	1438	1377	1104
1470	2014-01-09	\N	49	\N	2014-01-09                      	4	четверг         	f	9	9	1439	1378	1105
1471	2014-01-10	\N	49	\N	2014-01-10                      	5	пятница         	f	10	10	1440	1379	1106
1472	2014-01-11	\N	49	\N	2014-01-11                      	6	суббота         	t	11	11	1441	1380	1107
1474	2014-01-13	\N	49	\N	2014-01-13                      	1	понедельник     	f	13	13	1443	1382	1109
1475	2014-01-14	\N	49	\N	2014-01-14                      	2	вторник         	f	14	14	1444	1383	1110
1476	2014-01-15	\N	49	\N	2014-01-15                      	3	среда           	f	15	15	1445	1384	1111
1477	2014-01-16	\N	49	\N	2014-01-16                      	4	четверг         	f	16	16	1446	1385	1112
1478	2014-01-17	\N	49	\N	2014-01-17                      	5	пятница         	f	17	17	1447	1386	1113
1479	2014-01-18	\N	49	\N	2014-01-18                      	6	суббота         	t	18	18	1448	1387	1114
1481	2014-01-20	\N	49	\N	2014-01-20                      	1	понедельник     	f	20	20	1450	1389	1116
1482	2014-01-21	\N	49	\N	2014-01-21                      	2	вторник         	f	21	21	1451	1390	1117
1483	2014-01-22	\N	49	\N	2014-01-22                      	3	среда           	f	22	22	1452	1391	1118
1484	2014-01-23	\N	49	\N	2014-01-23                      	4	четверг         	f	23	23	1453	1392	1119
1485	2014-01-24	\N	49	\N	2014-01-24                      	5	пятница         	f	24	24	1454	1393	1120
1486	2014-01-25	\N	49	\N	2014-01-25                      	6	суббота         	t	25	25	1455	1394	1121
1488	2014-01-27	\N	49	\N	2014-01-27                      	1	понедельник     	f	27	27	1457	1396	1123
1489	2014-01-28	\N	49	\N	2014-01-28                      	2	вторник         	f	28	28	1458	1397	1124
1490	2014-01-29	\N	49	\N	2014-01-29                      	3	среда           	f	29	29	1459	1398	1125
1491	2014-01-30	\N	49	\N	2014-01-30                      	4	четверг         	f	30	30	1460	1399	1126
1492	2014-01-31	\N	49	\N	2014-01-31                      	5	пятница         	f	31	31	1461	1400	1127
1493	2014-02-01	\N	50	\N	2014-02-01                      	6	суббота         	t	1	32	1462	1401	1128
1495	2014-02-03	\N	50	\N	2014-02-03                      	1	понедельник     	f	3	34	1464	1403	1130
1496	2014-02-04	\N	50	\N	2014-02-04                      	2	вторник         	f	4	35	1465	1404	1131
1497	2014-02-05	\N	50	\N	2014-02-05                      	3	среда           	f	5	36	1466	1405	1132
1498	2014-02-06	\N	50	\N	2014-02-06                      	4	четверг         	f	6	37	1467	1406	1133
1499	2014-02-07	\N	50	\N	2014-02-07                      	5	пятница         	f	7	38	1468	1407	1134
1500	2014-02-08	\N	50	\N	2014-02-08                      	6	суббота         	t	8	39	1469	1408	1135
1502	2014-02-10	\N	50	\N	2014-02-10                      	1	понедельник     	f	10	41	1471	1410	1137
1503	2014-02-11	\N	50	\N	2014-02-11                      	2	вторник         	f	11	42	1472	1411	1138
1504	2014-02-12	\N	50	\N	2014-02-12                      	3	среда           	f	12	43	1473	1412	1139
1505	2014-02-13	\N	50	\N	2014-02-13                      	4	четверг         	f	13	44	1474	1413	1140
1506	2014-02-14	\N	50	\N	2014-02-14                      	5	пятница         	f	14	45	1475	1414	1141
1507	2014-02-15	\N	50	\N	2014-02-15                      	6	суббота         	t	15	46	1476	1415	1142
1509	2014-02-17	\N	50	\N	2014-02-17                      	1	понедельник     	f	17	48	1478	1417	1144
1510	2014-02-18	\N	50	\N	2014-02-18                      	2	вторник         	f	18	49	1479	1418	1145
1511	2014-02-19	\N	50	\N	2014-02-19                      	3	среда           	f	19	50	1480	1419	1146
1512	2014-02-20	\N	50	\N	2014-02-20                      	4	четверг         	f	20	51	1481	1420	1147
1513	2014-02-21	\N	50	\N	2014-02-21                      	5	пятница         	f	21	52	1482	1421	1148
1514	2014-02-22	\N	50	\N	2014-02-22                      	6	суббота         	t	22	53	1483	1422	1149
1516	2014-02-24	\N	50	\N	2014-02-24                      	1	понедельник     	f	24	55	1485	1424	1151
1517	2014-02-25	\N	50	\N	2014-02-25                      	2	вторник         	f	25	56	1486	1425	1152
1518	2014-02-26	\N	50	\N	2014-02-26                      	3	среда           	f	26	57	1487	1426	1153
1519	2014-02-27	\N	50	\N	2014-02-27                      	4	четверг         	f	27	58	1488	1427	1154
1520	2014-02-28	\N	50	\N	2014-02-28                      	5	пятница         	f	28	59	1489	1428	1155
1521	2014-03-01	\N	51	\N	2014-03-01                      	6	суббота         	t	1	60	1493	1431	1156
1523	2014-03-03	\N	51	\N	2014-03-03                      	1	понедельник     	f	3	62	1495	1433	1158
1524	2014-03-04	\N	51	\N	2014-03-04                      	2	вторник         	f	4	63	1496	1434	1159
1525	2014-03-05	\N	51	\N	2014-03-05                      	3	среда           	f	5	64	1497	1435	1160
1526	2014-03-06	\N	51	\N	2014-03-06                      	4	четверг         	f	6	65	1498	1436	1161
1527	2014-03-07	\N	51	\N	2014-03-07                      	5	пятница         	f	7	66	1499	1437	1162
1528	2014-03-08	\N	51	\N	2014-03-08                      	6	суббота         	t	8	67	1500	1438	1163
1530	2014-03-10	\N	51	\N	2014-03-10                      	1	понедельник     	f	10	69	1502	1440	1165
1531	2014-03-11	\N	51	\N	2014-03-11                      	2	вторник         	f	11	70	1503	1441	1166
1532	2014-03-12	\N	51	\N	2014-03-12                      	3	среда           	f	12	71	1504	1442	1167
1533	2014-03-13	\N	51	\N	2014-03-13                      	4	четверг         	f	13	72	1505	1443	1168
1534	2014-03-14	\N	51	\N	2014-03-14                      	5	пятница         	f	14	73	1506	1444	1169
1535	2014-03-15	\N	51	\N	2014-03-15                      	6	суббота         	t	15	74	1507	1445	1170
1537	2014-03-17	\N	51	\N	2014-03-17                      	1	понедельник     	f	17	76	1509	1447	1172
1538	2014-03-18	\N	51	\N	2014-03-18                      	2	вторник         	f	18	77	1510	1448	1173
1539	2014-03-19	\N	51	\N	2014-03-19                      	3	среда           	f	19	78	1511	1449	1174
1540	2014-03-20	\N	51	\N	2014-03-20                      	4	четверг         	f	20	79	1512	1450	1175
1541	2014-03-21	\N	51	\N	2014-03-21                      	5	пятница         	f	21	80	1513	1451	1176
1542	2014-03-22	\N	51	\N	2014-03-22                      	6	суббота         	t	22	81	1514	1452	1177
1544	2014-03-24	\N	51	\N	2014-03-24                      	1	понедельник     	f	24	83	1516	1454	1179
1545	2014-03-25	\N	51	\N	2014-03-25                      	2	вторник         	f	25	84	1517	1455	1180
1546	2014-03-26	\N	51	\N	2014-03-26                      	3	среда           	f	26	85	1518	1456	1181
1547	2014-03-27	\N	51	\N	2014-03-27                      	4	четверг         	f	27	86	1519	1457	1182
1548	2014-03-28	\N	51	\N	2014-03-28                      	5	пятница         	f	28	87	1520	1458	1183
1549	2014-03-29	\N	51	\N	2014-03-29                      	6	суббота         	t	29	88	1520	1459	1184
1551	2014-03-31	\N	51	\N	2014-03-31                      	1	понедельник     	f	31	90	1520	1461	1186
1552	2014-04-01	\N	52	\N	2014-04-01                      	2	вторник         	f	1	91	1521	1462	1187
1553	2014-04-02	\N	52	\N	2014-04-02                      	3	среда           	f	2	92	1522	1463	1188
1554	2014-04-03	\N	52	\N	2014-04-03                      	4	четверг         	f	3	93	1523	1464	1189
1555	2014-04-04	\N	52	\N	2014-04-04                      	5	пятница         	f	4	94	1524	1465	1190
1556	2014-04-05	\N	52	\N	2014-04-05                      	6	суббота         	t	5	95	1525	1466	1191
1558	2014-04-07	\N	52	\N	2014-04-07                      	1	понедельник     	f	7	97	1527	1468	1193
1559	2014-04-08	\N	52	\N	2014-04-08                      	2	вторник         	f	8	98	1528	1469	1194
1560	2014-04-09	\N	52	\N	2014-04-09                      	3	среда           	f	9	99	1529	1470	1195
1561	2014-04-10	\N	52	\N	2014-04-10                      	4	четверг         	f	10	100	1530	1471	1196
1562	2014-04-11	\N	52	\N	2014-04-11                      	5	пятница         	f	11	101	1531	1472	1197
1563	2014-04-12	\N	52	\N	2014-04-12                      	6	суббота         	t	12	102	1532	1473	1198
1565	2014-04-14	\N	52	\N	2014-04-14                      	1	понедельник     	f	14	104	1534	1475	1200
1566	2014-04-15	\N	52	\N	2014-04-15                      	2	вторник         	f	15	105	1535	1476	1201
1567	2014-04-16	\N	52	\N	2014-04-16                      	3	среда           	f	16	106	1536	1477	1202
1568	2014-04-17	\N	52	\N	2014-04-17                      	4	четверг         	f	17	107	1537	1478	1203
1569	2014-04-18	\N	52	\N	2014-04-18                      	5	пятница         	f	18	108	1538	1479	1204
1570	2014-04-19	\N	52	\N	2014-04-19                      	6	суббота         	t	19	109	1539	1480	1205
1572	2014-04-21	\N	52	\N	2014-04-21                      	1	понедельник     	f	21	111	1541	1482	1207
1573	2014-04-22	\N	52	\N	2014-04-22                      	2	вторник         	f	22	112	1542	1483	1208
1574	2014-04-23	\N	52	\N	2014-04-23                      	3	среда           	f	23	113	1543	1484	1209
1575	2014-04-24	\N	52	\N	2014-04-24                      	4	четверг         	f	24	114	1544	1485	1210
1576	2014-04-25	\N	52	\N	2014-04-25                      	5	пятница         	f	25	115	1545	1486	1211
1577	2014-04-26	\N	52	\N	2014-04-26                      	6	суббота         	t	26	116	1546	1487	1212
1579	2014-04-28	\N	52	\N	2014-04-28                      	1	понедельник     	f	28	118	1548	1489	1214
1580	2014-04-29	\N	52	\N	2014-04-29                      	2	вторник         	f	29	119	1549	1490	1215
1581	2014-04-30	\N	52	\N	2014-04-30                      	3	среда           	f	30	120	1550	1491	1216
1582	2014-05-01	\N	53	\N	2014-05-01                      	4	четверг         	f	1	121	1552	1493	1217
1583	2014-05-02	\N	53	\N	2014-05-02                      	5	пятница         	f	2	122	1553	1494	1218
1584	2014-05-03	\N	53	\N	2014-05-03                      	6	суббота         	t	3	123	1554	1495	1219
1586	2014-05-05	\N	53	\N	2014-05-05                      	1	понедельник     	f	5	125	1556	1497	1221
1587	2014-05-06	\N	53	\N	2014-05-06                      	2	вторник         	f	6	126	1557	1498	1222
1588	2014-05-07	\N	53	\N	2014-05-07                      	3	среда           	f	7	127	1558	1499	1223
1589	2014-05-08	\N	53	\N	2014-05-08                      	4	четверг         	f	8	128	1559	1500	1224
1590	2014-05-09	\N	53	\N	2014-05-09                      	5	пятница         	f	9	129	1560	1501	1225
1591	2014-05-10	\N	53	\N	2014-05-10                      	6	суббота         	t	10	130	1561	1502	1226
1593	2014-05-12	\N	53	\N	2014-05-12                      	1	понедельник     	f	12	132	1563	1504	1228
1594	2014-05-13	\N	53	\N	2014-05-13                      	2	вторник         	f	13	133	1564	1505	1229
1595	2014-05-14	\N	53	\N	2014-05-14                      	3	среда           	f	14	134	1565	1506	1230
1596	2014-05-15	\N	53	\N	2014-05-15                      	4	четверг         	f	15	135	1566	1507	1231
1597	2014-05-16	\N	53	\N	2014-05-16                      	5	пятница         	f	16	136	1567	1508	1232
1598	2014-05-17	\N	53	\N	2014-05-17                      	6	суббота         	t	17	137	1568	1509	1233
1600	2014-05-19	\N	53	\N	2014-05-19                      	1	понедельник     	f	19	139	1570	1511	1235
1601	2014-05-20	\N	53	\N	2014-05-20                      	2	вторник         	f	20	140	1571	1512	1236
1602	2014-05-21	\N	53	\N	2014-05-21                      	3	среда           	f	21	141	1572	1513	1237
1603	2014-05-22	\N	53	\N	2014-05-22                      	4	четверг         	f	22	142	1573	1514	1238
1604	2014-05-23	\N	53	\N	2014-05-23                      	5	пятница         	f	23	143	1574	1515	1239
1605	2014-05-24	\N	53	\N	2014-05-24                      	6	суббота         	t	24	144	1575	1516	1240
1607	2014-05-26	\N	53	\N	2014-05-26                      	1	понедельник     	f	26	146	1577	1518	1242
1608	2014-05-27	\N	53	\N	2014-05-27                      	2	вторник         	f	27	147	1578	1519	1243
1609	2014-05-28	\N	53	\N	2014-05-28                      	3	среда           	f	28	148	1579	1520	1244
1610	2014-05-29	\N	53	\N	2014-05-29                      	4	четверг         	f	29	149	1580	1520	1245
1611	2014-05-30	\N	53	\N	2014-05-30                      	5	пятница         	f	30	150	1581	1520	1246
1612	2014-05-31	\N	53	\N	2014-05-31                      	6	суббота         	t	31	151	1581	1520	1247
1614	2014-06-02	\N	54	\N	2014-06-02                      	1	понедельник     	f	2	153	1583	1522	1249
1615	2014-06-03	\N	54	\N	2014-06-03                      	2	вторник         	f	3	154	1584	1523	1250
1616	2014-06-04	\N	54	\N	2014-06-04                      	3	среда           	f	4	155	1585	1524	1251
1617	2014-06-05	\N	54	\N	2014-06-05                      	4	четверг         	f	5	156	1586	1525	1252
1618	2014-06-06	\N	54	\N	2014-06-06                      	5	пятница         	f	6	157	1587	1526	1253
1619	2014-06-07	\N	54	\N	2014-06-07                      	6	суббота         	t	7	158	1588	1527	1254
1621	2014-06-09	\N	54	\N	2014-06-09                      	1	понедельник     	f	9	160	1590	1529	1256
1622	2014-06-10	\N	54	\N	2014-06-10                      	2	вторник         	f	10	161	1591	1530	1257
1623	2014-06-11	\N	54	\N	2014-06-11                      	3	среда           	f	11	162	1592	1531	1258
1624	2014-06-12	\N	54	\N	2014-06-12                      	4	четверг         	f	12	163	1593	1532	1259
1625	2014-06-13	\N	54	\N	2014-06-13                      	5	пятница         	f	13	164	1594	1533	1260
1626	2014-06-14	\N	54	\N	2014-06-14                      	6	суббота         	t	14	165	1595	1534	1261
1628	2014-06-16	\N	54	\N	2014-06-16                      	1	понедельник     	f	16	167	1597	1536	1263
1629	2014-06-17	\N	54	\N	2014-06-17                      	2	вторник         	f	17	168	1598	1537	1264
1630	2014-06-18	\N	54	\N	2014-06-18                      	3	среда           	f	18	169	1599	1538	1265
1631	2014-06-19	\N	54	\N	2014-06-19                      	4	четверг         	f	19	170	1600	1539	1266
1632	2014-06-20	\N	54	\N	2014-06-20                      	5	пятница         	f	20	171	1601	1540	1267
1633	2014-06-21	\N	54	\N	2014-06-21                      	6	суббота         	t	21	172	1602	1541	1268
1635	2014-06-23	\N	54	\N	2014-06-23                      	1	понедельник     	f	23	174	1604	1543	1270
1636	2014-06-24	\N	54	\N	2014-06-24                      	2	вторник         	f	24	175	1605	1544	1271
1637	2014-06-25	\N	54	\N	2014-06-25                      	3	среда           	f	25	176	1606	1545	1272
1638	2014-06-26	\N	54	\N	2014-06-26                      	4	четверг         	f	26	177	1607	1546	1273
1639	2014-06-27	\N	54	\N	2014-06-27                      	5	пятница         	f	27	178	1608	1547	1274
1640	2014-06-28	\N	54	\N	2014-06-28                      	6	суббота         	t	28	179	1609	1548	1275
1642	2014-06-30	\N	54	\N	2014-06-30                      	1	понедельник     	f	30	181	1611	1550	1277
1643	2014-07-01	\N	55	\N	2014-07-01                      	2	вторник         	f	1	182	1613	1552	1278
1644	2014-07-02	\N	55	\N	2014-07-02                      	3	среда           	f	2	183	1614	1553	1279
1645	2014-07-03	\N	55	\N	2014-07-03                      	4	четверг         	f	3	184	1615	1554	1280
1646	2014-07-04	\N	55	\N	2014-07-04                      	5	пятница         	f	4	185	1616	1555	1281
1647	2014-07-05	\N	55	\N	2014-07-05                      	6	суббота         	t	5	186	1617	1556	1282
1649	2014-07-07	\N	55	\N	2014-07-07                      	1	понедельник     	f	7	188	1619	1558	1284
1650	2014-07-08	\N	55	\N	2014-07-08                      	2	вторник         	f	8	189	1620	1559	1285
1651	2014-07-09	\N	55	\N	2014-07-09                      	3	среда           	f	9	190	1621	1560	1286
1652	2014-07-10	\N	55	\N	2014-07-10                      	4	четверг         	f	10	191	1622	1561	1287
1653	2014-07-11	\N	55	\N	2014-07-11                      	5	пятница         	f	11	192	1623	1562	1288
1654	2014-07-12	\N	55	\N	2014-07-12                      	6	суббота         	t	12	193	1624	1563	1289
1656	2014-07-14	\N	55	\N	2014-07-14                      	1	понедельник     	f	14	195	1626	1565	1291
1657	2014-07-15	\N	55	\N	2014-07-15                      	2	вторник         	f	15	196	1627	1566	1292
1658	2014-07-16	\N	55	\N	2014-07-16                      	3	среда           	f	16	197	1628	1567	1293
1659	2014-07-17	\N	55	\N	2014-07-17                      	4	четверг         	f	17	198	1629	1568	1294
1660	2014-07-18	\N	55	\N	2014-07-18                      	5	пятница         	f	18	199	1630	1569	1295
1661	2014-07-19	\N	55	\N	2014-07-19                      	6	суббота         	t	19	200	1631	1570	1296
1663	2014-07-21	\N	55	\N	2014-07-21                      	1	понедельник     	f	21	202	1633	1572	1298
1664	2014-07-22	\N	55	\N	2014-07-22                      	2	вторник         	f	22	203	1634	1573	1299
1665	2014-07-23	\N	55	\N	2014-07-23                      	3	среда           	f	23	204	1635	1574	1300
1666	2014-07-24	\N	55	\N	2014-07-24                      	4	четверг         	f	24	205	1636	1575	1301
1667	2014-07-25	\N	55	\N	2014-07-25                      	5	пятница         	f	25	206	1637	1576	1302
1668	2014-07-26	\N	55	\N	2014-07-26                      	6	суббота         	t	26	207	1638	1577	1303
1670	2014-07-28	\N	55	\N	2014-07-28                      	1	понедельник     	f	28	209	1640	1579	1305
1671	2014-07-29	\N	55	\N	2014-07-29                      	2	вторник         	f	29	210	1641	1580	1306
1672	2014-07-30	\N	55	\N	2014-07-30                      	3	среда           	f	30	211	1642	1581	1307
1673	2014-07-31	\N	55	\N	2014-07-31                      	4	четверг         	f	31	212	1642	1581	1308
1674	2014-08-01	\N	56	\N	2014-08-01                      	5	пятница         	f	1	213	1643	1582	1309
1675	2014-08-02	\N	56	\N	2014-08-02                      	6	суббота         	t	2	214	1644	1583	1310
1677	2014-08-04	\N	56	\N	2014-08-04                      	1	понедельник     	f	4	216	1646	1585	1312
1678	2014-08-05	\N	56	\N	2014-08-05                      	2	вторник         	f	5	217	1647	1586	1313
1679	2014-08-06	\N	56	\N	2014-08-06                      	3	среда           	f	6	218	1648	1587	1314
1680	2014-08-07	\N	56	\N	2014-08-07                      	4	четверг         	f	7	219	1649	1588	1315
1681	2014-08-08	\N	56	\N	2014-08-08                      	5	пятница         	f	8	220	1650	1589	1316
1682	2014-08-09	\N	56	\N	2014-08-09                      	6	суббота         	t	9	221	1651	1590	1317
1684	2014-08-11	\N	56	\N	2014-08-11                      	1	понедельник     	f	11	223	1653	1592	1319
1685	2014-08-12	\N	56	\N	2014-08-12                      	2	вторник         	f	12	224	1654	1593	1320
1686	2014-08-13	\N	56	\N	2014-08-13                      	3	среда           	f	13	225	1655	1594	1321
1687	2014-08-14	\N	56	\N	2014-08-14                      	4	четверг         	f	14	226	1656	1595	1322
1688	2014-08-15	\N	56	\N	2014-08-15                      	5	пятница         	f	15	227	1657	1596	1323
1689	2014-08-16	\N	56	\N	2014-08-16                      	6	суббота         	t	16	228	1658	1597	1324
1691	2014-08-18	\N	56	\N	2014-08-18                      	1	понедельник     	f	18	230	1660	1599	1326
1692	2014-08-19	\N	56	\N	2014-08-19                      	2	вторник         	f	19	231	1661	1600	1327
1693	2014-08-20	\N	56	\N	2014-08-20                      	3	среда           	f	20	232	1662	1601	1328
1694	2014-08-21	\N	56	\N	2014-08-21                      	4	четверг         	f	21	233	1663	1602	1329
1695	2014-08-22	\N	56	\N	2014-08-22                      	5	пятница         	f	22	234	1664	1603	1330
1696	2014-08-23	\N	56	\N	2014-08-23                      	6	суббота         	t	23	235	1665	1604	1331
1698	2014-08-25	\N	56	\N	2014-08-25                      	1	понедельник     	f	25	237	1667	1606	1333
1699	2014-08-26	\N	56	\N	2014-08-26                      	2	вторник         	f	26	238	1668	1607	1334
1700	2014-08-27	\N	56	\N	2014-08-27                      	3	среда           	f	27	239	1669	1608	1335
1701	2014-08-28	\N	56	\N	2014-08-28                      	4	четверг         	f	28	240	1670	1609	1336
1702	2014-08-29	\N	56	\N	2014-08-29                      	5	пятница         	f	29	241	1671	1610	1337
1703	2014-08-30	\N	56	\N	2014-08-30                      	6	суббота         	t	30	242	1672	1611	1338
1705	2014-09-01	\N	57	\N	2014-09-01                      	1	понедельник     	f	1	244	1674	1613	1340
1706	2014-09-02	\N	57	\N	2014-09-02                      	2	вторник         	f	2	245	1675	1614	1341
1707	2014-09-03	\N	57	\N	2014-09-03                      	3	среда           	f	3	246	1676	1615	1342
1708	2014-09-04	\N	57	\N	2014-09-04                      	4	четверг         	f	4	247	1677	1616	1343
1709	2014-09-05	\N	57	\N	2014-09-05                      	5	пятница         	f	5	248	1678	1617	1344
1710	2014-09-06	\N	57	\N	2014-09-06                      	6	суббота         	t	6	249	1679	1618	1345
1712	2014-09-08	\N	57	\N	2014-09-08                      	1	понедельник     	f	8	251	1681	1620	1347
1713	2014-09-09	\N	57	\N	2014-09-09                      	2	вторник         	f	9	252	1682	1621	1348
1714	2014-09-10	\N	57	\N	2014-09-10                      	3	среда           	f	10	253	1683	1622	1349
1715	2014-09-11	\N	57	\N	2014-09-11                      	4	четверг         	f	11	254	1684	1623	1350
1716	2014-09-12	\N	57	\N	2014-09-12                      	5	пятница         	f	12	255	1685	1624	1351
1717	2014-09-13	\N	57	\N	2014-09-13                      	6	суббота         	t	13	256	1686	1625	1352
1719	2014-09-15	\N	57	\N	2014-09-15                      	1	понедельник     	f	15	258	1688	1627	1354
1720	2014-09-16	\N	57	\N	2014-09-16                      	2	вторник         	f	16	259	1689	1628	1355
1721	2014-09-17	\N	57	\N	2014-09-17                      	3	среда           	f	17	260	1690	1629	1356
1722	2014-09-18	\N	57	\N	2014-09-18                      	4	четверг         	f	18	261	1691	1630	1357
1723	2014-09-19	\N	57	\N	2014-09-19                      	5	пятница         	f	19	262	1692	1631	1358
1724	2014-09-20	\N	57	\N	2014-09-20                      	6	суббота         	t	20	263	1693	1632	1359
1726	2014-09-22	\N	57	\N	2014-09-22                      	1	понедельник     	f	22	265	1695	1634	1361
1727	2014-09-23	\N	57	\N	2014-09-23                      	2	вторник         	f	23	266	1696	1635	1362
1728	2014-09-24	\N	57	\N	2014-09-24                      	3	среда           	f	24	267	1697	1636	1363
1729	2014-09-25	\N	57	\N	2014-09-25                      	4	четверг         	f	25	268	1698	1637	1364
1730	2014-09-26	\N	57	\N	2014-09-26                      	5	пятница         	f	26	269	1699	1638	1365
1731	2014-09-27	\N	57	\N	2014-09-27                      	6	суббота         	t	27	270	1700	1639	1366
1733	2014-09-29	\N	57	\N	2014-09-29                      	1	понедельник     	f	29	272	1702	1641	1368
1734	2014-09-30	\N	57	\N	2014-09-30                      	2	вторник         	f	30	273	1703	1642	1369
1735	2014-10-01	\N	58	\N	2014-10-01                      	3	среда           	f	1	274	1705	1643	1370
1736	2014-10-02	\N	58	\N	2014-10-02                      	4	четверг         	f	2	275	1706	1644	1371
1737	2014-10-03	\N	58	\N	2014-10-03                      	5	пятница         	f	3	276	1707	1645	1372
1738	2014-10-04	\N	58	\N	2014-10-04                      	6	суббота         	t	4	277	1708	1646	1373
1740	2014-10-06	\N	58	\N	2014-10-06                      	1	понедельник     	f	6	279	1710	1648	1375
1741	2014-10-07	\N	58	\N	2014-10-07                      	2	вторник         	f	7	280	1711	1649	1376
1742	2014-10-08	\N	58	\N	2014-10-08                      	3	среда           	f	8	281	1712	1650	1377
1743	2014-10-09	\N	58	\N	2014-10-09                      	4	четверг         	f	9	282	1713	1651	1378
1744	2014-10-10	\N	58	\N	2014-10-10                      	5	пятница         	f	10	283	1714	1652	1379
1745	2014-10-11	\N	58	\N	2014-10-11                      	6	суббота         	t	11	284	1715	1653	1380
1747	2014-10-13	\N	58	\N	2014-10-13                      	1	понедельник     	f	13	286	1717	1655	1382
1748	2014-10-14	\N	58	\N	2014-10-14                      	2	вторник         	f	14	287	1718	1656	1383
1749	2014-10-15	\N	58	\N	2014-10-15                      	3	среда           	f	15	288	1719	1657	1384
1750	2014-10-16	\N	58	\N	2014-10-16                      	4	четверг         	f	16	289	1720	1658	1385
1751	2014-10-17	\N	58	\N	2014-10-17                      	5	пятница         	f	17	290	1721	1659	1386
1752	2014-10-18	\N	58	\N	2014-10-18                      	6	суббота         	t	18	291	1722	1660	1387
1754	2014-10-20	\N	58	\N	2014-10-20                      	1	понедельник     	f	20	293	1724	1662	1389
1755	2014-10-21	\N	58	\N	2014-10-21                      	2	вторник         	f	21	294	1725	1663	1390
1756	2014-10-22	\N	58	\N	2014-10-22                      	3	среда           	f	22	295	1726	1664	1391
1757	2014-10-23	\N	58	\N	2014-10-23                      	4	четверг         	f	23	296	1727	1665	1392
1758	2014-10-24	\N	58	\N	2014-10-24                      	5	пятница         	f	24	297	1728	1666	1393
1759	2014-10-25	\N	58	\N	2014-10-25                      	6	суббота         	t	25	298	1729	1667	1394
1761	2014-10-27	\N	58	\N	2014-10-27                      	1	понедельник     	f	27	300	1731	1669	1396
1762	2014-10-28	\N	58	\N	2014-10-28                      	2	вторник         	f	28	301	1732	1670	1397
1763	2014-10-29	\N	58	\N	2014-10-29                      	3	среда           	f	29	302	1733	1671	1398
1764	2014-10-30	\N	58	\N	2014-10-30                      	4	четверг         	f	30	303	1734	1672	1399
1765	2014-10-31	\N	58	\N	2014-10-31                      	5	пятница         	f	31	304	1734	1673	1400
1766	2014-11-01	\N	59	\N	2014-11-01                      	6	суббота         	t	1	305	1735	1674	1401
1768	2014-11-03	\N	59	\N	2014-11-03                      	1	понедельник     	f	3	307	1737	1676	1403
1769	2014-11-04	\N	59	\N	2014-11-04                      	2	вторник         	f	4	308	1738	1677	1404
1770	2014-11-05	\N	59	\N	2014-11-05                      	3	среда           	f	5	309	1739	1678	1405
1771	2014-11-06	\N	59	\N	2014-11-06                      	4	четверг         	f	6	310	1740	1679	1406
1772	2014-11-07	\N	59	\N	2014-11-07                      	5	пятница         	f	7	311	1741	1680	1407
1773	2014-11-08	\N	59	\N	2014-11-08                      	6	суббота         	t	8	312	1742	1681	1408
1775	2014-11-10	\N	59	\N	2014-11-10                      	1	понедельник     	f	10	314	1744	1683	1410
1776	2014-11-11	\N	59	\N	2014-11-11                      	2	вторник         	f	11	315	1745	1684	1411
1777	2014-11-12	\N	59	\N	2014-11-12                      	3	среда           	f	12	316	1746	1685	1412
1778	2014-11-13	\N	59	\N	2014-11-13                      	4	четверг         	f	13	317	1747	1686	1413
1779	2014-11-14	\N	59	\N	2014-11-14                      	5	пятница         	f	14	318	1748	1687	1414
1780	2014-11-15	\N	59	\N	2014-11-15                      	6	суббота         	t	15	319	1749	1688	1415
1782	2014-11-17	\N	59	\N	2014-11-17                      	1	понедельник     	f	17	321	1751	1690	1417
1783	2014-11-18	\N	59	\N	2014-11-18                      	2	вторник         	f	18	322	1752	1691	1418
1784	2014-11-19	\N	59	\N	2014-11-19                      	3	среда           	f	19	323	1753	1692	1419
1785	2014-11-20	\N	59	\N	2014-11-20                      	4	четверг         	f	20	324	1754	1693	1420
1786	2014-11-21	\N	59	\N	2014-11-21                      	5	пятница         	f	21	325	1755	1694	1421
1787	2014-11-22	\N	59	\N	2014-11-22                      	6	суббота         	t	22	326	1756	1695	1422
1789	2014-11-24	\N	59	\N	2014-11-24                      	1	понедельник     	f	24	328	1758	1697	1424
1790	2014-11-25	\N	59	\N	2014-11-25                      	2	вторник         	f	25	329	1759	1698	1425
1791	2014-11-26	\N	59	\N	2014-11-26                      	3	среда           	f	26	330	1760	1699	1426
1792	2014-11-27	\N	59	\N	2014-11-27                      	4	четверг         	f	27	331	1761	1700	1427
1793	2014-11-28	\N	59	\N	2014-11-28                      	5	пятница         	f	28	332	1762	1701	1428
1794	2014-11-29	\N	59	\N	2014-11-29                      	6	суббота         	t	29	333	1763	1702	1429
1798	2014-12-03	\N	60	\N	2014-12-03                      	3	среда           	f	3	337	1768	1707	1433
1797	2014-12-02	\N	60	\N	2014-12-02                      	2	вторник         	f	2	336	1767	1706	1432
1796	2014-12-01	\N	60	\N	2014-12-01                      	1	понедельник     	f	1	335	1766	1705	1431
1800	2014-12-05	\N	60	\N	2014-12-05                      	5	пятница         	f	5	339	1770	1709	1435
1810	2014-12-15	\N	60	\N	2014-12-15                      	1	понедельник     	f	15	349	1780	1719	1445
1812	2014-12-17	\N	60	\N	2014-12-17                      	3	среда           	f	17	351	1782	1721	1447
1817	2014-12-22	\N	60	\N	2014-12-22                      	1	понедельник     	f	22	356	1787	1726	1452
1818	2014-12-23	\N	60	\N	2014-12-23                      	2	вторник         	f	23	357	1788	1727	1453
1819	2014-12-24	\N	60	\N	2014-12-24                      	3	среда           	f	24	358	1789	1728	1454
1822	2014-12-27	\N	60	\N	2014-12-27                      	6	суббота         	t	27	361	1792	1731	1457
1824	2014-12-29	\N	60	\N	2014-12-29                      	1	понедельник     	f	29	363	1794	1733	1459
1825	2014-12-30	\N	60	\N	2014-12-30                      	2	вторник         	f	30	364	1795	1734	1460
1826	2014-12-31	\N	60	\N	2014-12-31                      	3	среда           	f	31	365	1795	1734	1461
1827	2015-01-01	\N	61	\N	2015-01-01                      	4	четверг         	f	1	1	1796	1735	1462
1828	2015-01-02	\N	61	\N	2015-01-02                      	5	пятница         	f	2	2	1797	1736	1463
1829	2015-01-03	\N	61	\N	2015-01-03                      	6	суббота         	t	3	3	1798	1737	1464
1831	2015-01-05	\N	61	\N	2015-01-05                      	1	понедельник     	f	5	5	1800	1739	1466
1832	2015-01-06	\N	61	\N	2015-01-06                      	2	вторник         	f	6	6	1801	1740	1467
1833	2015-01-07	\N	61	\N	2015-01-07                      	3	среда           	f	7	7	1802	1741	1468
1835	2015-01-09	\N	61	\N	2015-01-09                      	5	пятница         	f	9	9	1804	1743	1470
1836	2015-01-10	\N	61	\N	2015-01-10                      	6	суббота         	t	10	10	1805	1744	1471
1838	2015-01-12	\N	61	\N	2015-01-12                      	1	понедельник     	f	12	12	1807	1746	1473
1839	2015-01-13	\N	61	\N	2015-01-13                      	2	вторник         	f	13	13	1808	1747	1474
1840	2015-01-14	\N	61	\N	2015-01-14                      	3	среда           	f	14	14	1809	1748	1475
1841	2015-01-15	\N	61	\N	2015-01-15                      	4	четверг         	f	15	15	1810	1749	1476
1842	2015-01-16	\N	61	\N	2015-01-16                      	5	пятница         	f	16	16	1811	1750	1477
1843	2015-01-17	\N	61	\N	2015-01-17                      	6	суббота         	t	17	17	1812	1751	1478
1845	2015-01-19	\N	61	\N	2015-01-19                      	1	понедельник     	f	19	19	1814	1753	1480
1846	2015-01-20	\N	61	\N	2015-01-20                      	2	вторник         	f	20	20	1815	1754	1481
1847	2015-01-21	\N	61	\N	2015-01-21                      	3	среда           	f	21	21	1816	1755	1482
1848	2015-01-22	\N	61	\N	2015-01-22                      	4	четверг         	f	22	22	1817	1756	1483
1849	2015-01-23	\N	61	\N	2015-01-23                      	5	пятница         	f	23	23	1818	1757	1484
1850	2015-01-24	\N	61	\N	2015-01-24                      	6	суббота         	t	24	24	1819	1758	1485
1852	2015-01-26	\N	61	\N	2015-01-26                      	1	понедельник     	f	26	26	1821	1760	1487
1853	2015-01-27	\N	61	\N	2015-01-27                      	2	вторник         	f	27	27	1822	1761	1488
1854	2015-01-28	\N	61	\N	2015-01-28                      	3	среда           	f	28	28	1823	1762	1489
1855	2015-01-29	\N	61	\N	2015-01-29                      	4	четверг         	f	29	29	1824	1763	1490
1856	2015-01-30	\N	61	\N	2015-01-30                      	5	пятница         	f	30	30	1825	1764	1491
1857	2015-01-31	\N	61	\N	2015-01-31                      	6	суббота         	t	31	31	1826	1765	1492
1859	2015-02-02	\N	62	\N	2015-02-02                      	1	понедельник     	f	2	33	1828	1767	1494
1860	2015-02-03	\N	62	\N	2015-02-03                      	2	вторник         	f	3	34	1829	1768	1495
1861	2015-02-04	\N	62	\N	2015-02-04                      	3	среда           	f	4	35	1830	1769	1496
1862	2015-02-05	\N	62	\N	2015-02-05                      	4	четверг         	f	5	36	1831	1770	1497
1863	2015-02-06	\N	62	\N	2015-02-06                      	5	пятница         	f	6	37	1832	1771	1498
1864	2015-02-07	\N	62	\N	2015-02-07                      	6	суббота         	t	7	38	1833	1772	1499
1799	2014-12-04	\N	60	\N	2014-12-04                      	4	четверг         	f	4	338	1769	1708	1434
1821	2014-12-26	\N	60	\N	2014-12-26                      	5	пятница         	f	26	360	1791	1730	1456
1807	2014-12-12	\N	60	\N	2014-12-12                      	5	пятница         	f	12	346	1777	1716	1442
1805	2014-12-10	\N	60	\N	2014-12-10                      	3	среда           	f	10	344	1775	1714	1440
1815	2014-12-20	\N	60	\N	2014-12-20                      	6	суббота         	t	20	354	1785	1724	1450
1813	2014-12-18	\N	60	\N	2014-12-18                      	4	четверг         	f	18	352	1783	1722	1448
1834	2015-01-08	\N	61	\N	2015-01-08                      	4	четверг         	f	8	8	1803	1742	1469
1806	2014-12-11	\N	60	\N	2014-12-11                      	4	четверг         	f	11	345	1776	1715	1441
1820	2014-12-25	\N	60	\N	2014-12-25                      	4	четверг         	f	25	359	1790	1729	1455
1804	2014-12-09	\N	60	\N	2014-12-09                      	2	вторник         	f	9	343	1774	1713	1439
1803	2014-12-08	\N	60	\N	2014-12-08                      	1	понедельник     	f	8	342	1773	1712	1438
1801	2014-12-06	\N	60	\N	2014-12-06                      	6	суббота         	t	6	340	1771	1710	1436
1808	2014-12-13	\N	60	\N	2014-12-13                      	6	суббота         	f	13	347	1778	1717	1443
1811	2014-12-16	\N	60	\N	2014-12-16                      	2	вторник         	t	16	350	1781	1720	1446
1866	2015-02-09	\N	62	\N	2015-02-09                      	1	понедельник     	f	9	40	1835	1774	1501
1867	2015-02-10	\N	62	\N	2015-02-10                      	2	вторник         	f	10	41	1836	1775	1502
1868	2015-02-11	\N	62	\N	2015-02-11                      	3	среда           	f	11	42	1837	1776	1503
1869	2015-02-12	\N	62	\N	2015-02-12                      	4	четверг         	f	12	43	1838	1777	1504
1870	2015-02-13	\N	62	\N	2015-02-13                      	5	пятница         	f	13	44	1839	1778	1505
1871	2015-02-14	\N	62	\N	2015-02-14                      	6	суббота         	t	14	45	1840	1779	1506
1873	2015-02-16	\N	62	\N	2015-02-16                      	1	понедельник     	f	16	47	1842	1781	1508
1874	2015-02-17	\N	62	\N	2015-02-17                      	2	вторник         	f	17	48	1843	1782	1509
1875	2015-02-18	\N	62	\N	2015-02-18                      	3	среда           	f	18	49	1844	1783	1510
1876	2015-02-19	\N	62	\N	2015-02-19                      	4	четверг         	f	19	50	1845	1784	1511
1877	2015-02-20	\N	62	\N	2015-02-20                      	5	пятница         	f	20	51	1846	1785	1512
1878	2015-02-21	\N	62	\N	2015-02-21                      	6	суббота         	t	21	52	1847	1786	1513
1881	2015-02-24	\N	62	\N	2015-02-24                      	2	вторник         	f	24	55	1850	1789	1516
1882	2015-02-25	\N	62	\N	2015-02-25                      	3	среда           	f	25	56	1851	1790	1517
1883	2015-02-26	\N	62	\N	2015-02-26                      	4	четверг         	f	26	57	1852	1791	1518
1884	2015-02-27	\N	62	\N	2015-02-27                      	5	пятница         	f	27	58	1853	1792	1519
1885	2015-02-28	\N	62	\N	2015-02-28                      	6	суббота         	t	28	59	1854	1793	1520
1887	2015-03-02	\N	63	\N	2015-03-02                      	1	понедельник     	f	2	61	1859	1797	1522
1888	2015-03-03	\N	63	\N	2015-03-03                      	2	вторник         	f	3	62	1860	1798	1523
1889	2015-03-04	\N	63	\N	2015-03-04                      	3	среда           	f	4	63	1861	1799	1524
1890	2015-03-05	\N	63	\N	2015-03-05                      	4	четверг         	f	5	64	1862	1800	1525
1891	2015-03-06	\N	63	\N	2015-03-06                      	5	пятница         	f	6	65	1863	1801	1526
1892	2015-03-07	\N	63	\N	2015-03-07                      	6	суббота         	t	7	66	1864	1802	1527
1895	2015-03-10	\N	63	\N	2015-03-10                      	2	вторник         	f	10	69	1867	1805	1530
1896	2015-03-11	\N	63	\N	2015-03-11                      	3	среда           	f	11	70	1868	1806	1531
1897	2015-03-12	\N	63	\N	2015-03-12                      	4	четверг         	f	12	71	1869	1807	1532
1898	2015-03-13	\N	63	\N	2015-03-13                      	5	пятница         	f	13	72	1870	1808	1533
1899	2015-03-14	\N	63	\N	2015-03-14                      	6	суббота         	t	14	73	1871	1809	1534
1902	2015-03-17	\N	63	\N	2015-03-17                      	2	вторник         	f	17	76	1874	1812	1537
1903	2015-03-18	\N	63	\N	2015-03-18                      	3	среда           	f	18	77	1875	1813	1538
1904	2015-03-19	\N	63	\N	2015-03-19                      	4	четверг         	f	19	78	1876	1814	1539
1905	2015-03-20	\N	63	\N	2015-03-20                      	5	пятница         	f	20	79	1877	1815	1540
1906	2015-03-21	\N	63	\N	2015-03-21                      	6	суббота         	t	21	80	1878	1816	1541
1908	2015-03-23	\N	63	\N	2015-03-23                      	1	понедельник     	f	23	82	1880	1818	1543
1909	2015-03-24	\N	63	\N	2015-03-24                      	2	вторник         	f	24	83	1881	1819	1544
1910	2015-03-25	\N	63	\N	2015-03-25                      	3	среда           	f	25	84	1882	1820	1545
1911	2015-03-26	\N	63	\N	2015-03-26                      	4	четверг         	f	26	85	1883	1821	1546
1912	2015-03-27	\N	63	\N	2015-03-27                      	5	пятница         	f	27	86	1884	1822	1547
1913	2015-03-28	\N	63	\N	2015-03-28                      	6	суббота         	t	28	87	1885	1823	1548
1915	2015-03-30	\N	63	\N	2015-03-30                      	1	понедельник     	f	30	89	1885	1825	1550
1916	2015-03-31	\N	63	\N	2015-03-31                      	2	вторник         	f	31	90	1885	1826	1551
1917	2015-04-01	\N	64	\N	2015-04-01                      	3	среда           	f	1	91	1886	1827	1552
1918	2015-04-02	\N	64	\N	2015-04-02                      	4	четверг         	f	2	92	1887	1828	1553
1919	2015-04-03	\N	64	\N	2015-04-03                      	5	пятница         	f	3	93	1888	1829	1554
1920	2015-04-04	\N	64	\N	2015-04-04                      	6	суббота         	t	4	94	1889	1830	1555
1922	2015-04-06	\N	64	\N	2015-04-06                      	1	понедельник     	f	6	96	1891	1832	1557
1923	2015-04-07	\N	64	\N	2015-04-07                      	2	вторник         	f	7	97	1892	1833	1558
1924	2015-04-08	\N	64	\N	2015-04-08                      	3	среда           	f	8	98	1893	1834	1559
1925	2015-04-09	\N	64	\N	2015-04-09                      	4	четверг         	f	9	99	1894	1835	1560
1926	2015-04-10	\N	64	\N	2015-04-10                      	5	пятница         	f	10	100	1895	1836	1561
1927	2015-04-11	\N	64	\N	2015-04-11                      	6	суббота         	t	11	101	1896	1837	1562
1929	2015-04-13	\N	64	\N	2015-04-13                      	1	понедельник     	f	13	103	1898	1839	1564
1930	2015-04-14	\N	64	\N	2015-04-14                      	2	вторник         	f	14	104	1899	1840	1565
1931	2015-04-15	\N	64	\N	2015-04-15                      	3	среда           	f	15	105	1900	1841	1566
1932	2015-04-16	\N	64	\N	2015-04-16                      	4	четверг         	f	16	106	1901	1842	1567
1933	2015-04-17	\N	64	\N	2015-04-17                      	5	пятница         	f	17	107	1902	1843	1568
1934	2015-04-18	\N	64	\N	2015-04-18                      	6	суббота         	t	18	108	1903	1844	1569
1936	2015-04-20	\N	64	\N	2015-04-20                      	1	понедельник     	f	20	110	1905	1846	1571
1937	2015-04-21	\N	64	\N	2015-04-21                      	2	вторник         	f	21	111	1906	1847	1572
1938	2015-04-22	\N	64	\N	2015-04-22                      	3	среда           	f	22	112	1907	1848	1573
1939	2015-04-23	\N	64	\N	2015-04-23                      	4	четверг         	f	23	113	1908	1849	1574
1940	2015-04-24	\N	64	\N	2015-04-24                      	5	пятница         	f	24	114	1909	1850	1575
1941	2015-04-25	\N	64	\N	2015-04-25                      	6	суббота         	t	25	115	1910	1851	1576
1943	2015-04-27	\N	64	\N	2015-04-27                      	1	понедельник     	f	27	117	1912	1853	1578
1944	2015-04-28	\N	64	\N	2015-04-28                      	2	вторник         	f	28	118	1913	1854	1579
1945	2015-04-29	\N	64	\N	2015-04-29                      	3	среда           	f	29	119	1914	1855	1580
1946	2015-04-30	\N	64	\N	2015-04-30                      	4	четверг         	f	30	120	1915	1856	1581
1947	2015-05-01	\N	65	\N	2015-05-01                      	5	пятница         	f	1	121	1917	1858	1582
1948	2015-05-02	\N	65	\N	2015-05-02                      	6	суббота         	t	2	122	1918	1859	1583
1950	2015-05-04	\N	65	\N	2015-05-04                      	1	понедельник     	f	4	124	1920	1861	1585
1951	2015-05-05	\N	65	\N	2015-05-05                      	2	вторник         	f	5	125	1921	1862	1586
1952	2015-05-06	\N	65	\N	2015-05-06                      	3	среда           	f	6	126	1922	1863	1587
1953	2015-05-07	\N	65	\N	2015-05-07                      	4	четверг         	f	7	127	1923	1864	1588
1954	2015-05-08	\N	65	\N	2015-05-08                      	5	пятница         	f	8	128	1924	1865	1589
1955	2015-05-09	\N	65	\N	2015-05-09                      	6	суббота         	t	9	129	1925	1866	1590
1957	2015-05-11	\N	65	\N	2015-05-11                      	1	понедельник     	f	11	131	1927	1868	1592
1958	2015-05-12	\N	65	\N	2015-05-12                      	2	вторник         	f	12	132	1928	1869	1593
1959	2015-05-13	\N	65	\N	2015-05-13                      	3	среда           	f	13	133	1929	1870	1594
1960	2015-05-14	\N	65	\N	2015-05-14                      	4	четверг         	f	14	134	1930	1871	1595
1961	2015-05-15	\N	65	\N	2015-05-15                      	5	пятница         	f	15	135	1931	1872	1596
1962	2015-05-16	\N	65	\N	2015-05-16                      	6	суббота         	t	16	136	1932	1873	1597
1964	2015-05-18	\N	65	\N	2015-05-18                      	1	понедельник     	f	18	138	1934	1875	1599
1965	2015-05-19	\N	65	\N	2015-05-19                      	2	вторник         	f	19	139	1935	1876	1600
1966	2015-05-20	\N	65	\N	2015-05-20                      	3	среда           	f	20	140	1936	1877	1601
1967	2015-05-21	\N	65	\N	2015-05-21                      	4	четверг         	f	21	141	1937	1878	1602
1968	2015-05-22	\N	65	\N	2015-05-22                      	5	пятница         	f	22	142	1938	1879	1603
1969	2015-05-23	\N	65	\N	2015-05-23                      	6	суббота         	t	23	143	1939	1880	1604
1971	2015-05-25	\N	65	\N	2015-05-25                      	1	понедельник     	f	25	145	1941	1882	1606
1972	2015-05-26	\N	65	\N	2015-05-26                      	2	вторник         	f	26	146	1942	1883	1607
1973	2015-05-27	\N	65	\N	2015-05-27                      	3	среда           	f	27	147	1943	1884	1608
1901	2015-03-16	\N	63	\N	2015-03-16                      	1	понедельник     	f	16	75	1873	1811	1536
1974	2015-05-28	\N	65	\N	2015-05-28                      	4	четверг         	f	28	148	1944	1885	1609
1975	2015-05-29	\N	65	\N	2015-05-29                      	5	пятница         	f	29	149	1945	1885	1610
1976	2015-05-30	\N	65	\N	2015-05-30                      	6	суббота         	t	30	150	1946	1885	1611
1978	2015-06-01	\N	66	\N	2015-06-01                      	1	понедельник     	f	1	152	1947	1886	1613
1979	2015-06-02	\N	66	\N	2015-06-02                      	2	вторник         	f	2	153	1948	1887	1614
1980	2015-06-03	\N	66	\N	2015-06-03                      	3	среда           	f	3	154	1949	1888	1615
1981	2015-06-04	\N	66	\N	2015-06-04                      	4	четверг         	f	4	155	1950	1889	1616
1982	2015-06-05	\N	66	\N	2015-06-05                      	5	пятница         	f	5	156	1951	1890	1617
1983	2015-06-06	\N	66	\N	2015-06-06                      	6	суббота         	t	6	157	1952	1891	1618
1985	2015-06-08	\N	66	\N	2015-06-08                      	1	понедельник     	f	8	159	1954	1893	1620
1986	2015-06-09	\N	66	\N	2015-06-09                      	2	вторник         	f	9	160	1955	1894	1621
1987	2015-06-10	\N	66	\N	2015-06-10                      	3	среда           	f	10	161	1956	1895	1622
1988	2015-06-11	\N	66	\N	2015-06-11                      	4	четверг         	f	11	162	1957	1896	1623
1989	2015-06-12	\N	66	\N	2015-06-12                      	5	пятница         	f	12	163	1958	1897	1624
1990	2015-06-13	\N	66	\N	2015-06-13                      	6	суббота         	t	13	164	1959	1898	1625
1992	2015-06-15	\N	66	\N	2015-06-15                      	1	понедельник     	f	15	166	1961	1900	1627
1993	2015-06-16	\N	66	\N	2015-06-16                      	2	вторник         	f	16	167	1962	1901	1628
1994	2015-06-17	\N	66	\N	2015-06-17                      	3	среда           	f	17	168	1963	1902	1629
1995	2015-06-18	\N	66	\N	2015-06-18                      	4	четверг         	f	18	169	1964	1903	1630
1996	2015-06-19	\N	66	\N	2015-06-19                      	5	пятница         	f	19	170	1965	1904	1631
1997	2015-06-20	\N	66	\N	2015-06-20                      	6	суббота         	t	20	171	1966	1905	1632
1999	2015-06-22	\N	66	\N	2015-06-22                      	1	понедельник     	f	22	173	1968	1907	1634
2000	2015-06-23	\N	66	\N	2015-06-23                      	2	вторник         	f	23	174	1969	1908	1635
2001	2015-06-24	\N	66	\N	2015-06-24                      	3	среда           	f	24	175	1970	1909	1636
2002	2015-06-25	\N	66	\N	2015-06-25                      	4	четверг         	f	25	176	1971	1910	1637
2003	2015-06-26	\N	66	\N	2015-06-26                      	5	пятница         	f	26	177	1972	1911	1638
2004	2015-06-27	\N	66	\N	2015-06-27                      	6	суббота         	t	27	178	1973	1912	1639
2006	2015-06-29	\N	66	\N	2015-06-29                      	1	понедельник     	f	29	180	1975	1914	1641
2007	2015-06-30	\N	66	\N	2015-06-30                      	2	вторник         	f	30	181	1976	1915	1642
2008	2015-07-01	\N	67	\N	2015-07-01                      	3	среда           	f	1	182	1978	1917	1643
2009	2015-07-02	\N	67	\N	2015-07-02                      	4	четверг         	f	2	183	1979	1918	1644
2010	2015-07-03	\N	67	\N	2015-07-03                      	5	пятница         	f	3	184	1980	1919	1645
2011	2015-07-04	\N	67	\N	2015-07-04                      	6	суббота         	t	4	185	1981	1920	1646
2013	2015-07-06	\N	67	\N	2015-07-06                      	1	понедельник     	f	6	187	1983	1922	1648
2014	2015-07-07	\N	67	\N	2015-07-07                      	2	вторник         	f	7	188	1984	1923	1649
2015	2015-07-08	\N	67	\N	2015-07-08                      	3	среда           	f	8	189	1985	1924	1650
2016	2015-07-09	\N	67	\N	2015-07-09                      	4	четверг         	f	9	190	1986	1925	1651
2017	2015-07-10	\N	67	\N	2015-07-10                      	5	пятница         	f	10	191	1987	1926	1652
2018	2015-07-11	\N	67	\N	2015-07-11                      	6	суббота         	t	11	192	1988	1927	1653
2020	2015-07-13	\N	67	\N	2015-07-13                      	1	понедельник     	f	13	194	1990	1929	1655
2021	2015-07-14	\N	67	\N	2015-07-14                      	2	вторник         	f	14	195	1991	1930	1656
2022	2015-07-15	\N	67	\N	2015-07-15                      	3	среда           	f	15	196	1992	1931	1657
2023	2015-07-16	\N	67	\N	2015-07-16                      	4	четверг         	f	16	197	1993	1932	1658
2024	2015-07-17	\N	67	\N	2015-07-17                      	5	пятница         	f	17	198	1994	1933	1659
2025	2015-07-18	\N	67	\N	2015-07-18                      	6	суббота         	t	18	199	1995	1934	1660
2027	2015-07-20	\N	67	\N	2015-07-20                      	1	понедельник     	f	20	201	1997	1936	1662
2028	2015-07-21	\N	67	\N	2015-07-21                      	2	вторник         	f	21	202	1998	1937	1663
2029	2015-07-22	\N	67	\N	2015-07-22                      	3	среда           	f	22	203	1999	1938	1664
2030	2015-07-23	\N	67	\N	2015-07-23                      	4	четверг         	f	23	204	2000	1939	1665
2031	2015-07-24	\N	67	\N	2015-07-24                      	5	пятница         	f	24	205	2001	1940	1666
2032	2015-07-25	\N	67	\N	2015-07-25                      	6	суббота         	t	25	206	2002	1941	1667
2034	2015-07-27	\N	67	\N	2015-07-27                      	1	понедельник     	f	27	208	2004	1943	1669
2035	2015-07-28	\N	67	\N	2015-07-28                      	2	вторник         	f	28	209	2005	1944	1670
2036	2015-07-29	\N	67	\N	2015-07-29                      	3	среда           	f	29	210	2006	1945	1671
2037	2015-07-30	\N	67	\N	2015-07-30                      	4	четверг         	f	30	211	2007	1946	1672
2038	2015-07-31	\N	67	\N	2015-07-31                      	5	пятница         	f	31	212	2007	1946	1673
2039	2015-08-01	\N	68	\N	2015-08-01                      	6	суббота         	t	1	213	2008	1947	1674
2041	2015-08-03	\N	68	\N	2015-08-03                      	1	понедельник     	f	3	215	2010	1949	1676
2042	2015-08-04	\N	68	\N	2015-08-04                      	2	вторник         	f	4	216	2011	1950	1677
2043	2015-08-05	\N	68	\N	2015-08-05                      	3	среда           	f	5	217	2012	1951	1678
2044	2015-08-06	\N	68	\N	2015-08-06                      	4	четверг         	f	6	218	2013	1952	1679
2045	2015-08-07	\N	68	\N	2015-08-07                      	5	пятница         	f	7	219	2014	1953	1680
2046	2015-08-08	\N	68	\N	2015-08-08                      	6	суббота         	t	8	220	2015	1954	1681
2048	2015-08-10	\N	68	\N	2015-08-10                      	1	понедельник     	f	10	222	2017	1956	1683
2049	2015-08-11	\N	68	\N	2015-08-11                      	2	вторник         	f	11	223	2018	1957	1684
2050	2015-08-12	\N	68	\N	2015-08-12                      	3	среда           	f	12	224	2019	1958	1685
2051	2015-08-13	\N	68	\N	2015-08-13                      	4	четверг         	f	13	225	2020	1959	1686
2052	2015-08-14	\N	68	\N	2015-08-14                      	5	пятница         	f	14	226	2021	1960	1687
2053	2015-08-15	\N	68	\N	2015-08-15                      	6	суббота         	t	15	227	2022	1961	1688
2055	2015-08-17	\N	68	\N	2015-08-17                      	1	понедельник     	f	17	229	2024	1963	1690
2056	2015-08-18	\N	68	\N	2015-08-18                      	2	вторник         	f	18	230	2025	1964	1691
2057	2015-08-19	\N	68	\N	2015-08-19                      	3	среда           	f	19	231	2026	1965	1692
2058	2015-08-20	\N	68	\N	2015-08-20                      	4	четверг         	f	20	232	2027	1966	1693
2059	2015-08-21	\N	68	\N	2015-08-21                      	5	пятница         	f	21	233	2028	1967	1694
2060	2015-08-22	\N	68	\N	2015-08-22                      	6	суббота         	t	22	234	2029	1968	1695
2062	2015-08-24	\N	68	\N	2015-08-24                      	1	понедельник     	f	24	236	2031	1970	1697
2063	2015-08-25	\N	68	\N	2015-08-25                      	2	вторник         	f	25	237	2032	1971	1698
2064	2015-08-26	\N	68	\N	2015-08-26                      	3	среда           	f	26	238	2033	1972	1699
2065	2015-08-27	\N	68	\N	2015-08-27                      	4	четверг         	f	27	239	2034	1973	1700
2066	2015-08-28	\N	68	\N	2015-08-28                      	5	пятница         	f	28	240	2035	1974	1701
2067	2015-08-29	\N	68	\N	2015-08-29                      	6	суббота         	t	29	241	2036	1975	1702
2069	2015-08-31	\N	68	\N	2015-08-31                      	1	понедельник     	f	31	243	2038	1977	1704
2070	2015-09-01	\N	69	\N	2015-09-01                      	2	вторник         	f	1	244	2039	1978	1705
2071	2015-09-02	\N	69	\N	2015-09-02                      	3	среда           	f	2	245	2040	1979	1706
2072	2015-09-03	\N	69	\N	2015-09-03                      	4	четверг         	f	3	246	2041	1980	1707
2073	2015-09-04	\N	69	\N	2015-09-04                      	5	пятница         	f	4	247	2042	1981	1708
2074	2015-09-05	\N	69	\N	2015-09-05                      	6	суббота         	t	5	248	2043	1982	1709
2076	2015-09-07	\N	69	\N	2015-09-07                      	1	понедельник     	f	7	250	2045	1984	1711
2077	2015-09-08	\N	69	\N	2015-09-08                      	2	вторник         	f	8	251	2046	1985	1712
2078	2015-09-09	\N	69	\N	2015-09-09                      	3	среда           	f	9	252	2047	1986	1713
2079	2015-09-10	\N	69	\N	2015-09-10                      	4	четверг         	f	10	253	2048	1987	1714
2080	2015-09-11	\N	69	\N	2015-09-11                      	5	пятница         	f	11	254	2049	1988	1715
2081	2015-09-12	\N	69	\N	2015-09-12                      	6	суббота         	t	12	255	2050	1989	1716
2083	2015-09-14	\N	69	\N	2015-09-14                      	1	понедельник     	f	14	257	2052	1991	1718
2084	2015-09-15	\N	69	\N	2015-09-15                      	2	вторник         	f	15	258	2053	1992	1719
2085	2015-09-16	\N	69	\N	2015-09-16                      	3	среда           	f	16	259	2054	1993	1720
2086	2015-09-17	\N	69	\N	2015-09-17                      	4	четверг         	f	17	260	2055	1994	1721
2087	2015-09-18	\N	69	\N	2015-09-18                      	5	пятница         	f	18	261	2056	1995	1722
2088	2015-09-19	\N	69	\N	2015-09-19                      	6	суббота         	t	19	262	2057	1996	1723
2090	2015-09-21	\N	69	\N	2015-09-21                      	1	понедельник     	f	21	264	2059	1998	1725
2091	2015-09-22	\N	69	\N	2015-09-22                      	2	вторник         	f	22	265	2060	1999	1726
2092	2015-09-23	\N	69	\N	2015-09-23                      	3	среда           	f	23	266	2061	2000	1727
2093	2015-09-24	\N	69	\N	2015-09-24                      	4	четверг         	f	24	267	2062	2001	1728
2094	2015-09-25	\N	69	\N	2015-09-25                      	5	пятница         	f	25	268	2063	2002	1729
2095	2015-09-26	\N	69	\N	2015-09-26                      	6	суббота         	t	26	269	2064	2003	1730
2097	2015-09-28	\N	69	\N	2015-09-28                      	1	понедельник     	f	28	271	2066	2005	1732
2098	2015-09-29	\N	69	\N	2015-09-29                      	2	вторник         	f	29	272	2067	2006	1733
2099	2015-09-30	\N	69	\N	2015-09-30                      	3	среда           	f	30	273	2068	2007	1734
2100	2015-10-01	\N	70	\N	2015-10-01                      	4	четверг         	f	1	274	2070	2008	1735
2101	2015-10-02	\N	70	\N	2015-10-02                      	5	пятница         	f	2	275	2071	2009	1736
2102	2015-10-03	\N	70	\N	2015-10-03                      	6	суббота         	t	3	276	2072	2010	1737
2104	2015-10-05	\N	70	\N	2015-10-05                      	1	понедельник     	f	5	278	2074	2012	1739
2105	2015-10-06	\N	70	\N	2015-10-06                      	2	вторник         	f	6	279	2075	2013	1740
2106	2015-10-07	\N	70	\N	2015-10-07                      	3	среда           	f	7	280	2076	2014	1741
2107	2015-10-08	\N	70	\N	2015-10-08                      	4	четверг         	f	8	281	2077	2015	1742
2108	2015-10-09	\N	70	\N	2015-10-09                      	5	пятница         	f	9	282	2078	2016	1743
2109	2015-10-10	\N	70	\N	2015-10-10                      	6	суббота         	t	10	283	2079	2017	1744
2111	2015-10-12	\N	70	\N	2015-10-12                      	1	понедельник     	f	12	285	2081	2019	1746
2112	2015-10-13	\N	70	\N	2015-10-13                      	2	вторник         	f	13	286	2082	2020	1747
2113	2015-10-14	\N	70	\N	2015-10-14                      	3	среда           	f	14	287	2083	2021	1748
2114	2015-10-15	\N	70	\N	2015-10-15                      	4	четверг         	f	15	288	2084	2022	1749
2115	2015-10-16	\N	70	\N	2015-10-16                      	5	пятница         	f	16	289	2085	2023	1750
2116	2015-10-17	\N	70	\N	2015-10-17                      	6	суббота         	t	17	290	2086	2024	1751
2118	2015-10-19	\N	70	\N	2015-10-19                      	1	понедельник     	f	19	292	2088	2026	1753
2119	2015-10-20	\N	70	\N	2015-10-20                      	2	вторник         	f	20	293	2089	2027	1754
2120	2015-10-21	\N	70	\N	2015-10-21                      	3	среда           	f	21	294	2090	2028	1755
2121	2015-10-22	\N	70	\N	2015-10-22                      	4	четверг         	f	22	295	2091	2029	1756
2122	2015-10-23	\N	70	\N	2015-10-23                      	5	пятница         	f	23	296	2092	2030	1757
2123	2015-10-24	\N	70	\N	2015-10-24                      	6	суббота         	t	24	297	2093	2031	1758
2125	2015-10-26	\N	70	\N	2015-10-26                      	1	понедельник     	f	26	299	2095	2033	1760
2126	2015-10-27	\N	70	\N	2015-10-27                      	2	вторник         	f	27	300	2096	2034	1761
2127	2015-10-28	\N	70	\N	2015-10-28                      	3	среда           	f	28	301	2097	2035	1762
2128	2015-10-29	\N	70	\N	2015-10-29                      	4	четверг         	f	29	302	2098	2036	1763
2129	2015-10-30	\N	70	\N	2015-10-30                      	5	пятница         	f	30	303	2099	2037	1764
2130	2015-10-31	\N	70	\N	2015-10-31                      	6	суббота         	t	31	304	2099	2038	1765
2132	2015-11-02	\N	71	\N	2015-11-02                      	1	понедельник     	f	2	306	2101	2040	1767
2133	2015-11-03	\N	71	\N	2015-11-03                      	2	вторник         	f	3	307	2102	2041	1768
2134	2015-11-04	\N	71	\N	2015-11-04                      	3	среда           	f	4	308	2103	2042	1769
2135	2015-11-05	\N	71	\N	2015-11-05                      	4	четверг         	f	5	309	2104	2043	1770
2136	2015-11-06	\N	71	\N	2015-11-06                      	5	пятница         	f	6	310	2105	2044	1771
2137	2015-11-07	\N	71	\N	2015-11-07                      	6	суббота         	t	7	311	2106	2045	1772
2139	2015-11-09	\N	71	\N	2015-11-09                      	1	понедельник     	f	9	313	2108	2047	1774
2140	2015-11-10	\N	71	\N	2015-11-10                      	2	вторник         	f	10	314	2109	2048	1775
2141	2015-11-11	\N	71	\N	2015-11-11                      	3	среда           	f	11	315	2110	2049	1776
2142	2015-11-12	\N	71	\N	2015-11-12                      	4	четверг         	f	12	316	2111	2050	1777
2143	2015-11-13	\N	71	\N	2015-11-13                      	5	пятница         	f	13	317	2112	2051	1778
2144	2015-11-14	\N	71	\N	2015-11-14                      	6	суббота         	t	14	318	2113	2052	1779
2146	2015-11-16	\N	71	\N	2015-11-16                      	1	понедельник     	f	16	320	2115	2054	1781
2147	2015-11-17	\N	71	\N	2015-11-17                      	2	вторник         	f	17	321	2116	2055	1782
2148	2015-11-18	\N	71	\N	2015-11-18                      	3	среда           	f	18	322	2117	2056	1783
2149	2015-11-19	\N	71	\N	2015-11-19                      	4	четверг         	f	19	323	2118	2057	1784
2150	2015-11-20	\N	71	\N	2015-11-20                      	5	пятница         	f	20	324	2119	2058	1785
2151	2015-11-21	\N	71	\N	2015-11-21                      	6	суббота         	t	21	325	2120	2059	1786
2153	2015-11-23	\N	71	\N	2015-11-23                      	1	понедельник     	f	23	327	2122	2061	1788
2154	2015-11-24	\N	71	\N	2015-11-24                      	2	вторник         	f	24	328	2123	2062	1789
2155	2015-11-25	\N	71	\N	2015-11-25                      	3	среда           	f	25	329	2124	2063	1790
2156	2015-11-26	\N	71	\N	2015-11-26                      	4	четверг         	f	26	330	2125	2064	1791
2157	2015-11-27	\N	71	\N	2015-11-27                      	5	пятница         	f	27	331	2126	2065	1792
2158	2015-11-28	\N	71	\N	2015-11-28                      	6	суббота         	t	28	332	2127	2066	1793
2160	2015-11-30	\N	71	\N	2015-11-30                      	1	понедельник     	f	30	334	2129	2068	1795
2161	2015-12-01	\N	72	\N	2015-12-01                      	2	вторник         	f	1	335	2131	2070	1796
2162	2015-12-02	\N	72	\N	2015-12-02                      	3	среда           	f	2	336	2132	2071	1797
2163	2015-12-03	\N	72	\N	2015-12-03                      	4	четверг         	f	3	337	2133	2072	1798
2164	2015-12-04	\N	72	\N	2015-12-04                      	5	пятница         	f	4	338	2134	2073	1799
2165	2015-12-05	\N	72	\N	2015-12-05                      	6	суббота         	t	5	339	2135	2074	1800
2167	2015-12-07	\N	72	\N	2015-12-07                      	1	понедельник     	f	7	341	2137	2076	1802
2168	2015-12-08	\N	72	\N	2015-12-08                      	2	вторник         	f	8	342	2138	2077	1803
2169	2015-12-09	\N	72	\N	2015-12-09                      	3	среда           	f	9	343	2139	2078	1804
2170	2015-12-10	\N	72	\N	2015-12-10                      	4	четверг         	f	10	344	2140	2079	1805
2171	2015-12-11	\N	72	\N	2015-12-11                      	5	пятница         	f	11	345	2141	2080	1806
2172	2015-12-12	\N	72	\N	2015-12-12                      	6	суббота         	t	12	346	2142	2081	1807
2174	2015-12-14	\N	72	\N	2015-12-14                      	1	понедельник     	f	14	348	2144	2083	1809
2175	2015-12-15	\N	72	\N	2015-12-15                      	2	вторник         	f	15	349	2145	2084	1810
2176	2015-12-16	\N	72	\N	2015-12-16                      	3	среда           	f	16	350	2146	2085	1811
2177	2015-12-17	\N	72	\N	2015-12-17                      	4	четверг         	f	17	351	2147	2086	1812
2178	2015-12-18	\N	72	\N	2015-12-18                      	5	пятница         	f	18	352	2148	2087	1813
2179	2015-12-19	\N	72	\N	2015-12-19                      	6	суббота         	t	19	353	2149	2088	1814
2181	2015-12-21	\N	72	\N	2015-12-21                      	1	понедельник     	f	21	355	2151	2090	1816
2182	2015-12-22	\N	72	\N	2015-12-22                      	2	вторник         	f	22	356	2152	2091	1817
2183	2015-12-23	\N	72	\N	2015-12-23                      	3	среда           	f	23	357	2153	2092	1818
2184	2015-12-24	\N	72	\N	2015-12-24                      	4	четверг         	f	24	358	2154	2093	1819
2185	2015-12-25	\N	72	\N	2015-12-25                      	5	пятница         	f	25	359	2155	2094	1820
2186	2015-12-26	\N	72	\N	2015-12-26                      	6	суббота         	t	26	360	2156	2095	1821
2188	2015-12-28	\N	72	\N	2015-12-28                      	1	понедельник     	f	28	362	2158	2097	1823
2189	2015-12-29	\N	72	\N	2015-12-29                      	2	вторник         	f	29	363	2159	2098	1824
2190	2015-12-30	\N	72	\N	2015-12-30                      	3	среда           	f	30	364	2160	2099	1825
2191	2015-12-31	\N	72	\N	2015-12-31                      	4	четверг         	f	31	365	2160	2099	1826
2192	2016-01-01	\N	73	\N	2016-01-01                      	5	пятница         	f	1	1	2161	2100	1827
2193	2016-01-02	\N	73	\N	2016-01-02                      	6	суббота         	t	2	2	2162	2101	1828
2195	2016-01-04	\N	73	\N	2016-01-04                      	1	понедельник     	f	4	4	2164	2103	1830
2196	2016-01-05	\N	73	\N	2016-01-05                      	2	вторник         	f	5	5	2165	2104	1831
2197	2016-01-06	\N	73	\N	2016-01-06                      	3	среда           	f	6	6	2166	2105	1832
2198	2016-01-07	\N	73	\N	2016-01-07                      	4	четверг         	f	7	7	2167	2106	1833
2199	2016-01-08	\N	73	\N	2016-01-08                      	5	пятница         	f	8	8	2168	2107	1834
2200	2016-01-09	\N	73	\N	2016-01-09                      	6	суббота         	t	9	9	2169	2108	1835
2202	2016-01-11	\N	73	\N	2016-01-11                      	1	понедельник     	f	11	11	2171	2110	1837
2203	2016-01-12	\N	73	\N	2016-01-12                      	2	вторник         	f	12	12	2172	2111	1838
2204	2016-01-13	\N	73	\N	2016-01-13                      	3	среда           	f	13	13	2173	2112	1839
2205	2016-01-14	\N	73	\N	2016-01-14                      	4	четверг         	f	14	14	2174	2113	1840
2206	2016-01-15	\N	73	\N	2016-01-15                      	5	пятница         	f	15	15	2175	2114	1841
2207	2016-01-16	\N	73	\N	2016-01-16                      	6	суббота         	t	16	16	2176	2115	1842
2209	2016-01-18	\N	73	\N	2016-01-18                      	1	понедельник     	f	18	18	2178	2117	1844
2210	2016-01-19	\N	73	\N	2016-01-19                      	2	вторник         	f	19	19	2179	2118	1845
2211	2016-01-20	\N	73	\N	2016-01-20                      	3	среда           	f	20	20	2180	2119	1846
2212	2016-01-21	\N	73	\N	2016-01-21                      	4	четверг         	f	21	21	2181	2120	1847
2213	2016-01-22	\N	73	\N	2016-01-22                      	5	пятница         	f	22	22	2182	2121	1848
2214	2016-01-23	\N	73	\N	2016-01-23                      	6	суббота         	t	23	23	2183	2122	1849
2216	2016-01-25	\N	73	\N	2016-01-25                      	1	понедельник     	f	25	25	2185	2124	1851
2217	2016-01-26	\N	73	\N	2016-01-26                      	2	вторник         	f	26	26	2186	2125	1852
2218	2016-01-27	\N	73	\N	2016-01-27                      	3	среда           	f	27	27	2187	2126	1853
2219	2016-01-28	\N	73	\N	2016-01-28                      	4	четверг         	f	28	28	2188	2127	1854
2220	2016-01-29	\N	73	\N	2016-01-29                      	5	пятница         	f	29	29	2189	2128	1855
2221	2016-01-30	\N	73	\N	2016-01-30                      	6	суббота         	t	30	30	2190	2129	1856
2223	2016-02-01	\N	74	\N	2016-02-01                      	1	понедельник     	f	1	32	2192	2131	1858
2224	2016-02-02	\N	74	\N	2016-02-02                      	2	вторник         	f	2	33	2193	2132	1859
2225	2016-02-03	\N	74	\N	2016-02-03                      	3	среда           	f	3	34	2194	2133	1860
2226	2016-02-04	\N	74	\N	2016-02-04                      	4	четверг         	f	4	35	2195	2134	1861
2227	2016-02-05	\N	74	\N	2016-02-05                      	5	пятница         	f	5	36	2196	2135	1862
2228	2016-02-06	\N	74	\N	2016-02-06                      	6	суббота         	t	6	37	2197	2136	1863
2230	2016-02-08	\N	74	\N	2016-02-08                      	1	понедельник     	f	8	39	2199	2138	1865
2231	2016-02-09	\N	74	\N	2016-02-09                      	2	вторник         	f	9	40	2200	2139	1866
2232	2016-02-10	\N	74	\N	2016-02-10                      	3	среда           	f	10	41	2201	2140	1867
2233	2016-02-11	\N	74	\N	2016-02-11                      	4	четверг         	f	11	42	2202	2141	1868
2234	2016-02-12	\N	74	\N	2016-02-12                      	5	пятница         	f	12	43	2203	2142	1869
2235	2016-02-13	\N	74	\N	2016-02-13                      	6	суббота         	t	13	44	2204	2143	1870
2237	2016-02-15	\N	74	\N	2016-02-15                      	1	понедельник     	f	15	46	2206	2145	1872
2238	2016-02-16	\N	74	\N	2016-02-16                      	2	вторник         	f	16	47	2207	2146	1873
2239	2016-02-17	\N	74	\N	2016-02-17                      	3	среда           	f	17	48	2208	2147	1874
2240	2016-02-18	\N	74	\N	2016-02-18                      	4	четверг         	f	18	49	2209	2148	1875
2241	2016-02-19	\N	74	\N	2016-02-19                      	5	пятница         	f	19	50	2210	2149	1876
2242	2016-02-20	\N	74	\N	2016-02-20                      	6	суббота         	t	20	51	2211	2150	1877
2244	2016-02-22	\N	74	\N	2016-02-22                      	1	понедельник     	f	22	53	2213	2152	1879
2245	2016-02-23	\N	74	\N	2016-02-23                      	2	вторник         	f	23	54	2214	2153	1880
2246	2016-02-24	\N	74	\N	2016-02-24                      	3	среда           	f	24	55	2215	2154	1881
2247	2016-02-25	\N	74	\N	2016-02-25                      	4	четверг         	f	25	56	2216	2155	1882
2248	2016-02-26	\N	74	\N	2016-02-26                      	5	пятница         	f	26	57	2217	2156	1883
2249	2016-02-27	\N	74	\N	2016-02-27                      	6	суббота         	t	27	58	2218	2157	1884
2251	2016-02-29	\N	74	\N	2016-02-29                      	1	понедельник     	f	29	60	2220	2159	1885
2252	2016-03-01	\N	75	\N	2016-03-01                      	2	вторник         	f	1	61	2223	2161	1886
2253	2016-03-02	\N	75	\N	2016-03-02                      	3	среда           	f	2	62	2224	2162	1887
2254	2016-03-03	\N	75	\N	2016-03-03                      	4	четверг         	f	3	63	2225	2163	1888
2255	2016-03-04	\N	75	\N	2016-03-04                      	5	пятница         	f	4	64	2226	2164	1889
2256	2016-03-05	\N	75	\N	2016-03-05                      	6	суббота         	t	5	65	2227	2165	1890
2258	2016-03-07	\N	75	\N	2016-03-07                      	1	понедельник     	f	7	67	2229	2167	1892
2259	2016-03-08	\N	75	\N	2016-03-08                      	2	вторник         	f	8	68	2230	2168	1893
2260	2016-03-09	\N	75	\N	2016-03-09                      	3	среда           	f	9	69	2231	2169	1894
2261	2016-03-10	\N	75	\N	2016-03-10                      	4	четверг         	f	10	70	2232	2170	1895
2262	2016-03-11	\N	75	\N	2016-03-11                      	5	пятница         	f	11	71	2233	2171	1896
2263	2016-03-12	\N	75	\N	2016-03-12                      	6	суббота         	t	12	72	2234	2172	1897
2265	2016-03-14	\N	75	\N	2016-03-14                      	1	понедельник     	f	14	74	2236	2174	1899
2266	2016-03-15	\N	75	\N	2016-03-15                      	2	вторник         	f	15	75	2237	2175	1900
2267	2016-03-16	\N	75	\N	2016-03-16                      	3	среда           	f	16	76	2238	2176	1901
2268	2016-03-17	\N	75	\N	2016-03-17                      	4	четверг         	f	17	77	2239	2177	1902
2269	2016-03-18	\N	75	\N	2016-03-18                      	5	пятница         	f	18	78	2240	2178	1903
2270	2016-03-19	\N	75	\N	2016-03-19                      	6	суббота         	t	19	79	2241	2179	1904
2272	2016-03-21	\N	75	\N	2016-03-21                      	1	понедельник     	f	21	81	2243	2181	1906
2273	2016-03-22	\N	75	\N	2016-03-22                      	2	вторник         	f	22	82	2244	2182	1907
2274	2016-03-23	\N	75	\N	2016-03-23                      	3	среда           	f	23	83	2245	2183	1908
2275	2016-03-24	\N	75	\N	2016-03-24                      	4	четверг         	f	24	84	2246	2184	1909
2276	2016-03-25	\N	75	\N	2016-03-25                      	5	пятница         	f	25	85	2247	2185	1910
2277	2016-03-26	\N	75	\N	2016-03-26                      	6	суббота         	t	26	86	2248	2186	1911
2279	2016-03-28	\N	75	\N	2016-03-28                      	1	понедельник     	f	28	88	2250	2188	1913
2280	2016-03-29	\N	75	\N	2016-03-29                      	2	вторник         	f	29	89	2251	2189	1914
2281	2016-03-30	\N	75	\N	2016-03-30                      	3	среда           	f	30	90	2251	2190	1915
2282	2016-03-31	\N	75	\N	2016-03-31                      	4	четверг         	f	31	91	2251	2191	1916
2283	2016-04-01	\N	76	\N	2016-04-01                      	5	пятница         	f	1	92	2252	2192	1917
2284	2016-04-02	\N	76	\N	2016-04-02                      	6	суббота         	t	2	93	2253	2193	1918
2286	2016-04-04	\N	76	\N	2016-04-04                      	1	понедельник     	f	4	95	2255	2195	1920
2287	2016-04-05	\N	76	\N	2016-04-05                      	2	вторник         	f	5	96	2256	2196	1921
2288	2016-04-06	\N	76	\N	2016-04-06                      	3	среда           	f	6	97	2257	2197	1922
2289	2016-04-07	\N	76	\N	2016-04-07                      	4	четверг         	f	7	98	2258	2198	1923
2290	2016-04-08	\N	76	\N	2016-04-08                      	5	пятница         	f	8	99	2259	2199	1924
2291	2016-04-09	\N	76	\N	2016-04-09                      	6	суббота         	t	9	100	2260	2200	1925
2293	2016-04-11	\N	76	\N	2016-04-11                      	1	понедельник     	f	11	102	2262	2202	1927
2294	2016-04-12	\N	76	\N	2016-04-12                      	2	вторник         	f	12	103	2263	2203	1928
2295	2016-04-13	\N	76	\N	2016-04-13                      	3	среда           	f	13	104	2264	2204	1929
2296	2016-04-14	\N	76	\N	2016-04-14                      	4	четверг         	f	14	105	2265	2205	1930
2297	2016-04-15	\N	76	\N	2016-04-15                      	5	пятница         	f	15	106	2266	2206	1931
2298	2016-04-16	\N	76	\N	2016-04-16                      	6	суббота         	t	16	107	2267	2207	1932
2300	2016-04-18	\N	76	\N	2016-04-18                      	1	понедельник     	f	18	109	2269	2209	1934
2301	2016-04-19	\N	76	\N	2016-04-19                      	2	вторник         	f	19	110	2270	2210	1935
2302	2016-04-20	\N	76	\N	2016-04-20                      	3	среда           	f	20	111	2271	2211	1936
2303	2016-04-21	\N	76	\N	2016-04-21                      	4	четверг         	f	21	112	2272	2212	1937
2304	2016-04-22	\N	76	\N	2016-04-22                      	5	пятница         	f	22	113	2273	2213	1938
2305	2016-04-23	\N	76	\N	2016-04-23                      	6	суббота         	t	23	114	2274	2214	1939
2307	2016-04-25	\N	76	\N	2016-04-25                      	1	понедельник     	f	25	116	2276	2216	1941
2308	2016-04-26	\N	76	\N	2016-04-26                      	2	вторник         	f	26	117	2277	2217	1942
2309	2016-04-27	\N	76	\N	2016-04-27                      	3	среда           	f	27	118	2278	2218	1943
2310	2016-04-28	\N	76	\N	2016-04-28                      	4	четверг         	f	28	119	2279	2219	1944
2311	2016-04-29	\N	76	\N	2016-04-29                      	5	пятница         	f	29	120	2280	2220	1945
2312	2016-04-30	\N	76	\N	2016-04-30                      	6	суббота         	t	30	121	2281	2221	1946
2314	2016-05-02	\N	77	\N	2016-05-02                      	1	понедельник     	f	2	123	2284	2224	1948
2315	2016-05-03	\N	77	\N	2016-05-03                      	2	вторник         	f	3	124	2285	2225	1949
2316	2016-05-04	\N	77	\N	2016-05-04                      	3	среда           	f	4	125	2286	2226	1950
2317	2016-05-05	\N	77	\N	2016-05-05                      	4	четверг         	f	5	126	2287	2227	1951
2318	2016-05-06	\N	77	\N	2016-05-06                      	5	пятница         	f	6	127	2288	2228	1952
2319	2016-05-07	\N	77	\N	2016-05-07                      	6	суббота         	t	7	128	2289	2229	1953
2321	2016-05-09	\N	77	\N	2016-05-09                      	1	понедельник     	f	9	130	2291	2231	1955
2322	2016-05-10	\N	77	\N	2016-05-10                      	2	вторник         	f	10	131	2292	2232	1956
2323	2016-05-11	\N	77	\N	2016-05-11                      	3	среда           	f	11	132	2293	2233	1957
2324	2016-05-12	\N	77	\N	2016-05-12                      	4	четверг         	f	12	133	2294	2234	1958
2325	2016-05-13	\N	77	\N	2016-05-13                      	5	пятница         	f	13	134	2295	2235	1959
2326	2016-05-14	\N	77	\N	2016-05-14                      	6	суббота         	t	14	135	2296	2236	1960
2328	2016-05-16	\N	77	\N	2016-05-16                      	1	понедельник     	f	16	137	2298	2238	1962
2329	2016-05-17	\N	77	\N	2016-05-17                      	2	вторник         	f	17	138	2299	2239	1963
2330	2016-05-18	\N	77	\N	2016-05-18                      	3	среда           	f	18	139	2300	2240	1964
2331	2016-05-19	\N	77	\N	2016-05-19                      	4	четверг         	f	19	140	2301	2241	1965
2332	2016-05-20	\N	77	\N	2016-05-20                      	5	пятница         	f	20	141	2302	2242	1966
2333	2016-05-21	\N	77	\N	2016-05-21                      	6	суббота         	t	21	142	2303	2243	1967
2335	2016-05-23	\N	77	\N	2016-05-23                      	1	понедельник     	f	23	144	2305	2245	1969
2336	2016-05-24	\N	77	\N	2016-05-24                      	2	вторник         	f	24	145	2306	2246	1970
2337	2016-05-25	\N	77	\N	2016-05-25                      	3	среда           	f	25	146	2307	2247	1971
2338	2016-05-26	\N	77	\N	2016-05-26                      	4	четверг         	f	26	147	2308	2248	1972
2339	2016-05-27	\N	77	\N	2016-05-27                      	5	пятница         	f	27	148	2309	2249	1973
2340	2016-05-28	\N	77	\N	2016-05-28                      	6	суббота         	t	28	149	2310	2250	1974
2342	2016-05-30	\N	77	\N	2016-05-30                      	1	понедельник     	f	30	151	2312	2251	1976
2343	2016-05-31	\N	77	\N	2016-05-31                      	2	вторник         	f	31	152	2312	2251	1977
2344	2016-06-01	\N	78	\N	2016-06-01                      	3	среда           	f	1	153	2313	2252	1978
2345	2016-06-02	\N	78	\N	2016-06-02                      	4	четверг         	f	2	154	2314	2253	1979
2346	2016-06-03	\N	78	\N	2016-06-03                      	5	пятница         	f	3	155	2315	2254	1980
2347	2016-06-04	\N	78	\N	2016-06-04                      	6	суббота         	t	4	156	2316	2255	1981
2349	2016-06-06	\N	78	\N	2016-06-06                      	1	понедельник     	f	6	158	2318	2257	1983
2350	2016-06-07	\N	78	\N	2016-06-07                      	2	вторник         	f	7	159	2319	2258	1984
2351	2016-06-08	\N	78	\N	2016-06-08                      	3	среда           	f	8	160	2320	2259	1985
2352	2016-06-09	\N	78	\N	2016-06-09                      	4	четверг         	f	9	161	2321	2260	1986
2353	2016-06-10	\N	78	\N	2016-06-10                      	5	пятница         	f	10	162	2322	2261	1987
2354	2016-06-11	\N	78	\N	2016-06-11                      	6	суббота         	t	11	163	2323	2262	1988
2356	2016-06-13	\N	78	\N	2016-06-13                      	1	понедельник     	f	13	165	2325	2264	1990
2357	2016-06-14	\N	78	\N	2016-06-14                      	2	вторник         	f	14	166	2326	2265	1991
2358	2016-06-15	\N	78	\N	2016-06-15                      	3	среда           	f	15	167	2327	2266	1992
2359	2016-06-16	\N	78	\N	2016-06-16                      	4	четверг         	f	16	168	2328	2267	1993
2360	2016-06-17	\N	78	\N	2016-06-17                      	5	пятница         	f	17	169	2329	2268	1994
2361	2016-06-18	\N	78	\N	2016-06-18                      	6	суббота         	t	18	170	2330	2269	1995
2363	2016-06-20	\N	78	\N	2016-06-20                      	1	понедельник     	f	20	172	2332	2271	1997
2364	2016-06-21	\N	78	\N	2016-06-21                      	2	вторник         	f	21	173	2333	2272	1998
2365	2016-06-22	\N	78	\N	2016-06-22                      	3	среда           	f	22	174	2334	2273	1999
2366	2016-06-23	\N	78	\N	2016-06-23                      	4	четверг         	f	23	175	2335	2274	2000
2367	2016-06-24	\N	78	\N	2016-06-24                      	5	пятница         	f	24	176	2336	2275	2001
2368	2016-06-25	\N	78	\N	2016-06-25                      	6	суббота         	t	25	177	2337	2276	2002
2370	2016-06-27	\N	78	\N	2016-06-27                      	1	понедельник     	f	27	179	2339	2278	2004
2371	2016-06-28	\N	78	\N	2016-06-28                      	2	вторник         	f	28	180	2340	2279	2005
2372	2016-06-29	\N	78	\N	2016-06-29                      	3	среда           	f	29	181	2341	2280	2006
2373	2016-06-30	\N	78	\N	2016-06-30                      	4	четверг         	f	30	182	2342	2281	2007
2374	2016-07-01	\N	79	\N	2016-07-01                      	5	пятница         	f	1	183	2344	2283	2008
2375	2016-07-02	\N	79	\N	2016-07-02                      	6	суббота         	t	2	184	2345	2284	2009
2377	2016-07-04	\N	79	\N	2016-07-04                      	1	понедельник     	f	4	186	2347	2286	2011
2378	2016-07-05	\N	79	\N	2016-07-05                      	2	вторник         	f	5	187	2348	2287	2012
2379	2016-07-06	\N	79	\N	2016-07-06                      	3	среда           	f	6	188	2349	2288	2013
2380	2016-07-07	\N	79	\N	2016-07-07                      	4	четверг         	f	7	189	2350	2289	2014
2381	2016-07-08	\N	79	\N	2016-07-08                      	5	пятница         	f	8	190	2351	2290	2015
2382	2016-07-09	\N	79	\N	2016-07-09                      	6	суббота         	t	9	191	2352	2291	2016
2384	2016-07-11	\N	79	\N	2016-07-11                      	1	понедельник     	f	11	193	2354	2293	2018
2385	2016-07-12	\N	79	\N	2016-07-12                      	2	вторник         	f	12	194	2355	2294	2019
2386	2016-07-13	\N	79	\N	2016-07-13                      	3	среда           	f	13	195	2356	2295	2020
2387	2016-07-14	\N	79	\N	2016-07-14                      	4	четверг         	f	14	196	2357	2296	2021
2388	2016-07-15	\N	79	\N	2016-07-15                      	5	пятница         	f	15	197	2358	2297	2022
2389	2016-07-16	\N	79	\N	2016-07-16                      	6	суббота         	t	16	198	2359	2298	2023
2391	2016-07-18	\N	79	\N	2016-07-18                      	1	понедельник     	f	18	200	2361	2300	2025
2392	2016-07-19	\N	79	\N	2016-07-19                      	2	вторник         	f	19	201	2362	2301	2026
2393	2016-07-20	\N	79	\N	2016-07-20                      	3	среда           	f	20	202	2363	2302	2027
2394	2016-07-21	\N	79	\N	2016-07-21                      	4	четверг         	f	21	203	2364	2303	2028
2395	2016-07-22	\N	79	\N	2016-07-22                      	5	пятница         	f	22	204	2365	2304	2029
2396	2016-07-23	\N	79	\N	2016-07-23                      	6	суббота         	t	23	205	2366	2305	2030
2398	2016-07-25	\N	79	\N	2016-07-25                      	1	понедельник     	f	25	207	2368	2307	2032
2399	2016-07-26	\N	79	\N	2016-07-26                      	2	вторник         	f	26	208	2369	2308	2033
2400	2016-07-27	\N	79	\N	2016-07-27                      	3	среда           	f	27	209	2370	2309	2034
2401	2016-07-28	\N	79	\N	2016-07-28                      	4	четверг         	f	28	210	2371	2310	2035
2402	2016-07-29	\N	79	\N	2016-07-29                      	5	пятница         	f	29	211	2372	2311	2036
2403	2016-07-30	\N	79	\N	2016-07-30                      	6	суббота         	t	30	212	2373	2312	2037
2405	2016-08-01	\N	80	\N	2016-08-01                      	1	понедельник     	f	1	214	2374	2313	2039
2406	2016-08-02	\N	80	\N	2016-08-02                      	2	вторник         	f	2	215	2375	2314	2040
2407	2016-08-03	\N	80	\N	2016-08-03                      	3	среда           	f	3	216	2376	2315	2041
2408	2016-08-04	\N	80	\N	2016-08-04                      	4	четверг         	f	4	217	2377	2316	2042
2409	2016-08-05	\N	80	\N	2016-08-05                      	5	пятница         	f	5	218	2378	2317	2043
2410	2016-08-06	\N	80	\N	2016-08-06                      	6	суббота         	t	6	219	2379	2318	2044
2412	2016-08-08	\N	80	\N	2016-08-08                      	1	понедельник     	f	8	221	2381	2320	2046
2413	2016-08-09	\N	80	\N	2016-08-09                      	2	вторник         	f	9	222	2382	2321	2047
2414	2016-08-10	\N	80	\N	2016-08-10                      	3	среда           	f	10	223	2383	2322	2048
2415	2016-08-11	\N	80	\N	2016-08-11                      	4	четверг         	f	11	224	2384	2323	2049
2416	2016-08-12	\N	80	\N	2016-08-12                      	5	пятница         	f	12	225	2385	2324	2050
2417	2016-08-13	\N	80	\N	2016-08-13                      	6	суббота         	t	13	226	2386	2325	2051
2419	2016-08-15	\N	80	\N	2016-08-15                      	1	понедельник     	f	15	228	2388	2327	2053
2420	2016-08-16	\N	80	\N	2016-08-16                      	2	вторник         	f	16	229	2389	2328	2054
2421	2016-08-17	\N	80	\N	2016-08-17                      	3	среда           	f	17	230	2390	2329	2055
2422	2016-08-18	\N	80	\N	2016-08-18                      	4	четверг         	f	18	231	2391	2330	2056
2423	2016-08-19	\N	80	\N	2016-08-19                      	5	пятница         	f	19	232	2392	2331	2057
2424	2016-08-20	\N	80	\N	2016-08-20                      	6	суббота         	t	20	233	2393	2332	2058
2426	2016-08-22	\N	80	\N	2016-08-22                      	1	понедельник     	f	22	235	2395	2334	2060
2427	2016-08-23	\N	80	\N	2016-08-23                      	2	вторник         	f	23	236	2396	2335	2061
2428	2016-08-24	\N	80	\N	2016-08-24                      	3	среда           	f	24	237	2397	2336	2062
2429	2016-08-25	\N	80	\N	2016-08-25                      	4	четверг         	f	25	238	2398	2337	2063
2430	2016-08-26	\N	80	\N	2016-08-26                      	5	пятница         	f	26	239	2399	2338	2064
2431	2016-08-27	\N	80	\N	2016-08-27                      	6	суббота         	t	27	240	2400	2339	2065
2433	2016-08-29	\N	80	\N	2016-08-29                      	1	понедельник     	f	29	242	2402	2341	2067
2434	2016-08-30	\N	80	\N	2016-08-30                      	2	вторник         	f	30	243	2403	2342	2068
2435	2016-08-31	\N	80	\N	2016-08-31                      	3	среда           	f	31	244	2404	2343	2069
2436	2016-09-01	\N	81	\N	2016-09-01                      	4	четверг         	f	1	245	2405	2344	2070
2437	2016-09-02	\N	81	\N	2016-09-02                      	5	пятница         	f	2	246	2406	2345	2071
2438	2016-09-03	\N	81	\N	2016-09-03                      	6	суббота         	t	3	247	2407	2346	2072
2440	2016-09-05	\N	81	\N	2016-09-05                      	1	понедельник     	f	5	249	2409	2348	2074
2441	2016-09-06	\N	81	\N	2016-09-06                      	2	вторник         	f	6	250	2410	2349	2075
2442	2016-09-07	\N	81	\N	2016-09-07                      	3	среда           	f	7	251	2411	2350	2076
2443	2016-09-08	\N	81	\N	2016-09-08                      	4	четверг         	f	8	252	2412	2351	2077
2444	2016-09-09	\N	81	\N	2016-09-09                      	5	пятница         	f	9	253	2413	2352	2078
2445	2016-09-10	\N	81	\N	2016-09-10                      	6	суббота         	t	10	254	2414	2353	2079
2447	2016-09-12	\N	81	\N	2016-09-12                      	1	понедельник     	f	12	256	2416	2355	2081
2448	2016-09-13	\N	81	\N	2016-09-13                      	2	вторник         	f	13	257	2417	2356	2082
2449	2016-09-14	\N	81	\N	2016-09-14                      	3	среда           	f	14	258	2418	2357	2083
2450	2016-09-15	\N	81	\N	2016-09-15                      	4	четверг         	f	15	259	2419	2358	2084
2451	2016-09-16	\N	81	\N	2016-09-16                      	5	пятница         	f	16	260	2420	2359	2085
2452	2016-09-17	\N	81	\N	2016-09-17                      	6	суббота         	t	17	261	2421	2360	2086
2454	2016-09-19	\N	81	\N	2016-09-19                      	1	понедельник     	f	19	263	2423	2362	2088
2455	2016-09-20	\N	81	\N	2016-09-20                      	2	вторник         	f	20	264	2424	2363	2089
2456	2016-09-21	\N	81	\N	2016-09-21                      	3	среда           	f	21	265	2425	2364	2090
2457	2016-09-22	\N	81	\N	2016-09-22                      	4	четверг         	f	22	266	2426	2365	2091
2458	2016-09-23	\N	81	\N	2016-09-23                      	5	пятница         	f	23	267	2427	2366	2092
2459	2016-09-24	\N	81	\N	2016-09-24                      	6	суббота         	t	24	268	2428	2367	2093
2461	2016-09-26	\N	81	\N	2016-09-26                      	1	понедельник     	f	26	270	2430	2369	2095
2462	2016-09-27	\N	81	\N	2016-09-27                      	2	вторник         	f	27	271	2431	2370	2096
2463	2016-09-28	\N	81	\N	2016-09-28                      	3	среда           	f	28	272	2432	2371	2097
2464	2016-09-29	\N	81	\N	2016-09-29                      	4	четверг         	f	29	273	2433	2372	2098
2465	2016-09-30	\N	81	\N	2016-09-30                      	5	пятница         	f	30	274	2434	2373	2099
2466	2016-10-01	\N	82	\N	2016-10-01                      	6	суббота         	t	1	275	2436	2374	2100
2468	2016-10-03	\N	82	\N	2016-10-03                      	1	понедельник     	f	3	277	2438	2376	2102
2469	2016-10-04	\N	82	\N	2016-10-04                      	2	вторник         	f	4	278	2439	2377	2103
2470	2016-10-05	\N	82	\N	2016-10-05                      	3	среда           	f	5	279	2440	2378	2104
2471	2016-10-06	\N	82	\N	2016-10-06                      	4	четверг         	f	6	280	2441	2379	2105
2472	2016-10-07	\N	82	\N	2016-10-07                      	5	пятница         	f	7	281	2442	2380	2106
2473	2016-10-08	\N	82	\N	2016-10-08                      	6	суббота         	t	8	282	2443	2381	2107
2475	2016-10-10	\N	82	\N	2016-10-10                      	1	понедельник     	f	10	284	2445	2383	2109
2476	2016-10-11	\N	82	\N	2016-10-11                      	2	вторник         	f	11	285	2446	2384	2110
2477	2016-10-12	\N	82	\N	2016-10-12                      	3	среда           	f	12	286	2447	2385	2111
2478	2016-10-13	\N	82	\N	2016-10-13                      	4	четверг         	f	13	287	2448	2386	2112
2479	2016-10-14	\N	82	\N	2016-10-14                      	5	пятница         	f	14	288	2449	2387	2113
2480	2016-10-15	\N	82	\N	2016-10-15                      	6	суббота         	t	15	289	2450	2388	2114
2482	2016-10-17	\N	82	\N	2016-10-17                      	1	понедельник     	f	17	291	2452	2390	2116
2483	2016-10-18	\N	82	\N	2016-10-18                      	2	вторник         	f	18	292	2453	2391	2117
2484	2016-10-19	\N	82	\N	2016-10-19                      	3	среда           	f	19	293	2454	2392	2118
2485	2016-10-20	\N	82	\N	2016-10-20                      	4	четверг         	f	20	294	2455	2393	2119
2486	2016-10-21	\N	82	\N	2016-10-21                      	5	пятница         	f	21	295	2456	2394	2120
2487	2016-10-22	\N	82	\N	2016-10-22                      	6	суббота         	t	22	296	2457	2395	2121
2489	2016-10-24	\N	82	\N	2016-10-24                      	1	понедельник     	f	24	298	2459	2397	2123
2490	2016-10-25	\N	82	\N	2016-10-25                      	2	вторник         	f	25	299	2460	2398	2124
2491	2016-10-26	\N	82	\N	2016-10-26                      	3	среда           	f	26	300	2461	2399	2125
2492	2016-10-27	\N	82	\N	2016-10-27                      	4	четверг         	f	27	301	2462	2400	2126
2493	2016-10-28	\N	82	\N	2016-10-28                      	5	пятница         	f	28	302	2463	2401	2127
2494	2016-10-29	\N	82	\N	2016-10-29                      	6	суббота         	t	29	303	2464	2402	2128
2496	2016-10-31	\N	82	\N	2016-10-31                      	1	понедельник     	f	31	305	2465	2404	2130
2497	2016-11-01	\N	83	\N	2016-11-01                      	2	вторник         	f	1	306	2466	2405	2131
2498	2016-11-02	\N	83	\N	2016-11-02                      	3	среда           	f	2	307	2467	2406	2132
2499	2016-11-03	\N	83	\N	2016-11-03                      	4	четверг         	f	3	308	2468	2407	2133
2500	2016-11-04	\N	83	\N	2016-11-04                      	5	пятница         	f	4	309	2469	2408	2134
2501	2016-11-05	\N	83	\N	2016-11-05                      	6	суббота         	t	5	310	2470	2409	2135
2503	2016-11-07	\N	83	\N	2016-11-07                      	1	понедельник     	f	7	312	2472	2411	2137
2504	2016-11-08	\N	83	\N	2016-11-08                      	2	вторник         	f	8	313	2473	2412	2138
2505	2016-11-09	\N	83	\N	2016-11-09                      	3	среда           	f	9	314	2474	2413	2139
2506	2016-11-10	\N	83	\N	2016-11-10                      	4	четверг         	f	10	315	2475	2414	2140
2507	2016-11-11	\N	83	\N	2016-11-11                      	5	пятница         	f	11	316	2476	2415	2141
2508	2016-11-12	\N	83	\N	2016-11-12                      	6	суббота         	t	12	317	2477	2416	2142
2510	2016-11-14	\N	83	\N	2016-11-14                      	1	понедельник     	f	14	319	2479	2418	2144
2511	2016-11-15	\N	83	\N	2016-11-15                      	2	вторник         	f	15	320	2480	2419	2145
2512	2016-11-16	\N	83	\N	2016-11-16                      	3	среда           	f	16	321	2481	2420	2146
2513	2016-11-17	\N	83	\N	2016-11-17                      	4	четверг         	f	17	322	2482	2421	2147
2514	2016-11-18	\N	83	\N	2016-11-18                      	5	пятница         	f	18	323	2483	2422	2148
2515	2016-11-19	\N	83	\N	2016-11-19                      	6	суббота         	t	19	324	2484	2423	2149
2517	2016-11-21	\N	83	\N	2016-11-21                      	1	понедельник     	f	21	326	2486	2425	2151
2518	2016-11-22	\N	83	\N	2016-11-22                      	2	вторник         	f	22	327	2487	2426	2152
2519	2016-11-23	\N	83	\N	2016-11-23                      	3	среда           	f	23	328	2488	2427	2153
2520	2016-11-24	\N	83	\N	2016-11-24                      	4	четверг         	f	24	329	2489	2428	2154
2521	2016-11-25	\N	83	\N	2016-11-25                      	5	пятница         	f	25	330	2490	2429	2155
2522	2016-11-26	\N	83	\N	2016-11-26                      	6	суббота         	t	26	331	2491	2430	2156
2524	2016-11-28	\N	83	\N	2016-11-28                      	1	понедельник     	f	28	333	2493	2432	2158
2525	2016-11-29	\N	83	\N	2016-11-29                      	2	вторник         	f	29	334	2494	2433	2159
2526	2016-11-30	\N	83	\N	2016-11-30                      	3	среда           	f	30	335	2495	2434	2160
2527	2016-12-01	\N	84	\N	2016-12-01                      	4	четверг         	f	1	336	2497	2436	2161
2528	2016-12-02	\N	84	\N	2016-12-02                      	5	пятница         	f	2	337	2498	2437	2162
2529	2016-12-03	\N	84	\N	2016-12-03                      	6	суббота         	t	3	338	2499	2438	2163
2531	2016-12-05	\N	84	\N	2016-12-05                      	1	понедельник     	f	5	340	2501	2440	2165
2532	2016-12-06	\N	84	\N	2016-12-06                      	2	вторник         	f	6	341	2502	2441	2166
2533	2016-12-07	\N	84	\N	2016-12-07                      	3	среда           	f	7	342	2503	2442	2167
2534	2016-12-08	\N	84	\N	2016-12-08                      	4	четверг         	f	8	343	2504	2443	2168
2535	2016-12-09	\N	84	\N	2016-12-09                      	5	пятница         	f	9	344	2505	2444	2169
2536	2016-12-10	\N	84	\N	2016-12-10                      	6	суббота         	t	10	345	2506	2445	2170
2538	2016-12-12	\N	84	\N	2016-12-12                      	1	понедельник     	f	12	347	2508	2447	2172
2539	2016-12-13	\N	84	\N	2016-12-13                      	2	вторник         	f	13	348	2509	2448	2173
2540	2016-12-14	\N	84	\N	2016-12-14                      	3	среда           	f	14	349	2510	2449	2174
2541	2016-12-15	\N	84	\N	2016-12-15                      	4	четверг         	f	15	350	2511	2450	2175
2542	2016-12-16	\N	84	\N	2016-12-16                      	5	пятница         	f	16	351	2512	2451	2176
2543	2016-12-17	\N	84	\N	2016-12-17                      	6	суббота         	t	17	352	2513	2452	2177
2545	2016-12-19	\N	84	\N	2016-12-19                      	1	понедельник     	f	19	354	2515	2454	2179
2546	2016-12-20	\N	84	\N	2016-12-20                      	2	вторник         	f	20	355	2516	2455	2180
2547	2016-12-21	\N	84	\N	2016-12-21                      	3	среда           	f	21	356	2517	2456	2181
2548	2016-12-22	\N	84	\N	2016-12-22                      	4	четверг         	f	22	357	2518	2457	2182
2549	2016-12-23	\N	84	\N	2016-12-23                      	5	пятница         	f	23	358	2519	2458	2183
2550	2016-12-24	\N	84	\N	2016-12-24                      	6	суббота         	t	24	359	2520	2459	2184
2552	2016-12-26	\N	84	\N	2016-12-26                      	1	понедельник     	f	26	361	2522	2461	2186
2553	2016-12-27	\N	84	\N	2016-12-27                      	2	вторник         	f	27	362	2523	2462	2187
2554	2016-12-28	\N	84	\N	2016-12-28                      	3	среда           	f	28	363	2524	2463	2188
2555	2016-12-29	\N	84	\N	2016-12-29                      	4	четверг         	f	29	364	2525	2464	2189
2556	2016-12-30	\N	84	\N	2016-12-30                      	5	пятница         	f	30	365	2526	2465	2190
2557	2016-12-31	\N	84	\N	2016-12-31                      	6	суббота         	t	31	366	2526	2465	2191
2559	2017-01-02	\N	85	\N	2017-01-02                      	1	понедельник     	f	2	2	2528	2467	2193
2560	2017-01-03	\N	85	\N	2017-01-03                      	2	вторник         	f	3	3	2529	2468	2194
2561	2017-01-04	\N	85	\N	2017-01-04                      	3	среда           	f	4	4	2530	2469	2195
2562	2017-01-05	\N	85	\N	2017-01-05                      	4	четверг         	f	5	5	2531	2470	2196
2563	2017-01-06	\N	85	\N	2017-01-06                      	5	пятница         	f	6	6	2532	2471	2197
2564	2017-01-07	\N	85	\N	2017-01-07                      	6	суббота         	t	7	7	2533	2472	2198
2566	2017-01-09	\N	85	\N	2017-01-09                      	1	понедельник     	f	9	9	2535	2474	2200
2567	2017-01-10	\N	85	\N	2017-01-10                      	2	вторник         	f	10	10	2536	2475	2201
2568	2017-01-11	\N	85	\N	2017-01-11                      	3	среда           	f	11	11	2537	2476	2202
2569	2017-01-12	\N	85	\N	2017-01-12                      	4	четверг         	f	12	12	2538	2477	2203
2570	2017-01-13	\N	85	\N	2017-01-13                      	5	пятница         	f	13	13	2539	2478	2204
2571	2017-01-14	\N	85	\N	2017-01-14                      	6	суббота         	t	14	14	2540	2479	2205
2573	2017-01-16	\N	85	\N	2017-01-16                      	1	понедельник     	f	16	16	2542	2481	2207
2574	2017-01-17	\N	85	\N	2017-01-17                      	2	вторник         	f	17	17	2543	2482	2208
2575	2017-01-18	\N	85	\N	2017-01-18                      	3	среда           	f	18	18	2544	2483	2209
2576	2017-01-19	\N	85	\N	2017-01-19                      	4	четверг         	f	19	19	2545	2484	2210
2577	2017-01-20	\N	85	\N	2017-01-20                      	5	пятница         	f	20	20	2546	2485	2211
2578	2017-01-21	\N	85	\N	2017-01-21                      	6	суббота         	t	21	21	2547	2486	2212
2580	2017-01-23	\N	85	\N	2017-01-23                      	1	понедельник     	f	23	23	2549	2488	2214
2581	2017-01-24	\N	85	\N	2017-01-24                      	2	вторник         	f	24	24	2550	2489	2215
2582	2017-01-25	\N	85	\N	2017-01-25                      	3	среда           	f	25	25	2551	2490	2216
2583	2017-01-26	\N	85	\N	2017-01-26                      	4	четверг         	f	26	26	2552	2491	2217
2584	2017-01-27	\N	85	\N	2017-01-27                      	5	пятница         	f	27	27	2553	2492	2218
2585	2017-01-28	\N	85	\N	2017-01-28                      	6	суббота         	t	28	28	2554	2493	2219
2587	2017-01-30	\N	85	\N	2017-01-30                      	1	понедельник     	f	30	30	2556	2495	2221
2588	2017-01-31	\N	85	\N	2017-01-31                      	2	вторник         	f	31	31	2557	2496	2222
2589	2017-02-01	\N	86	\N	2017-02-01                      	3	среда           	f	1	32	2558	2497	2223
2590	2017-02-02	\N	86	\N	2017-02-02                      	4	четверг         	f	2	33	2559	2498	2224
2591	2017-02-03	\N	86	\N	2017-02-03                      	5	пятница         	f	3	34	2560	2499	2225
2592	2017-02-04	\N	86	\N	2017-02-04                      	6	суббота         	t	4	35	2561	2500	2226
2594	2017-02-06	\N	86	\N	2017-02-06                      	1	понедельник     	f	6	37	2563	2502	2228
2595	2017-02-07	\N	86	\N	2017-02-07                      	2	вторник         	f	7	38	2564	2503	2229
2596	2017-02-08	\N	86	\N	2017-02-08                      	3	среда           	f	8	39	2565	2504	2230
2597	2017-02-09	\N	86	\N	2017-02-09                      	4	четверг         	f	9	40	2566	2505	2231
2598	2017-02-10	\N	86	\N	2017-02-10                      	5	пятница         	f	10	41	2567	2506	2232
2599	2017-02-11	\N	86	\N	2017-02-11                      	6	суббота         	t	11	42	2568	2507	2233
2601	2017-02-13	\N	86	\N	2017-02-13                      	1	понедельник     	f	13	44	2570	2509	2235
2602	2017-02-14	\N	86	\N	2017-02-14                      	2	вторник         	f	14	45	2571	2510	2236
2603	2017-02-15	\N	86	\N	2017-02-15                      	3	среда           	f	15	46	2572	2511	2237
2604	2017-02-16	\N	86	\N	2017-02-16                      	4	четверг         	f	16	47	2573	2512	2238
2605	2017-02-17	\N	86	\N	2017-02-17                      	5	пятница         	f	17	48	2574	2513	2239
2606	2017-02-18	\N	86	\N	2017-02-18                      	6	суббота         	t	18	49	2575	2514	2240
2608	2017-02-20	\N	86	\N	2017-02-20                      	1	понедельник     	f	20	51	2577	2516	2242
2609	2017-02-21	\N	86	\N	2017-02-21                      	2	вторник         	f	21	52	2578	2517	2243
2610	2017-02-22	\N	86	\N	2017-02-22                      	3	среда           	f	22	53	2579	2518	2244
2611	2017-02-23	\N	86	\N	2017-02-23                      	4	четверг         	f	23	54	2580	2519	2245
2612	2017-02-24	\N	86	\N	2017-02-24                      	5	пятница         	f	24	55	2581	2520	2246
2613	2017-02-25	\N	86	\N	2017-02-25                      	6	суббота         	t	25	56	2582	2521	2247
2615	2017-02-27	\N	86	\N	2017-02-27                      	1	понедельник     	f	27	58	2584	2523	2249
2616	2017-02-28	\N	86	\N	2017-02-28                      	2	вторник         	f	28	59	2585	2524	2250
2617	2017-03-01	\N	87	\N	2017-03-01                      	3	среда           	f	1	60	2589	2527	2252
2618	2017-03-02	\N	87	\N	2017-03-02                      	4	четверг         	f	2	61	2590	2528	2253
2619	2017-03-03	\N	87	\N	2017-03-03                      	5	пятница         	f	3	62	2591	2529	2254
2620	2017-03-04	\N	87	\N	2017-03-04                      	6	суббота         	t	4	63	2592	2530	2255
2622	2017-03-06	\N	87	\N	2017-03-06                      	1	понедельник     	f	6	65	2594	2532	2257
2623	2017-03-07	\N	87	\N	2017-03-07                      	2	вторник         	f	7	66	2595	2533	2258
2624	2017-03-08	\N	87	\N	2017-03-08                      	3	среда           	f	8	67	2596	2534	2259
2625	2017-03-09	\N	87	\N	2017-03-09                      	4	четверг         	f	9	68	2597	2535	2260
2626	2017-03-10	\N	87	\N	2017-03-10                      	5	пятница         	f	10	69	2598	2536	2261
2627	2017-03-11	\N	87	\N	2017-03-11                      	6	суббота         	t	11	70	2599	2537	2262
2629	2017-03-13	\N	87	\N	2017-03-13                      	1	понедельник     	f	13	72	2601	2539	2264
2630	2017-03-14	\N	87	\N	2017-03-14                      	2	вторник         	f	14	73	2602	2540	2265
2631	2017-03-15	\N	87	\N	2017-03-15                      	3	среда           	f	15	74	2603	2541	2266
2632	2017-03-16	\N	87	\N	2017-03-16                      	4	четверг         	f	16	75	2604	2542	2267
2633	2017-03-17	\N	87	\N	2017-03-17                      	5	пятница         	f	17	76	2605	2543	2268
2634	2017-03-18	\N	87	\N	2017-03-18                      	6	суббота         	t	18	77	2606	2544	2269
2636	2017-03-20	\N	87	\N	2017-03-20                      	1	понедельник     	f	20	79	2608	2546	2271
2637	2017-03-21	\N	87	\N	2017-03-21                      	2	вторник         	f	21	80	2609	2547	2272
2638	2017-03-22	\N	87	\N	2017-03-22                      	3	среда           	f	22	81	2610	2548	2273
2639	2017-03-23	\N	87	\N	2017-03-23                      	4	четверг         	f	23	82	2611	2549	2274
2640	2017-03-24	\N	87	\N	2017-03-24                      	5	пятница         	f	24	83	2612	2550	2275
2641	2017-03-25	\N	87	\N	2017-03-25                      	6	суббота         	t	25	84	2613	2551	2276
2643	2017-03-27	\N	87	\N	2017-03-27                      	1	понедельник     	f	27	86	2615	2553	2278
2644	2017-03-28	\N	87	\N	2017-03-28                      	2	вторник         	f	28	87	2616	2554	2279
2645	2017-03-29	\N	87	\N	2017-03-29                      	3	среда           	f	29	88	2616	2555	2280
2646	2017-03-30	\N	87	\N	2017-03-30                      	4	четверг         	f	30	89	2616	2556	2281
2647	2017-03-31	\N	87	\N	2017-03-31                      	5	пятница         	f	31	90	2616	2557	2282
2648	2017-04-01	\N	88	\N	2017-04-01                      	6	суббота         	t	1	91	2617	2558	2283
2650	2017-04-03	\N	88	\N	2017-04-03                      	1	понедельник     	f	3	93	2619	2560	2285
2651	2017-04-04	\N	88	\N	2017-04-04                      	2	вторник         	f	4	94	2620	2561	2286
2652	2017-04-05	\N	88	\N	2017-04-05                      	3	среда           	f	5	95	2621	2562	2287
2653	2017-04-06	\N	88	\N	2017-04-06                      	4	четверг         	f	6	96	2622	2563	2288
2654	2017-04-07	\N	88	\N	2017-04-07                      	5	пятница         	f	7	97	2623	2564	2289
2655	2017-04-08	\N	88	\N	2017-04-08                      	6	суббота         	t	8	98	2624	2565	2290
2657	2017-04-10	\N	88	\N	2017-04-10                      	1	понедельник     	f	10	100	2626	2567	2292
2658	2017-04-11	\N	88	\N	2017-04-11                      	2	вторник         	f	11	101	2627	2568	2293
2659	2017-04-12	\N	88	\N	2017-04-12                      	3	среда           	f	12	102	2628	2569	2294
2660	2017-04-13	\N	88	\N	2017-04-13                      	4	четверг         	f	13	103	2629	2570	2295
2661	2017-04-14	\N	88	\N	2017-04-14                      	5	пятница         	f	14	104	2630	2571	2296
2662	2017-04-15	\N	88	\N	2017-04-15                      	6	суббота         	t	15	105	2631	2572	2297
2664	2017-04-17	\N	88	\N	2017-04-17                      	1	понедельник     	f	17	107	2633	2574	2299
2665	2017-04-18	\N	88	\N	2017-04-18                      	2	вторник         	f	18	108	2634	2575	2300
2666	2017-04-19	\N	88	\N	2017-04-19                      	3	среда           	f	19	109	2635	2576	2301
2667	2017-04-20	\N	88	\N	2017-04-20                      	4	четверг         	f	20	110	2636	2577	2302
2668	2017-04-21	\N	88	\N	2017-04-21                      	5	пятница         	f	21	111	2637	2578	2303
2669	2017-04-22	\N	88	\N	2017-04-22                      	6	суббота         	t	22	112	2638	2579	2304
2671	2017-04-24	\N	88	\N	2017-04-24                      	1	понедельник     	f	24	114	2640	2581	2306
2672	2017-04-25	\N	88	\N	2017-04-25                      	2	вторник         	f	25	115	2641	2582	2307
2673	2017-04-26	\N	88	\N	2017-04-26                      	3	среда           	f	26	116	2642	2583	2308
2674	2017-04-27	\N	88	\N	2017-04-27                      	4	четверг         	f	27	117	2643	2584	2309
2675	2017-04-28	\N	88	\N	2017-04-28                      	5	пятница         	f	28	118	2644	2585	2310
2676	2017-04-29	\N	88	\N	2017-04-29                      	6	суббота         	t	29	119	2645	2586	2311
2678	2017-05-01	\N	89	\N	2017-05-01                      	1	понедельник     	f	1	121	2648	2589	2313
2679	2017-05-02	\N	89	\N	2017-05-02                      	2	вторник         	f	2	122	2649	2590	2314
2680	2017-05-03	\N	89	\N	2017-05-03                      	3	среда           	f	3	123	2650	2591	2315
2681	2017-05-04	\N	89	\N	2017-05-04                      	4	четверг         	f	4	124	2651	2592	2316
2682	2017-05-05	\N	89	\N	2017-05-05                      	5	пятница         	f	5	125	2652	2593	2317
2683	2017-05-06	\N	89	\N	2017-05-06                      	6	суббота         	t	6	126	2653	2594	2318
2685	2017-05-08	\N	89	\N	2017-05-08                      	1	понедельник     	f	8	128	2655	2596	2320
2686	2017-05-09	\N	89	\N	2017-05-09                      	2	вторник         	f	9	129	2656	2597	2321
2687	2017-05-10	\N	89	\N	2017-05-10                      	3	среда           	f	10	130	2657	2598	2322
2688	2017-05-11	\N	89	\N	2017-05-11                      	4	четверг         	f	11	131	2658	2599	2323
2689	2017-05-12	\N	89	\N	2017-05-12                      	5	пятница         	f	12	132	2659	2600	2324
2690	2017-05-13	\N	89	\N	2017-05-13                      	6	суббота         	t	13	133	2660	2601	2325
2692	2017-05-15	\N	89	\N	2017-05-15                      	1	понедельник     	f	15	135	2662	2603	2327
2693	2017-05-16	\N	89	\N	2017-05-16                      	2	вторник         	f	16	136	2663	2604	2328
2694	2017-05-17	\N	89	\N	2017-05-17                      	3	среда           	f	17	137	2664	2605	2329
2695	2017-05-18	\N	89	\N	2017-05-18                      	4	четверг         	f	18	138	2665	2606	2330
2696	2017-05-19	\N	89	\N	2017-05-19                      	5	пятница         	f	19	139	2666	2607	2331
2697	2017-05-20	\N	89	\N	2017-05-20                      	6	суббота         	t	20	140	2667	2608	2332
2699	2017-05-22	\N	89	\N	2017-05-22                      	1	понедельник     	f	22	142	2669	2610	2334
2700	2017-05-23	\N	89	\N	2017-05-23                      	2	вторник         	f	23	143	2670	2611	2335
2701	2017-05-24	\N	89	\N	2017-05-24                      	3	среда           	f	24	144	2671	2612	2336
2702	2017-05-25	\N	89	\N	2017-05-25                      	4	четверг         	f	25	145	2672	2613	2337
2703	2017-05-26	\N	89	\N	2017-05-26                      	5	пятница         	f	26	146	2673	2614	2338
2704	2017-05-27	\N	89	\N	2017-05-27                      	6	суббота         	t	27	147	2674	2615	2339
2706	2017-05-29	\N	89	\N	2017-05-29                      	1	понедельник     	f	29	149	2676	2616	2341
2707	2017-05-30	\N	89	\N	2017-05-30                      	2	вторник         	f	30	150	2677	2616	2342
2708	2017-05-31	\N	89	\N	2017-05-31                      	3	среда           	f	31	151	2677	2616	2343
2709	2017-06-01	\N	90	\N	2017-06-01                      	4	четверг         	f	1	152	2678	2617	2344
2710	2017-06-02	\N	90	\N	2017-06-02                      	5	пятница         	f	2	153	2679	2618	2345
2711	2017-06-03	\N	90	\N	2017-06-03                      	6	суббота         	t	3	154	2680	2619	2346
2713	2017-06-05	\N	90	\N	2017-06-05                      	1	понедельник     	f	5	156	2682	2621	2348
2714	2017-06-06	\N	90	\N	2017-06-06                      	2	вторник         	f	6	157	2683	2622	2349
2715	2017-06-07	\N	90	\N	2017-06-07                      	3	среда           	f	7	158	2684	2623	2350
2716	2017-06-08	\N	90	\N	2017-06-08                      	4	четверг         	f	8	159	2685	2624	2351
2717	2017-06-09	\N	90	\N	2017-06-09                      	5	пятница         	f	9	160	2686	2625	2352
2718	2017-06-10	\N	90	\N	2017-06-10                      	6	суббота         	t	10	161	2687	2626	2353
2720	2017-06-12	\N	90	\N	2017-06-12                      	1	понедельник     	f	12	163	2689	2628	2355
2721	2017-06-13	\N	90	\N	2017-06-13                      	2	вторник         	f	13	164	2690	2629	2356
2722	2017-06-14	\N	90	\N	2017-06-14                      	3	среда           	f	14	165	2691	2630	2357
2723	2017-06-15	\N	90	\N	2017-06-15                      	4	четверг         	f	15	166	2692	2631	2358
2724	2017-06-16	\N	90	\N	2017-06-16                      	5	пятница         	f	16	167	2693	2632	2359
2725	2017-06-17	\N	90	\N	2017-06-17                      	6	суббота         	t	17	168	2694	2633	2360
2727	2017-06-19	\N	90	\N	2017-06-19                      	1	понедельник     	f	19	170	2696	2635	2362
2728	2017-06-20	\N	90	\N	2017-06-20                      	2	вторник         	f	20	171	2697	2636	2363
2729	2017-06-21	\N	90	\N	2017-06-21                      	3	среда           	f	21	172	2698	2637	2364
2730	2017-06-22	\N	90	\N	2017-06-22                      	4	четверг         	f	22	173	2699	2638	2365
2731	2017-06-23	\N	90	\N	2017-06-23                      	5	пятница         	f	23	174	2700	2639	2366
2732	2017-06-24	\N	90	\N	2017-06-24                      	6	суббота         	t	24	175	2701	2640	2367
2734	2017-06-26	\N	90	\N	2017-06-26                      	1	понедельник     	f	26	177	2703	2642	2369
2735	2017-06-27	\N	90	\N	2017-06-27                      	2	вторник         	f	27	178	2704	2643	2370
2736	2017-06-28	\N	90	\N	2017-06-28                      	3	среда           	f	28	179	2705	2644	2371
2737	2017-06-29	\N	90	\N	2017-06-29                      	4	четверг         	f	29	180	2706	2645	2372
2738	2017-06-30	\N	90	\N	2017-06-30                      	5	пятница         	f	30	181	2707	2646	2373
2739	2017-07-01	\N	91	\N	2017-07-01                      	6	суббота         	t	1	182	2709	2648	2374
2741	2017-07-03	\N	91	\N	2017-07-03                      	1	понедельник     	f	3	184	2711	2650	2376
2742	2017-07-04	\N	91	\N	2017-07-04                      	2	вторник         	f	4	185	2712	2651	2377
2743	2017-07-05	\N	91	\N	2017-07-05                      	3	среда           	f	5	186	2713	2652	2378
2744	2017-07-06	\N	91	\N	2017-07-06                      	4	четверг         	f	6	187	2714	2653	2379
2745	2017-07-07	\N	91	\N	2017-07-07                      	5	пятница         	f	7	188	2715	2654	2380
2746	2017-07-08	\N	91	\N	2017-07-08                      	6	суббота         	t	8	189	2716	2655	2381
2748	2017-07-10	\N	91	\N	2017-07-10                      	1	понедельник     	f	10	191	2718	2657	2383
2749	2017-07-11	\N	91	\N	2017-07-11                      	2	вторник         	f	11	192	2719	2658	2384
2750	2017-07-12	\N	91	\N	2017-07-12                      	3	среда           	f	12	193	2720	2659	2385
2751	2017-07-13	\N	91	\N	2017-07-13                      	4	четверг         	f	13	194	2721	2660	2386
2752	2017-07-14	\N	91	\N	2017-07-14                      	5	пятница         	f	14	195	2722	2661	2387
2753	2017-07-15	\N	91	\N	2017-07-15                      	6	суббота         	t	15	196	2723	2662	2388
2755	2017-07-17	\N	91	\N	2017-07-17                      	1	понедельник     	f	17	198	2725	2664	2390
2756	2017-07-18	\N	91	\N	2017-07-18                      	2	вторник         	f	18	199	2726	2665	2391
2757	2017-07-19	\N	91	\N	2017-07-19                      	3	среда           	f	19	200	2727	2666	2392
2758	2017-07-20	\N	91	\N	2017-07-20                      	4	четверг         	f	20	201	2728	2667	2393
2759	2017-07-21	\N	91	\N	2017-07-21                      	5	пятница         	f	21	202	2729	2668	2394
2760	2017-07-22	\N	91	\N	2017-07-22                      	6	суббота         	t	22	203	2730	2669	2395
2762	2017-07-24	\N	91	\N	2017-07-24                      	1	понедельник     	f	24	205	2732	2671	2397
2763	2017-07-25	\N	91	\N	2017-07-25                      	2	вторник         	f	25	206	2733	2672	2398
2764	2017-07-26	\N	91	\N	2017-07-26                      	3	среда           	f	26	207	2734	2673	2399
2765	2017-07-27	\N	91	\N	2017-07-27                      	4	четверг         	f	27	208	2735	2674	2400
2766	2017-07-28	\N	91	\N	2017-07-28                      	5	пятница         	f	28	209	2736	2675	2401
2767	2017-07-29	\N	91	\N	2017-07-29                      	6	суббота         	t	29	210	2737	2676	2402
2769	2017-07-31	\N	91	\N	2017-07-31                      	1	понедельник     	f	31	212	2738	2677	2404
2770	2017-08-01	\N	92	\N	2017-08-01                      	2	вторник         	f	1	213	2739	2678	2405
2771	2017-08-02	\N	92	\N	2017-08-02                      	3	среда           	f	2	214	2740	2679	2406
2772	2017-08-03	\N	92	\N	2017-08-03                      	4	четверг         	f	3	215	2741	2680	2407
2773	2017-08-04	\N	92	\N	2017-08-04                      	5	пятница         	f	4	216	2742	2681	2408
2774	2017-08-05	\N	92	\N	2017-08-05                      	6	суббота         	t	5	217	2743	2682	2409
2776	2017-08-07	\N	92	\N	2017-08-07                      	1	понедельник     	f	7	219	2745	2684	2411
2777	2017-08-08	\N	92	\N	2017-08-08                      	2	вторник         	f	8	220	2746	2685	2412
2778	2017-08-09	\N	92	\N	2017-08-09                      	3	среда           	f	9	221	2747	2686	2413
2779	2017-08-10	\N	92	\N	2017-08-10                      	4	четверг         	f	10	222	2748	2687	2414
2780	2017-08-11	\N	92	\N	2017-08-11                      	5	пятница         	f	11	223	2749	2688	2415
2781	2017-08-12	\N	92	\N	2017-08-12                      	6	суббота         	t	12	224	2750	2689	2416
2783	2017-08-14	\N	92	\N	2017-08-14                      	1	понедельник     	f	14	226	2752	2691	2418
2784	2017-08-15	\N	92	\N	2017-08-15                      	2	вторник         	f	15	227	2753	2692	2419
2785	2017-08-16	\N	92	\N	2017-08-16                      	3	среда           	f	16	228	2754	2693	2420
2786	2017-08-17	\N	92	\N	2017-08-17                      	4	четверг         	f	17	229	2755	2694	2421
2787	2017-08-18	\N	92	\N	2017-08-18                      	5	пятница         	f	18	230	2756	2695	2422
2788	2017-08-19	\N	92	\N	2017-08-19                      	6	суббота         	t	19	231	2757	2696	2423
2790	2017-08-21	\N	92	\N	2017-08-21                      	1	понедельник     	f	21	233	2759	2698	2425
2791	2017-08-22	\N	92	\N	2017-08-22                      	2	вторник         	f	22	234	2760	2699	2426
2792	2017-08-23	\N	92	\N	2017-08-23                      	3	среда           	f	23	235	2761	2700	2427
2793	2017-08-24	\N	92	\N	2017-08-24                      	4	четверг         	f	24	236	2762	2701	2428
2794	2017-08-25	\N	92	\N	2017-08-25                      	5	пятница         	f	25	237	2763	2702	2429
2795	2017-08-26	\N	92	\N	2017-08-26                      	6	суббота         	t	26	238	2764	2703	2430
2797	2017-08-28	\N	92	\N	2017-08-28                      	1	понедельник     	f	28	240	2766	2705	2432
2798	2017-08-29	\N	92	\N	2017-08-29                      	2	вторник         	f	29	241	2767	2706	2433
2799	2017-08-30	\N	92	\N	2017-08-30                      	3	среда           	f	30	242	2768	2707	2434
2800	2017-08-31	\N	92	\N	2017-08-31                      	4	четверг         	f	31	243	2769	2708	2435
2801	2017-09-01	\N	93	\N	2017-09-01                      	5	пятница         	f	1	244	2770	2709	2436
2802	2017-09-02	\N	93	\N	2017-09-02                      	6	суббота         	t	2	245	2771	2710	2437
2804	2017-09-04	\N	93	\N	2017-09-04                      	1	понедельник     	f	4	247	2773	2712	2439
2805	2017-09-05	\N	93	\N	2017-09-05                      	2	вторник         	f	5	248	2774	2713	2440
2806	2017-09-06	\N	93	\N	2017-09-06                      	3	среда           	f	6	249	2775	2714	2441
2807	2017-09-07	\N	93	\N	2017-09-07                      	4	четверг         	f	7	250	2776	2715	2442
2808	2017-09-08	\N	93	\N	2017-09-08                      	5	пятница         	f	8	251	2777	2716	2443
2809	2017-09-09	\N	93	\N	2017-09-09                      	6	суббота         	t	9	252	2778	2717	2444
2811	2017-09-11	\N	93	\N	2017-09-11                      	1	понедельник     	f	11	254	2780	2719	2446
2812	2017-09-12	\N	93	\N	2017-09-12                      	2	вторник         	f	12	255	2781	2720	2447
2813	2017-09-13	\N	93	\N	2017-09-13                      	3	среда           	f	13	256	2782	2721	2448
2814	2017-09-14	\N	93	\N	2017-09-14                      	4	четверг         	f	14	257	2783	2722	2449
2815	2017-09-15	\N	93	\N	2017-09-15                      	5	пятница         	f	15	258	2784	2723	2450
2816	2017-09-16	\N	93	\N	2017-09-16                      	6	суббота         	t	16	259	2785	2724	2451
2818	2017-09-18	\N	93	\N	2017-09-18                      	1	понедельник     	f	18	261	2787	2726	2453
2819	2017-09-19	\N	93	\N	2017-09-19                      	2	вторник         	f	19	262	2788	2727	2454
2820	2017-09-20	\N	93	\N	2017-09-20                      	3	среда           	f	20	263	2789	2728	2455
2821	2017-09-21	\N	93	\N	2017-09-21                      	4	четверг         	f	21	264	2790	2729	2456
2822	2017-09-22	\N	93	\N	2017-09-22                      	5	пятница         	f	22	265	2791	2730	2457
2823	2017-09-23	\N	93	\N	2017-09-23                      	6	суббота         	t	23	266	2792	2731	2458
2825	2017-09-25	\N	93	\N	2017-09-25                      	1	понедельник     	f	25	268	2794	2733	2460
2826	2017-09-26	\N	93	\N	2017-09-26                      	2	вторник         	f	26	269	2795	2734	2461
2827	2017-09-27	\N	93	\N	2017-09-27                      	3	среда           	f	27	270	2796	2735	2462
2828	2017-09-28	\N	93	\N	2017-09-28                      	4	четверг         	f	28	271	2797	2736	2463
2829	2017-09-29	\N	93	\N	2017-09-29                      	5	пятница         	f	29	272	2798	2737	2464
2830	2017-09-30	\N	93	\N	2017-09-30                      	6	суббота         	t	30	273	2799	2738	2465
2832	2017-10-02	\N	94	\N	2017-10-02                      	1	понедельник     	f	2	275	2802	2740	2467
2833	2017-10-03	\N	94	\N	2017-10-03                      	2	вторник         	f	3	276	2803	2741	2468
2834	2017-10-04	\N	94	\N	2017-10-04                      	3	среда           	f	4	277	2804	2742	2469
2835	2017-10-05	\N	94	\N	2017-10-05                      	4	четверг         	f	5	278	2805	2743	2470
2836	2017-10-06	\N	94	\N	2017-10-06                      	5	пятница         	f	6	279	2806	2744	2471
2837	2017-10-07	\N	94	\N	2017-10-07                      	6	суббота         	t	7	280	2807	2745	2472
2839	2017-10-09	\N	94	\N	2017-10-09                      	1	понедельник     	f	9	282	2809	2747	2474
2840	2017-10-10	\N	94	\N	2017-10-10                      	2	вторник         	f	10	283	2810	2748	2475
2841	2017-10-11	\N	94	\N	2017-10-11                      	3	среда           	f	11	284	2811	2749	2476
2842	2017-10-12	\N	94	\N	2017-10-12                      	4	четверг         	f	12	285	2812	2750	2477
2843	2017-10-13	\N	94	\N	2017-10-13                      	5	пятница         	f	13	286	2813	2751	2478
2844	2017-10-14	\N	94	\N	2017-10-14                      	6	суббота         	t	14	287	2814	2752	2479
2846	2017-10-16	\N	94	\N	2017-10-16                      	1	понедельник     	f	16	289	2816	2754	2481
2847	2017-10-17	\N	94	\N	2017-10-17                      	2	вторник         	f	17	290	2817	2755	2482
2848	2017-10-18	\N	94	\N	2017-10-18                      	3	среда           	f	18	291	2818	2756	2483
2849	2017-10-19	\N	94	\N	2017-10-19                      	4	четверг         	f	19	292	2819	2757	2484
2850	2017-10-20	\N	94	\N	2017-10-20                      	5	пятница         	f	20	293	2820	2758	2485
2851	2017-10-21	\N	94	\N	2017-10-21                      	6	суббота         	t	21	294	2821	2759	2486
2853	2017-10-23	\N	94	\N	2017-10-23                      	1	понедельник     	f	23	296	2823	2761	2488
2854	2017-10-24	\N	94	\N	2017-10-24                      	2	вторник         	f	24	297	2824	2762	2489
2855	2017-10-25	\N	94	\N	2017-10-25                      	3	среда           	f	25	298	2825	2763	2490
2856	2017-10-26	\N	94	\N	2017-10-26                      	4	четверг         	f	26	299	2826	2764	2491
2857	2017-10-27	\N	94	\N	2017-10-27                      	5	пятница         	f	27	300	2827	2765	2492
2858	2017-10-28	\N	94	\N	2017-10-28                      	6	суббота         	t	28	301	2828	2766	2493
2860	2017-10-30	\N	94	\N	2017-10-30                      	1	понедельник     	f	30	303	2830	2768	2495
2861	2017-10-31	\N	94	\N	2017-10-31                      	2	вторник         	f	31	304	2830	2769	2496
2862	2017-11-01	\N	95	\N	2017-11-01                      	3	среда           	f	1	305	2831	2770	2497
2863	2017-11-02	\N	95	\N	2017-11-02                      	4	четверг         	f	2	306	2832	2771	2498
2864	2017-11-03	\N	95	\N	2017-11-03                      	5	пятница         	f	3	307	2833	2772	2499
2865	2017-11-04	\N	95	\N	2017-11-04                      	6	суббота         	t	4	308	2834	2773	2500
2867	2017-11-06	\N	95	\N	2017-11-06                      	1	понедельник     	f	6	310	2836	2775	2502
2868	2017-11-07	\N	95	\N	2017-11-07                      	2	вторник         	f	7	311	2837	2776	2503
2869	2017-11-08	\N	95	\N	2017-11-08                      	3	среда           	f	8	312	2838	2777	2504
2870	2017-11-09	\N	95	\N	2017-11-09                      	4	четверг         	f	9	313	2839	2778	2505
2871	2017-11-10	\N	95	\N	2017-11-10                      	5	пятница         	f	10	314	2840	2779	2506
2872	2017-11-11	\N	95	\N	2017-11-11                      	6	суббота         	t	11	315	2841	2780	2507
2874	2017-11-13	\N	95	\N	2017-11-13                      	1	понедельник     	f	13	317	2843	2782	2509
2875	2017-11-14	\N	95	\N	2017-11-14                      	2	вторник         	f	14	318	2844	2783	2510
2876	2017-11-15	\N	95	\N	2017-11-15                      	3	среда           	f	15	319	2845	2784	2511
2877	2017-11-16	\N	95	\N	2017-11-16                      	4	четверг         	f	16	320	2846	2785	2512
2878	2017-11-17	\N	95	\N	2017-11-17                      	5	пятница         	f	17	321	2847	2786	2513
2879	2017-11-18	\N	95	\N	2017-11-18                      	6	суббота         	t	18	322	2848	2787	2514
2881	2017-11-20	\N	95	\N	2017-11-20                      	1	понедельник     	f	20	324	2850	2789	2516
2882	2017-11-21	\N	95	\N	2017-11-21                      	2	вторник         	f	21	325	2851	2790	2517
2883	2017-11-22	\N	95	\N	2017-11-22                      	3	среда           	f	22	326	2852	2791	2518
2884	2017-11-23	\N	95	\N	2017-11-23                      	4	четверг         	f	23	327	2853	2792	2519
2885	2017-11-24	\N	95	\N	2017-11-24                      	5	пятница         	f	24	328	2854	2793	2520
2886	2017-11-25	\N	95	\N	2017-11-25                      	6	суббота         	t	25	329	2855	2794	2521
2888	2017-11-27	\N	95	\N	2017-11-27                      	1	понедельник     	f	27	331	2857	2796	2523
2889	2017-11-28	\N	95	\N	2017-11-28                      	2	вторник         	f	28	332	2858	2797	2524
2890	2017-11-29	\N	95	\N	2017-11-29                      	3	среда           	f	29	333	2859	2798	2525
2891	2017-11-30	\N	95	\N	2017-11-30                      	4	четверг         	f	30	334	2860	2799	2526
2892	2017-12-01	\N	96	\N	2017-12-01                      	5	пятница         	f	1	335	2862	2801	2527
2893	2017-12-02	\N	96	\N	2017-12-02                      	6	суббота         	t	2	336	2863	2802	2528
2895	2017-12-04	\N	96	\N	2017-12-04                      	1	понедельник     	f	4	338	2865	2804	2530
2896	2017-12-05	\N	96	\N	2017-12-05                      	2	вторник         	f	5	339	2866	2805	2531
2897	2017-12-06	\N	96	\N	2017-12-06                      	3	среда           	f	6	340	2867	2806	2532
2898	2017-12-07	\N	96	\N	2017-12-07                      	4	четверг         	f	7	341	2868	2807	2533
2899	2017-12-08	\N	96	\N	2017-12-08                      	5	пятница         	f	8	342	2869	2808	2534
2900	2017-12-09	\N	96	\N	2017-12-09                      	6	суббота         	t	9	343	2870	2809	2535
2902	2017-12-11	\N	96	\N	2017-12-11                      	1	понедельник     	f	11	345	2872	2811	2537
2903	2017-12-12	\N	96	\N	2017-12-12                      	2	вторник         	f	12	346	2873	2812	2538
2904	2017-12-13	\N	96	\N	2017-12-13                      	3	среда           	f	13	347	2874	2813	2539
2905	2017-12-14	\N	96	\N	2017-12-14                      	4	четверг         	f	14	348	2875	2814	2540
2906	2017-12-15	\N	96	\N	2017-12-15                      	5	пятница         	f	15	349	2876	2815	2541
2907	2017-12-16	\N	96	\N	2017-12-16                      	6	суббота         	t	16	350	2877	2816	2542
2909	2017-12-18	\N	96	\N	2017-12-18                      	1	понедельник     	f	18	352	2879	2818	2544
2910	2017-12-19	\N	96	\N	2017-12-19                      	2	вторник         	f	19	353	2880	2819	2545
2911	2017-12-20	\N	96	\N	2017-12-20                      	3	среда           	f	20	354	2881	2820	2546
2912	2017-12-21	\N	96	\N	2017-12-21                      	4	четверг         	f	21	355	2882	2821	2547
2913	2017-12-22	\N	96	\N	2017-12-22                      	5	пятница         	f	22	356	2883	2822	2548
2914	2017-12-23	\N	96	\N	2017-12-23                      	6	суббота         	t	23	357	2884	2823	2549
2916	2017-12-25	\N	96	\N	2017-12-25                      	1	понедельник     	f	25	359	2886	2825	2551
2917	2017-12-26	\N	96	\N	2017-12-26                      	2	вторник         	f	26	360	2887	2826	2552
2918	2017-12-27	\N	96	\N	2017-12-27                      	3	среда           	f	27	361	2888	2827	2553
2919	2017-12-28	\N	96	\N	2017-12-28                      	4	четверг         	f	28	362	2889	2828	2554
2920	2017-12-29	\N	96	\N	2017-12-29                      	5	пятница         	f	29	363	2890	2829	2555
2921	2017-12-30	\N	96	\N	2017-12-30                      	6	суббота         	t	30	364	2891	2830	2556
2923	2018-01-01	\N	97	\N	2018-01-01                      	1	понедельник     	f	1	1	2892	2831	2558
2924	2018-01-02	\N	97	\N	2018-01-02                      	2	вторник         	f	2	2	2893	2832	2559
2925	2018-01-03	\N	97	\N	2018-01-03                      	3	среда           	f	3	3	2894	2833	2560
2926	2018-01-04	\N	97	\N	2018-01-04                      	4	четверг         	f	4	4	2895	2834	2561
2927	2018-01-05	\N	97	\N	2018-01-05                      	5	пятница         	f	5	5	2896	2835	2562
2928	2018-01-06	\N	97	\N	2018-01-06                      	6	суббота         	t	6	6	2897	2836	2563
2930	2018-01-08	\N	97	\N	2018-01-08                      	1	понедельник     	f	8	8	2899	2838	2565
2931	2018-01-09	\N	97	\N	2018-01-09                      	2	вторник         	f	9	9	2900	2839	2566
2932	2018-01-10	\N	97	\N	2018-01-10                      	3	среда           	f	10	10	2901	2840	2567
2933	2018-01-11	\N	97	\N	2018-01-11                      	4	четверг         	f	11	11	2902	2841	2568
2934	2018-01-12	\N	97	\N	2018-01-12                      	5	пятница         	f	12	12	2903	2842	2569
2935	2018-01-13	\N	97	\N	2018-01-13                      	6	суббота         	t	13	13	2904	2843	2570
2937	2018-01-15	\N	97	\N	2018-01-15                      	1	понедельник     	f	15	15	2906	2845	2572
2938	2018-01-16	\N	97	\N	2018-01-16                      	2	вторник         	f	16	16	2907	2846	2573
2939	2018-01-17	\N	97	\N	2018-01-17                      	3	среда           	f	17	17	2908	2847	2574
2940	2018-01-18	\N	97	\N	2018-01-18                      	4	четверг         	f	18	18	2909	2848	2575
2941	2018-01-19	\N	97	\N	2018-01-19                      	5	пятница         	f	19	19	2910	2849	2576
2942	2018-01-20	\N	97	\N	2018-01-20                      	6	суббота         	t	20	20	2911	2850	2577
2944	2018-01-22	\N	97	\N	2018-01-22                      	1	понедельник     	f	22	22	2913	2852	2579
2945	2018-01-23	\N	97	\N	2018-01-23                      	2	вторник         	f	23	23	2914	2853	2580
2946	2018-01-24	\N	97	\N	2018-01-24                      	3	среда           	f	24	24	2915	2854	2581
2947	2018-01-25	\N	97	\N	2018-01-25                      	4	четверг         	f	25	25	2916	2855	2582
2948	2018-01-26	\N	97	\N	2018-01-26                      	5	пятница         	f	26	26	2917	2856	2583
2949	2018-01-27	\N	97	\N	2018-01-27                      	6	суббота         	t	27	27	2918	2857	2584
2951	2018-01-29	\N	97	\N	2018-01-29                      	1	понедельник     	f	29	29	2920	2859	2586
2952	2018-01-30	\N	97	\N	2018-01-30                      	2	вторник         	f	30	30	2921	2860	2587
2953	2018-01-31	\N	97	\N	2018-01-31                      	3	среда           	f	31	31	2922	2861	2588
2954	2018-02-01	\N	98	\N	2018-02-01                      	4	четверг         	f	1	32	2923	2862	2589
2955	2018-02-02	\N	98	\N	2018-02-02                      	5	пятница         	f	2	33	2924	2863	2590
2956	2018-02-03	\N	98	\N	2018-02-03                      	6	суббота         	t	3	34	2925	2864	2591
2958	2018-02-05	\N	98	\N	2018-02-05                      	1	понедельник     	f	5	36	2927	2866	2593
2959	2018-02-06	\N	98	\N	2018-02-06                      	2	вторник         	f	6	37	2928	2867	2594
2960	2018-02-07	\N	98	\N	2018-02-07                      	3	среда           	f	7	38	2929	2868	2595
2961	2018-02-08	\N	98	\N	2018-02-08                      	4	четверг         	f	8	39	2930	2869	2596
2962	2018-02-09	\N	98	\N	2018-02-09                      	5	пятница         	f	9	40	2931	2870	2597
2963	2018-02-10	\N	98	\N	2018-02-10                      	6	суббота         	t	10	41	2932	2871	2598
2965	2018-02-12	\N	98	\N	2018-02-12                      	1	понедельник     	f	12	43	2934	2873	2600
2966	2018-02-13	\N	98	\N	2018-02-13                      	2	вторник         	f	13	44	2935	2874	2601
2967	2018-02-14	\N	98	\N	2018-02-14                      	3	среда           	f	14	45	2936	2875	2602
2968	2018-02-15	\N	98	\N	2018-02-15                      	4	четверг         	f	15	46	2937	2876	2603
2969	2018-02-16	\N	98	\N	2018-02-16                      	5	пятница         	f	16	47	2938	2877	2604
2970	2018-02-17	\N	98	\N	2018-02-17                      	6	суббота         	t	17	48	2939	2878	2605
2972	2018-02-19	\N	98	\N	2018-02-19                      	1	понедельник     	f	19	50	2941	2880	2607
2973	2018-02-20	\N	98	\N	2018-02-20                      	2	вторник         	f	20	51	2942	2881	2608
2974	2018-02-21	\N	98	\N	2018-02-21                      	3	среда           	f	21	52	2943	2882	2609
2975	2018-02-22	\N	98	\N	2018-02-22                      	4	четверг         	f	22	53	2944	2883	2610
2976	2018-02-23	\N	98	\N	2018-02-23                      	5	пятница         	f	23	54	2945	2884	2611
2977	2018-02-24	\N	98	\N	2018-02-24                      	6	суббота         	t	24	55	2946	2885	2612
2979	2018-02-26	\N	98	\N	2018-02-26                      	1	понедельник     	f	26	57	2948	2887	2614
2980	2018-02-27	\N	98	\N	2018-02-27                      	2	вторник         	f	27	58	2949	2888	2615
2981	2018-02-28	\N	98	\N	2018-02-28                      	3	среда           	f	28	59	2950	2889	2616
2982	2018-03-01	\N	99	\N	2018-03-01                      	4	четверг         	f	1	60	2954	2892	2617
2983	2018-03-02	\N	99	\N	2018-03-02                      	5	пятница         	f	2	61	2955	2893	2618
2984	2018-03-03	\N	99	\N	2018-03-03                      	6	суббота         	t	3	62	2956	2894	2619
2986	2018-03-05	\N	99	\N	2018-03-05                      	1	понедельник     	f	5	64	2958	2896	2621
2987	2018-03-06	\N	99	\N	2018-03-06                      	2	вторник         	f	6	65	2959	2897	2622
2988	2018-03-07	\N	99	\N	2018-03-07                      	3	среда           	f	7	66	2960	2898	2623
2989	2018-03-08	\N	99	\N	2018-03-08                      	4	четверг         	f	8	67	2961	2899	2624
2990	2018-03-09	\N	99	\N	2018-03-09                      	5	пятница         	f	9	68	2962	2900	2625
2991	2018-03-10	\N	99	\N	2018-03-10                      	6	суббота         	t	10	69	2963	2901	2626
2993	2018-03-12	\N	99	\N	2018-03-12                      	1	понедельник     	f	12	71	2965	2903	2628
2994	2018-03-13	\N	99	\N	2018-03-13                      	2	вторник         	f	13	72	2966	2904	2629
2995	2018-03-14	\N	99	\N	2018-03-14                      	3	среда           	f	14	73	2967	2905	2630
2996	2018-03-15	\N	99	\N	2018-03-15                      	4	четверг         	f	15	74	2968	2906	2631
2997	2018-03-16	\N	99	\N	2018-03-16                      	5	пятница         	f	16	75	2969	2907	2632
2998	2018-03-17	\N	99	\N	2018-03-17                      	6	суббота         	t	17	76	2970	2908	2633
3000	2018-03-19	\N	99	\N	2018-03-19                      	1	понедельник     	f	19	78	2972	2910	2635
3001	2018-03-20	\N	99	\N	2018-03-20                      	2	вторник         	f	20	79	2973	2911	2636
3002	2018-03-21	\N	99	\N	2018-03-21                      	3	среда           	f	21	80	2974	2912	2637
3003	2018-03-22	\N	99	\N	2018-03-22                      	4	четверг         	f	22	81	2975	2913	2638
3004	2018-03-23	\N	99	\N	2018-03-23                      	5	пятница         	f	23	82	2976	2914	2639
3005	2018-03-24	\N	99	\N	2018-03-24                      	6	суббота         	t	24	83	2977	2915	2640
3007	2018-03-26	\N	99	\N	2018-03-26                      	1	понедельник     	f	26	85	2979	2917	2642
3008	2018-03-27	\N	99	\N	2018-03-27                      	2	вторник         	f	27	86	2980	2918	2643
3009	2018-03-28	\N	99	\N	2018-03-28                      	3	среда           	f	28	87	2981	2919	2644
3010	2018-03-29	\N	99	\N	2018-03-29                      	4	четверг         	f	29	88	2981	2920	2645
3011	2018-03-30	\N	99	\N	2018-03-30                      	5	пятница         	f	30	89	2981	2921	2646
3012	2018-03-31	\N	99	\N	2018-03-31                      	6	суббота         	t	31	90	2981	2922	2647
3014	2018-04-02	\N	100	\N	2018-04-02                      	1	понедельник     	f	2	92	2983	2924	2649
3015	2018-04-03	\N	100	\N	2018-04-03                      	2	вторник         	f	3	93	2984	2925	2650
3016	2018-04-04	\N	100	\N	2018-04-04                      	3	среда           	f	4	94	2985	2926	2651
3017	2018-04-05	\N	100	\N	2018-04-05                      	4	четверг         	f	5	95	2986	2927	2652
3018	2018-04-06	\N	100	\N	2018-04-06                      	5	пятница         	f	6	96	2987	2928	2653
3019	2018-04-07	\N	100	\N	2018-04-07                      	6	суббота         	t	7	97	2988	2929	2654
3021	2018-04-09	\N	100	\N	2018-04-09                      	1	понедельник     	f	9	99	2990	2931	2656
3022	2018-04-10	\N	100	\N	2018-04-10                      	2	вторник         	f	10	100	2991	2932	2657
3023	2018-04-11	\N	100	\N	2018-04-11                      	3	среда           	f	11	101	2992	2933	2658
3024	2018-04-12	\N	100	\N	2018-04-12                      	4	четверг         	f	12	102	2993	2934	2659
3025	2018-04-13	\N	100	\N	2018-04-13                      	5	пятница         	f	13	103	2994	2935	2660
3026	2018-04-14	\N	100	\N	2018-04-14                      	6	суббота         	t	14	104	2995	2936	2661
3028	2018-04-16	\N	100	\N	2018-04-16                      	1	понедельник     	f	16	106	2997	2938	2663
3029	2018-04-17	\N	100	\N	2018-04-17                      	2	вторник         	f	17	107	2998	2939	2664
3030	2018-04-18	\N	100	\N	2018-04-18                      	3	среда           	f	18	108	2999	2940	2665
3031	2018-04-19	\N	100	\N	2018-04-19                      	4	четверг         	f	19	109	3000	2941	2666
3032	2018-04-20	\N	100	\N	2018-04-20                      	5	пятница         	f	20	110	3001	2942	2667
3033	2018-04-21	\N	100	\N	2018-04-21                      	6	суббота         	t	21	111	3002	2943	2668
3035	2018-04-23	\N	100	\N	2018-04-23                      	1	понедельник     	f	23	113	3004	2945	2670
3036	2018-04-24	\N	100	\N	2018-04-24                      	2	вторник         	f	24	114	3005	2946	2671
3037	2018-04-25	\N	100	\N	2018-04-25                      	3	среда           	f	25	115	3006	2947	2672
3038	2018-04-26	\N	100	\N	2018-04-26                      	4	четверг         	f	26	116	3007	2948	2673
3039	2018-04-27	\N	100	\N	2018-04-27                      	5	пятница         	f	27	117	3008	2949	2674
3040	2018-04-28	\N	100	\N	2018-04-28                      	6	суббота         	t	28	118	3009	2950	2675
3042	2018-04-30	\N	100	\N	2018-04-30                      	1	понедельник     	f	30	120	3011	2952	2677
3043	2018-05-01	\N	101	\N	2018-05-01                      	2	вторник         	f	1	121	3013	2954	2678
3044	2018-05-02	\N	101	\N	2018-05-02                      	3	среда           	f	2	122	3014	2955	2679
3045	2018-05-03	\N	101	\N	2018-05-03                      	4	четверг         	f	3	123	3015	2956	2680
3046	2018-05-04	\N	101	\N	2018-05-04                      	5	пятница         	f	4	124	3016	2957	2681
3047	2018-05-05	\N	101	\N	2018-05-05                      	6	суббота         	t	5	125	3017	2958	2682
3049	2018-05-07	\N	101	\N	2018-05-07                      	1	понедельник     	f	7	127	3019	2960	2684
3050	2018-05-08	\N	101	\N	2018-05-08                      	2	вторник         	f	8	128	3020	2961	2685
3051	2018-05-09	\N	101	\N	2018-05-09                      	3	среда           	f	9	129	3021	2962	2686
3052	2018-05-10	\N	101	\N	2018-05-10                      	4	четверг         	f	10	130	3022	2963	2687
3053	2018-05-11	\N	101	\N	2018-05-11                      	5	пятница         	f	11	131	3023	2964	2688
3054	2018-05-12	\N	101	\N	2018-05-12                      	6	суббота         	t	12	132	3024	2965	2689
3056	2018-05-14	\N	101	\N	2018-05-14                      	1	понедельник     	f	14	134	3026	2967	2691
3057	2018-05-15	\N	101	\N	2018-05-15                      	2	вторник         	f	15	135	3027	2968	2692
3058	2018-05-16	\N	101	\N	2018-05-16                      	3	среда           	f	16	136	3028	2969	2693
3059	2018-05-17	\N	101	\N	2018-05-17                      	4	четверг         	f	17	137	3029	2970	2694
3060	2018-05-18	\N	101	\N	2018-05-18                      	5	пятница         	f	18	138	3030	2971	2695
3061	2018-05-19	\N	101	\N	2018-05-19                      	6	суббота         	t	19	139	3031	2972	2696
3063	2018-05-21	\N	101	\N	2018-05-21                      	1	понедельник     	f	21	141	3033	2974	2698
3064	2018-05-22	\N	101	\N	2018-05-22                      	2	вторник         	f	22	142	3034	2975	2699
3065	2018-05-23	\N	101	\N	2018-05-23                      	3	среда           	f	23	143	3035	2976	2700
3066	2018-05-24	\N	101	\N	2018-05-24                      	4	четверг         	f	24	144	3036	2977	2701
3067	2018-05-25	\N	101	\N	2018-05-25                      	5	пятница         	f	25	145	3037	2978	2702
3068	2018-05-26	\N	101	\N	2018-05-26                      	6	суббота         	t	26	146	3038	2979	2703
3070	2018-05-28	\N	101	\N	2018-05-28                      	1	понедельник     	f	28	148	3040	2981	2705
3071	2018-05-29	\N	101	\N	2018-05-29                      	2	вторник         	f	29	149	3041	2981	2706
3072	2018-05-30	\N	101	\N	2018-05-30                      	3	среда           	f	30	150	3042	2981	2707
3073	2018-05-31	\N	101	\N	2018-05-31                      	4	четверг         	f	31	151	3042	2981	2708
3074	2018-06-01	\N	102	\N	2018-06-01                      	5	пятница         	f	1	152	3043	2982	2709
3075	2018-06-02	\N	102	\N	2018-06-02                      	6	суббота         	t	2	153	3044	2983	2710
3077	2018-06-04	\N	102	\N	2018-06-04                      	1	понедельник     	f	4	155	3046	2985	2712
3078	2018-06-05	\N	102	\N	2018-06-05                      	2	вторник         	f	5	156	3047	2986	2713
3079	2018-06-06	\N	102	\N	2018-06-06                      	3	среда           	f	6	157	3048	2987	2714
3080	2018-06-07	\N	102	\N	2018-06-07                      	4	четверг         	f	7	158	3049	2988	2715
3081	2018-06-08	\N	102	\N	2018-06-08                      	5	пятница         	f	8	159	3050	2989	2716
3082	2018-06-09	\N	102	\N	2018-06-09                      	6	суббота         	t	9	160	3051	2990	2717
3084	2018-06-11	\N	102	\N	2018-06-11                      	1	понедельник     	f	11	162	3053	2992	2719
3085	2018-06-12	\N	102	\N	2018-06-12                      	2	вторник         	f	12	163	3054	2993	2720
3086	2018-06-13	\N	102	\N	2018-06-13                      	3	среда           	f	13	164	3055	2994	2721
3087	2018-06-14	\N	102	\N	2018-06-14                      	4	четверг         	f	14	165	3056	2995	2722
3088	2018-06-15	\N	102	\N	2018-06-15                      	5	пятница         	f	15	166	3057	2996	2723
3089	2018-06-16	\N	102	\N	2018-06-16                      	6	суббота         	t	16	167	3058	2997	2724
3091	2018-06-18	\N	102	\N	2018-06-18                      	1	понедельник     	f	18	169	3060	2999	2726
3092	2018-06-19	\N	102	\N	2018-06-19                      	2	вторник         	f	19	170	3061	3000	2727
3093	2018-06-20	\N	102	\N	2018-06-20                      	3	среда           	f	20	171	3062	3001	2728
3094	2018-06-21	\N	102	\N	2018-06-21                      	4	четверг         	f	21	172	3063	3002	2729
3095	2018-06-22	\N	102	\N	2018-06-22                      	5	пятница         	f	22	173	3064	3003	2730
3096	2018-06-23	\N	102	\N	2018-06-23                      	6	суббота         	t	23	174	3065	3004	2731
3098	2018-06-25	\N	102	\N	2018-06-25                      	1	понедельник     	f	25	176	3067	3006	2733
3099	2018-06-26	\N	102	\N	2018-06-26                      	2	вторник         	f	26	177	3068	3007	2734
3100	2018-06-27	\N	102	\N	2018-06-27                      	3	среда           	f	27	178	3069	3008	2735
3101	2018-06-28	\N	102	\N	2018-06-28                      	4	четверг         	f	28	179	3070	3009	2736
3102	2018-06-29	\N	102	\N	2018-06-29                      	5	пятница         	f	29	180	3071	3010	2737
3103	2018-06-30	\N	102	\N	2018-06-30                      	6	суббота         	t	30	181	3072	3011	2738
3105	2018-07-02	\N	103	\N	2018-07-02                      	1	понедельник     	f	2	183	3075	3014	2740
3106	2018-07-03	\N	103	\N	2018-07-03                      	2	вторник         	f	3	184	3076	3015	2741
3107	2018-07-04	\N	103	\N	2018-07-04                      	3	среда           	f	4	185	3077	3016	2742
3108	2018-07-05	\N	103	\N	2018-07-05                      	4	четверг         	f	5	186	3078	3017	2743
3109	2018-07-06	\N	103	\N	2018-07-06                      	5	пятница         	f	6	187	3079	3018	2744
3110	2018-07-07	\N	103	\N	2018-07-07                      	6	суббота         	t	7	188	3080	3019	2745
3112	2018-07-09	\N	103	\N	2018-07-09                      	1	понедельник     	f	9	190	3082	3021	2747
3113	2018-07-10	\N	103	\N	2018-07-10                      	2	вторник         	f	10	191	3083	3022	2748
3114	2018-07-11	\N	103	\N	2018-07-11                      	3	среда           	f	11	192	3084	3023	2749
3115	2018-07-12	\N	103	\N	2018-07-12                      	4	четверг         	f	12	193	3085	3024	2750
3116	2018-07-13	\N	103	\N	2018-07-13                      	5	пятница         	f	13	194	3086	3025	2751
3117	2018-07-14	\N	103	\N	2018-07-14                      	6	суббота         	t	14	195	3087	3026	2752
3119	2018-07-16	\N	103	\N	2018-07-16                      	1	понедельник     	f	16	197	3089	3028	2754
3120	2018-07-17	\N	103	\N	2018-07-17                      	2	вторник         	f	17	198	3090	3029	2755
3121	2018-07-18	\N	103	\N	2018-07-18                      	3	среда           	f	18	199	3091	3030	2756
3122	2018-07-19	\N	103	\N	2018-07-19                      	4	четверг         	f	19	200	3092	3031	2757
3123	2018-07-20	\N	103	\N	2018-07-20                      	5	пятница         	f	20	201	3093	3032	2758
3124	2018-07-21	\N	103	\N	2018-07-21                      	6	суббота         	t	21	202	3094	3033	2759
3126	2018-07-23	\N	103	\N	2018-07-23                      	1	понедельник     	f	23	204	3096	3035	2761
3127	2018-07-24	\N	103	\N	2018-07-24                      	2	вторник         	f	24	205	3097	3036	2762
3128	2018-07-25	\N	103	\N	2018-07-25                      	3	среда           	f	25	206	3098	3037	2763
3129	2018-07-26	\N	103	\N	2018-07-26                      	4	четверг         	f	26	207	3099	3038	2764
3130	2018-07-27	\N	103	\N	2018-07-27                      	5	пятница         	f	27	208	3100	3039	2765
3131	2018-07-28	\N	103	\N	2018-07-28                      	6	суббота         	t	28	209	3101	3040	2766
3133	2018-07-30	\N	103	\N	2018-07-30                      	1	понедельник     	f	30	211	3103	3042	2768
3134	2018-07-31	\N	103	\N	2018-07-31                      	2	вторник         	f	31	212	3103	3042	2769
3135	2018-08-01	\N	104	\N	2018-08-01                      	3	среда           	f	1	213	3104	3043	2770
3136	2018-08-02	\N	104	\N	2018-08-02                      	4	четверг         	f	2	214	3105	3044	2771
3137	2018-08-03	\N	104	\N	2018-08-03                      	5	пятница         	f	3	215	3106	3045	2772
3138	2018-08-04	\N	104	\N	2018-08-04                      	6	суббота         	t	4	216	3107	3046	2773
3140	2018-08-06	\N	104	\N	2018-08-06                      	1	понедельник     	f	6	218	3109	3048	2775
3141	2018-08-07	\N	104	\N	2018-08-07                      	2	вторник         	f	7	219	3110	3049	2776
3142	2018-08-08	\N	104	\N	2018-08-08                      	3	среда           	f	8	220	3111	3050	2777
3143	2018-08-09	\N	104	\N	2018-08-09                      	4	четверг         	f	9	221	3112	3051	2778
3144	2018-08-10	\N	104	\N	2018-08-10                      	5	пятница         	f	10	222	3113	3052	2779
3145	2018-08-11	\N	104	\N	2018-08-11                      	6	суббота         	t	11	223	3114	3053	2780
3147	2018-08-13	\N	104	\N	2018-08-13                      	1	понедельник     	f	13	225	3116	3055	2782
3148	2018-08-14	\N	104	\N	2018-08-14                      	2	вторник         	f	14	226	3117	3056	2783
3149	2018-08-15	\N	104	\N	2018-08-15                      	3	среда           	f	15	227	3118	3057	2784
3150	2018-08-16	\N	104	\N	2018-08-16                      	4	четверг         	f	16	228	3119	3058	2785
3151	2018-08-17	\N	104	\N	2018-08-17                      	5	пятница         	f	17	229	3120	3059	2786
3152	2018-08-18	\N	104	\N	2018-08-18                      	6	суббота         	t	18	230	3121	3060	2787
3154	2018-08-20	\N	104	\N	2018-08-20                      	1	понедельник     	f	20	232	3123	3062	2789
3155	2018-08-21	\N	104	\N	2018-08-21                      	2	вторник         	f	21	233	3124	3063	2790
3156	2018-08-22	\N	104	\N	2018-08-22                      	3	среда           	f	22	234	3125	3064	2791
3157	2018-08-23	\N	104	\N	2018-08-23                      	4	четверг         	f	23	235	3126	3065	2792
3158	2018-08-24	\N	104	\N	2018-08-24                      	5	пятница         	f	24	236	3127	3066	2793
3159	2018-08-25	\N	104	\N	2018-08-25                      	6	суббота         	t	25	237	3128	3067	2794
3161	2018-08-27	\N	104	\N	2018-08-27                      	1	понедельник     	f	27	239	3130	3069	2796
3162	2018-08-28	\N	104	\N	2018-08-28                      	2	вторник         	f	28	240	3131	3070	2797
3163	2018-08-29	\N	104	\N	2018-08-29                      	3	среда           	f	29	241	3132	3071	2798
3164	2018-08-30	\N	104	\N	2018-08-30                      	4	четверг         	f	30	242	3133	3072	2799
3165	2018-08-31	\N	104	\N	2018-08-31                      	5	пятница         	f	31	243	3134	3073	2800
3166	2018-09-01	\N	105	\N	2018-09-01                      	6	суббота         	t	1	244	3135	3074	2801
3168	2018-09-03	\N	105	\N	2018-09-03                      	1	понедельник     	f	3	246	3137	3076	2803
3169	2018-09-04	\N	105	\N	2018-09-04                      	2	вторник         	f	4	247	3138	3077	2804
3170	2018-09-05	\N	105	\N	2018-09-05                      	3	среда           	f	5	248	3139	3078	2805
3171	2018-09-06	\N	105	\N	2018-09-06                      	4	четверг         	f	6	249	3140	3079	2806
3172	2018-09-07	\N	105	\N	2018-09-07                      	5	пятница         	f	7	250	3141	3080	2807
3173	2018-09-08	\N	105	\N	2018-09-08                      	6	суббота         	t	8	251	3142	3081	2808
3175	2018-09-10	\N	105	\N	2018-09-10                      	1	понедельник     	f	10	253	3144	3083	2810
3176	2018-09-11	\N	105	\N	2018-09-11                      	2	вторник         	f	11	254	3145	3084	2811
3177	2018-09-12	\N	105	\N	2018-09-12                      	3	среда           	f	12	255	3146	3085	2812
3178	2018-09-13	\N	105	\N	2018-09-13                      	4	четверг         	f	13	256	3147	3086	2813
3179	2018-09-14	\N	105	\N	2018-09-14                      	5	пятница         	f	14	257	3148	3087	2814
3180	2018-09-15	\N	105	\N	2018-09-15                      	6	суббота         	t	15	258	3149	3088	2815
3182	2018-09-17	\N	105	\N	2018-09-17                      	1	понедельник     	f	17	260	3151	3090	2817
3183	2018-09-18	\N	105	\N	2018-09-18                      	2	вторник         	f	18	261	3152	3091	2818
3184	2018-09-19	\N	105	\N	2018-09-19                      	3	среда           	f	19	262	3153	3092	2819
3185	2018-09-20	\N	105	\N	2018-09-20                      	4	четверг         	f	20	263	3154	3093	2820
3186	2018-09-21	\N	105	\N	2018-09-21                      	5	пятница         	f	21	264	3155	3094	2821
3187	2018-09-22	\N	105	\N	2018-09-22                      	6	суббота         	t	22	265	3156	3095	2822
3189	2018-09-24	\N	105	\N	2018-09-24                      	1	понедельник     	f	24	267	3158	3097	2824
3190	2018-09-25	\N	105	\N	2018-09-25                      	2	вторник         	f	25	268	3159	3098	2825
3191	2018-09-26	\N	105	\N	2018-09-26                      	3	среда           	f	26	269	3160	3099	2826
3192	2018-09-27	\N	105	\N	2018-09-27                      	4	четверг         	f	27	270	3161	3100	2827
3193	2018-09-28	\N	105	\N	2018-09-28                      	5	пятница         	f	28	271	3162	3101	2828
3194	2018-09-29	\N	105	\N	2018-09-29                      	6	суббота         	t	29	272	3163	3102	2829
3196	2018-10-01	\N	106	\N	2018-10-01                      	1	понедельник     	f	1	274	3166	3104	2831
3197	2018-10-02	\N	106	\N	2018-10-02                      	2	вторник         	f	2	275	3167	3105	2832
3198	2018-10-03	\N	106	\N	2018-10-03                      	3	среда           	f	3	276	3168	3106	2833
3199	2018-10-04	\N	106	\N	2018-10-04                      	4	четверг         	f	4	277	3169	3107	2834
3200	2018-10-05	\N	106	\N	2018-10-05                      	5	пятница         	f	5	278	3170	3108	2835
3201	2018-10-06	\N	106	\N	2018-10-06                      	6	суббота         	t	6	279	3171	3109	2836
3203	2018-10-08	\N	106	\N	2018-10-08                      	1	понедельник     	f	8	281	3173	3111	2838
3204	2018-10-09	\N	106	\N	2018-10-09                      	2	вторник         	f	9	282	3174	3112	2839
3205	2018-10-10	\N	106	\N	2018-10-10                      	3	среда           	f	10	283	3175	3113	2840
3206	2018-10-11	\N	106	\N	2018-10-11                      	4	четверг         	f	11	284	3176	3114	2841
3207	2018-10-12	\N	106	\N	2018-10-12                      	5	пятница         	f	12	285	3177	3115	2842
3208	2018-10-13	\N	106	\N	2018-10-13                      	6	суббота         	t	13	286	3178	3116	2843
3210	2018-10-15	\N	106	\N	2018-10-15                      	1	понедельник     	f	15	288	3180	3118	2845
3211	2018-10-16	\N	106	\N	2018-10-16                      	2	вторник         	f	16	289	3181	3119	2846
3212	2018-10-17	\N	106	\N	2018-10-17                      	3	среда           	f	17	290	3182	3120	2847
3213	2018-10-18	\N	106	\N	2018-10-18                      	4	четверг         	f	18	291	3183	3121	2848
3214	2018-10-19	\N	106	\N	2018-10-19                      	5	пятница         	f	19	292	3184	3122	2849
3215	2018-10-20	\N	106	\N	2018-10-20                      	6	суббота         	t	20	293	3185	3123	2850
3217	2018-10-22	\N	106	\N	2018-10-22                      	1	понедельник     	f	22	295	3187	3125	2852
3218	2018-10-23	\N	106	\N	2018-10-23                      	2	вторник         	f	23	296	3188	3126	2853
3219	2018-10-24	\N	106	\N	2018-10-24                      	3	среда           	f	24	297	3189	3127	2854
3220	2018-10-25	\N	106	\N	2018-10-25                      	4	четверг         	f	25	298	3190	3128	2855
3221	2018-10-26	\N	106	\N	2018-10-26                      	5	пятница         	f	26	299	3191	3129	2856
3222	2018-10-27	\N	106	\N	2018-10-27                      	6	суббота         	t	27	300	3192	3130	2857
3224	2018-10-29	\N	106	\N	2018-10-29                      	1	понедельник     	f	29	302	3194	3132	2859
3225	2018-10-30	\N	106	\N	2018-10-30                      	2	вторник         	f	30	303	3195	3133	2860
3226	2018-10-31	\N	106	\N	2018-10-31                      	3	среда           	f	31	304	3195	3134	2861
3227	2018-11-01	\N	107	\N	2018-11-01                      	4	четверг         	f	1	305	3196	3135	2862
3228	2018-11-02	\N	107	\N	2018-11-02                      	5	пятница         	f	2	306	3197	3136	2863
3229	2018-11-03	\N	107	\N	2018-11-03                      	6	суббота         	t	3	307	3198	3137	2864
3231	2018-11-05	\N	107	\N	2018-11-05                      	1	понедельник     	f	5	309	3200	3139	2866
3232	2018-11-06	\N	107	\N	2018-11-06                      	2	вторник         	f	6	310	3201	3140	2867
3233	2018-11-07	\N	107	\N	2018-11-07                      	3	среда           	f	7	311	3202	3141	2868
3234	2018-11-08	\N	107	\N	2018-11-08                      	4	четверг         	f	8	312	3203	3142	2869
3235	2018-11-09	\N	107	\N	2018-11-09                      	5	пятница         	f	9	313	3204	3143	2870
3236	2018-11-10	\N	107	\N	2018-11-10                      	6	суббота         	t	10	314	3205	3144	2871
3238	2018-11-12	\N	107	\N	2018-11-12                      	1	понедельник     	f	12	316	3207	3146	2873
3239	2018-11-13	\N	107	\N	2018-11-13                      	2	вторник         	f	13	317	3208	3147	2874
3240	2018-11-14	\N	107	\N	2018-11-14                      	3	среда           	f	14	318	3209	3148	2875
3241	2018-11-15	\N	107	\N	2018-11-15                      	4	четверг         	f	15	319	3210	3149	2876
3242	2018-11-16	\N	107	\N	2018-11-16                      	5	пятница         	f	16	320	3211	3150	2877
3243	2018-11-17	\N	107	\N	2018-11-17                      	6	суббота         	t	17	321	3212	3151	2878
3245	2018-11-19	\N	107	\N	2018-11-19                      	1	понедельник     	f	19	323	3214	3153	2880
3246	2018-11-20	\N	107	\N	2018-11-20                      	2	вторник         	f	20	324	3215	3154	2881
3247	2018-11-21	\N	107	\N	2018-11-21                      	3	среда           	f	21	325	3216	3155	2882
3248	2018-11-22	\N	107	\N	2018-11-22                      	4	четверг         	f	22	326	3217	3156	2883
3249	2018-11-23	\N	107	\N	2018-11-23                      	5	пятница         	f	23	327	3218	3157	2884
3250	2018-11-24	\N	107	\N	2018-11-24                      	6	суббота         	t	24	328	3219	3158	2885
3252	2018-11-26	\N	107	\N	2018-11-26                      	1	понедельник     	f	26	330	3221	3160	2887
3253	2018-11-27	\N	107	\N	2018-11-27                      	2	вторник         	f	27	331	3222	3161	2888
3254	2018-11-28	\N	107	\N	2018-11-28                      	3	среда           	f	28	332	3223	3162	2889
3255	2018-11-29	\N	107	\N	2018-11-29                      	4	четверг         	f	29	333	3224	3163	2890
3256	2018-11-30	\N	107	\N	2018-11-30                      	5	пятница         	f	30	334	3225	3164	2891
3257	2018-12-01	\N	108	\N	2018-12-01                      	6	суббота         	t	1	335	3227	3166	2892
3259	2018-12-03	\N	108	\N	2018-12-03                      	1	понедельник     	f	3	337	3229	3168	2894
3260	2018-12-04	\N	108	\N	2018-12-04                      	2	вторник         	f	4	338	3230	3169	2895
3261	2018-12-05	\N	108	\N	2018-12-05                      	3	среда           	f	5	339	3231	3170	2896
3262	2018-12-06	\N	108	\N	2018-12-06                      	4	четверг         	f	6	340	3232	3171	2897
3263	2018-12-07	\N	108	\N	2018-12-07                      	5	пятница         	f	7	341	3233	3172	2898
3264	2018-12-08	\N	108	\N	2018-12-08                      	6	суббота         	t	8	342	3234	3173	2899
3266	2018-12-10	\N	108	\N	2018-12-10                      	1	понедельник     	f	10	344	3236	3175	2901
3267	2018-12-11	\N	108	\N	2018-12-11                      	2	вторник         	f	11	345	3237	3176	2902
3268	2018-12-12	\N	108	\N	2018-12-12                      	3	среда           	f	12	346	3238	3177	2903
3269	2018-12-13	\N	108	\N	2018-12-13                      	4	четверг         	f	13	347	3239	3178	2904
3270	2018-12-14	\N	108	\N	2018-12-14                      	5	пятница         	f	14	348	3240	3179	2905
3271	2018-12-15	\N	108	\N	2018-12-15                      	6	суббота         	t	15	349	3241	3180	2906
3273	2018-12-17	\N	108	\N	2018-12-17                      	1	понедельник     	f	17	351	3243	3182	2908
3274	2018-12-18	\N	108	\N	2018-12-18                      	2	вторник         	f	18	352	3244	3183	2909
3275	2018-12-19	\N	108	\N	2018-12-19                      	3	среда           	f	19	353	3245	3184	2910
3276	2018-12-20	\N	108	\N	2018-12-20                      	4	четверг         	f	20	354	3246	3185	2911
3277	2018-12-21	\N	108	\N	2018-12-21                      	5	пятница         	f	21	355	3247	3186	2912
3278	2018-12-22	\N	108	\N	2018-12-22                      	6	суббота         	t	22	356	3248	3187	2913
3280	2018-12-24	\N	108	\N	2018-12-24                      	1	понедельник     	f	24	358	3250	3189	2915
3281	2018-12-25	\N	108	\N	2018-12-25                      	2	вторник         	f	25	359	3251	3190	2916
3282	2018-12-26	\N	108	\N	2018-12-26                      	3	среда           	f	26	360	3252	3191	2917
3283	2018-12-27	\N	108	\N	2018-12-27                      	4	четверг         	f	27	361	3253	3192	2918
3284	2018-12-28	\N	108	\N	2018-12-28                      	5	пятница         	f	28	362	3254	3193	2919
3285	2018-12-29	\N	108	\N	2018-12-29                      	6	суббота         	t	29	363	3255	3194	2920
3287	2018-12-31	\N	108	\N	2018-12-31                      	1	понедельник     	f	31	365	3256	3195	2922
3288	2019-01-01	\N	109	\N	2019-01-01                      	2	вторник         	f	1	1	3257	3196	2923
3289	2019-01-02	\N	109	\N	2019-01-02                      	3	среда           	f	2	2	3258	3197	2924
3290	2019-01-03	\N	109	\N	2019-01-03                      	4	четверг         	f	3	3	3259	3198	2925
3291	2019-01-04	\N	109	\N	2019-01-04                      	5	пятница         	f	4	4	3260	3199	2926
3292	2019-01-05	\N	109	\N	2019-01-05                      	6	суббота         	t	5	5	3261	3200	2927
3294	2019-01-07	\N	109	\N	2019-01-07                      	1	понедельник     	f	7	7	3263	3202	2929
3295	2019-01-08	\N	109	\N	2019-01-08                      	2	вторник         	f	8	8	3264	3203	2930
3296	2019-01-09	\N	109	\N	2019-01-09                      	3	среда           	f	9	9	3265	3204	2931
3297	2019-01-10	\N	109	\N	2019-01-10                      	4	четверг         	f	10	10	3266	3205	2932
3298	2019-01-11	\N	109	\N	2019-01-11                      	5	пятница         	f	11	11	3267	3206	2933
3299	2019-01-12	\N	109	\N	2019-01-12                      	6	суббота         	t	12	12	3268	3207	2934
3301	2019-01-14	\N	109	\N	2019-01-14                      	1	понедельник     	f	14	14	3270	3209	2936
3302	2019-01-15	\N	109	\N	2019-01-15                      	2	вторник         	f	15	15	3271	3210	2937
3303	2019-01-16	\N	109	\N	2019-01-16                      	3	среда           	f	16	16	3272	3211	2938
3304	2019-01-17	\N	109	\N	2019-01-17                      	4	четверг         	f	17	17	3273	3212	2939
3305	2019-01-18	\N	109	\N	2019-01-18                      	5	пятница         	f	18	18	3274	3213	2940
3306	2019-01-19	\N	109	\N	2019-01-19                      	6	суббота         	t	19	19	3275	3214	2941
3308	2019-01-21	\N	109	\N	2019-01-21                      	1	понедельник     	f	21	21	3277	3216	2943
3309	2019-01-22	\N	109	\N	2019-01-22                      	2	вторник         	f	22	22	3278	3217	2944
3310	2019-01-23	\N	109	\N	2019-01-23                      	3	среда           	f	23	23	3279	3218	2945
3311	2019-01-24	\N	109	\N	2019-01-24                      	4	четверг         	f	24	24	3280	3219	2946
3312	2019-01-25	\N	109	\N	2019-01-25                      	5	пятница         	f	25	25	3281	3220	2947
3313	2019-01-26	\N	109	\N	2019-01-26                      	6	суббота         	t	26	26	3282	3221	2948
3315	2019-01-28	\N	109	\N	2019-01-28                      	1	понедельник     	f	28	28	3284	3223	2950
3316	2019-01-29	\N	109	\N	2019-01-29                      	2	вторник         	f	29	29	3285	3224	2951
3317	2019-01-30	\N	109	\N	2019-01-30                      	3	среда           	f	30	30	3286	3225	2952
3318	2019-01-31	\N	109	\N	2019-01-31                      	4	четверг         	f	31	31	3287	3226	2953
3319	2019-02-01	\N	110	\N	2019-02-01                      	5	пятница         	f	1	32	3288	3227	2954
3320	2019-02-02	\N	110	\N	2019-02-02                      	6	суббота         	t	2	33	3289	3228	2955
3322	2019-02-04	\N	110	\N	2019-02-04                      	1	понедельник     	f	4	35	3291	3230	2957
3323	2019-02-05	\N	110	\N	2019-02-05                      	2	вторник         	f	5	36	3292	3231	2958
3324	2019-02-06	\N	110	\N	2019-02-06                      	3	среда           	f	6	37	3293	3232	2959
3325	2019-02-07	\N	110	\N	2019-02-07                      	4	четверг         	f	7	38	3294	3233	2960
3326	2019-02-08	\N	110	\N	2019-02-08                      	5	пятница         	f	8	39	3295	3234	2961
3327	2019-02-09	\N	110	\N	2019-02-09                      	6	суббота         	t	9	40	3296	3235	2962
3329	2019-02-11	\N	110	\N	2019-02-11                      	1	понедельник     	f	11	42	3298	3237	2964
3330	2019-02-12	\N	110	\N	2019-02-12                      	2	вторник         	f	12	43	3299	3238	2965
3331	2019-02-13	\N	110	\N	2019-02-13                      	3	среда           	f	13	44	3300	3239	2966
3332	2019-02-14	\N	110	\N	2019-02-14                      	4	четверг         	f	14	45	3301	3240	2967
3333	2019-02-15	\N	110	\N	2019-02-15                      	5	пятница         	f	15	46	3302	3241	2968
3334	2019-02-16	\N	110	\N	2019-02-16                      	6	суббота         	t	16	47	3303	3242	2969
3336	2019-02-18	\N	110	\N	2019-02-18                      	1	понедельник     	f	18	49	3305	3244	2971
3337	2019-02-19	\N	110	\N	2019-02-19                      	2	вторник         	f	19	50	3306	3245	2972
3338	2019-02-20	\N	110	\N	2019-02-20                      	3	среда           	f	20	51	3307	3246	2973
3339	2019-02-21	\N	110	\N	2019-02-21                      	4	четверг         	f	21	52	3308	3247	2974
3340	2019-02-22	\N	110	\N	2019-02-22                      	5	пятница         	f	22	53	3309	3248	2975
3341	2019-02-23	\N	110	\N	2019-02-23                      	6	суббота         	t	23	54	3310	3249	2976
3343	2019-02-25	\N	110	\N	2019-02-25                      	1	понедельник     	f	25	56	3312	3251	2978
3344	2019-02-26	\N	110	\N	2019-02-26                      	2	вторник         	f	26	57	3313	3252	2979
3345	2019-02-27	\N	110	\N	2019-02-27                      	3	среда           	f	27	58	3314	3253	2980
3346	2019-02-28	\N	110	\N	2019-02-28                      	4	четверг         	f	28	59	3315	3254	2981
3347	2019-03-01	\N	111	\N	2019-03-01                      	5	пятница         	f	1	60	3319	3257	2982
3348	2019-03-02	\N	111	\N	2019-03-02                      	6	суббота         	t	2	61	3320	3258	2983
3350	2019-03-04	\N	111	\N	2019-03-04                      	1	понедельник     	f	4	63	3322	3260	2985
3351	2019-03-05	\N	111	\N	2019-03-05                      	2	вторник         	f	5	64	3323	3261	2986
3352	2019-03-06	\N	111	\N	2019-03-06                      	3	среда           	f	6	65	3324	3262	2987
3353	2019-03-07	\N	111	\N	2019-03-07                      	4	четверг         	f	7	66	3325	3263	2988
3354	2019-03-08	\N	111	\N	2019-03-08                      	5	пятница         	f	8	67	3326	3264	2989
3355	2019-03-09	\N	111	\N	2019-03-09                      	6	суббота         	t	9	68	3327	3265	2990
3357	2019-03-11	\N	111	\N	2019-03-11                      	1	понедельник     	f	11	70	3329	3267	2992
3358	2019-03-12	\N	111	\N	2019-03-12                      	2	вторник         	f	12	71	3330	3268	2993
3359	2019-03-13	\N	111	\N	2019-03-13                      	3	среда           	f	13	72	3331	3269	2994
3360	2019-03-14	\N	111	\N	2019-03-14                      	4	четверг         	f	14	73	3332	3270	2995
3361	2019-03-15	\N	111	\N	2019-03-15                      	5	пятница         	f	15	74	3333	3271	2996
3362	2019-03-16	\N	111	\N	2019-03-16                      	6	суббота         	t	16	75	3334	3272	2997
3364	2019-03-18	\N	111	\N	2019-03-18                      	1	понедельник     	f	18	77	3336	3274	2999
3365	2019-03-19	\N	111	\N	2019-03-19                      	2	вторник         	f	19	78	3337	3275	3000
3366	2019-03-20	\N	111	\N	2019-03-20                      	3	среда           	f	20	79	3338	3276	3001
3367	2019-03-21	\N	111	\N	2019-03-21                      	4	четверг         	f	21	80	3339	3277	3002
3368	2019-03-22	\N	111	\N	2019-03-22                      	5	пятница         	f	22	81	3340	3278	3003
3369	2019-03-23	\N	111	\N	2019-03-23                      	6	суббота         	t	23	82	3341	3279	3004
3371	2019-03-25	\N	111	\N	2019-03-25                      	1	понедельник     	f	25	84	3343	3281	3006
3372	2019-03-26	\N	111	\N	2019-03-26                      	2	вторник         	f	26	85	3344	3282	3007
3373	2019-03-27	\N	111	\N	2019-03-27                      	3	среда           	f	27	86	3345	3283	3008
3374	2019-03-28	\N	111	\N	2019-03-28                      	4	четверг         	f	28	87	3346	3284	3009
3375	2019-03-29	\N	111	\N	2019-03-29                      	5	пятница         	f	29	88	3346	3285	3010
3376	2019-03-30	\N	111	\N	2019-03-30                      	6	суббота         	t	30	89	3346	3286	3011
3378	2019-04-01	\N	112	\N	2019-04-01                      	1	понедельник     	f	1	91	3347	3288	3013
3379	2019-04-02	\N	112	\N	2019-04-02                      	2	вторник         	f	2	92	3348	3289	3014
3380	2019-04-03	\N	112	\N	2019-04-03                      	3	среда           	f	3	93	3349	3290	3015
3381	2019-04-04	\N	112	\N	2019-04-04                      	4	четверг         	f	4	94	3350	3291	3016
3382	2019-04-05	\N	112	\N	2019-04-05                      	5	пятница         	f	5	95	3351	3292	3017
3383	2019-04-06	\N	112	\N	2019-04-06                      	6	суббота         	t	6	96	3352	3293	3018
3385	2019-04-08	\N	112	\N	2019-04-08                      	1	понедельник     	f	8	98	3354	3295	3020
3386	2019-04-09	\N	112	\N	2019-04-09                      	2	вторник         	f	9	99	3355	3296	3021
3387	2019-04-10	\N	112	\N	2019-04-10                      	3	среда           	f	10	100	3356	3297	3022
3388	2019-04-11	\N	112	\N	2019-04-11                      	4	четверг         	f	11	101	3357	3298	3023
3389	2019-04-12	\N	112	\N	2019-04-12                      	5	пятница         	f	12	102	3358	3299	3024
3390	2019-04-13	\N	112	\N	2019-04-13                      	6	суббота         	t	13	103	3359	3300	3025
3392	2019-04-15	\N	112	\N	2019-04-15                      	1	понедельник     	f	15	105	3361	3302	3027
3393	2019-04-16	\N	112	\N	2019-04-16                      	2	вторник         	f	16	106	3362	3303	3028
3394	2019-04-17	\N	112	\N	2019-04-17                      	3	среда           	f	17	107	3363	3304	3029
3395	2019-04-18	\N	112	\N	2019-04-18                      	4	четверг         	f	18	108	3364	3305	3030
3396	2019-04-19	\N	112	\N	2019-04-19                      	5	пятница         	f	19	109	3365	3306	3031
3397	2019-04-20	\N	112	\N	2019-04-20                      	6	суббота         	t	20	110	3366	3307	3032
3399	2019-04-22	\N	112	\N	2019-04-22                      	1	понедельник     	f	22	112	3368	3309	3034
3400	2019-04-23	\N	112	\N	2019-04-23                      	2	вторник         	f	23	113	3369	3310	3035
3401	2019-04-24	\N	112	\N	2019-04-24                      	3	среда           	f	24	114	3370	3311	3036
3402	2019-04-25	\N	112	\N	2019-04-25                      	4	четверг         	f	25	115	3371	3312	3037
3403	2019-04-26	\N	112	\N	2019-04-26                      	5	пятница         	f	26	116	3372	3313	3038
3404	2019-04-27	\N	112	\N	2019-04-27                      	6	суббота         	t	27	117	3373	3314	3039
3406	2019-04-29	\N	112	\N	2019-04-29                      	1	понедельник     	f	29	119	3375	3316	3041
3407	2019-04-30	\N	112	\N	2019-04-30                      	2	вторник         	f	30	120	3376	3317	3042
3408	2019-05-01	\N	113	\N	2019-05-01                      	3	среда           	f	1	121	3378	3319	3043
3409	2019-05-02	\N	113	\N	2019-05-02                      	4	четверг         	f	2	122	3379	3320	3044
3410	2019-05-03	\N	113	\N	2019-05-03                      	5	пятница         	f	3	123	3380	3321	3045
3411	2019-05-04	\N	113	\N	2019-05-04                      	6	суббота         	t	4	124	3381	3322	3046
3413	2019-05-06	\N	113	\N	2019-05-06                      	1	понедельник     	f	6	126	3383	3324	3048
3414	2019-05-07	\N	113	\N	2019-05-07                      	2	вторник         	f	7	127	3384	3325	3049
3415	2019-05-08	\N	113	\N	2019-05-08                      	3	среда           	f	8	128	3385	3326	3050
3416	2019-05-09	\N	113	\N	2019-05-09                      	4	четверг         	f	9	129	3386	3327	3051
3417	2019-05-10	\N	113	\N	2019-05-10                      	5	пятница         	f	10	130	3387	3328	3052
3418	2019-05-11	\N	113	\N	2019-05-11                      	6	суббота         	t	11	131	3388	3329	3053
3420	2019-05-13	\N	113	\N	2019-05-13                      	1	понедельник     	f	13	133	3390	3331	3055
3421	2019-05-14	\N	113	\N	2019-05-14                      	2	вторник         	f	14	134	3391	3332	3056
3422	2019-05-15	\N	113	\N	2019-05-15                      	3	среда           	f	15	135	3392	3333	3057
3423	2019-05-16	\N	113	\N	2019-05-16                      	4	четверг         	f	16	136	3393	3334	3058
3424	2019-05-17	\N	113	\N	2019-05-17                      	5	пятница         	f	17	137	3394	3335	3059
3425	2019-05-18	\N	113	\N	2019-05-18                      	6	суббота         	t	18	138	3395	3336	3060
3427	2019-05-20	\N	113	\N	2019-05-20                      	1	понедельник     	f	20	140	3397	3338	3062
3428	2019-05-21	\N	113	\N	2019-05-21                      	2	вторник         	f	21	141	3398	3339	3063
3429	2019-05-22	\N	113	\N	2019-05-22                      	3	среда           	f	22	142	3399	3340	3064
3430	2019-05-23	\N	113	\N	2019-05-23                      	4	четверг         	f	23	143	3400	3341	3065
3431	2019-05-24	\N	113	\N	2019-05-24                      	5	пятница         	f	24	144	3401	3342	3066
3432	2019-05-25	\N	113	\N	2019-05-25                      	6	суббота         	t	25	145	3402	3343	3067
3434	2019-05-27	\N	113	\N	2019-05-27                      	1	понедельник     	f	27	147	3404	3345	3069
3435	2019-05-28	\N	113	\N	2019-05-28                      	2	вторник         	f	28	148	3405	3346	3070
3436	2019-05-29	\N	113	\N	2019-05-29                      	3	среда           	f	29	149	3406	3346	3071
3437	2019-05-30	\N	113	\N	2019-05-30                      	4	четверг         	f	30	150	3407	3346	3072
3438	2019-05-31	\N	113	\N	2019-05-31                      	5	пятница         	f	31	151	3407	3346	3073
3439	2019-06-01	\N	114	\N	2019-06-01                      	6	суббота         	t	1	152	3408	3347	3074
3441	2019-06-03	\N	114	\N	2019-06-03                      	1	понедельник     	f	3	154	3410	3349	3076
3442	2019-06-04	\N	114	\N	2019-06-04                      	2	вторник         	f	4	155	3411	3350	3077
3443	2019-06-05	\N	114	\N	2019-06-05                      	3	среда           	f	5	156	3412	3351	3078
3444	2019-06-06	\N	114	\N	2019-06-06                      	4	четверг         	f	6	157	3413	3352	3079
3445	2019-06-07	\N	114	\N	2019-06-07                      	5	пятница         	f	7	158	3414	3353	3080
3446	2019-06-08	\N	114	\N	2019-06-08                      	6	суббота         	t	8	159	3415	3354	3081
3448	2019-06-10	\N	114	\N	2019-06-10                      	1	понедельник     	f	10	161	3417	3356	3083
3449	2019-06-11	\N	114	\N	2019-06-11                      	2	вторник         	f	11	162	3418	3357	3084
3450	2019-06-12	\N	114	\N	2019-06-12                      	3	среда           	f	12	163	3419	3358	3085
3451	2019-06-13	\N	114	\N	2019-06-13                      	4	четверг         	f	13	164	3420	3359	3086
3452	2019-06-14	\N	114	\N	2019-06-14                      	5	пятница         	f	14	165	3421	3360	3087
3453	2019-06-15	\N	114	\N	2019-06-15                      	6	суббота         	t	15	166	3422	3361	3088
3455	2019-06-17	\N	114	\N	2019-06-17                      	1	понедельник     	f	17	168	3424	3363	3090
3456	2019-06-18	\N	114	\N	2019-06-18                      	2	вторник         	f	18	169	3425	3364	3091
3457	2019-06-19	\N	114	\N	2019-06-19                      	3	среда           	f	19	170	3426	3365	3092
3458	2019-06-20	\N	114	\N	2019-06-20                      	4	четверг         	f	20	171	3427	3366	3093
3459	2019-06-21	\N	114	\N	2019-06-21                      	5	пятница         	f	21	172	3428	3367	3094
3460	2019-06-22	\N	114	\N	2019-06-22                      	6	суббота         	t	22	173	3429	3368	3095
3462	2019-06-24	\N	114	\N	2019-06-24                      	1	понедельник     	f	24	175	3431	3370	3097
3463	2019-06-25	\N	114	\N	2019-06-25                      	2	вторник         	f	25	176	3432	3371	3098
3464	2019-06-26	\N	114	\N	2019-06-26                      	3	среда           	f	26	177	3433	3372	3099
3465	2019-06-27	\N	114	\N	2019-06-27                      	4	четверг         	f	27	178	3434	3373	3100
3466	2019-06-28	\N	114	\N	2019-06-28                      	5	пятница         	f	28	179	3435	3374	3101
3467	2019-06-29	\N	114	\N	2019-06-29                      	6	суббота         	t	29	180	3436	3375	3102
3469	2019-07-01	\N	115	\N	2019-07-01                      	1	понедельник     	f	1	182	3439	3378	3104
3470	2019-07-02	\N	115	\N	2019-07-02                      	2	вторник         	f	2	183	3440	3379	3105
3471	2019-07-03	\N	115	\N	2019-07-03                      	3	среда           	f	3	184	3441	3380	3106
3472	2019-07-04	\N	115	\N	2019-07-04                      	4	четверг         	f	4	185	3442	3381	3107
3473	2019-07-05	\N	115	\N	2019-07-05                      	5	пятница         	f	5	186	3443	3382	3108
3474	2019-07-06	\N	115	\N	2019-07-06                      	6	суббота         	t	6	187	3444	3383	3109
3476	2019-07-08	\N	115	\N	2019-07-08                      	1	понедельник     	f	8	189	3446	3385	3111
3477	2019-07-09	\N	115	\N	2019-07-09                      	2	вторник         	f	9	190	3447	3386	3112
3478	2019-07-10	\N	115	\N	2019-07-10                      	3	среда           	f	10	191	3448	3387	3113
3479	2019-07-11	\N	115	\N	2019-07-11                      	4	четверг         	f	11	192	3449	3388	3114
3480	2019-07-12	\N	115	\N	2019-07-12                      	5	пятница         	f	12	193	3450	3389	3115
3481	2019-07-13	\N	115	\N	2019-07-13                      	6	суббота         	t	13	194	3451	3390	3116
3483	2019-07-15	\N	115	\N	2019-07-15                      	1	понедельник     	f	15	196	3453	3392	3118
3484	2019-07-16	\N	115	\N	2019-07-16                      	2	вторник         	f	16	197	3454	3393	3119
3485	2019-07-17	\N	115	\N	2019-07-17                      	3	среда           	f	17	198	3455	3394	3120
3486	2019-07-18	\N	115	\N	2019-07-18                      	4	четверг         	f	18	199	3456	3395	3121
3487	2019-07-19	\N	115	\N	2019-07-19                      	5	пятница         	f	19	200	3457	3396	3122
3488	2019-07-20	\N	115	\N	2019-07-20                      	6	суббота         	t	20	201	3458	3397	3123
3490	2019-07-22	\N	115	\N	2019-07-22                      	1	понедельник     	f	22	203	3460	3399	3125
3491	2019-07-23	\N	115	\N	2019-07-23                      	2	вторник         	f	23	204	3461	3400	3126
3492	2019-07-24	\N	115	\N	2019-07-24                      	3	среда           	f	24	205	3462	3401	3127
3493	2019-07-25	\N	115	\N	2019-07-25                      	4	четверг         	f	25	206	3463	3402	3128
3494	2019-07-26	\N	115	\N	2019-07-26                      	5	пятница         	f	26	207	3464	3403	3129
3495	2019-07-27	\N	115	\N	2019-07-27                      	6	суббота         	t	27	208	3465	3404	3130
3497	2019-07-29	\N	115	\N	2019-07-29                      	1	понедельник     	f	29	210	3467	3406	3132
3498	2019-07-30	\N	115	\N	2019-07-30                      	2	вторник         	f	30	211	3468	3407	3133
3499	2019-07-31	\N	115	\N	2019-07-31                      	3	среда           	f	31	212	3468	3407	3134
3500	2019-08-01	\N	116	\N	2019-08-01                      	4	четверг         	f	1	213	3469	3408	3135
3501	2019-08-02	\N	116	\N	2019-08-02                      	5	пятница         	f	2	214	3470	3409	3136
3502	2019-08-03	\N	116	\N	2019-08-03                      	6	суббота         	t	3	215	3471	3410	3137
3504	2019-08-05	\N	116	\N	2019-08-05                      	1	понедельник     	f	5	217	3473	3412	3139
3505	2019-08-06	\N	116	\N	2019-08-06                      	2	вторник         	f	6	218	3474	3413	3140
3506	2019-08-07	\N	116	\N	2019-08-07                      	3	среда           	f	7	219	3475	3414	3141
3507	2019-08-08	\N	116	\N	2019-08-08                      	4	четверг         	f	8	220	3476	3415	3142
3508	2019-08-09	\N	116	\N	2019-08-09                      	5	пятница         	f	9	221	3477	3416	3143
3509	2019-08-10	\N	116	\N	2019-08-10                      	6	суббота         	t	10	222	3478	3417	3144
3511	2019-08-12	\N	116	\N	2019-08-12                      	1	понедельник     	f	12	224	3480	3419	3146
3512	2019-08-13	\N	116	\N	2019-08-13                      	2	вторник         	f	13	225	3481	3420	3147
3513	2019-08-14	\N	116	\N	2019-08-14                      	3	среда           	f	14	226	3482	3421	3148
3514	2019-08-15	\N	116	\N	2019-08-15                      	4	четверг         	f	15	227	3483	3422	3149
3515	2019-08-16	\N	116	\N	2019-08-16                      	5	пятница         	f	16	228	3484	3423	3150
3516	2019-08-17	\N	116	\N	2019-08-17                      	6	суббота         	t	17	229	3485	3424	3151
3518	2019-08-19	\N	116	\N	2019-08-19                      	1	понедельник     	f	19	231	3487	3426	3153
3519	2019-08-20	\N	116	\N	2019-08-20                      	2	вторник         	f	20	232	3488	3427	3154
3520	2019-08-21	\N	116	\N	2019-08-21                      	3	среда           	f	21	233	3489	3428	3155
3521	2019-08-22	\N	116	\N	2019-08-22                      	4	четверг         	f	22	234	3490	3429	3156
3522	2019-08-23	\N	116	\N	2019-08-23                      	5	пятница         	f	23	235	3491	3430	3157
3523	2019-08-24	\N	116	\N	2019-08-24                      	6	суббота         	t	24	236	3492	3431	3158
3525	2019-08-26	\N	116	\N	2019-08-26                      	1	понедельник     	f	26	238	3494	3433	3160
3526	2019-08-27	\N	116	\N	2019-08-27                      	2	вторник         	f	27	239	3495	3434	3161
3527	2019-08-28	\N	116	\N	2019-08-28                      	3	среда           	f	28	240	3496	3435	3162
3528	2019-08-29	\N	116	\N	2019-08-29                      	4	четверг         	f	29	241	3497	3436	3163
3529	2019-08-30	\N	116	\N	2019-08-30                      	5	пятница         	f	30	242	3498	3437	3164
3530	2019-08-31	\N	116	\N	2019-08-31                      	6	суббота         	t	31	243	3499	3438	3165
3532	2019-09-02	\N	117	\N	2019-09-02                      	1	понедельник     	f	2	245	3501	3440	3167
3533	2019-09-03	\N	117	\N	2019-09-03                      	2	вторник         	f	3	246	3502	3441	3168
3534	2019-09-04	\N	117	\N	2019-09-04                      	3	среда           	f	4	247	3503	3442	3169
3535	2019-09-05	\N	117	\N	2019-09-05                      	4	четверг         	f	5	248	3504	3443	3170
3536	2019-09-06	\N	117	\N	2019-09-06                      	5	пятница         	f	6	249	3505	3444	3171
3537	2019-09-07	\N	117	\N	2019-09-07                      	6	суббота         	t	7	250	3506	3445	3172
3539	2019-09-09	\N	117	\N	2019-09-09                      	1	понедельник     	f	9	252	3508	3447	3174
3540	2019-09-10	\N	117	\N	2019-09-10                      	2	вторник         	f	10	253	3509	3448	3175
3541	2019-09-11	\N	117	\N	2019-09-11                      	3	среда           	f	11	254	3510	3449	3176
3542	2019-09-12	\N	117	\N	2019-09-12                      	4	четверг         	f	12	255	3511	3450	3177
3543	2019-09-13	\N	117	\N	2019-09-13                      	5	пятница         	f	13	256	3512	3451	3178
3544	2019-09-14	\N	117	\N	2019-09-14                      	6	суббота         	t	14	257	3513	3452	3179
3546	2019-09-16	\N	117	\N	2019-09-16                      	1	понедельник     	f	16	259	3515	3454	3181
3547	2019-09-17	\N	117	\N	2019-09-17                      	2	вторник         	f	17	260	3516	3455	3182
3548	2019-09-18	\N	117	\N	2019-09-18                      	3	среда           	f	18	261	3517	3456	3183
3549	2019-09-19	\N	117	\N	2019-09-19                      	4	четверг         	f	19	262	3518	3457	3184
3550	2019-09-20	\N	117	\N	2019-09-20                      	5	пятница         	f	20	263	3519	3458	3185
3551	2019-09-21	\N	117	\N	2019-09-21                      	6	суббота         	t	21	264	3520	3459	3186
3553	2019-09-23	\N	117	\N	2019-09-23                      	1	понедельник     	f	23	266	3522	3461	3188
3554	2019-09-24	\N	117	\N	2019-09-24                      	2	вторник         	f	24	267	3523	3462	3189
3555	2019-09-25	\N	117	\N	2019-09-25                      	3	среда           	f	25	268	3524	3463	3190
3556	2019-09-26	\N	117	\N	2019-09-26                      	4	четверг         	f	26	269	3525	3464	3191
3557	2019-09-27	\N	117	\N	2019-09-27                      	5	пятница         	f	27	270	3526	3465	3192
3558	2019-09-28	\N	117	\N	2019-09-28                      	6	суббота         	t	28	271	3527	3466	3193
3560	2019-09-30	\N	117	\N	2019-09-30                      	1	понедельник     	f	30	273	3529	3468	3195
3561	2019-10-01	\N	118	\N	2019-10-01                      	2	вторник         	f	1	274	3531	3469	3196
3562	2019-10-02	\N	118	\N	2019-10-02                      	3	среда           	f	2	275	3532	3470	3197
3563	2019-10-03	\N	118	\N	2019-10-03                      	4	четверг         	f	3	276	3533	3471	3198
3564	2019-10-04	\N	118	\N	2019-10-04                      	5	пятница         	f	4	277	3534	3472	3199
3565	2019-10-05	\N	118	\N	2019-10-05                      	6	суббота         	t	5	278	3535	3473	3200
3567	2019-10-07	\N	118	\N	2019-10-07                      	1	понедельник     	f	7	280	3537	3475	3202
3568	2019-10-08	\N	118	\N	2019-10-08                      	2	вторник         	f	8	281	3538	3476	3203
3569	2019-10-09	\N	118	\N	2019-10-09                      	3	среда           	f	9	282	3539	3477	3204
3570	2019-10-10	\N	118	\N	2019-10-10                      	4	четверг         	f	10	283	3540	3478	3205
3571	2019-10-11	\N	118	\N	2019-10-11                      	5	пятница         	f	11	284	3541	3479	3206
3572	2019-10-12	\N	118	\N	2019-10-12                      	6	суббота         	t	12	285	3542	3480	3207
3574	2019-10-14	\N	118	\N	2019-10-14                      	1	понедельник     	f	14	287	3544	3482	3209
3575	2019-10-15	\N	118	\N	2019-10-15                      	2	вторник         	f	15	288	3545	3483	3210
3576	2019-10-16	\N	118	\N	2019-10-16                      	3	среда           	f	16	289	3546	3484	3211
3577	2019-10-17	\N	118	\N	2019-10-17                      	4	четверг         	f	17	290	3547	3485	3212
3578	2019-10-18	\N	118	\N	2019-10-18                      	5	пятница         	f	18	291	3548	3486	3213
3579	2019-10-19	\N	118	\N	2019-10-19                      	6	суббота         	t	19	292	3549	3487	3214
3581	2019-10-21	\N	118	\N	2019-10-21                      	1	понедельник     	f	21	294	3551	3489	3216
3582	2019-10-22	\N	118	\N	2019-10-22                      	2	вторник         	f	22	295	3552	3490	3217
3583	2019-10-23	\N	118	\N	2019-10-23                      	3	среда           	f	23	296	3553	3491	3218
3584	2019-10-24	\N	118	\N	2019-10-24                      	4	четверг         	f	24	297	3554	3492	3219
3585	2019-10-25	\N	118	\N	2019-10-25                      	5	пятница         	f	25	298	3555	3493	3220
3586	2019-10-26	\N	118	\N	2019-10-26                      	6	суббота         	t	26	299	3556	3494	3221
3588	2019-10-28	\N	118	\N	2019-10-28                      	1	понедельник     	f	28	301	3558	3496	3223
3589	2019-10-29	\N	118	\N	2019-10-29                      	2	вторник         	f	29	302	3559	3497	3224
3590	2019-10-30	\N	118	\N	2019-10-30                      	3	среда           	f	30	303	3560	3498	3225
3591	2019-10-31	\N	118	\N	2019-10-31                      	4	четверг         	f	31	304	3560	3499	3226
3592	2019-11-01	\N	119	\N	2019-11-01                      	5	пятница         	f	1	305	3561	3500	3227
3593	2019-11-02	\N	119	\N	2019-11-02                      	6	суббота         	t	2	306	3562	3501	3228
3595	2019-11-04	\N	119	\N	2019-11-04                      	1	понедельник     	f	4	308	3564	3503	3230
3596	2019-11-05	\N	119	\N	2019-11-05                      	2	вторник         	f	5	309	3565	3504	3231
3597	2019-11-06	\N	119	\N	2019-11-06                      	3	среда           	f	6	310	3566	3505	3232
3598	2019-11-07	\N	119	\N	2019-11-07                      	4	четверг         	f	7	311	3567	3506	3233
3599	2019-11-08	\N	119	\N	2019-11-08                      	5	пятница         	f	8	312	3568	3507	3234
3600	2019-11-09	\N	119	\N	2019-11-09                      	6	суббота         	t	9	313	3569	3508	3235
3602	2019-11-11	\N	119	\N	2019-11-11                      	1	понедельник     	f	11	315	3571	3510	3237
3603	2019-11-12	\N	119	\N	2019-11-12                      	2	вторник         	f	12	316	3572	3511	3238
3604	2019-11-13	\N	119	\N	2019-11-13                      	3	среда           	f	13	317	3573	3512	3239
3605	2019-11-14	\N	119	\N	2019-11-14                      	4	четверг         	f	14	318	3574	3513	3240
3606	2019-11-15	\N	119	\N	2019-11-15                      	5	пятница         	f	15	319	3575	3514	3241
3607	2019-11-16	\N	119	\N	2019-11-16                      	6	суббота         	t	16	320	3576	3515	3242
3609	2019-11-18	\N	119	\N	2019-11-18                      	1	понедельник     	f	18	322	3578	3517	3244
3610	2019-11-19	\N	119	\N	2019-11-19                      	2	вторник         	f	19	323	3579	3518	3245
3611	2019-11-20	\N	119	\N	2019-11-20                      	3	среда           	f	20	324	3580	3519	3246
3612	2019-11-21	\N	119	\N	2019-11-21                      	4	четверг         	f	21	325	3581	3520	3247
3613	2019-11-22	\N	119	\N	2019-11-22                      	5	пятница         	f	22	326	3582	3521	3248
3614	2019-11-23	\N	119	\N	2019-11-23                      	6	суббота         	t	23	327	3583	3522	3249
3616	2019-11-25	\N	119	\N	2019-11-25                      	1	понедельник     	f	25	329	3585	3524	3251
3617	2019-11-26	\N	119	\N	2019-11-26                      	2	вторник         	f	26	330	3586	3525	3252
3618	2019-11-27	\N	119	\N	2019-11-27                      	3	среда           	f	27	331	3587	3526	3253
3619	2019-11-28	\N	119	\N	2019-11-28                      	4	четверг         	f	28	332	3588	3527	3254
3620	2019-11-29	\N	119	\N	2019-11-29                      	5	пятница         	f	29	333	3589	3528	3255
3621	2019-11-30	\N	119	\N	2019-11-30                      	6	суббота         	t	30	334	3590	3529	3256
3623	2019-12-02	\N	120	\N	2019-12-02                      	1	понедельник     	f	2	336	3593	3532	3258
3624	2019-12-03	\N	120	\N	2019-12-03                      	2	вторник         	f	3	337	3594	3533	3259
3625	2019-12-04	\N	120	\N	2019-12-04                      	3	среда           	f	4	338	3595	3534	3260
3626	2019-12-05	\N	120	\N	2019-12-05                      	4	четверг         	f	5	339	3596	3535	3261
3627	2019-12-06	\N	120	\N	2019-12-06                      	5	пятница         	f	6	340	3597	3536	3262
3628	2019-12-07	\N	120	\N	2019-12-07                      	6	суббота         	t	7	341	3598	3537	3263
3630	2019-12-09	\N	120	\N	2019-12-09                      	1	понедельник     	f	9	343	3600	3539	3265
3631	2019-12-10	\N	120	\N	2019-12-10                      	2	вторник         	f	10	344	3601	3540	3266
3632	2019-12-11	\N	120	\N	2019-12-11                      	3	среда           	f	11	345	3602	3541	3267
3633	2019-12-12	\N	120	\N	2019-12-12                      	4	четверг         	f	12	346	3603	3542	3268
3634	2019-12-13	\N	120	\N	2019-12-13                      	5	пятница         	f	13	347	3604	3543	3269
3635	2019-12-14	\N	120	\N	2019-12-14                      	6	суббота         	t	14	348	3605	3544	3270
3637	2019-12-16	\N	120	\N	2019-12-16                      	1	понедельник     	f	16	350	3607	3546	3272
3638	2019-12-17	\N	120	\N	2019-12-17                      	2	вторник         	f	17	351	3608	3547	3273
3639	2019-12-18	\N	120	\N	2019-12-18                      	3	среда           	f	18	352	3609	3548	3274
3640	2019-12-19	\N	120	\N	2019-12-19                      	4	четверг         	f	19	353	3610	3549	3275
3641	2019-12-20	\N	120	\N	2019-12-20                      	5	пятница         	f	20	354	3611	3550	3276
3642	2019-12-21	\N	120	\N	2019-12-21                      	6	суббота         	t	21	355	3612	3551	3277
3644	2019-12-23	\N	120	\N	2019-12-23                      	1	понедельник     	f	23	357	3614	3553	3279
3645	2019-12-24	\N	120	\N	2019-12-24                      	2	вторник         	f	24	358	3615	3554	3280
3646	2019-12-25	\N	120	\N	2019-12-25                      	3	среда           	f	25	359	3616	3555	3281
3647	2019-12-26	\N	120	\N	2019-12-26                      	4	четверг         	f	26	360	3617	3556	3282
3648	2019-12-27	\N	120	\N	2019-12-27                      	5	пятница         	f	27	361	3618	3557	3283
3649	2019-12-28	\N	120	\N	2019-12-28                      	6	суббота         	t	28	362	3619	3558	3284
3651	2019-12-30	\N	120	\N	2019-12-30                      	1	понедельник     	f	30	364	3621	3560	3286
3652	2019-12-31	\N	120	\N	2019-12-31                      	2	вторник         	f	31	365	3621	3560	3287
3653	2020-01-01	\N	121	\N	2020-01-01                      	3	среда           	f	1	1	3622	3561	3288
3654	2020-01-02	\N	121	\N	2020-01-02                      	4	четверг         	f	2	2	3623	3562	3289
3655	2020-01-03	\N	121	\N	2020-01-03                      	5	пятница         	f	3	3	3624	3563	3290
3656	2020-01-04	\N	121	\N	2020-01-04                      	6	суббота         	t	4	4	3625	3564	3291
3658	2020-01-06	\N	121	\N	2020-01-06                      	1	понедельник     	f	6	6	3627	3566	3293
3659	2020-01-07	\N	121	\N	2020-01-07                      	2	вторник         	f	7	7	3628	3567	3294
3660	2020-01-08	\N	121	\N	2020-01-08                      	3	среда           	f	8	8	3629	3568	3295
3661	2020-01-09	\N	121	\N	2020-01-09                      	4	четверг         	f	9	9	3630	3569	3296
3662	2020-01-10	\N	121	\N	2020-01-10                      	5	пятница         	f	10	10	3631	3570	3297
3663	2020-01-11	\N	121	\N	2020-01-11                      	6	суббота         	t	11	11	3632	3571	3298
3665	2020-01-13	\N	121	\N	2020-01-13                      	1	понедельник     	f	13	13	3634	3573	3300
3666	2020-01-14	\N	121	\N	2020-01-14                      	2	вторник         	f	14	14	3635	3574	3301
3667	2020-01-15	\N	121	\N	2020-01-15                      	3	среда           	f	15	15	3636	3575	3302
3668	2020-01-16	\N	121	\N	2020-01-16                      	4	четверг         	f	16	16	3637	3576	3303
3669	2020-01-17	\N	121	\N	2020-01-17                      	5	пятница         	f	17	17	3638	3577	3304
3670	2020-01-18	\N	121	\N	2020-01-18                      	6	суббота         	t	18	18	3639	3578	3305
3672	2020-01-20	\N	121	\N	2020-01-20                      	1	понедельник     	f	20	20	3641	3580	3307
3673	2020-01-21	\N	121	\N	2020-01-21                      	2	вторник         	f	21	21	3642	3581	3308
3674	2020-01-22	\N	121	\N	2020-01-22                      	3	среда           	f	22	22	3643	3582	3309
3675	2020-01-23	\N	121	\N	2020-01-23                      	4	четверг         	f	23	23	3644	3583	3310
3676	2020-01-24	\N	121	\N	2020-01-24                      	5	пятница         	f	24	24	3645	3584	3311
3679	2020-01-27	\N	121	\N	2020-01-27                      	1	понедельник     	f	27	27	3648	3587	3314
3680	2020-01-28	\N	121	\N	2020-01-28                      	2	вторник         	f	28	28	3649	3588	3315
3681	2020-01-29	\N	121	\N	2020-01-29                      	3	среда           	f	29	29	3650	3589	3316
3682	2020-01-30	\N	121	\N	2020-01-30                      	4	четверг         	f	30	30	3651	3590	3317
3683	2020-01-31	\N	121	\N	2020-01-31                      	5	пятница         	f	31	31	3652	3591	3318
3684	2020-02-01	\N	122	\N	2020-02-01                      	6	суббота         	t	1	32	3653	3592	3319
3686	2020-02-03	\N	122	\N	2020-02-03                      	1	понедельник     	f	3	34	3655	3594	3321
3687	2020-02-04	\N	122	\N	2020-02-04                      	2	вторник         	f	4	35	3656	3595	3322
3688	2020-02-05	\N	122	\N	2020-02-05                      	3	среда           	f	5	36	3657	3596	3323
3689	2020-02-06	\N	122	\N	2020-02-06                      	4	четверг         	f	6	37	3658	3597	3324
3690	2020-02-07	\N	122	\N	2020-02-07                      	5	пятница         	f	7	38	3659	3598	3325
3691	2020-02-08	\N	122	\N	2020-02-08                      	6	суббота         	t	8	39	3660	3599	3326
3693	2020-02-10	\N	122	\N	2020-02-10                      	1	понедельник     	f	10	41	3662	3601	3328
3694	2020-02-11	\N	122	\N	2020-02-11                      	2	вторник         	f	11	42	3663	3602	3329
3695	2020-02-12	\N	122	\N	2020-02-12                      	3	среда           	f	12	43	3664	3603	3330
3696	2020-02-13	\N	122	\N	2020-02-13                      	4	четверг         	f	13	44	3665	3604	3331
3697	2020-02-14	\N	122	\N	2020-02-14                      	5	пятница         	f	14	45	3666	3605	3332
3698	2020-02-15	\N	122	\N	2020-02-15                      	6	суббота         	t	15	46	3667	3606	3333
3700	2020-02-17	\N	122	\N	2020-02-17                      	1	понедельник     	f	17	48	3669	3608	3335
3701	2020-02-18	\N	122	\N	2020-02-18                      	2	вторник         	f	18	49	3670	3609	3336
3702	2020-02-19	\N	122	\N	2020-02-19                      	3	среда           	f	19	50	3671	3610	3337
3703	2020-02-20	\N	122	\N	2020-02-20                      	4	четверг         	f	20	51	3672	3611	3338
3704	2020-02-21	\N	122	\N	2020-02-21                      	5	пятница         	f	21	52	3673	3612	3339
3705	2020-02-22	\N	122	\N	2020-02-22                      	6	суббота         	t	22	53	3674	3613	3340
3707	2020-02-24	\N	122	\N	2020-02-24                      	1	понедельник     	f	24	55	3676	3615	3342
3708	2020-02-25	\N	122	\N	2020-02-25                      	2	вторник         	f	25	56	3677	3616	3343
3709	2020-02-26	\N	122	\N	2020-02-26                      	3	среда           	f	26	57	3678	3617	3344
3710	2020-02-27	\N	122	\N	2020-02-27                      	4	четверг         	f	27	58	3679	3618	3345
3711	2020-02-28	\N	122	\N	2020-02-28                      	5	пятница         	f	28	59	3680	3619	3346
3712	2020-02-29	\N	122	\N	2020-02-29                      	6	суббота         	t	29	60	3681	3620	3346
3677	2020-01-25	\N	121	\N	2020-01-25                      	6	суббота         	t	25	25	3646	3585	3312
3714	2020-03-02	\N	123	\N	2020-03-02                      	1	понедельник     	f	2	62	3685	3623	3348
3715	2020-03-03	\N	123	\N	2020-03-03                      	2	вторник         	f	3	63	3686	3624	3349
3716	2020-03-04	\N	123	\N	2020-03-04                      	3	среда           	f	4	64	3687	3625	3350
3717	2020-03-05	\N	123	\N	2020-03-05                      	4	четверг         	f	5	65	3688	3626	3351
3718	2020-03-06	\N	123	\N	2020-03-06                      	5	пятница         	f	6	66	3689	3627	3352
3719	2020-03-07	\N	123	\N	2020-03-07                      	6	суббота         	t	7	67	3690	3628	3353
3721	2020-03-09	\N	123	\N	2020-03-09                      	1	понедельник     	f	9	69	3692	3630	3355
3722	2020-03-10	\N	123	\N	2020-03-10                      	2	вторник         	f	10	70	3693	3631	3356
3723	2020-03-11	\N	123	\N	2020-03-11                      	3	среда           	f	11	71	3694	3632	3357
3724	2020-03-12	\N	123	\N	2020-03-12                      	4	четверг         	f	12	72	3695	3633	3358
3725	2020-03-13	\N	123	\N	2020-03-13                      	5	пятница         	f	13	73	3696	3634	3359
3726	2020-03-14	\N	123	\N	2020-03-14                      	6	суббота         	t	14	74	3697	3635	3360
3728	2020-03-16	\N	123	\N	2020-03-16                      	1	понедельник     	f	16	76	3699	3637	3362
3729	2020-03-17	\N	123	\N	2020-03-17                      	2	вторник         	f	17	77	3700	3638	3363
3730	2020-03-18	\N	123	\N	2020-03-18                      	3	среда           	f	18	78	3701	3639	3364
3731	2020-03-19	\N	123	\N	2020-03-19                      	4	четверг         	f	19	79	3702	3640	3365
3732	2020-03-20	\N	123	\N	2020-03-20                      	5	пятница         	f	20	80	3703	3641	3366
3733	2020-03-21	\N	123	\N	2020-03-21                      	6	суббота         	t	21	81	3704	3642	3367
3735	2020-03-23	\N	123	\N	2020-03-23                      	1	понедельник     	f	23	83	3706	3644	3369
3736	2020-03-24	\N	123	\N	2020-03-24                      	2	вторник         	f	24	84	3707	3645	3370
3737	2020-03-25	\N	123	\N	2020-03-25                      	3	среда           	f	25	85	3708	3646	3371
3738	2020-03-26	\N	123	\N	2020-03-26                      	4	четверг         	f	26	86	3709	3647	3372
3739	2020-03-27	\N	123	\N	2020-03-27                      	5	пятница         	f	27	87	3710	3648	3373
3740	2020-03-28	\N	123	\N	2020-03-28                      	6	суббота         	t	28	88	3711	3649	3374
3742	2020-03-30	\N	123	\N	2020-03-30                      	1	понедельник     	f	30	90	3712	3651	3376
3743	2020-03-31	\N	123	\N	2020-03-31                      	2	вторник         	f	31	91	3712	3652	3377
3744	2020-04-01	\N	124	\N	2020-04-01                      	3	среда           	f	1	92	3713	3653	3378
3745	2020-04-02	\N	124	\N	2020-04-02                      	4	четверг         	f	2	93	3714	3654	3379
3746	2020-04-03	\N	124	\N	2020-04-03                      	5	пятница         	f	3	94	3715	3655	3380
3747	2020-04-04	\N	124	\N	2020-04-04                      	6	суббота         	t	4	95	3716	3656	3381
3749	2020-04-06	\N	124	\N	2020-04-06                      	1	понедельник     	f	6	97	3718	3658	3383
3750	2020-04-07	\N	124	\N	2020-04-07                      	2	вторник         	f	7	98	3719	3659	3384
3751	2020-04-08	\N	124	\N	2020-04-08                      	3	среда           	f	8	99	3720	3660	3385
3752	2020-04-09	\N	124	\N	2020-04-09                      	4	четверг         	f	9	100	3721	3661	3386
3753	2020-04-10	\N	124	\N	2020-04-10                      	5	пятница         	f	10	101	3722	3662	3387
3754	2020-04-11	\N	124	\N	2020-04-11                      	6	суббота         	t	11	102	3723	3663	3388
3756	2020-04-13	\N	124	\N	2020-04-13                      	1	понедельник     	f	13	104	3725	3665	3390
3757	2020-04-14	\N	124	\N	2020-04-14                      	2	вторник         	f	14	105	3726	3666	3391
3758	2020-04-15	\N	124	\N	2020-04-15                      	3	среда           	f	15	106	3727	3667	3392
3759	2020-04-16	\N	124	\N	2020-04-16                      	4	четверг         	f	16	107	3728	3668	3393
3760	2020-04-17	\N	124	\N	2020-04-17                      	5	пятница         	f	17	108	3729	3669	3394
3761	2020-04-18	\N	124	\N	2020-04-18                      	6	суббота         	t	18	109	3730	3670	3395
3763	2020-04-20	\N	124	\N	2020-04-20                      	1	понедельник     	f	20	111	3732	3672	3397
3764	2020-04-21	\N	124	\N	2020-04-21                      	2	вторник         	f	21	112	3733	3673	3398
3765	2020-04-22	\N	124	\N	2020-04-22                      	3	среда           	f	22	113	3734	3674	3399
3766	2020-04-23	\N	124	\N	2020-04-23                      	4	четверг         	f	23	114	3735	3675	3400
3767	2020-04-24	\N	124	\N	2020-04-24                      	5	пятница         	f	24	115	3736	3676	3401
3768	2020-04-25	\N	124	\N	2020-04-25                      	6	суббота         	t	25	116	3737	3677	3402
3770	2020-04-27	\N	124	\N	2020-04-27                      	1	понедельник     	f	27	118	3739	3679	3404
3771	2020-04-28	\N	124	\N	2020-04-28                      	2	вторник         	f	28	119	3740	3680	3405
3772	2020-04-29	\N	124	\N	2020-04-29                      	3	среда           	f	29	120	3741	3681	3406
3773	2020-04-30	\N	124	\N	2020-04-30                      	4	четверг         	f	30	121	3742	3682	3407
3774	2020-05-01	\N	125	\N	2020-05-01                      	5	пятница         	f	1	122	3744	3684	3408
3775	2020-05-02	\N	125	\N	2020-05-02                      	6	суббота         	t	2	123	3745	3685	3409
3777	2020-05-04	\N	125	\N	2020-05-04                      	1	понедельник     	f	4	125	3747	3687	3411
3778	2020-05-05	\N	125	\N	2020-05-05                      	2	вторник         	f	5	126	3748	3688	3412
3779	2020-05-06	\N	125	\N	2020-05-06                      	3	среда           	f	6	127	3749	3689	3413
3780	2020-05-07	\N	125	\N	2020-05-07                      	4	четверг         	f	7	128	3750	3690	3414
3781	2020-05-08	\N	125	\N	2020-05-08                      	5	пятница         	f	8	129	3751	3691	3415
3782	2020-05-09	\N	125	\N	2020-05-09                      	6	суббота         	t	9	130	3752	3692	3416
3784	2020-05-11	\N	125	\N	2020-05-11                      	1	понедельник     	f	11	132	3754	3694	3418
3785	2020-05-12	\N	125	\N	2020-05-12                      	2	вторник         	f	12	133	3755	3695	3419
3786	2020-05-13	\N	125	\N	2020-05-13                      	3	среда           	f	13	134	3756	3696	3420
3787	2020-05-14	\N	125	\N	2020-05-14                      	4	четверг         	f	14	135	3757	3697	3421
3788	2020-05-15	\N	125	\N	2020-05-15                      	5	пятница         	f	15	136	3758	3698	3422
3789	2020-05-16	\N	125	\N	2020-05-16                      	6	суббота         	t	16	137	3759	3699	3423
3791	2020-05-18	\N	125	\N	2020-05-18                      	1	понедельник     	f	18	139	3761	3701	3425
3792	2020-05-19	\N	125	\N	2020-05-19                      	2	вторник         	f	19	140	3762	3702	3426
3793	2020-05-20	\N	125	\N	2020-05-20                      	3	среда           	f	20	141	3763	3703	3427
3794	2020-05-21	\N	125	\N	2020-05-21                      	4	четверг         	f	21	142	3764	3704	3428
3795	2020-05-22	\N	125	\N	2020-05-22                      	5	пятница         	f	22	143	3765	3705	3429
3796	2020-05-23	\N	125	\N	2020-05-23                      	6	суббота         	t	23	144	3766	3706	3430
3798	2020-05-25	\N	125	\N	2020-05-25                      	1	понедельник     	f	25	146	3768	3708	3432
3799	2020-05-26	\N	125	\N	2020-05-26                      	2	вторник         	f	26	147	3769	3709	3433
3800	2020-05-27	\N	125	\N	2020-05-27                      	3	среда           	f	27	148	3770	3710	3434
3801	2020-05-28	\N	125	\N	2020-05-28                      	4	четверг         	f	28	149	3771	3711	3435
3802	2020-05-29	\N	125	\N	2020-05-29                      	5	пятница         	f	29	150	3772	3712	3436
3803	2020-05-30	\N	125	\N	2020-05-30                      	6	суббота         	t	30	151	3773	3712	3437
3805	2020-06-01	\N	126	\N	2020-06-01                      	1	понедельник     	f	1	153	3774	3713	3439
3806	2020-06-02	\N	126	\N	2020-06-02                      	2	вторник         	f	2	154	3775	3714	3440
3807	2020-06-03	\N	126	\N	2020-06-03                      	3	среда           	f	3	155	3776	3715	3441
3808	2020-06-04	\N	126	\N	2020-06-04                      	4	четверг         	f	4	156	3777	3716	3442
3809	2020-06-05	\N	126	\N	2020-06-05                      	5	пятница         	f	5	157	3778	3717	3443
3810	2020-06-06	\N	126	\N	2020-06-06                      	6	суббота         	t	6	158	3779	3718	3444
3812	2020-06-08	\N	126	\N	2020-06-08                      	1	понедельник     	f	8	160	3781	3720	3446
3813	2020-06-09	\N	126	\N	2020-06-09                      	2	вторник         	f	9	161	3782	3721	3447
3814	2020-06-10	\N	126	\N	2020-06-10                      	3	среда           	f	10	162	3783	3722	3448
3815	2020-06-11	\N	126	\N	2020-06-11                      	4	четверг         	f	11	163	3784	3723	3449
3816	2020-06-12	\N	126	\N	2020-06-12                      	5	пятница         	f	12	164	3785	3724	3450
3817	2020-06-13	\N	126	\N	2020-06-13                      	6	суббота         	t	13	165	3786	3725	3451
3819	2020-06-15	\N	126	\N	2020-06-15                      	1	понедельник     	f	15	167	3788	3727	3453
3820	2020-06-16	\N	126	\N	2020-06-16                      	2	вторник         	f	16	168	3789	3728	3454
3821	2020-06-17	\N	126	\N	2020-06-17                      	3	среда           	f	17	169	3790	3729	3455
3822	2020-06-18	\N	126	\N	2020-06-18                      	4	четверг         	f	18	170	3791	3730	3456
3823	2020-06-19	\N	126	\N	2020-06-19                      	5	пятница         	f	19	171	3792	3731	3457
3824	2020-06-20	\N	126	\N	2020-06-20                      	6	суббота         	t	20	172	3793	3732	3458
3826	2020-06-22	\N	126	\N	2020-06-22                      	1	понедельник     	f	22	174	3795	3734	3460
3827	2020-06-23	\N	126	\N	2020-06-23                      	2	вторник         	f	23	175	3796	3735	3461
3828	2020-06-24	\N	126	\N	2020-06-24                      	3	среда           	f	24	176	3797	3736	3462
3829	2020-06-25	\N	126	\N	2020-06-25                      	4	четверг         	f	25	177	3798	3737	3463
3830	2020-06-26	\N	126	\N	2020-06-26                      	5	пятница         	f	26	178	3799	3738	3464
3831	2020-06-27	\N	126	\N	2020-06-27                      	6	суббота         	t	27	179	3800	3739	3465
3833	2020-06-29	\N	126	\N	2020-06-29                      	1	понедельник     	f	29	181	3802	3741	3467
3834	2020-06-30	\N	126	\N	2020-06-30                      	2	вторник         	f	30	182	3803	3742	3468
3835	2020-07-01	\N	127	\N	2020-07-01                      	3	среда           	f	1	183	3805	3744	3469
3836	2020-07-02	\N	127	\N	2020-07-02                      	4	четверг         	f	2	184	3806	3745	3470
3837	2020-07-03	\N	127	\N	2020-07-03                      	5	пятница         	f	3	185	3807	3746	3471
3838	2020-07-04	\N	127	\N	2020-07-04                      	6	суббота         	t	4	186	3808	3747	3472
3840	2020-07-06	\N	127	\N	2020-07-06                      	1	понедельник     	f	6	188	3810	3749	3474
3841	2020-07-07	\N	127	\N	2020-07-07                      	2	вторник         	f	7	189	3811	3750	3475
3842	2020-07-08	\N	127	\N	2020-07-08                      	3	среда           	f	8	190	3812	3751	3476
3843	2020-07-09	\N	127	\N	2020-07-09                      	4	четверг         	f	9	191	3813	3752	3477
3844	2020-07-10	\N	127	\N	2020-07-10                      	5	пятница         	f	10	192	3814	3753	3478
3845	2020-07-11	\N	127	\N	2020-07-11                      	6	суббота         	t	11	193	3815	3754	3479
3847	2020-07-13	\N	127	\N	2020-07-13                      	1	понедельник     	f	13	195	3817	3756	3481
3848	2020-07-14	\N	127	\N	2020-07-14                      	2	вторник         	f	14	196	3818	3757	3482
3849	2020-07-15	\N	127	\N	2020-07-15                      	3	среда           	f	15	197	3819	3758	3483
3850	2020-07-16	\N	127	\N	2020-07-16                      	4	четверг         	f	16	198	3820	3759	3484
3851	2020-07-17	\N	127	\N	2020-07-17                      	5	пятница         	f	17	199	3821	3760	3485
3852	2020-07-18	\N	127	\N	2020-07-18                      	6	суббота         	t	18	200	3822	3761	3486
3854	2020-07-20	\N	127	\N	2020-07-20                      	1	понедельник     	f	20	202	3824	3763	3488
3855	2020-07-21	\N	127	\N	2020-07-21                      	2	вторник         	f	21	203	3825	3764	3489
3856	2020-07-22	\N	127	\N	2020-07-22                      	3	среда           	f	22	204	3826	3765	3490
3857	2020-07-23	\N	127	\N	2020-07-23                      	4	четверг         	f	23	205	3827	3766	3491
3858	2020-07-24	\N	127	\N	2020-07-24                      	5	пятница         	f	24	206	3828	3767	3492
3859	2020-07-25	\N	127	\N	2020-07-25                      	6	суббота         	t	25	207	3829	3768	3493
3861	2020-07-27	\N	127	\N	2020-07-27                      	1	понедельник     	f	27	209	3831	3770	3495
3862	2020-07-28	\N	127	\N	2020-07-28                      	2	вторник         	f	28	210	3832	3771	3496
3863	2020-07-29	\N	127	\N	2020-07-29                      	3	среда           	f	29	211	3833	3772	3497
3864	2020-07-30	\N	127	\N	2020-07-30                      	4	четверг         	f	30	212	3834	3773	3498
3865	2020-07-31	\N	127	\N	2020-07-31                      	5	пятница         	f	31	213	3834	3773	3499
3866	2020-08-01	\N	128	\N	2020-08-01                      	6	суббота         	t	1	214	3835	3774	3500
3868	2020-08-03	\N	128	\N	2020-08-03                      	1	понедельник     	f	3	216	3837	3776	3502
3869	2020-08-04	\N	128	\N	2020-08-04                      	2	вторник         	f	4	217	3838	3777	3503
3870	2020-08-05	\N	128	\N	2020-08-05                      	3	среда           	f	5	218	3839	3778	3504
3871	2020-08-06	\N	128	\N	2020-08-06                      	4	четверг         	f	6	219	3840	3779	3505
3872	2020-08-07	\N	128	\N	2020-08-07                      	5	пятница         	f	7	220	3841	3780	3506
3873	2020-08-08	\N	128	\N	2020-08-08                      	6	суббота         	t	8	221	3842	3781	3507
3875	2020-08-10	\N	128	\N	2020-08-10                      	1	понедельник     	f	10	223	3844	3783	3509
3876	2020-08-11	\N	128	\N	2020-08-11                      	2	вторник         	f	11	224	3845	3784	3510
3877	2020-08-12	\N	128	\N	2020-08-12                      	3	среда           	f	12	225	3846	3785	3511
3878	2020-08-13	\N	128	\N	2020-08-13                      	4	четверг         	f	13	226	3847	3786	3512
3879	2020-08-14	\N	128	\N	2020-08-14                      	5	пятница         	f	14	227	3848	3787	3513
3880	2020-08-15	\N	128	\N	2020-08-15                      	6	суббота         	t	15	228	3849	3788	3514
3882	2020-08-17	\N	128	\N	2020-08-17                      	1	понедельник     	f	17	230	3851	3790	3516
3883	2020-08-18	\N	128	\N	2020-08-18                      	2	вторник         	f	18	231	3852	3791	3517
3884	2020-08-19	\N	128	\N	2020-08-19                      	3	среда           	f	19	232	3853	3792	3518
3885	2020-08-20	\N	128	\N	2020-08-20                      	4	четверг         	f	20	233	3854	3793	3519
3886	2020-08-21	\N	128	\N	2020-08-21                      	5	пятница         	f	21	234	3855	3794	3520
3887	2020-08-22	\N	128	\N	2020-08-22                      	6	суббота         	t	22	235	3856	3795	3521
3889	2020-08-24	\N	128	\N	2020-08-24                      	1	понедельник     	f	24	237	3858	3797	3523
3890	2020-08-25	\N	128	\N	2020-08-25                      	2	вторник         	f	25	238	3859	3798	3524
3891	2020-08-26	\N	128	\N	2020-08-26                      	3	среда           	f	26	239	3860	3799	3525
3892	2020-08-27	\N	128	\N	2020-08-27                      	4	четверг         	f	27	240	3861	3800	3526
3893	2020-08-28	\N	128	\N	2020-08-28                      	5	пятница         	f	28	241	3862	3801	3527
3894	2020-08-29	\N	128	\N	2020-08-29                      	6	суббота         	t	29	242	3863	3802	3528
3896	2020-08-31	\N	128	\N	2020-08-31                      	1	понедельник     	f	31	244	3865	3804	3530
3897	2020-09-01	\N	129	\N	2020-09-01                      	2	вторник         	f	1	245	3866	3805	3531
3898	2020-09-02	\N	129	\N	2020-09-02                      	3	среда           	f	2	246	3867	3806	3532
3899	2020-09-03	\N	129	\N	2020-09-03                      	4	четверг         	f	3	247	3868	3807	3533
3900	2020-09-04	\N	129	\N	2020-09-04                      	5	пятница         	f	4	248	3869	3808	3534
3901	2020-09-05	\N	129	\N	2020-09-05                      	6	суббота         	t	5	249	3870	3809	3535
3903	2020-09-07	\N	129	\N	2020-09-07                      	1	понедельник     	f	7	251	3872	3811	3537
3904	2020-09-08	\N	129	\N	2020-09-08                      	2	вторник         	f	8	252	3873	3812	3538
3905	2020-09-09	\N	129	\N	2020-09-09                      	3	среда           	f	9	253	3874	3813	3539
3906	2020-09-10	\N	129	\N	2020-09-10                      	4	четверг         	f	10	254	3875	3814	3540
3907	2020-09-11	\N	129	\N	2020-09-11                      	5	пятница         	f	11	255	3876	3815	3541
3908	2020-09-12	\N	129	\N	2020-09-12                      	6	суббота         	t	12	256	3877	3816	3542
3910	2020-09-14	\N	129	\N	2020-09-14                      	1	понедельник     	f	14	258	3879	3818	3544
3911	2020-09-15	\N	129	\N	2020-09-15                      	2	вторник         	f	15	259	3880	3819	3545
3912	2020-09-16	\N	129	\N	2020-09-16                      	3	среда           	f	16	260	3881	3820	3546
3913	2020-09-17	\N	129	\N	2020-09-17                      	4	четверг         	f	17	261	3882	3821	3547
3914	2020-09-18	\N	129	\N	2020-09-18                      	5	пятница         	f	18	262	3883	3822	3548
3915	2020-09-19	\N	129	\N	2020-09-19                      	6	суббота         	t	19	263	3884	3823	3549
3917	2020-09-21	\N	129	\N	2020-09-21                      	1	понедельник     	f	21	265	3886	3825	3551
3918	2020-09-22	\N	129	\N	2020-09-22                      	2	вторник         	f	22	266	3887	3826	3552
3919	2020-09-23	\N	129	\N	2020-09-23                      	3	среда           	f	23	267	3888	3827	3553
3920	2020-09-24	\N	129	\N	2020-09-24                      	4	четверг         	f	24	268	3889	3828	3554
3921	2020-09-25	\N	129	\N	2020-09-25                      	5	пятница         	f	25	269	3890	3829	3555
3922	2020-09-26	\N	129	\N	2020-09-26                      	6	суббота         	t	26	270	3891	3830	3556
3924	2020-09-28	\N	129	\N	2020-09-28                      	1	понедельник     	f	28	272	3893	3832	3558
3925	2020-09-29	\N	129	\N	2020-09-29                      	2	вторник         	f	29	273	3894	3833	3559
3926	2020-09-30	\N	129	\N	2020-09-30                      	3	среда           	f	30	274	3895	3834	3560
3927	2020-10-01	\N	130	\N	2020-10-01                      	4	четверг         	f	1	275	3897	3835	3561
3928	2020-10-02	\N	130	\N	2020-10-02                      	5	пятница         	f	2	276	3898	3836	3562
3929	2020-10-03	\N	130	\N	2020-10-03                      	6	суббота         	t	3	277	3899	3837	3563
3931	2020-10-05	\N	130	\N	2020-10-05                      	1	понедельник     	f	5	279	3901	3839	3565
3932	2020-10-06	\N	130	\N	2020-10-06                      	2	вторник         	f	6	280	3902	3840	3566
3933	2020-10-07	\N	130	\N	2020-10-07                      	3	среда           	f	7	281	3903	3841	3567
3934	2020-10-08	\N	130	\N	2020-10-08                      	4	четверг         	f	8	282	3904	3842	3568
3935	2020-10-09	\N	130	\N	2020-10-09                      	5	пятница         	f	9	283	3905	3843	3569
3936	2020-10-10	\N	130	\N	2020-10-10                      	6	суббота         	t	10	284	3906	3844	3570
3938	2020-10-12	\N	130	\N	2020-10-12                      	1	понедельник     	f	12	286	3908	3846	3572
3939	2020-10-13	\N	130	\N	2020-10-13                      	2	вторник         	f	13	287	3909	3847	3573
3940	2020-10-14	\N	130	\N	2020-10-14                      	3	среда           	f	14	288	3910	3848	3574
3941	2020-10-15	\N	130	\N	2020-10-15                      	4	четверг         	f	15	289	3911	3849	3575
3942	2020-10-16	\N	130	\N	2020-10-16                      	5	пятница         	f	16	290	3912	3850	3576
3943	2020-10-17	\N	130	\N	2020-10-17                      	6	суббота         	t	17	291	3913	3851	3577
3945	2020-10-19	\N	130	\N	2020-10-19                      	1	понедельник     	f	19	293	3915	3853	3579
3946	2020-10-20	\N	130	\N	2020-10-20                      	2	вторник         	f	20	294	3916	3854	3580
3947	2020-10-21	\N	130	\N	2020-10-21                      	3	среда           	f	21	295	3917	3855	3581
3948	2020-10-22	\N	130	\N	2020-10-22                      	4	четверг         	f	22	296	3918	3856	3582
3949	2020-10-23	\N	130	\N	2020-10-23                      	5	пятница         	f	23	297	3919	3857	3583
3950	2020-10-24	\N	130	\N	2020-10-24                      	6	суббота         	t	24	298	3920	3858	3584
3952	2020-10-26	\N	130	\N	2020-10-26                      	1	понедельник     	f	26	300	3922	3860	3586
3953	2020-10-27	\N	130	\N	2020-10-27                      	2	вторник         	f	27	301	3923	3861	3587
3954	2020-10-28	\N	130	\N	2020-10-28                      	3	среда           	f	28	302	3924	3862	3588
3955	2020-10-29	\N	130	\N	2020-10-29                      	4	четверг         	f	29	303	3925	3863	3589
3956	2020-10-30	\N	130	\N	2020-10-30                      	5	пятница         	f	30	304	3926	3864	3590
3957	2020-10-31	\N	130	\N	2020-10-31                      	6	суббота         	t	31	305	3926	3865	3591
3959	2020-11-02	\N	131	\N	2020-11-02                      	1	понедельник     	f	2	307	3928	3867	3593
3960	2020-11-03	\N	131	\N	2020-11-03                      	2	вторник         	f	3	308	3929	3868	3594
3961	2020-11-04	\N	131	\N	2020-11-04                      	3	среда           	f	4	309	3930	3869	3595
3962	2020-11-05	\N	131	\N	2020-11-05                      	4	четверг         	f	5	310	3931	3870	3596
3963	2020-11-06	\N	131	\N	2020-11-06                      	5	пятница         	f	6	311	3932	3871	3597
3964	2020-11-07	\N	131	\N	2020-11-07                      	6	суббота         	t	7	312	3933	3872	3598
3966	2020-11-09	\N	131	\N	2020-11-09                      	1	понедельник     	f	9	314	3935	3874	3600
3967	2020-11-10	\N	131	\N	2020-11-10                      	2	вторник         	f	10	315	3936	3875	3601
3968	2020-11-11	\N	131	\N	2020-11-11                      	3	среда           	f	11	316	3937	3876	3602
3969	2020-11-12	\N	131	\N	2020-11-12                      	4	четверг         	f	12	317	3938	3877	3603
3970	2020-11-13	\N	131	\N	2020-11-13                      	5	пятница         	f	13	318	3939	3878	3604
3971	2020-11-14	\N	131	\N	2020-11-14                      	6	суббота         	t	14	319	3940	3879	3605
3973	2020-11-16	\N	131	\N	2020-11-16                      	1	понедельник     	f	16	321	3942	3881	3607
3974	2020-11-17	\N	131	\N	2020-11-17                      	2	вторник         	f	17	322	3943	3882	3608
3975	2020-11-18	\N	131	\N	2020-11-18                      	3	среда           	f	18	323	3944	3883	3609
3976	2020-11-19	\N	131	\N	2020-11-19                      	4	четверг         	f	19	324	3945	3884	3610
3977	2020-11-20	\N	131	\N	2020-11-20                      	5	пятница         	f	20	325	3946	3885	3611
3978	2020-11-21	\N	131	\N	2020-11-21                      	6	суббота         	t	21	326	3947	3886	3612
3980	2020-11-23	\N	131	\N	2020-11-23                      	1	понедельник     	f	23	328	3949	3888	3614
3981	2020-11-24	\N	131	\N	2020-11-24                      	2	вторник         	f	24	329	3950	3889	3615
3982	2020-11-25	\N	131	\N	2020-11-25                      	3	среда           	f	25	330	3951	3890	3616
3983	2020-11-26	\N	131	\N	2020-11-26                      	4	четверг         	f	26	331	3952	3891	3617
3984	2020-11-27	\N	131	\N	2020-11-27                      	5	пятница         	f	27	332	3953	3892	3618
3985	2020-11-28	\N	131	\N	2020-11-28                      	6	суббота         	t	28	333	3954	3893	3619
3987	2020-11-30	\N	131	\N	2020-11-30                      	1	понедельник     	f	30	335	3956	3895	3621
3988	2020-12-01	\N	132	\N	2020-12-01                      	2	вторник         	f	1	336	3958	3897	3622
3989	2020-12-02	\N	132	\N	2020-12-02                      	3	среда           	f	2	337	3959	3898	3623
3990	2020-12-03	\N	132	\N	2020-12-03                      	4	четверг         	f	3	338	3960	3899	3624
3991	2020-12-04	\N	132	\N	2020-12-04                      	5	пятница         	f	4	339	3961	3900	3625
3992	2020-12-05	\N	132	\N	2020-12-05                      	6	суббота         	t	5	340	3962	3901	3626
3994	2020-12-07	\N	132	\N	2020-12-07                      	1	понедельник     	f	7	342	3964	3903	3628
3995	2020-12-08	\N	132	\N	2020-12-08                      	2	вторник         	f	8	343	3965	3904	3629
3996	2020-12-09	\N	132	\N	2020-12-09                      	3	среда           	f	9	344	3966	3905	3630
3997	2020-12-10	\N	132	\N	2020-12-10                      	4	четверг         	f	10	345	3967	3906	3631
3998	2020-12-11	\N	132	\N	2020-12-11                      	5	пятница         	f	11	346	3968	3907	3632
3999	2020-12-12	\N	132	\N	2020-12-12                      	6	суббота         	t	12	347	3969	3908	3633
4001	2020-12-14	\N	132	\N	2020-12-14                      	1	понедельник     	f	14	349	3971	3910	3635
4002	2020-12-15	\N	132	\N	2020-12-15                      	2	вторник         	f	15	350	3972	3911	3636
4003	2020-12-16	\N	132	\N	2020-12-16                      	3	среда           	f	16	351	3973	3912	3637
4004	2020-12-17	\N	132	\N	2020-12-17                      	4	четверг         	f	17	352	3974	3913	3638
4005	2020-12-18	\N	132	\N	2020-12-18                      	5	пятница         	f	18	353	3975	3914	3639
4006	2020-12-19	\N	132	\N	2020-12-19                      	6	суббота         	t	19	354	3976	3915	3640
4008	2020-12-21	\N	132	\N	2020-12-21                      	1	понедельник     	f	21	356	3978	3917	3642
4009	2020-12-22	\N	132	\N	2020-12-22                      	2	вторник         	f	22	357	3979	3918	3643
4010	2020-12-23	\N	132	\N	2020-12-23                      	3	среда           	f	23	358	3980	3919	3644
4011	2020-12-24	\N	132	\N	2020-12-24                      	4	четверг         	f	24	359	3981	3920	3645
4012	2020-12-25	\N	132	\N	2020-12-25                      	5	пятница         	f	25	360	3982	3921	3646
4013	2020-12-26	\N	132	\N	2020-12-26                      	6	суббота         	t	26	361	3983	3922	3647
4015	2020-12-28	\N	132	\N	2020-12-28                      	1	понедельник     	f	28	363	3985	3924	3649
4016	2020-12-29	\N	132	\N	2020-12-29                      	2	вторник         	f	29	364	3986	3925	3650
4017	2020-12-30	\N	132	\N	2020-12-30                      	3	среда           	f	30	365	3987	3926	3651
4018	2020-12-31	\N	132	\N	2020-12-31                      	4	четверг         	f	31	366	3987	3926	3652
3	2010-01-03	\N	1	\N	2010-01-03                      	7	воскресенье     	t	3	3	\N	\N	\N
10	2010-01-10	\N	1	\N	2010-01-10                      	7	воскресенье     	t	10	10	\N	\N	\N
17	2010-01-17	\N	1	\N	2010-01-17                      	7	воскресенье     	t	17	17	\N	\N	\N
24	2010-01-24	\N	1	\N	2010-01-24                      	7	воскресенье     	t	24	24	\N	\N	\N
31	2010-01-31	\N	1	\N	2010-01-31                      	7	воскресенье     	t	31	31	\N	\N	\N
38	2010-02-07	\N	2	\N	2010-02-07                      	7	воскресенье     	t	7	38	7	\N	\N
45	2010-02-14	\N	2	\N	2010-02-14                      	7	воскресенье     	t	14	45	14	\N	\N
52	2010-02-21	\N	2	\N	2010-02-21                      	7	воскресенье     	t	21	52	21	\N	\N
59	2010-02-28	\N	2	\N	2010-02-28                      	7	воскресенье     	t	28	59	28	\N	\N
66	2010-03-07	\N	3	\N	2010-03-07                      	7	воскресенье     	t	7	66	38	\N	\N
73	2010-03-14	\N	3	\N	2010-03-14                      	7	воскресенье     	t	14	73	45	\N	\N
80	2010-03-21	\N	3	\N	2010-03-21                      	7	воскресенье     	t	21	80	52	\N	\N
87	2010-03-28	\N	3	\N	2010-03-28                      	7	воскресенье     	t	28	87	59	\N	\N
94	2010-04-04	\N	4	\N	2010-04-04                      	7	воскресенье     	t	4	94	63	4	\N
101	2010-04-11	\N	4	\N	2010-04-11                      	7	воскресенье     	t	11	101	70	11	\N
108	2010-04-18	\N	4	\N	2010-04-18                      	7	воскресенье     	t	18	108	77	18	\N
115	2010-04-25	\N	4	\N	2010-04-25                      	7	воскресенье     	t	25	115	84	25	\N
122	2010-05-02	\N	5	\N	2010-05-02                      	7	воскресенье     	t	2	122	92	33	\N
129	2010-05-09	\N	5	\N	2010-05-09                      	7	воскресенье     	t	9	129	99	40	\N
136	2010-05-16	\N	5	\N	2010-05-16                      	7	воскресенье     	t	16	136	106	47	\N
143	2010-05-23	\N	5	\N	2010-05-23                      	7	воскресенье     	t	23	143	113	54	\N
150	2010-05-30	\N	5	\N	2010-05-30                      	7	воскресенье     	t	30	150	120	59	\N
157	2010-06-06	\N	6	\N	2010-06-06                      	7	воскресенье     	t	6	157	126	65	\N
164	2010-06-13	\N	6	\N	2010-06-13                      	7	воскресенье     	t	13	164	133	72	\N
171	2010-06-20	\N	6	\N	2010-06-20                      	7	воскресенье     	t	20	171	140	79	\N
178	2010-06-27	\N	6	\N	2010-06-27                      	7	воскресенье     	t	27	178	147	86	\N
185	2010-07-04	\N	7	\N	2010-07-04                      	7	воскресенье     	t	4	185	155	94	\N
192	2010-07-11	\N	7	\N	2010-07-11                      	7	воскресенье     	t	11	192	162	101	\N
199	2010-07-18	\N	7	\N	2010-07-18                      	7	воскресенье     	t	18	199	169	108	\N
206	2010-07-25	\N	7	\N	2010-07-25                      	7	воскресенье     	t	25	206	176	115	\N
213	2010-08-01	\N	8	\N	2010-08-01                      	7	воскресенье     	t	1	213	182	121	\N
220	2010-08-08	\N	8	\N	2010-08-08                      	7	воскресенье     	t	8	220	189	128	\N
227	2010-08-15	\N	8	\N	2010-08-15                      	7	воскресенье     	t	15	227	196	135	\N
234	2010-08-22	\N	8	\N	2010-08-22                      	7	воскресенье     	t	22	234	203	142	\N
241	2010-08-29	\N	8	\N	2010-08-29                      	7	воскресенье     	t	29	241	210	149	\N
248	2010-09-05	\N	9	\N	2010-09-05                      	7	воскресенье     	t	5	248	217	156	\N
255	2010-09-12	\N	9	\N	2010-09-12                      	7	воскресенье     	t	12	255	224	163	\N
262	2010-09-19	\N	9	\N	2010-09-19                      	7	воскресенье     	t	19	262	231	170	\N
269	2010-09-26	\N	9	\N	2010-09-26                      	7	воскресенье     	t	26	269	238	177	\N
276	2010-10-03	\N	10	\N	2010-10-03                      	7	воскресенье     	t	3	276	246	184	\N
283	2010-10-10	\N	10	\N	2010-10-10                      	7	воскресенье     	t	10	283	253	191	\N
290	2010-10-17	\N	10	\N	2010-10-17                      	7	воскресенье     	t	17	290	260	198	\N
297	2010-10-24	\N	10	\N	2010-10-24                      	7	воскресенье     	t	24	297	267	205	\N
304	2010-10-31	\N	10	\N	2010-10-31                      	7	воскресенье     	t	31	304	273	212	\N
311	2010-11-07	\N	11	\N	2010-11-07                      	7	воскресенье     	t	7	311	280	219	\N
318	2010-11-14	\N	11	\N	2010-11-14                      	7	воскресенье     	t	14	318	287	226	\N
325	2010-11-21	\N	11	\N	2010-11-21                      	7	воскресенье     	t	21	325	294	233	\N
332	2010-11-28	\N	11	\N	2010-11-28                      	7	воскресенье     	t	28	332	301	240	\N
339	2010-12-05	\N	12	\N	2010-12-05                      	7	воскресенье     	t	5	339	309	248	\N
346	2010-12-12	\N	12	\N	2010-12-12                      	7	воскресенье     	t	12	346	316	255	\N
353	2010-12-19	\N	12	\N	2010-12-19                      	7	воскресенье     	t	19	353	323	262	\N
360	2010-12-26	\N	12	\N	2010-12-26                      	7	воскресенье     	t	26	360	330	269	\N
367	2011-01-02	\N	13	\N	2011-01-02                      	7	воскресенье     	t	2	2	336	275	2
374	2011-01-09	\N	13	\N	2011-01-09                      	7	воскресенье     	t	9	9	343	282	9
381	2011-01-16	\N	13	\N	2011-01-16                      	7	воскресенье     	t	16	16	350	289	16
388	2011-01-23	\N	13	\N	2011-01-23                      	7	воскресенье     	t	23	23	357	296	23
395	2011-01-30	\N	13	\N	2011-01-30                      	7	воскресенье     	t	30	30	364	303	30
402	2011-02-06	\N	14	\N	2011-02-06                      	7	воскресенье     	t	6	37	371	310	37
409	2011-02-13	\N	14	\N	2011-02-13                      	7	воскресенье     	t	13	44	378	317	44
416	2011-02-20	\N	14	\N	2011-02-20                      	7	воскресенье     	t	20	51	385	324	51
423	2011-02-27	\N	14	\N	2011-02-27                      	7	воскресенье     	t	27	58	392	331	58
430	2011-03-06	\N	15	\N	2011-03-06                      	7	воскресенье     	t	6	65	402	340	65
437	2011-03-13	\N	15	\N	2011-03-13                      	7	воскресенье     	t	13	72	409	347	72
444	2011-03-20	\N	15	\N	2011-03-20                      	7	воскресенье     	t	20	79	416	354	79
451	2011-03-27	\N	15	\N	2011-03-27                      	7	воскресенье     	t	27	86	423	361	86
458	2011-04-03	\N	16	\N	2011-04-03                      	7	воскресенье     	t	3	93	427	368	93
465	2011-04-10	\N	16	\N	2011-04-10                      	7	воскресенье     	t	10	100	434	375	100
472	2011-04-17	\N	16	\N	2011-04-17                      	7	воскресенье     	t	17	107	441	382	107
479	2011-04-24	\N	16	\N	2011-04-24                      	7	воскресенье     	t	24	114	448	389	114
486	2011-05-01	\N	17	\N	2011-05-01                      	7	воскресенье     	t	1	121	456	397	121
493	2011-05-08	\N	17	\N	2011-05-08                      	7	воскресенье     	t	8	128	463	404	128
500	2011-05-15	\N	17	\N	2011-05-15                      	7	воскресенье     	t	15	135	470	411	135
507	2011-05-22	\N	17	\N	2011-05-22                      	7	воскресенье     	t	22	142	477	418	142
514	2011-05-29	\N	17	\N	2011-05-29                      	7	воскресенье     	t	29	149	484	424	149
521	2011-06-05	\N	18	\N	2011-06-05                      	7	воскресенье     	t	5	156	490	429	156
528	2011-06-12	\N	18	\N	2011-06-12                      	7	воскресенье     	t	12	163	497	436	163
535	2011-06-19	\N	18	\N	2011-06-19                      	7	воскресенье     	t	19	170	504	443	170
542	2011-06-26	\N	18	\N	2011-06-26                      	7	воскресенье     	t	26	177	511	450	177
549	2011-07-03	\N	19	\N	2011-07-03                      	7	воскресенье     	t	3	184	519	458	184
556	2011-07-10	\N	19	\N	2011-07-10                      	7	воскресенье     	t	10	191	526	465	191
563	2011-07-17	\N	19	\N	2011-07-17                      	7	воскресенье     	t	17	198	533	472	198
570	2011-07-24	\N	19	\N	2011-07-24                      	7	воскресенье     	t	24	205	540	479	205
577	2011-07-31	\N	19	\N	2011-07-31                      	7	воскресенье     	t	31	212	546	485	212
584	2011-08-07	\N	20	\N	2011-08-07                      	7	воскресенье     	t	7	219	553	492	219
591	2011-08-14	\N	20	\N	2011-08-14                      	7	воскресенье     	t	14	226	560	499	226
598	2011-08-21	\N	20	\N	2011-08-21                      	7	воскресенье     	t	21	233	567	506	233
605	2011-08-28	\N	20	\N	2011-08-28                      	7	воскресенье     	t	28	240	574	513	240
612	2011-09-04	\N	21	\N	2011-09-04                      	7	воскресенье     	t	4	247	581	520	247
619	2011-09-11	\N	21	\N	2011-09-11                      	7	воскресенье     	t	11	254	588	527	254
626	2011-09-18	\N	21	\N	2011-09-18                      	7	воскресенье     	t	18	261	595	534	261
633	2011-09-25	\N	21	\N	2011-09-25                      	7	воскресенье     	t	25	268	602	541	268
640	2011-10-02	\N	22	\N	2011-10-02                      	7	воскресенье     	t	2	275	610	548	275
647	2011-10-09	\N	22	\N	2011-10-09                      	7	воскресенье     	t	9	282	617	555	282
654	2011-10-16	\N	22	\N	2011-10-16                      	7	воскресенье     	t	16	289	624	562	289
661	2011-10-23	\N	22	\N	2011-10-23                      	7	воскресенье     	t	23	296	631	569	296
668	2011-10-30	\N	22	\N	2011-10-30                      	7	воскресенье     	t	30	303	638	576	303
675	2011-11-06	\N	23	\N	2011-11-06                      	7	воскресенье     	t	6	310	644	583	310
682	2011-11-13	\N	23	\N	2011-11-13                      	7	воскресенье     	t	13	317	651	590	317
689	2011-11-20	\N	23	\N	2011-11-20                      	7	воскресенье     	t	20	324	658	597	324
696	2011-11-27	\N	23	\N	2011-11-27                      	7	воскресенье     	t	27	331	665	604	331
703	2011-12-04	\N	24	\N	2011-12-04                      	7	воскресенье     	t	4	338	673	612	338
710	2011-12-11	\N	24	\N	2011-12-11                      	7	воскресенье     	t	11	345	680	619	345
717	2011-12-18	\N	24	\N	2011-12-18                      	7	воскресенье     	t	18	352	687	626	352
724	2011-12-25	\N	24	\N	2011-12-25                      	7	воскресенье     	t	25	359	694	633	359
731	2012-01-01	\N	25	\N	2012-01-01                      	7	воскресенье     	t	1	1	700	639	366
738	2012-01-08	\N	25	\N	2012-01-08                      	7	воскресенье     	t	8	8	707	646	373
745	2012-01-15	\N	25	\N	2012-01-15                      	7	воскресенье     	t	15	15	714	653	380
752	2012-01-22	\N	25	\N	2012-01-22                      	7	воскресенье     	t	22	22	721	660	387
759	2012-01-29	\N	25	\N	2012-01-29                      	7	воскресенье     	t	29	29	728	667	394
766	2012-02-05	\N	26	\N	2012-02-05                      	7	воскресенье     	t	5	36	735	674	401
773	2012-02-12	\N	26	\N	2012-02-12                      	7	воскресенье     	t	12	43	742	681	408
780	2012-02-19	\N	26	\N	2012-02-19                      	7	воскресенье     	t	19	50	749	688	415
787	2012-02-26	\N	26	\N	2012-02-26                      	7	воскресенье     	t	26	57	756	695	422
794	2012-03-04	\N	27	\N	2012-03-04                      	7	воскресенье     	t	4	64	765	703	428
801	2012-03-11	\N	27	\N	2012-03-11                      	7	воскресенье     	t	11	71	772	710	435
808	2012-03-18	\N	27	\N	2012-03-18                      	7	воскресенье     	t	18	78	779	717	442
815	2012-03-25	\N	27	\N	2012-03-25                      	7	воскресенье     	t	25	85	786	724	449
822	2012-04-01	\N	28	\N	2012-04-01                      	7	воскресенье     	t	1	92	791	731	456
829	2012-04-08	\N	28	\N	2012-04-08                      	7	воскресенье     	t	8	99	798	738	463
836	2012-04-15	\N	28	\N	2012-04-15                      	7	воскресенье     	t	15	106	805	745	470
843	2012-04-22	\N	28	\N	2012-04-22                      	7	воскресенье     	t	22	113	812	752	477
850	2012-04-29	\N	28	\N	2012-04-29                      	7	воскресенье     	t	29	120	819	759	484
857	2012-05-06	\N	29	\N	2012-05-06                      	7	воскресенье     	t	6	127	827	767	491
864	2012-05-13	\N	29	\N	2012-05-13                      	7	воскресенье     	t	13	134	834	774	498
871	2012-05-20	\N	29	\N	2012-05-20                      	7	воскресенье     	t	20	141	841	781	505
878	2012-05-27	\N	29	\N	2012-05-27                      	7	воскресенье     	t	27	148	848	788	512
885	2012-06-03	\N	30	\N	2012-06-03                      	7	воскресенье     	t	3	155	854	793	519
892	2012-06-10	\N	30	\N	2012-06-10                      	7	воскресенье     	t	10	162	861	800	526
899	2012-06-17	\N	30	\N	2012-06-17                      	7	воскресенье     	t	17	169	868	807	533
906	2012-06-24	\N	30	\N	2012-06-24                      	7	воскресенье     	t	24	176	875	814	540
913	2012-07-01	\N	31	\N	2012-07-01                      	7	воскресенье     	t	1	183	883	822	547
920	2012-07-08	\N	31	\N	2012-07-08                      	7	воскресенье     	t	8	190	890	829	554
927	2012-07-15	\N	31	\N	2012-07-15                      	7	воскресенье     	t	15	197	897	836	561
934	2012-07-22	\N	31	\N	2012-07-22                      	7	воскресенье     	t	22	204	904	843	568
941	2012-07-29	\N	31	\N	2012-07-29                      	7	воскресенье     	t	29	211	911	850	575
948	2012-08-05	\N	32	\N	2012-08-05                      	7	воскресенье     	t	5	218	917	856	582
955	2012-08-12	\N	32	\N	2012-08-12                      	7	воскресенье     	t	12	225	924	863	589
962	2012-08-19	\N	32	\N	2012-08-19                      	7	воскресенье     	t	19	232	931	870	596
969	2012-08-26	\N	32	\N	2012-08-26                      	7	воскресенье     	t	26	239	938	877	603
976	2012-09-02	\N	33	\N	2012-09-02                      	7	воскресенье     	t	2	246	945	884	610
983	2012-09-09	\N	33	\N	2012-09-09                      	7	воскресенье     	t	9	253	952	891	617
990	2012-09-16	\N	33	\N	2012-09-16                      	7	воскресенье     	t	16	260	959	898	624
997	2012-09-23	\N	33	\N	2012-09-23                      	7	воскресенье     	t	23	267	966	905	631
1004	2012-09-30	\N	33	\N	2012-09-30                      	7	воскресенье     	t	30	274	973	912	638
1011	2012-10-07	\N	34	\N	2012-10-07                      	7	воскресенье     	t	7	281	981	919	645
1018	2012-10-14	\N	34	\N	2012-10-14                      	7	воскресенье     	t	14	288	988	926	652
1025	2012-10-21	\N	34	\N	2012-10-21                      	7	воскресенье     	t	21	295	995	933	659
1032	2012-10-28	\N	34	\N	2012-10-28                      	7	воскресенье     	t	28	302	1002	940	666
1039	2012-11-04	\N	35	\N	2012-11-04                      	7	воскресенье     	t	4	309	1008	947	673
1046	2012-11-11	\N	35	\N	2012-11-11                      	7	воскресенье     	t	11	316	1015	954	680
1053	2012-11-18	\N	35	\N	2012-11-18                      	7	воскресенье     	t	18	323	1022	961	687
1060	2012-11-25	\N	35	\N	2012-11-25                      	7	воскресенье     	t	25	330	1029	968	694
1067	2012-12-02	\N	36	\N	2012-12-02                      	7	воскресенье     	t	2	337	1037	976	701
1074	2012-12-09	\N	36	\N	2012-12-09                      	7	воскресенье     	t	9	344	1044	983	708
1081	2012-12-16	\N	36	\N	2012-12-16                      	7	воскресенье     	t	16	351	1051	990	715
1088	2012-12-23	\N	36	\N	2012-12-23                      	7	воскресенье     	t	23	358	1058	997	722
1095	2012-12-30	\N	36	\N	2012-12-30                      	7	воскресенье     	t	30	365	1065	1004	729
1102	2013-01-06	\N	37	\N	2013-01-06                      	7	воскресенье     	t	6	6	1071	1010	736
1109	2013-01-13	\N	37	\N	2013-01-13                      	7	воскресенье     	t	13	13	1078	1017	743
1116	2013-01-20	\N	37	\N	2013-01-20                      	7	воскресенье     	t	20	20	1085	1024	750
1123	2013-01-27	\N	37	\N	2013-01-27                      	7	воскресенье     	t	27	27	1092	1031	757
1130	2013-02-03	\N	38	\N	2013-02-03                      	7	воскресенье     	t	3	34	1099	1038	764
1137	2013-02-10	\N	38	\N	2013-02-10                      	7	воскресенье     	t	10	41	1106	1045	771
1144	2013-02-17	\N	38	\N	2013-02-17                      	7	воскресенье     	t	17	48	1113	1052	778
1151	2013-02-24	\N	38	\N	2013-02-24                      	7	воскресенье     	t	24	55	1120	1059	785
1158	2013-03-03	\N	39	\N	2013-03-03                      	7	воскресенье     	t	3	62	1130	1068	793
1165	2013-03-10	\N	39	\N	2013-03-10                      	7	воскресенье     	t	10	69	1137	1075	800
1172	2013-03-17	\N	39	\N	2013-03-17                      	7	воскресенье     	t	17	76	1144	1082	807
1179	2013-03-24	\N	39	\N	2013-03-24                      	7	воскресенье     	t	24	83	1151	1089	814
1186	2013-03-31	\N	39	\N	2013-03-31                      	7	воскресенье     	t	31	90	1155	1096	821
1193	2013-04-07	\N	40	\N	2013-04-07                      	7	воскресенье     	t	7	97	1162	1103	828
1200	2013-04-14	\N	40	\N	2013-04-14                      	7	воскресенье     	t	14	104	1169	1110	835
1207	2013-04-21	\N	40	\N	2013-04-21                      	7	воскресенье     	t	21	111	1176	1117	842
1214	2013-04-28	\N	40	\N	2013-04-28                      	7	воскресенье     	t	28	118	1183	1124	849
1221	2013-05-05	\N	41	\N	2013-05-05                      	7	воскресенье     	t	5	125	1191	1132	856
1228	2013-05-12	\N	41	\N	2013-05-12                      	7	воскресенье     	t	12	132	1198	1139	863
1235	2013-05-19	\N	41	\N	2013-05-19                      	7	воскресенье     	t	19	139	1205	1146	870
1242	2013-05-26	\N	41	\N	2013-05-26                      	7	воскресенье     	t	26	146	1212	1153	877
1249	2013-06-02	\N	42	\N	2013-06-02                      	7	воскресенье     	t	2	153	1218	1157	884
1256	2013-06-09	\N	42	\N	2013-06-09                      	7	воскресенье     	t	9	160	1225	1164	891
1263	2013-06-16	\N	42	\N	2013-06-16                      	7	воскресенье     	t	16	167	1232	1171	898
1270	2013-06-23	\N	42	\N	2013-06-23                      	7	воскресенье     	t	23	174	1239	1178	905
1277	2013-06-30	\N	42	\N	2013-06-30                      	7	воскресенье     	t	30	181	1246	1185	912
1284	2013-07-07	\N	43	\N	2013-07-07                      	7	воскресенье     	t	7	188	1254	1193	919
1291	2013-07-14	\N	43	\N	2013-07-14                      	7	воскресенье     	t	14	195	1261	1200	926
1298	2013-07-21	\N	43	\N	2013-07-21                      	7	воскресенье     	t	21	202	1268	1207	933
1305	2013-07-28	\N	43	\N	2013-07-28                      	7	воскресенье     	t	28	209	1275	1214	940
1312	2013-08-04	\N	44	\N	2013-08-04                      	7	воскресенье     	t	4	216	1281	1220	947
1319	2013-08-11	\N	44	\N	2013-08-11                      	7	воскресенье     	t	11	223	1288	1227	954
1326	2013-08-18	\N	44	\N	2013-08-18                      	7	воскресенье     	t	18	230	1295	1234	961
1333	2013-08-25	\N	44	\N	2013-08-25                      	7	воскресенье     	t	25	237	1302	1241	968
1340	2013-09-01	\N	45	\N	2013-09-01                      	7	воскресенье     	t	1	244	1309	1248	975
1347	2013-09-08	\N	45	\N	2013-09-08                      	7	воскресенье     	t	8	251	1316	1255	982
1354	2013-09-15	\N	45	\N	2013-09-15                      	7	воскресенье     	t	15	258	1323	1262	989
1361	2013-09-22	\N	45	\N	2013-09-22                      	7	воскресенье     	t	22	265	1330	1269	996
1368	2013-09-29	\N	45	\N	2013-09-29                      	7	воскресенье     	t	29	272	1337	1276	1003
1375	2013-10-06	\N	46	\N	2013-10-06                      	7	воскресенье     	t	6	279	1345	1283	1010
1382	2013-10-13	\N	46	\N	2013-10-13                      	7	воскресенье     	t	13	286	1352	1290	1017
1389	2013-10-20	\N	46	\N	2013-10-20                      	7	воскресенье     	t	20	293	1359	1297	1024
1396	2013-10-27	\N	46	\N	2013-10-27                      	7	воскресенье     	t	27	300	1366	1304	1031
1403	2013-11-03	\N	47	\N	2013-11-03                      	7	воскресенье     	t	3	307	1372	1311	1038
1410	2013-11-10	\N	47	\N	2013-11-10                      	7	воскресенье     	t	10	314	1379	1318	1045
1417	2013-11-17	\N	47	\N	2013-11-17                      	7	воскресенье     	t	17	321	1386	1325	1052
1424	2013-11-24	\N	47	\N	2013-11-24                      	7	воскресенье     	t	24	328	1393	1332	1059
1431	2013-12-01	\N	48	\N	2013-12-01                      	7	воскресенье     	t	1	335	1401	1340	1066
1438	2013-12-08	\N	48	\N	2013-12-08                      	7	воскресенье     	t	8	342	1408	1347	1073
1445	2013-12-15	\N	48	\N	2013-12-15                      	7	воскресенье     	t	15	349	1415	1354	1080
1452	2013-12-22	\N	48	\N	2013-12-22                      	7	воскресенье     	t	22	356	1422	1361	1087
1459	2013-12-29	\N	48	\N	2013-12-29                      	7	воскресенье     	t	29	363	1429	1368	1094
1466	2014-01-05	\N	49	\N	2014-01-05                      	7	воскресенье     	t	5	5	1435	1374	1101
1473	2014-01-12	\N	49	\N	2014-01-12                      	7	воскресенье     	t	12	12	1442	1381	1108
1480	2014-01-19	\N	49	\N	2014-01-19                      	7	воскресенье     	t	19	19	1449	1388	1115
1487	2014-01-26	\N	49	\N	2014-01-26                      	7	воскресенье     	t	26	26	1456	1395	1122
1494	2014-02-02	\N	50	\N	2014-02-02                      	7	воскресенье     	t	2	33	1463	1402	1129
1501	2014-02-09	\N	50	\N	2014-02-09                      	7	воскресенье     	t	9	40	1470	1409	1136
1508	2014-02-16	\N	50	\N	2014-02-16                      	7	воскресенье     	t	16	47	1477	1416	1143
1515	2014-02-23	\N	50	\N	2014-02-23                      	7	воскресенье     	t	23	54	1484	1423	1150
1522	2014-03-02	\N	51	\N	2014-03-02                      	7	воскресенье     	t	2	61	1494	1432	1157
1529	2014-03-09	\N	51	\N	2014-03-09                      	7	воскресенье     	t	9	68	1501	1439	1164
1536	2014-03-16	\N	51	\N	2014-03-16                      	7	воскресенье     	t	16	75	1508	1446	1171
1543	2014-03-23	\N	51	\N	2014-03-23                      	7	воскресенье     	t	23	82	1515	1453	1178
1550	2014-03-30	\N	51	\N	2014-03-30                      	7	воскресенье     	t	30	89	1520	1460	1185
1557	2014-04-06	\N	52	\N	2014-04-06                      	7	воскресенье     	t	6	96	1526	1467	1192
1564	2014-04-13	\N	52	\N	2014-04-13                      	7	воскресенье     	t	13	103	1533	1474	1199
1571	2014-04-20	\N	52	\N	2014-04-20                      	7	воскресенье     	t	20	110	1540	1481	1206
1578	2014-04-27	\N	52	\N	2014-04-27                      	7	воскресенье     	t	27	117	1547	1488	1213
1585	2014-05-04	\N	53	\N	2014-05-04                      	7	воскресенье     	t	4	124	1555	1496	1220
1592	2014-05-11	\N	53	\N	2014-05-11                      	7	воскресенье     	t	11	131	1562	1503	1227
1599	2014-05-18	\N	53	\N	2014-05-18                      	7	воскресенье     	t	18	138	1569	1510	1234
1606	2014-05-25	\N	53	\N	2014-05-25                      	7	воскресенье     	t	25	145	1576	1517	1241
1613	2014-06-01	\N	54	\N	2014-06-01                      	7	воскресенье     	t	1	152	1582	1521	1248
1620	2014-06-08	\N	54	\N	2014-06-08                      	7	воскресенье     	t	8	159	1589	1528	1255
1627	2014-06-15	\N	54	\N	2014-06-15                      	7	воскресенье     	t	15	166	1596	1535	1262
1634	2014-06-22	\N	54	\N	2014-06-22                      	7	воскресенье     	t	22	173	1603	1542	1269
1641	2014-06-29	\N	54	\N	2014-06-29                      	7	воскресенье     	t	29	180	1610	1549	1276
1648	2014-07-06	\N	55	\N	2014-07-06                      	7	воскресенье     	t	6	187	1618	1557	1283
1655	2014-07-13	\N	55	\N	2014-07-13                      	7	воскресенье     	t	13	194	1625	1564	1290
1662	2014-07-20	\N	55	\N	2014-07-20                      	7	воскресенье     	t	20	201	1632	1571	1297
1669	2014-07-27	\N	55	\N	2014-07-27                      	7	воскресенье     	t	27	208	1639	1578	1304
1676	2014-08-03	\N	56	\N	2014-08-03                      	7	воскресенье     	t	3	215	1645	1584	1311
1683	2014-08-10	\N	56	\N	2014-08-10                      	7	воскресенье     	t	10	222	1652	1591	1318
1690	2014-08-17	\N	56	\N	2014-08-17                      	7	воскресенье     	t	17	229	1659	1598	1325
1697	2014-08-24	\N	56	\N	2014-08-24                      	7	воскресенье     	t	24	236	1666	1605	1332
1704	2014-08-31	\N	56	\N	2014-08-31                      	7	воскресенье     	t	31	243	1673	1612	1339
1711	2014-09-07	\N	57	\N	2014-09-07                      	7	воскресенье     	t	7	250	1680	1619	1346
1718	2014-09-14	\N	57	\N	2014-09-14                      	7	воскресенье     	t	14	257	1687	1626	1353
1725	2014-09-21	\N	57	\N	2014-09-21                      	7	воскресенье     	t	21	264	1694	1633	1360
1732	2014-09-28	\N	57	\N	2014-09-28                      	7	воскресенье     	t	28	271	1701	1640	1367
1739	2014-10-05	\N	58	\N	2014-10-05                      	7	воскресенье     	t	5	278	1709	1647	1374
1746	2014-10-12	\N	58	\N	2014-10-12                      	7	воскресенье     	t	12	285	1716	1654	1381
1753	2014-10-19	\N	58	\N	2014-10-19                      	7	воскресенье     	t	19	292	1723	1661	1388
1760	2014-10-26	\N	58	\N	2014-10-26                      	7	воскресенье     	t	26	299	1730	1668	1395
1767	2014-11-02	\N	59	\N	2014-11-02                      	7	воскресенье     	t	2	306	1736	1675	1402
1774	2014-11-09	\N	59	\N	2014-11-09                      	7	воскресенье     	t	9	313	1743	1682	1409
1781	2014-11-16	\N	59	\N	2014-11-16                      	7	воскресенье     	t	16	320	1750	1689	1416
1788	2014-11-23	\N	59	\N	2014-11-23                      	7	воскресенье     	t	23	327	1757	1696	1423
1795	2014-11-30	\N	59	\N	2014-11-30                      	7	воскресенье     	t	30	334	1764	1703	1430
1802	2014-12-07	\N	60	\N	2014-12-07                      	7	воскресенье     	t	7	341	1772	1711	1437
1816	2014-12-21	\N	60	\N	2014-12-21                      	7	воскресенье     	t	21	355	1786	1725	1451
1823	2014-12-28	\N	60	\N	2014-12-28                      	7	воскресенье     	t	28	362	1793	1732	1458
1830	2015-01-04	\N	61	\N	2015-01-04                      	7	воскресенье     	t	4	4	1799	1738	1465
1837	2015-01-11	\N	61	\N	2015-01-11                      	7	воскресенье     	t	11	11	1806	1745	1472
1844	2015-01-18	\N	61	\N	2015-01-18                      	7	воскресенье     	t	18	18	1813	1752	1479
1851	2015-01-25	\N	61	\N	2015-01-25                      	7	воскресенье     	t	25	25	1820	1759	1486
1858	2015-02-01	\N	62	\N	2015-02-01                      	7	воскресенье     	t	1	32	1827	1766	1493
1865	2015-02-08	\N	62	\N	2015-02-08                      	7	воскресенье     	t	8	39	1834	1773	1500
1872	2015-02-15	\N	62	\N	2015-02-15                      	7	воскресенье     	t	15	46	1841	1780	1507
1879	2015-02-22	\N	62	\N	2015-02-22                      	7	воскресенье     	t	22	53	1848	1787	1514
1886	2015-03-01	\N	63	\N	2015-03-01                      	7	воскресенье     	t	1	60	1858	1796	1521
1893	2015-03-08	\N	63	\N	2015-03-08                      	7	воскресенье     	t	8	67	1865	1803	1528
1907	2015-03-22	\N	63	\N	2015-03-22                      	7	воскресенье     	t	22	81	1879	1817	1542
1914	2015-03-29	\N	63	\N	2015-03-29                      	7	воскресенье     	t	29	88	1885	1824	1549
1921	2015-04-05	\N	64	\N	2015-04-05                      	7	воскресенье     	t	5	95	1890	1831	1556
1928	2015-04-12	\N	64	\N	2015-04-12                      	7	воскресенье     	t	12	102	1897	1838	1563
1935	2015-04-19	\N	64	\N	2015-04-19                      	7	воскресенье     	t	19	109	1904	1845	1570
1942	2015-04-26	\N	64	\N	2015-04-26                      	7	воскресенье     	t	26	116	1911	1852	1577
1949	2015-05-03	\N	65	\N	2015-05-03                      	7	воскресенье     	t	3	123	1919	1860	1584
1956	2015-05-10	\N	65	\N	2015-05-10                      	7	воскресенье     	t	10	130	1926	1867	1591
1963	2015-05-17	\N	65	\N	2015-05-17                      	7	воскресенье     	t	17	137	1933	1874	1598
1970	2015-05-24	\N	65	\N	2015-05-24                      	7	воскресенье     	t	24	144	1940	1881	1605
1977	2015-05-31	\N	65	\N	2015-05-31                      	7	воскресенье     	t	31	151	1946	1885	1612
1984	2015-06-07	\N	66	\N	2015-06-07                      	7	воскресенье     	t	7	158	1953	1892	1619
1991	2015-06-14	\N	66	\N	2015-06-14                      	7	воскресенье     	t	14	165	1960	1899	1626
1998	2015-06-21	\N	66	\N	2015-06-21                      	7	воскресенье     	t	21	172	1967	1906	1633
2005	2015-06-28	\N	66	\N	2015-06-28                      	7	воскресенье     	t	28	179	1974	1913	1640
2012	2015-07-05	\N	67	\N	2015-07-05                      	7	воскресенье     	t	5	186	1982	1921	1647
2019	2015-07-12	\N	67	\N	2015-07-12                      	7	воскресенье     	t	12	193	1989	1928	1654
2026	2015-07-19	\N	67	\N	2015-07-19                      	7	воскресенье     	t	19	200	1996	1935	1661
2033	2015-07-26	\N	67	\N	2015-07-26                      	7	воскресенье     	t	26	207	2003	1942	1668
2040	2015-08-02	\N	68	\N	2015-08-02                      	7	воскресенье     	t	2	214	2009	1948	1675
2047	2015-08-09	\N	68	\N	2015-08-09                      	7	воскресенье     	t	9	221	2016	1955	1682
2054	2015-08-16	\N	68	\N	2015-08-16                      	7	воскресенье     	t	16	228	2023	1962	1689
2061	2015-08-23	\N	68	\N	2015-08-23                      	7	воскресенье     	t	23	235	2030	1969	1696
2068	2015-08-30	\N	68	\N	2015-08-30                      	7	воскресенье     	t	30	242	2037	1976	1703
2075	2015-09-06	\N	69	\N	2015-09-06                      	7	воскресенье     	t	6	249	2044	1983	1710
2082	2015-09-13	\N	69	\N	2015-09-13                      	7	воскресенье     	t	13	256	2051	1990	1717
2089	2015-09-20	\N	69	\N	2015-09-20                      	7	воскресенье     	t	20	263	2058	1997	1724
2096	2015-09-27	\N	69	\N	2015-09-27                      	7	воскресенье     	t	27	270	2065	2004	1731
2103	2015-10-04	\N	70	\N	2015-10-04                      	7	воскресенье     	t	4	277	2073	2011	1738
2110	2015-10-11	\N	70	\N	2015-10-11                      	7	воскресенье     	t	11	284	2080	2018	1745
2117	2015-10-18	\N	70	\N	2015-10-18                      	7	воскресенье     	t	18	291	2087	2025	1752
2124	2015-10-25	\N	70	\N	2015-10-25                      	7	воскресенье     	t	25	298	2094	2032	1759
2131	2015-11-01	\N	71	\N	2015-11-01                      	7	воскресенье     	t	1	305	2100	2039	1766
2138	2015-11-08	\N	71	\N	2015-11-08                      	7	воскресенье     	t	8	312	2107	2046	1773
2145	2015-11-15	\N	71	\N	2015-11-15                      	7	воскресенье     	t	15	319	2114	2053	1780
2152	2015-11-22	\N	71	\N	2015-11-22                      	7	воскресенье     	t	22	326	2121	2060	1787
2159	2015-11-29	\N	71	\N	2015-11-29                      	7	воскресенье     	t	29	333	2128	2067	1794
2166	2015-12-06	\N	72	\N	2015-12-06                      	7	воскресенье     	t	6	340	2136	2075	1801
2173	2015-12-13	\N	72	\N	2015-12-13                      	7	воскресенье     	t	13	347	2143	2082	1808
2180	2015-12-20	\N	72	\N	2015-12-20                      	7	воскресенье     	t	20	354	2150	2089	1815
2187	2015-12-27	\N	72	\N	2015-12-27                      	7	воскресенье     	t	27	361	2157	2096	1822
2194	2016-01-03	\N	73	\N	2016-01-03                      	7	воскресенье     	t	3	3	2163	2102	1829
2201	2016-01-10	\N	73	\N	2016-01-10                      	7	воскресенье     	t	10	10	2170	2109	1836
2208	2016-01-17	\N	73	\N	2016-01-17                      	7	воскресенье     	t	17	17	2177	2116	1843
2215	2016-01-24	\N	73	\N	2016-01-24                      	7	воскресенье     	t	24	24	2184	2123	1850
2222	2016-01-31	\N	73	\N	2016-01-31                      	7	воскресенье     	t	31	31	2191	2130	1857
2229	2016-02-07	\N	74	\N	2016-02-07                      	7	воскресенье     	t	7	38	2198	2137	1864
2236	2016-02-14	\N	74	\N	2016-02-14                      	7	воскресенье     	t	14	45	2205	2144	1871
2243	2016-02-21	\N	74	\N	2016-02-21                      	7	воскресенье     	t	21	52	2212	2151	1878
2250	2016-02-28	\N	74	\N	2016-02-28                      	7	воскресенье     	t	28	59	2219	2158	1885
2257	2016-03-06	\N	75	\N	2016-03-06                      	7	воскресенье     	t	6	66	2228	2166	1891
2264	2016-03-13	\N	75	\N	2016-03-13                      	7	воскресенье     	t	13	73	2235	2173	1898
2271	2016-03-20	\N	75	\N	2016-03-20                      	7	воскресенье     	t	20	80	2242	2180	1905
2278	2016-03-27	\N	75	\N	2016-03-27                      	7	воскресенье     	t	27	87	2249	2187	1912
2285	2016-04-03	\N	76	\N	2016-04-03                      	7	воскресенье     	t	3	94	2254	2194	1919
2292	2016-04-10	\N	76	\N	2016-04-10                      	7	воскресенье     	t	10	101	2261	2201	1926
2299	2016-04-17	\N	76	\N	2016-04-17                      	7	воскресенье     	t	17	108	2268	2208	1933
2306	2016-04-24	\N	76	\N	2016-04-24                      	7	воскресенье     	t	24	115	2275	2215	1940
2313	2016-05-01	\N	77	\N	2016-05-01                      	7	воскресенье     	t	1	122	2283	2223	1947
2320	2016-05-08	\N	77	\N	2016-05-08                      	7	воскресенье     	t	8	129	2290	2230	1954
2327	2016-05-15	\N	77	\N	2016-05-15                      	7	воскресенье     	t	15	136	2297	2237	1961
2334	2016-05-22	\N	77	\N	2016-05-22                      	7	воскресенье     	t	22	143	2304	2244	1968
2341	2016-05-29	\N	77	\N	2016-05-29                      	7	воскресенье     	t	29	150	2311	2251	1975
2348	2016-06-05	\N	78	\N	2016-06-05                      	7	воскресенье     	t	5	157	2317	2256	1982
2355	2016-06-12	\N	78	\N	2016-06-12                      	7	воскресенье     	t	12	164	2324	2263	1989
2362	2016-06-19	\N	78	\N	2016-06-19                      	7	воскресенье     	t	19	171	2331	2270	1996
2369	2016-06-26	\N	78	\N	2016-06-26                      	7	воскресенье     	t	26	178	2338	2277	2003
2376	2016-07-03	\N	79	\N	2016-07-03                      	7	воскресенье     	t	3	185	2346	2285	2010
2383	2016-07-10	\N	79	\N	2016-07-10                      	7	воскресенье     	t	10	192	2353	2292	2017
2390	2016-07-17	\N	79	\N	2016-07-17                      	7	воскресенье     	t	17	199	2360	2299	2024
2397	2016-07-24	\N	79	\N	2016-07-24                      	7	воскресенье     	t	24	206	2367	2306	2031
2404	2016-07-31	\N	79	\N	2016-07-31                      	7	воскресенье     	t	31	213	2373	2312	2038
2411	2016-08-07	\N	80	\N	2016-08-07                      	7	воскресенье     	t	7	220	2380	2319	2045
2418	2016-08-14	\N	80	\N	2016-08-14                      	7	воскресенье     	t	14	227	2387	2326	2052
2425	2016-08-21	\N	80	\N	2016-08-21                      	7	воскресенье     	t	21	234	2394	2333	2059
2432	2016-08-28	\N	80	\N	2016-08-28                      	7	воскресенье     	t	28	241	2401	2340	2066
2439	2016-09-04	\N	81	\N	2016-09-04                      	7	воскресенье     	t	4	248	2408	2347	2073
2446	2016-09-11	\N	81	\N	2016-09-11                      	7	воскресенье     	t	11	255	2415	2354	2080
2453	2016-09-18	\N	81	\N	2016-09-18                      	7	воскресенье     	t	18	262	2422	2361	2087
2460	2016-09-25	\N	81	\N	2016-09-25                      	7	воскресенье     	t	25	269	2429	2368	2094
2467	2016-10-02	\N	82	\N	2016-10-02                      	7	воскресенье     	t	2	276	2437	2375	2101
2474	2016-10-09	\N	82	\N	2016-10-09                      	7	воскресенье     	t	9	283	2444	2382	2108
2481	2016-10-16	\N	82	\N	2016-10-16                      	7	воскресенье     	t	16	290	2451	2389	2115
2488	2016-10-23	\N	82	\N	2016-10-23                      	7	воскресенье     	t	23	297	2458	2396	2122
2495	2016-10-30	\N	82	\N	2016-10-30                      	7	воскресенье     	t	30	304	2465	2403	2129
2502	2016-11-06	\N	83	\N	2016-11-06                      	7	воскресенье     	t	6	311	2471	2410	2136
2509	2016-11-13	\N	83	\N	2016-11-13                      	7	воскресенье     	t	13	318	2478	2417	2143
2516	2016-11-20	\N	83	\N	2016-11-20                      	7	воскресенье     	t	20	325	2485	2424	2150
2523	2016-11-27	\N	83	\N	2016-11-27                      	7	воскресенье     	t	27	332	2492	2431	2157
2530	2016-12-04	\N	84	\N	2016-12-04                      	7	воскресенье     	t	4	339	2500	2439	2164
2537	2016-12-11	\N	84	\N	2016-12-11                      	7	воскресенье     	t	11	346	2507	2446	2171
2544	2016-12-18	\N	84	\N	2016-12-18                      	7	воскресенье     	t	18	353	2514	2453	2178
2551	2016-12-25	\N	84	\N	2016-12-25                      	7	воскресенье     	t	25	360	2521	2460	2185
2558	2017-01-01	\N	85	\N	2017-01-01                      	7	воскресенье     	t	1	1	2527	2466	2192
2565	2017-01-08	\N	85	\N	2017-01-08                      	7	воскресенье     	t	8	8	2534	2473	2199
2572	2017-01-15	\N	85	\N	2017-01-15                      	7	воскресенье     	t	15	15	2541	2480	2206
2579	2017-01-22	\N	85	\N	2017-01-22                      	7	воскресенье     	t	22	22	2548	2487	2213
2586	2017-01-29	\N	85	\N	2017-01-29                      	7	воскресенье     	t	29	29	2555	2494	2220
2593	2017-02-05	\N	86	\N	2017-02-05                      	7	воскресенье     	t	5	36	2562	2501	2227
2600	2017-02-12	\N	86	\N	2017-02-12                      	7	воскресенье     	t	12	43	2569	2508	2234
2607	2017-02-19	\N	86	\N	2017-02-19                      	7	воскресенье     	t	19	50	2576	2515	2241
2614	2017-02-26	\N	86	\N	2017-02-26                      	7	воскресенье     	t	26	57	2583	2522	2248
2621	2017-03-05	\N	87	\N	2017-03-05                      	7	воскресенье     	t	5	64	2593	2531	2256
2628	2017-03-12	\N	87	\N	2017-03-12                      	7	воскресенье     	t	12	71	2600	2538	2263
2635	2017-03-19	\N	87	\N	2017-03-19                      	7	воскресенье     	t	19	78	2607	2545	2270
2642	2017-03-26	\N	87	\N	2017-03-26                      	7	воскресенье     	t	26	85	2614	2552	2277
2649	2017-04-02	\N	88	\N	2017-04-02                      	7	воскресенье     	t	2	92	2618	2559	2284
2656	2017-04-09	\N	88	\N	2017-04-09                      	7	воскресенье     	t	9	99	2625	2566	2291
2663	2017-04-16	\N	88	\N	2017-04-16                      	7	воскресенье     	t	16	106	2632	2573	2298
2670	2017-04-23	\N	88	\N	2017-04-23                      	7	воскресенье     	t	23	113	2639	2580	2305
2677	2017-04-30	\N	88	\N	2017-04-30                      	7	воскресенье     	t	30	120	2646	2587	2312
2684	2017-05-07	\N	89	\N	2017-05-07                      	7	воскресенье     	t	7	127	2654	2595	2319
2691	2017-05-14	\N	89	\N	2017-05-14                      	7	воскресенье     	t	14	134	2661	2602	2326
2698	2017-05-21	\N	89	\N	2017-05-21                      	7	воскресенье     	t	21	141	2668	2609	2333
2705	2017-05-28	\N	89	\N	2017-05-28                      	7	воскресенье     	t	28	148	2675	2616	2340
2712	2017-06-04	\N	90	\N	2017-06-04                      	7	воскресенье     	t	4	155	2681	2620	2347
2719	2017-06-11	\N	90	\N	2017-06-11                      	7	воскресенье     	t	11	162	2688	2627	2354
2726	2017-06-18	\N	90	\N	2017-06-18                      	7	воскресенье     	t	18	169	2695	2634	2361
2733	2017-06-25	\N	90	\N	2017-06-25                      	7	воскресенье     	t	25	176	2702	2641	2368
2740	2017-07-02	\N	91	\N	2017-07-02                      	7	воскресенье     	t	2	183	2710	2649	2375
2747	2017-07-09	\N	91	\N	2017-07-09                      	7	воскресенье     	t	9	190	2717	2656	2382
2754	2017-07-16	\N	91	\N	2017-07-16                      	7	воскресенье     	t	16	197	2724	2663	2389
2761	2017-07-23	\N	91	\N	2017-07-23                      	7	воскресенье     	t	23	204	2731	2670	2396
2768	2017-07-30	\N	91	\N	2017-07-30                      	7	воскресенье     	t	30	211	2738	2677	2403
2775	2017-08-06	\N	92	\N	2017-08-06                      	7	воскресенье     	t	6	218	2744	2683	2410
2782	2017-08-13	\N	92	\N	2017-08-13                      	7	воскресенье     	t	13	225	2751	2690	2417
2789	2017-08-20	\N	92	\N	2017-08-20                      	7	воскресенье     	t	20	232	2758	2697	2424
2796	2017-08-27	\N	92	\N	2017-08-27                      	7	воскресенье     	t	27	239	2765	2704	2431
2803	2017-09-03	\N	93	\N	2017-09-03                      	7	воскресенье     	t	3	246	2772	2711	2438
2810	2017-09-10	\N	93	\N	2017-09-10                      	7	воскресенье     	t	10	253	2779	2718	2445
2817	2017-09-17	\N	93	\N	2017-09-17                      	7	воскресенье     	t	17	260	2786	2725	2452
2824	2017-09-24	\N	93	\N	2017-09-24                      	7	воскресенье     	t	24	267	2793	2732	2459
2831	2017-10-01	\N	94	\N	2017-10-01                      	7	воскресенье     	t	1	274	2801	2739	2466
2838	2017-10-08	\N	94	\N	2017-10-08                      	7	воскресенье     	t	8	281	2808	2746	2473
2845	2017-10-15	\N	94	\N	2017-10-15                      	7	воскресенье     	t	15	288	2815	2753	2480
2852	2017-10-22	\N	94	\N	2017-10-22                      	7	воскресенье     	t	22	295	2822	2760	2487
2859	2017-10-29	\N	94	\N	2017-10-29                      	7	воскресенье     	t	29	302	2829	2767	2494
2866	2017-11-05	\N	95	\N	2017-11-05                      	7	воскресенье     	t	5	309	2835	2774	2501
2873	2017-11-12	\N	95	\N	2017-11-12                      	7	воскресенье     	t	12	316	2842	2781	2508
2880	2017-11-19	\N	95	\N	2017-11-19                      	7	воскресенье     	t	19	323	2849	2788	2515
2887	2017-11-26	\N	95	\N	2017-11-26                      	7	воскресенье     	t	26	330	2856	2795	2522
2894	2017-12-03	\N	96	\N	2017-12-03                      	7	воскресенье     	t	3	337	2864	2803	2529
2901	2017-12-10	\N	96	\N	2017-12-10                      	7	воскресенье     	t	10	344	2871	2810	2536
2908	2017-12-17	\N	96	\N	2017-12-17                      	7	воскресенье     	t	17	351	2878	2817	2543
2915	2017-12-24	\N	96	\N	2017-12-24                      	7	воскресенье     	t	24	358	2885	2824	2550
2922	2017-12-31	\N	96	\N	2017-12-31                      	7	воскресенье     	t	31	365	2891	2830	2557
2929	2018-01-07	\N	97	\N	2018-01-07                      	7	воскресенье     	t	7	7	2898	2837	2564
2936	2018-01-14	\N	97	\N	2018-01-14                      	7	воскресенье     	t	14	14	2905	2844	2571
2943	2018-01-21	\N	97	\N	2018-01-21                      	7	воскресенье     	t	21	21	2912	2851	2578
2950	2018-01-28	\N	97	\N	2018-01-28                      	7	воскресенье     	t	28	28	2919	2858	2585
2957	2018-02-04	\N	98	\N	2018-02-04                      	7	воскресенье     	t	4	35	2926	2865	2592
2964	2018-02-11	\N	98	\N	2018-02-11                      	7	воскресенье     	t	11	42	2933	2872	2599
2971	2018-02-18	\N	98	\N	2018-02-18                      	7	воскресенье     	t	18	49	2940	2879	2606
2978	2018-02-25	\N	98	\N	2018-02-25                      	7	воскресенье     	t	25	56	2947	2886	2613
2985	2018-03-04	\N	99	\N	2018-03-04                      	7	воскресенье     	t	4	63	2957	2895	2620
2992	2018-03-11	\N	99	\N	2018-03-11                      	7	воскресенье     	t	11	70	2964	2902	2627
2999	2018-03-18	\N	99	\N	2018-03-18                      	7	воскресенье     	t	18	77	2971	2909	2634
3006	2018-03-25	\N	99	\N	2018-03-25                      	7	воскресенье     	t	25	84	2978	2916	2641
3013	2018-04-01	\N	100	\N	2018-04-01                      	7	воскресенье     	t	1	91	2982	2923	2648
3020	2018-04-08	\N	100	\N	2018-04-08                      	7	воскресенье     	t	8	98	2989	2930	2655
3027	2018-04-15	\N	100	\N	2018-04-15                      	7	воскресенье     	t	15	105	2996	2937	2662
3034	2018-04-22	\N	100	\N	2018-04-22                      	7	воскресенье     	t	22	112	3003	2944	2669
3041	2018-04-29	\N	100	\N	2018-04-29                      	7	воскресенье     	t	29	119	3010	2951	2676
3048	2018-05-06	\N	101	\N	2018-05-06                      	7	воскресенье     	t	6	126	3018	2959	2683
3055	2018-05-13	\N	101	\N	2018-05-13                      	7	воскресенье     	t	13	133	3025	2966	2690
3062	2018-05-20	\N	101	\N	2018-05-20                      	7	воскресенье     	t	20	140	3032	2973	2697
3069	2018-05-27	\N	101	\N	2018-05-27                      	7	воскресенье     	t	27	147	3039	2980	2704
3076	2018-06-03	\N	102	\N	2018-06-03                      	7	воскресенье     	t	3	154	3045	2984	2711
3083	2018-06-10	\N	102	\N	2018-06-10                      	7	воскресенье     	t	10	161	3052	2991	2718
3090	2018-06-17	\N	102	\N	2018-06-17                      	7	воскресенье     	t	17	168	3059	2998	2725
3097	2018-06-24	\N	102	\N	2018-06-24                      	7	воскресенье     	t	24	175	3066	3005	2732
3104	2018-07-01	\N	103	\N	2018-07-01                      	7	воскресенье     	t	1	182	3074	3013	2739
3111	2018-07-08	\N	103	\N	2018-07-08                      	7	воскресенье     	t	8	189	3081	3020	2746
3118	2018-07-15	\N	103	\N	2018-07-15                      	7	воскресенье     	t	15	196	3088	3027	2753
3125	2018-07-22	\N	103	\N	2018-07-22                      	7	воскресенье     	t	22	203	3095	3034	2760
3132	2018-07-29	\N	103	\N	2018-07-29                      	7	воскресенье     	t	29	210	3102	3041	2767
3139	2018-08-05	\N	104	\N	2018-08-05                      	7	воскресенье     	t	5	217	3108	3047	2774
3146	2018-08-12	\N	104	\N	2018-08-12                      	7	воскресенье     	t	12	224	3115	3054	2781
3153	2018-08-19	\N	104	\N	2018-08-19                      	7	воскресенье     	t	19	231	3122	3061	2788
3160	2018-08-26	\N	104	\N	2018-08-26                      	7	воскресенье     	t	26	238	3129	3068	2795
3167	2018-09-02	\N	105	\N	2018-09-02                      	7	воскресенье     	t	2	245	3136	3075	2802
3174	2018-09-09	\N	105	\N	2018-09-09                      	7	воскресенье     	t	9	252	3143	3082	2809
3181	2018-09-16	\N	105	\N	2018-09-16                      	7	воскресенье     	t	16	259	3150	3089	2816
3188	2018-09-23	\N	105	\N	2018-09-23                      	7	воскресенье     	t	23	266	3157	3096	2823
3195	2018-09-30	\N	105	\N	2018-09-30                      	7	воскресенье     	t	30	273	3164	3103	2830
3202	2018-10-07	\N	106	\N	2018-10-07                      	7	воскресенье     	t	7	280	3172	3110	2837
3209	2018-10-14	\N	106	\N	2018-10-14                      	7	воскресенье     	t	14	287	3179	3117	2844
3216	2018-10-21	\N	106	\N	2018-10-21                      	7	воскресенье     	t	21	294	3186	3124	2851
3223	2018-10-28	\N	106	\N	2018-10-28                      	7	воскресенье     	t	28	301	3193	3131	2858
3230	2018-11-04	\N	107	\N	2018-11-04                      	7	воскресенье     	t	4	308	3199	3138	2865
3237	2018-11-11	\N	107	\N	2018-11-11                      	7	воскресенье     	t	11	315	3206	3145	2872
3244	2018-11-18	\N	107	\N	2018-11-18                      	7	воскресенье     	t	18	322	3213	3152	2879
3251	2018-11-25	\N	107	\N	2018-11-25                      	7	воскресенье     	t	25	329	3220	3159	2886
3258	2018-12-02	\N	108	\N	2018-12-02                      	7	воскресенье     	t	2	336	3228	3167	2893
3265	2018-12-09	\N	108	\N	2018-12-09                      	7	воскресенье     	t	9	343	3235	3174	2900
3272	2018-12-16	\N	108	\N	2018-12-16                      	7	воскресенье     	t	16	350	3242	3181	2907
3279	2018-12-23	\N	108	\N	2018-12-23                      	7	воскресенье     	t	23	357	3249	3188	2914
3286	2018-12-30	\N	108	\N	2018-12-30                      	7	воскресенье     	t	30	364	3256	3195	2921
3293	2019-01-06	\N	109	\N	2019-01-06                      	7	воскресенье     	t	6	6	3262	3201	2928
3300	2019-01-13	\N	109	\N	2019-01-13                      	7	воскресенье     	t	13	13	3269	3208	2935
3307	2019-01-20	\N	109	\N	2019-01-20                      	7	воскресенье     	t	20	20	3276	3215	2942
3314	2019-01-27	\N	109	\N	2019-01-27                      	7	воскресенье     	t	27	27	3283	3222	2949
3321	2019-02-03	\N	110	\N	2019-02-03                      	7	воскресенье     	t	3	34	3290	3229	2956
3328	2019-02-10	\N	110	\N	2019-02-10                      	7	воскресенье     	t	10	41	3297	3236	2963
3335	2019-02-17	\N	110	\N	2019-02-17                      	7	воскресенье     	t	17	48	3304	3243	2970
3342	2019-02-24	\N	110	\N	2019-02-24                      	7	воскресенье     	t	24	55	3311	3250	2977
3349	2019-03-03	\N	111	\N	2019-03-03                      	7	воскресенье     	t	3	62	3321	3259	2984
3356	2019-03-10	\N	111	\N	2019-03-10                      	7	воскресенье     	t	10	69	3328	3266	2991
3363	2019-03-17	\N	111	\N	2019-03-17                      	7	воскресенье     	t	17	76	3335	3273	2998
3370	2019-03-24	\N	111	\N	2019-03-24                      	7	воскресенье     	t	24	83	3342	3280	3005
3377	2019-03-31	\N	111	\N	2019-03-31                      	7	воскресенье     	t	31	90	3346	3287	3012
3384	2019-04-07	\N	112	\N	2019-04-07                      	7	воскресенье     	t	7	97	3353	3294	3019
3391	2019-04-14	\N	112	\N	2019-04-14                      	7	воскресенье     	t	14	104	3360	3301	3026
3398	2019-04-21	\N	112	\N	2019-04-21                      	7	воскресенье     	t	21	111	3367	3308	3033
3405	2019-04-28	\N	112	\N	2019-04-28                      	7	воскресенье     	t	28	118	3374	3315	3040
3412	2019-05-05	\N	113	\N	2019-05-05                      	7	воскресенье     	t	5	125	3382	3323	3047
3419	2019-05-12	\N	113	\N	2019-05-12                      	7	воскресенье     	t	12	132	3389	3330	3054
3426	2019-05-19	\N	113	\N	2019-05-19                      	7	воскресенье     	t	19	139	3396	3337	3061
3433	2019-05-26	\N	113	\N	2019-05-26                      	7	воскресенье     	t	26	146	3403	3344	3068
3440	2019-06-02	\N	114	\N	2019-06-02                      	7	воскресенье     	t	2	153	3409	3348	3075
3447	2019-06-09	\N	114	\N	2019-06-09                      	7	воскресенье     	t	9	160	3416	3355	3082
3454	2019-06-16	\N	114	\N	2019-06-16                      	7	воскресенье     	t	16	167	3423	3362	3089
3461	2019-06-23	\N	114	\N	2019-06-23                      	7	воскресенье     	t	23	174	3430	3369	3096
3468	2019-06-30	\N	114	\N	2019-06-30                      	7	воскресенье     	t	30	181	3437	3376	3103
3475	2019-07-07	\N	115	\N	2019-07-07                      	7	воскресенье     	t	7	188	3445	3384	3110
3482	2019-07-14	\N	115	\N	2019-07-14                      	7	воскресенье     	t	14	195	3452	3391	3117
3489	2019-07-21	\N	115	\N	2019-07-21                      	7	воскресенье     	t	21	202	3459	3398	3124
3496	2019-07-28	\N	115	\N	2019-07-28                      	7	воскресенье     	t	28	209	3466	3405	3131
3503	2019-08-04	\N	116	\N	2019-08-04                      	7	воскресенье     	t	4	216	3472	3411	3138
3510	2019-08-11	\N	116	\N	2019-08-11                      	7	воскресенье     	t	11	223	3479	3418	3145
3517	2019-08-18	\N	116	\N	2019-08-18                      	7	воскресенье     	t	18	230	3486	3425	3152
3524	2019-08-25	\N	116	\N	2019-08-25                      	7	воскресенье     	t	25	237	3493	3432	3159
3531	2019-09-01	\N	117	\N	2019-09-01                      	7	воскресенье     	t	1	244	3500	3439	3166
3538	2019-09-08	\N	117	\N	2019-09-08                      	7	воскресенье     	t	8	251	3507	3446	3173
3545	2019-09-15	\N	117	\N	2019-09-15                      	7	воскресенье     	t	15	258	3514	3453	3180
3552	2019-09-22	\N	117	\N	2019-09-22                      	7	воскресенье     	t	22	265	3521	3460	3187
3559	2019-09-29	\N	117	\N	2019-09-29                      	7	воскресенье     	t	29	272	3528	3467	3194
3566	2019-10-06	\N	118	\N	2019-10-06                      	7	воскресенье     	t	6	279	3536	3474	3201
3573	2019-10-13	\N	118	\N	2019-10-13                      	7	воскресенье     	t	13	286	3543	3481	3208
3580	2019-10-20	\N	118	\N	2019-10-20                      	7	воскресенье     	t	20	293	3550	3488	3215
3587	2019-10-27	\N	118	\N	2019-10-27                      	7	воскресенье     	t	27	300	3557	3495	3222
3594	2019-11-03	\N	119	\N	2019-11-03                      	7	воскресенье     	t	3	307	3563	3502	3229
3601	2019-11-10	\N	119	\N	2019-11-10                      	7	воскресенье     	t	10	314	3570	3509	3236
3608	2019-11-17	\N	119	\N	2019-11-17                      	7	воскресенье     	t	17	321	3577	3516	3243
3615	2019-11-24	\N	119	\N	2019-11-24                      	7	воскресенье     	t	24	328	3584	3523	3250
3622	2019-12-01	\N	120	\N	2019-12-01                      	7	воскресенье     	t	1	335	3592	3531	3257
3629	2019-12-08	\N	120	\N	2019-12-08                      	7	воскресенье     	t	8	342	3599	3538	3264
3636	2019-12-15	\N	120	\N	2019-12-15                      	7	воскресенье     	t	15	349	3606	3545	3271
3643	2019-12-22	\N	120	\N	2019-12-22                      	7	воскресенье     	t	22	356	3613	3552	3278
3650	2019-12-29	\N	120	\N	2019-12-29                      	7	воскресенье     	t	29	363	3620	3559	3285
3657	2020-01-05	\N	121	\N	2020-01-05                      	7	воскресенье     	t	5	5	3626	3565	3292
3664	2020-01-12	\N	121	\N	2020-01-12                      	7	воскресенье     	t	12	12	3633	3572	3299
3671	2020-01-19	\N	121	\N	2020-01-19                      	7	воскресенье     	t	19	19	3640	3579	3306
3678	2020-01-26	\N	121	\N	2020-01-26                      	7	воскресенье     	t	26	26	3647	3586	3313
3685	2020-02-02	\N	122	\N	2020-02-02                      	7	воскресенье     	t	2	33	3654	3593	3320
3692	2020-02-09	\N	122	\N	2020-02-09                      	7	воскресенье     	t	9	40	3661	3600	3327
3699	2020-02-16	\N	122	\N	2020-02-16                      	7	воскресенье     	t	16	47	3668	3607	3334
3706	2020-02-23	\N	122	\N	2020-02-23                      	7	воскресенье     	t	23	54	3675	3614	3341
3713	2020-03-01	\N	123	\N	2020-03-01                      	7	воскресенье     	t	1	61	3684	3622	3347
3720	2020-03-08	\N	123	\N	2020-03-08                      	7	воскресенье     	t	8	68	3691	3629	3354
3727	2020-03-15	\N	123	\N	2020-03-15                      	7	воскресенье     	t	15	75	3698	3636	3361
3734	2020-03-22	\N	123	\N	2020-03-22                      	7	воскресенье     	t	22	82	3705	3643	3368
3741	2020-03-29	\N	123	\N	2020-03-29                      	7	воскресенье     	t	29	89	3712	3650	3375
3748	2020-04-05	\N	124	\N	2020-04-05                      	7	воскресенье     	t	5	96	3717	3657	3382
3755	2020-04-12	\N	124	\N	2020-04-12                      	7	воскресенье     	t	12	103	3724	3664	3389
3762	2020-04-19	\N	124	\N	2020-04-19                      	7	воскресенье     	t	19	110	3731	3671	3396
3769	2020-04-26	\N	124	\N	2020-04-26                      	7	воскресенье     	t	26	117	3738	3678	3403
3776	2020-05-03	\N	125	\N	2020-05-03                      	7	воскресенье     	t	3	124	3746	3686	3410
3783	2020-05-10	\N	125	\N	2020-05-10                      	7	воскресенье     	t	10	131	3753	3693	3417
3790	2020-05-17	\N	125	\N	2020-05-17                      	7	воскресенье     	t	17	138	3760	3700	3424
3797	2020-05-24	\N	125	\N	2020-05-24                      	7	воскресенье     	t	24	145	3767	3707	3431
3804	2020-05-31	\N	125	\N	2020-05-31                      	7	воскресенье     	t	31	152	3773	3712	3438
3811	2020-06-07	\N	126	\N	2020-06-07                      	7	воскресенье     	t	7	159	3780	3719	3445
3818	2020-06-14	\N	126	\N	2020-06-14                      	7	воскресенье     	t	14	166	3787	3726	3452
3825	2020-06-21	\N	126	\N	2020-06-21                      	7	воскресенье     	t	21	173	3794	3733	3459
3832	2020-06-28	\N	126	\N	2020-06-28                      	7	воскресенье     	t	28	180	3801	3740	3466
3839	2020-07-05	\N	127	\N	2020-07-05                      	7	воскресенье     	t	5	187	3809	3748	3473
3846	2020-07-12	\N	127	\N	2020-07-12                      	7	воскресенье     	t	12	194	3816	3755	3480
3853	2020-07-19	\N	127	\N	2020-07-19                      	7	воскресенье     	t	19	201	3823	3762	3487
3860	2020-07-26	\N	127	\N	2020-07-26                      	7	воскресенье     	t	26	208	3830	3769	3494
3867	2020-08-02	\N	128	\N	2020-08-02                      	7	воскресенье     	t	2	215	3836	3775	3501
3874	2020-08-09	\N	128	\N	2020-08-09                      	7	воскресенье     	t	9	222	3843	3782	3508
3881	2020-08-16	\N	128	\N	2020-08-16                      	7	воскресенье     	t	16	229	3850	3789	3515
3888	2020-08-23	\N	128	\N	2020-08-23                      	7	воскресенье     	t	23	236	3857	3796	3522
3895	2020-08-30	\N	128	\N	2020-08-30                      	7	воскресенье     	t	30	243	3864	3803	3529
3902	2020-09-06	\N	129	\N	2020-09-06                      	7	воскресенье     	t	6	250	3871	3810	3536
3909	2020-09-13	\N	129	\N	2020-09-13                      	7	воскресенье     	t	13	257	3878	3817	3543
3916	2020-09-20	\N	129	\N	2020-09-20                      	7	воскресенье     	t	20	264	3885	3824	3550
3923	2020-09-27	\N	129	\N	2020-09-27                      	7	воскресенье     	t	27	271	3892	3831	3557
3930	2020-10-04	\N	130	\N	2020-10-04                      	7	воскресенье     	t	4	278	3900	3838	3564
3937	2020-10-11	\N	130	\N	2020-10-11                      	7	воскресенье     	t	11	285	3907	3845	3571
3944	2020-10-18	\N	130	\N	2020-10-18                      	7	воскресенье     	t	18	292	3914	3852	3578
3951	2020-10-25	\N	130	\N	2020-10-25                      	7	воскресенье     	t	25	299	3921	3859	3585
3958	2020-11-01	\N	131	\N	2020-11-01                      	7	воскресенье     	t	1	306	3927	3866	3592
3965	2020-11-08	\N	131	\N	2020-11-08                      	7	воскресенье     	t	8	313	3934	3873	3599
3972	2020-11-15	\N	131	\N	2020-11-15                      	7	воскресенье     	t	15	320	3941	3880	3606
3979	2020-11-22	\N	131	\N	2020-11-22                      	7	воскресенье     	t	22	327	3948	3887	3613
3986	2020-11-29	\N	131	\N	2020-11-29                      	7	воскресенье     	t	29	334	3955	3894	3620
3993	2020-12-06	\N	132	\N	2020-12-06                      	7	воскресенье     	t	6	341	3963	3902	3627
4000	2020-12-13	\N	132	\N	2020-12-13                      	7	воскресенье     	t	13	348	3970	3909	3634
4007	2020-12-20	\N	132	\N	2020-12-20                      	7	воскресенье     	t	20	355	3977	3916	3641
4014	2020-12-27	\N	132	\N	2020-12-27                      	7	воскресенье     	t	27	362	3984	3923	3648
1809	2014-12-14	\N	60	\N	2014-12-14                      	7	воскресенье     	t	14	348	1779	1718	1444
1814	2014-12-19	\N	60	\N	2014-12-19                      	5	пятница         	f	19	353	1784	1723	1449
1880	2015-02-23	\N	62	\N	2015-02-23                      	1	понедельник     	t	23	54	1849	1788	1515
1900	2015-03-15	\N	63	\N	2015-03-15                      	7	воскресенье     	t	15	74	1872	1810	1535
1894	2015-03-09	\N	63	\N	2015-03-09                      	1	понедельник     	f	9	68	1866	1804	1529
\.


--
-- Data for Name: lu_discipline; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lu_discipline (patr_id, discipline_id, discipline_desc, discipline_short_desc) FROM stdin;
\.


--
-- Name: lu_discipline_discipline_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('lu_discipline_discipline_id_seq', 1, false);


--
-- Data for Name: lu_education_form; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lu_education_form (education_form_id, education_form_desc) FROM stdin;
\.


--
-- Data for Name: lu_language; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lu_language (lang_id, lang_desc) FROM stdin;
\.


--
-- Data for Name: lu_lesson; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lu_lesson (lesson_id, lesson_desc, lesson_beg, lesson_end) FROM stdin;
1	1-я пара	08:00:00	09:25:00
2	2-я пара	09:35:00	11:00:00
3	3-я пара	11:25:00	12:50:00
4	4-я пара	13:00:00	14:25:00
5	5-я пара	14:35:00	16:00:00
6	6-я пара	16:25:00	17:50:00
7	7-я пара	18:00:00	19:25:00
8	8-я пара	19:25:00	21:00:00
9	9-я пара	21:05:00	22:30:00
\.


--
-- Data for Name: lu_lesson_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lu_lesson_type (lesson_type_id, lesson_type_desc) FROM stdin;
\.


--
-- Data for Name: lu_month; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lu_month (quarter_id, month_of_year_id, month_id, month_desc, month_duration, prev_month_id, lq_month_id, ly_month_id) FROM stdin;
1	1	1	январь 2010г.           	31	\N	\N	\N
1	2	2	февраль 2010г.          	28	1	\N	\N
1	3	3	март 2010г.             	31	2	\N	\N
2	4	4	апрель 2010г.           	30	3	1	\N
2	5	5	май 2010г.              	31	4	2	\N
2	6	6	июнь 2010г.             	30	5	3	\N
3	7	7	июль 2010г.             	31	6	4	\N
3	8	8	август 2010г.           	31	7	5	\N
3	9	9	сентябрь 2010г.         	30	8	6	\N
4	10	10	октябрь 2010г.          	31	9	7	\N
4	11	11	ноябрь 2010г.           	30	10	8	\N
4	12	12	деквбрь 2010г.          	31	11	9	\N
5	1	13	январь 2011г.           	31	12	10	1
5	2	14	февраль 2011г.          	28	13	11	2
5	3	15	март 2011г.             	31	14	12	3
6	4	16	апрель 2011г.           	30	15	13	4
6	5	17	май 2011г.              	31	16	14	5
6	6	18	июнь 2011г.             	30	17	15	6
7	7	19	июль 2011г.             	31	18	16	7
7	8	20	август 2011г.           	31	19	17	8
7	9	21	сентябрь 2011г.         	30	20	18	9
8	10	22	октябрь 2011г.          	31	21	19	10
8	11	23	ноябрь 2011г.           	30	22	20	11
8	12	24	деквбрь 2011г.          	31	23	21	12
9	1	25	январь 2012г.           	31	24	22	13
9	2	26	февраль 2012г.          	29	25	23	14
9	3	27	март 2012г.             	31	26	24	15
10	4	28	апрель 2012г.           	30	27	25	16
10	5	29	май 2012г.              	31	28	26	17
10	6	30	июнь 2012г.             	30	29	27	18
11	7	31	июль 2012г.             	31	30	\N	28
11	8	32	август 2012г.           	31	31	29	20
11	9	33	сентябрь 2012г.         	30	32	30	21
12	10	34	октябрь 2012г.          	31	33	31	22
12	11	35	ноябрь 2012г.           	30	34	32	23
12	12	36	деквбрь 2012г.          	31	35	33	24
13	1	37	январь 2013г.           	31	36	34	25
13	2	38	февраль 2013г.          	28	37	35	26
13	3	39	март 2013г.             	31	38	36	27
14	4	40	апрель 2013г.           	30	39	37	28
14	5	41	май 2013г.              	31	40	38	29
14	6	42	июнь 2013г.             	30	41	39	30
15	7	43	июль 2013г.             	31	42	40	31
15	8	44	август 2013г.           	31	43	41	32
15	9	45	сентябрь 2013г.         	30	44	42	33
16	10	46	октябрь 2013г.          	31	45	43	34
16	11	47	ноябрь 2013г.           	30	46	44	35
16	12	48	деквбрь 2013г.          	31	47	45	36
17	1	49	январь 2014г.           	31	48	46	37
17	2	50	февраль 2014г.          	28	49	47	38
17	3	51	март 2014г.             	31	50	48	39
18	4	52	апрель 2014г.           	30	51	49	40
18	5	53	май 2014г.              	31	52	50	41
18	6	54	июнь 2014г.             	30	53	51	42
19	7	55	июль 2014г.             	31	54	52	43
19	8	56	август 2014г.           	31	55	53	44
19	9	57	сентябрь 2014г.         	30	56	54	45
20	10	58	октябрь 2014г.          	31	57	55	46
20	11	59	ноябрь 2014г.           	30	58	56	47
20	12	60	деквбрь 2014г.          	31	59	57	48
21	1	61	январь 2015г.           	31	60	58	49
21	2	62	февраль 2015г.          	28	61	59	50
21	3	63	март 2015г.             	31	62	60	51
22	4	64	апрель 2015г.           	30	63	61	52
22	5	65	май 2015г.              	31	64	62	53
22	6	66	июнь 2015г.             	30	65	63	54
23	7	67	июль 2015г.             	31	66	64	55
23	8	68	август 2015г.           	31	67	65	56
23	9	69	сентябрь 2015г.         	30	68	66	57
24	10	70	октябрь 2015г.          	31	69	67	58
24	11	71	ноябрь 2015г.           	30	70	68	59
24	12	72	деквбрь 2015г.          	31	71	69	60
25	1	73	январь 2016г.           	31	72	70	61
25	2	74	февраль 2016г.          	29	73	71	62
25	3	75	март 2016г.             	31	74	72	63
26	4	76	апрель 2016г.           	30	75	73	64
26	5	77	май 2016г.              	31	76	74	65
26	6	78	июнь 2016г.             	30	77	75	66
27	7	79	июль 2016г.             	31	78	76	67
27	8	80	август 2016г.           	31	79	77	68
27	9	81	сентябрь 2016г.         	30	80	78	69
28	10	82	октябрь 2016г.          	31	81	79	70
28	11	83	ноябрь 2016г.           	30	82	80	71
28	12	84	деквбрь 2016г.          	31	83	81	72
29	1	85	январь 2017г.           	31	84	82	73
29	2	86	февраль 2017г.          	28	85	83	74
29	3	87	март 2017г.             	31	86	84	75
30	4	88	апрель 2017г.           	30	87	85	76
30	5	89	май 2017г.              	31	88	86	77
30	6	90	июнь 2017г.             	30	89	87	78
31	7	91	июль 2017г.             	31	90	88	79
31	8	92	август 2017г.           	31	91	89	80
31	9	93	сентябрь 2017г.         	30	92	90	81
32	10	94	октябрь 2017г.          	31	93	91	82
32	11	95	ноябрь 2017г.           	30	94	92	83
32	12	96	деквбрь 2017г.          	31	95	93	84
33	1	97	январь 2018г.           	31	96	94	85
33	2	98	февраль 2018г.          	28	97	95	86
33	3	99	март 2018г.             	31	98	96	87
34	4	100	апрель 2018г.           	30	99	97	88
34	5	101	май 2018г.              	31	100	98	89
34	6	102	июнь 2018г.             	30	101	99	90
35	7	103	июль 2018г.             	31	102	100	91
35	8	104	август 2018г.           	31	103	101	92
35	9	105	сентябрь 2018г.         	30	104	102	93
36	10	106	октябрь 2018г.          	31	105	103	94
36	11	107	ноябрь 2018г.           	30	106	104	95
36	12	108	деквбрь 2018г.          	31	107	105	96
37	1	109	январь 2019г.           	31	108	106	97
37	2	110	февраль 2019г.          	28	109	107	98
37	3	111	март 2019г.             	31	110	108	99
38	4	112	апрель 2019г.           	30	111	109	100
38	5	113	май 2019г.              	31	112	110	101
38	6	114	июнь 2019г.             	30	113	111	102
39	7	115	июль 2019г.             	31	114	112	103
39	8	116	август 2019г.           	31	115	113	104
39	9	117	сентябрь 2019г.         	30	116	114	105
40	10	118	октябрь 2019г.          	31	117	115	106
40	11	119	ноябрь 2019г.           	30	118	116	107
40	12	120	деквбрь 2019г.          	31	119	117	108
41	1	121	январь 2020г.           	31	120	118	109
41	2	122	февраль 2020г.          	29	121	119	110
41	3	123	март 2020г.             	31	122	120	111
42	4	124	апрель 2020г.           	30	123	121	112
42	5	125	май 2020г.              	31	124	122	113
42	6	126	июнь 2020г.             	30	125	123	114
43	7	127	июль 2020г.             	31	126	124	115
43	8	128	август 2020г.           	31	127	125	116
43	9	129	сентябрь 2020г.         	30	128	126	117
44	10	130	октябрь 2020г.          	31	129	127	118
44	11	131	ноябрь 2020г.           	30	130	128	119
44	12	132	деквбрь 2020г.          	31	131	129	120
\.


--
-- Data for Name: lu_month_of_year; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lu_month_of_year (month_of_year_id, month_of_year_desc) FROM stdin;
1	январь    
2	февраль   
3	март      
4	апрель    
5	май       
6	июнь      
7	июль      
8	август    
9	сентябрь  
10	октябрь   
11	ноябрь    
12	декабрь   
\.


--
-- Data for Name: lu_part_level; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lu_part_level (part_level_id, part_level_desc) FROM stdin;
\.


--
-- Data for Name: lu_position; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lu_position (position_id, position_desc) FROM stdin;
\.


--
-- Data for Name: lu_progcontent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lu_progcontent (recbookrow_id, program_id, discipline_id, specific_id, lesson_type_id, lesson_count, course, semestr, final_control_type) FROM stdin;
\.


--
-- Data for Name: lu_program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lu_program (patr_id, speciality_id, program_id, education_form_id, semestr_number, beg_date_id, end_date_id, in_use_flg) FROM stdin;
\.


--
-- Name: lu_program_program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('lu_program_program_id_seq', 1, false);


--
-- Data for Name: lu_quarter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lu_quarter (year_id, quarter_id, quarter_desc, quarter_duration, prev_quarter_id, ly_quarter_id) FROM stdin;
1	1	1-й квартал 2010г.              	90	0	0
1	2	2-й квартал 2010г.              	91	1	0
1	3	3-й квартал 2010г.              	92	2	0
1	4	4-й квартал 2010г.              	92	3	0
2	5	1-й квартал 2011г.              	90	4	1
2	6	2-й квартал 2011г.              	91	5	2
2	7	3-й квартал 2011г.              	92	6	3
2	8	4-й квартал 2011г.              	92	7	4
3	9	1-й квартал 2012г.              	91	8	5
3	10	2-й квартал 2012г.              	91	9	6
3	11	3-й квартал 2012г.              	92	10	7
3	12	4-й квартал 2012г.              	92	11	8
4	13	1-й квартал 2013г.              	90	12	9
4	14	2-й квартал 2013г.              	91	13	10
4	15	3-й квартал 2013г.              	92	14	11
4	16	4-й квартал 2013г.              	92	15	12
5	17	1-й квартал 2014г.              	90	16	13
5	18	2-й квартал 2014г.              	91	17	14
5	19	3-й квартал 2014г.              	92	18	15
5	20	4-й квартал 2014г.              	92	19	16
6	21	1-й квартал 2015г.              	90	20	17
6	22	2-й квартал 2015г.              	91	21	18
6	23	3-й квартал 2015г.              	92	22	19
6	24	4-й квартал 2015г.              	92	23	20
7	25	1-й квартал 2016г.              	91	24	21
7	26	2-й квартал 2016г.              	91	25	22
7	27	3-й квартал 2016г.              	92	26	23
7	28	4-й квартал 2016г.              	92	27	24
8	29	1-й квартал 2017г.              	90	28	25
8	30	2-й квартал 2017г.              	91	29	26
8	31	3-й квартал 2017г.              	92	30	27
8	32	4-й квартал 2017г.              	92	31	28
9	33	1-й квартал 2018г.              	90	32	29
9	34	2-й квартал 2018г.              	91	33	30
9	35	3-й квартал 2018г.              	92	34	31
9	36	4-й квартал 2018г.              	92	35	32
10	37	1-й квартал 2019г.              	90	36	33
10	38	2-й квартал 2019г.              	91	37	34
10	39	3-й квартал 2019г.              	92	38	35
10	40	4-й квартал 2019г.              	92	39	36
11	41	1-й квартал 2020г.              	91	40	37
11	42	2-й квартал 2020г.              	91	41	38
11	43	3-й квартал 2020г.              	92	42	39
11	44	4-й квартал 2020г.              	92	43	40
\.


--
-- Data for Name: lu_speciality; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lu_speciality (speciality_id, speciality_desc) FROM stdin;
\.


--
-- Data for Name: lu_specific; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lu_specific (specific_id, specific_desc) FROM stdin;
\.


--
-- Data for Name: lu_st_semestr; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lu_st_semestr (st_year_id, st_semestr_id, st_semestr_desc) FROM stdin;
\.


--
-- Data for Name: lu_st_year; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lu_st_year (st_year_id, st_year_desc) FROM stdin;
\.


--
-- Data for Name: lu_structure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lu_structure (patr_id, parent_id, part_desc, beg_date_id, end_date_id, part_level_id) FROM stdin;
\.


--
-- Data for Name: lu_week_of_semestr; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lu_week_of_semestr (week_of_semestr_id, week_of_semestr_desc) FROM stdin;
\.


--
-- Data for Name: lu_year; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lu_year (year_id, year_desc, is_leap_year, year_duration, prev_year_id) FROM stdin;
1	2010	f	365	0
2	2011	f	365	1
3	2012	t	366	2
4	2013	f	365	3
5	2014	f	365	4
6	2015	f	365	5
7	2016	t	366	6
8	2017	f	365	7
9	2018	f	365	8
10	2019	f	365	9
11	2020	t	366	10
\.


--
-- Name: module_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('module_id_seq', 2, true);


--
-- Name: permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('permission_id_seq', 1, true);


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY person (person_id, first_name, father_name, second_name, birth_date, birth_addr, fact_addr, username, pass, gender, email) FROM stdin;
2	Гость                           	                                	Гость                           	\N	                                                                                                                                	                                                                                                                                	guest           	202cb962ac59075b964b07152d234b70	 	\N
1	Администратор                   	                                	Администратор                   	\N	                                                                                                                                	                                                                                                                                	admin           	202cb962ac59075b964b07152d234b70	 	\N
\.


--
-- Data for Name: person_doc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY person_doc (person_id, doc_type, doc_series, doc_number, doc_beg_date_id, doc_end_date_id, doc_issuer, doc_kp, doc_addr) FROM stdin;
\.


--
-- Name: person_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('person_person_id_seq', 2, true);


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('role_id_seq', 2, true);


--
-- Data for Name: schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schedule (el_schedule_id, date_id, end_date_id, lesson_id, discipline_id, teacher_id, flow_id, classroom_id, lesson_type, is_closed) FROM stdin;
\.


--
-- Data for Name: spec_day_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY spec_day_list (day_id, day_desc, spec_desc, holiday_ind) FROM stdin;
\.


--
-- Data for Name: st_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY st_flow (flow_id, flow_desc, beg_date_id, end_date_id) FROM stdin;
\.


--
-- Data for Name: st_flow_content; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY st_flow_content (flow_id, group_id) FROM stdin;
\.


--
-- Name: st_flow_flow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('st_flow_flow_id_seq', 1, false);


--
-- Data for Name: st_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY st_group (group_id, group_desc, patr_id, program_id, st_year_id, cur_st_year_id, year_cnt, semestr_cnt, stuff_cnt, stuff_add, decree_no) FROM stdin;
\.


--
-- Data for Name: st_group_content; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY st_group_content (contract_id, group_id, user_id, upd_dt, semestr_id) FROM stdin;
\.


--
-- Name: st_group_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('st_group_group_id_seq', 1, false);


--
-- Data for Name: st_group_hist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY st_group_hist (contract_id, group_id, semestr_id, beg_date_id, ens_date_id, user_id, prev_user_id) FROM stdin;
\.


--
-- Name: auth_permission_permission_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_permission_name_key UNIQUE (permission_name);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (permission_id);


--
-- Name: auth_role_permission_role_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_role_permission
    ADD CONSTRAINT auth_role_permission_role_id_permission_id_key UNIQUE (role_id, permission_id);


--
-- Name: auth_role_person_role_id_person_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_role_person
    ADD CONSTRAINT auth_role_person_role_id_person_id_key UNIQUE (role_id, person_id);


--
-- Name: ban_ip_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ban
    ADD CONSTRAINT ban_ip_key UNIQUE (ip);


--
-- Name: pk_contract_fact; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY contract_fact
    ADD CONSTRAINT pk_contract_fact PRIMARY KEY (contract_id);


--
-- Name: pk_disc_var_detail; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY disc_var_detail
    ADD CONSTRAINT pk_disc_var_detail PRIMARY KEY (discipline_id, specific_id, lesson_type_id, lesson_num);


--
-- Name: pk_disc_var_summary; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY disc_var_summary
    ADD CONSTRAINT pk_disc_var_summary PRIMARY KEY (discipline_id, specific_id, lesson_type_id);


--
-- Name: pk_journal_fact; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY journal_fact
    ADD CONSTRAINT pk_journal_fact PRIMARY KEY (el_schedule_id, student_id);


--
-- Name: pk_journal_hist; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY journal_hist
    ADD CONSTRAINT pk_journal_hist PRIMARY KEY (el_schedule_id, student_id, check_mark);


--
-- Name: pk_lu_day; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lu_day
    ADD CONSTRAINT pk_lu_day PRIMARY KEY (day_id);


--
-- Name: pk_lu_discipline; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lu_discipline
    ADD CONSTRAINT pk_lu_discipline PRIMARY KEY (discipline_id);


--
-- Name: pk_lu_education_form; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lu_education_form
    ADD CONSTRAINT pk_lu_education_form PRIMARY KEY (education_form_id);


--
-- Name: pk_lu_language; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lu_language
    ADD CONSTRAINT pk_lu_language PRIMARY KEY (lang_id);


--
-- Name: pk_lu_lesson_type; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lu_lesson_type
    ADD CONSTRAINT pk_lu_lesson_type PRIMARY KEY (lesson_type_id);


--
-- Name: pk_lu_month; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lu_month
    ADD CONSTRAINT pk_lu_month PRIMARY KEY (month_id);


--
-- Name: pk_lu_month_of_year; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lu_month_of_year
    ADD CONSTRAINT pk_lu_month_of_year PRIMARY KEY (month_of_year_id);


--
-- Name: pk_lu_part_level; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lu_part_level
    ADD CONSTRAINT pk_lu_part_level PRIMARY KEY (part_level_id);


--
-- Name: pk_lu_position; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lu_position
    ADD CONSTRAINT pk_lu_position PRIMARY KEY (position_id);


--
-- Name: pk_lu_progcontent; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lu_progcontent
    ADD CONSTRAINT pk_lu_progcontent PRIMARY KEY (recbookrow_id);


--
-- Name: pk_lu_program; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lu_program
    ADD CONSTRAINT pk_lu_program PRIMARY KEY (program_id);


--
-- Name: pk_lu_quarter; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lu_quarter
    ADD CONSTRAINT pk_lu_quarter PRIMARY KEY (quarter_id);


--
-- Name: pk_lu_speciality; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lu_speciality
    ADD CONSTRAINT pk_lu_speciality PRIMARY KEY (speciality_id);


--
-- Name: pk_lu_specific; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lu_specific
    ADD CONSTRAINT pk_lu_specific PRIMARY KEY (specific_id);


--
-- Name: pk_lu_st_semestr; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lu_st_semestr
    ADD CONSTRAINT pk_lu_st_semestr PRIMARY KEY (st_semestr_id);


--
-- Name: pk_lu_st_year; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lu_st_year
    ADD CONSTRAINT pk_lu_st_year PRIMARY KEY (st_year_id);


--
-- Name: pk_lu_structure; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lu_structure
    ADD CONSTRAINT pk_lu_structure PRIMARY KEY (patr_id);


--
-- Name: pk_lu_week_of_semestr; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lu_week_of_semestr
    ADD CONSTRAINT pk_lu_week_of_semestr PRIMARY KEY (week_of_semestr_id);


--
-- Name: pk_lu_year; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lu_year
    ADD CONSTRAINT pk_lu_year PRIMARY KEY (year_id);


--
-- Name: pk_person; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY person
    ADD CONSTRAINT pk_person PRIMARY KEY (person_id);


--
-- Name: pk_schedule; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY schedule
    ADD CONSTRAINT pk_schedule PRIMARY KEY (el_schedule_id);


--
-- Name: pk_st_flow; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_flow
    ADD CONSTRAINT pk_st_flow PRIMARY KEY (flow_id);


--
-- Name: pk_st_group; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_group
    ADD CONSTRAINT pk_st_group PRIMARY KEY (group_id);


--
-- Name: pk_st_group_content; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY st_group_content
    ADD CONSTRAINT pk_st_group_content PRIMARY KEY (contract_id, group_id);


--
-- Name: uk_module_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_module
    ADD CONSTRAINT uk_module_id UNIQUE (module_id);


--
-- Name: uk_role_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY auth_role
    ADD CONSTRAINT uk_role_id UNIQUE (role_id);


--
-- Name: uix_date; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX uix_date ON lu_day USING btree (day_desc);


--
-- Name: auth_permission_module_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_module_id_fkey FOREIGN KEY (module_id) REFERENCES auth_module(module_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: auth_role_permission_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_role_permission
    ADD CONSTRAINT auth_role_permission_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(permission_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: auth_role_permission_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_role_permission
    ADD CONSTRAINT auth_role_permission_role_id_fkey FOREIGN KEY (role_id) REFERENCES auth_role(role_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_contract_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contract_fact
    ADD CONSTRAINT fk_contract_person FOREIGN KEY (contract_person_id) REFERENCES person(person_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_contract_reference_lu_posit; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contract_fact
    ADD CONSTRAINT fk_contract_reference_lu_posit FOREIGN KEY (position_id) REFERENCES lu_position(position_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_contract_reference_lu_progr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contract_fact
    ADD CONSTRAINT fk_contract_reference_lu_progr FOREIGN KEY (program_id) REFERENCES lu_program(program_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_contract_reference_lu_st_ye; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contract_fact
    ADD CONSTRAINT fk_contract_reference_lu_st_ye FOREIGN KEY (st_year_id) REFERENCES lu_st_year(st_year_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_contract_reference_lu_struc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contract_fact
    ADD CONSTRAINT fk_contract_reference_lu_struc FOREIGN KEY (patr_id) REFERENCES lu_structure(patr_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_contract_reference_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contract_fact
    ADD CONSTRAINT fk_contract_reference_person FOREIGN KEY (person_id) REFERENCES person(person_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_contractlang2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contract_fact
    ADD CONSTRAINT fk_contractlang2 FOREIGN KEY (lang_2_id) REFERENCES lu_language(lang_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_contrlang1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contract_fact
    ADD CONSTRAINT fk_contrlang1 FOREIGN KEY (lang_1_id) REFERENCES lu_language(lang_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_disc_var_reference_disc_var; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY disc_var_detail
    ADD CONSTRAINT fk_disc_var_reference_disc_var FOREIGN KEY (discipline_id, specific_id, lesson_type_id) REFERENCES disc_var_summary(discipline_id, specific_id, lesson_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_disc_var_reference_lu_disci; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY disc_var_summary
    ADD CONSTRAINT fk_disc_var_reference_lu_disci FOREIGN KEY (discipline_id) REFERENCES lu_discipline(discipline_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_disc_var_reference_lu_lesso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY disc_var_summary
    ADD CONSTRAINT fk_disc_var_reference_lu_lesso FOREIGN KEY (lesson_type_id) REFERENCES lu_lesson_type(lesson_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_disc_var_reference_lu_speci; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY disc_var_summary
    ADD CONSTRAINT fk_disc_var_reference_lu_speci FOREIGN KEY (specific_id) REFERENCES lu_specific(specific_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_flconflow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY st_flow_content
    ADD CONSTRAINT fk_flconflow FOREIGN KEY (flow_id) REFERENCES st_flow(flow_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_flowgroup; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY st_flow_content
    ADD CONSTRAINT fk_flowgroup FOREIGN KEY (group_id) REFERENCES st_group(group_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_journal__reference_journal_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY journal_hist
    ADD CONSTRAINT fk_journal__reference_journal_ FOREIGN KEY (el_schedule_id, student_id) REFERENCES journal_fact(el_schedule_id, student_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_journal__reference_schedule; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY journal_fact
    ADD CONSTRAINT fk_journal__reference_schedule FOREIGN KEY (el_schedule_id) REFERENCES schedule(el_schedule_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_lu_day_reference_lu_month; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lu_day
    ADD CONSTRAINT fk_lu_day_reference_lu_month FOREIGN KEY (month_id) REFERENCES lu_month(month_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_lu_day_reference_lu_st_se; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lu_day
    ADD CONSTRAINT fk_lu_day_reference_lu_st_se FOREIGN KEY (st_semestr_id) REFERENCES lu_st_semestr(st_semestr_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_lu_day_reference_lu_week_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lu_day
    ADD CONSTRAINT fk_lu_day_reference_lu_week_ FOREIGN KEY (week_of_semestr_id) REFERENCES lu_week_of_semestr(week_of_semestr_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_lu_disci_reference_lu_struc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lu_discipline
    ADD CONSTRAINT fk_lu_disci_reference_lu_struc FOREIGN KEY (patr_id) REFERENCES lu_structure(patr_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_lu_month_reference_lu_month; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lu_month
    ADD CONSTRAINT fk_lu_month_reference_lu_month FOREIGN KEY (month_of_year_id) REFERENCES lu_month_of_year(month_of_year_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_lu_month_reference_lu_quart; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lu_month
    ADD CONSTRAINT fk_lu_month_reference_lu_quart FOREIGN KEY (quarter_id) REFERENCES lu_quarter(quarter_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_lu_progc_reference_disc_var; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lu_progcontent
    ADD CONSTRAINT fk_lu_progc_reference_disc_var FOREIGN KEY (discipline_id, specific_id, lesson_type_id) REFERENCES disc_var_summary(discipline_id, specific_id, lesson_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_lu_progc_reference_lu_progr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lu_progcontent
    ADD CONSTRAINT fk_lu_progc_reference_lu_progr FOREIGN KEY (program_id) REFERENCES lu_program(program_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_lu_progr_reference_lu_educa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lu_program
    ADD CONSTRAINT fk_lu_progr_reference_lu_educa FOREIGN KEY (education_form_id) REFERENCES lu_education_form(education_form_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_lu_progr_reference_lu_speci; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lu_program
    ADD CONSTRAINT fk_lu_progr_reference_lu_speci FOREIGN KEY (speciality_id) REFERENCES lu_speciality(speciality_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_lu_progr_reference_lu_struc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lu_program
    ADD CONSTRAINT fk_lu_progr_reference_lu_struc FOREIGN KEY (patr_id) REFERENCES lu_structure(patr_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_lu_quart_reference_lu_year; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lu_quarter
    ADD CONSTRAINT fk_lu_quart_reference_lu_year FOREIGN KEY (year_id) REFERENCES lu_year(year_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_lu_st_se_reference_lu_st_ye; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lu_st_semestr
    ADD CONSTRAINT fk_lu_st_se_reference_lu_st_ye FOREIGN KEY (st_year_id) REFERENCES lu_st_year(st_year_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_lu_struc_reference_lu_part_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lu_structure
    ADD CONSTRAINT fk_lu_struc_reference_lu_part_ FOREIGN KEY (part_level_id) REFERENCES lu_part_level(part_level_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_lu_struc_reference_lu_struc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lu_structure
    ADD CONSTRAINT fk_lu_struc_reference_lu_struc FOREIGN KEY (parent_id) REFERENCES lu_structure(patr_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_person_d_reference_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY person_doc
    ADD CONSTRAINT fk_person_d_reference_person FOREIGN KEY (person_id) REFERENCES person(person_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_person_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_role_person
    ADD CONSTRAINT fk_person_id FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE RESTRICT;


--
-- Name: fk_prgfc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lu_progcontent
    ADD CONSTRAINT fk_prgfc FOREIGN KEY (final_control_type) REFERENCES lu_lesson_type(lesson_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_role_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_role_person
    ADD CONSTRAINT fk_role_id FOREIGN KEY (role_id) REFERENCES auth_role(role_id) ON DELETE RESTRICT;


--
-- Name: fk_spec_day_reference_lu_day; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY spec_day_list
    ADD CONSTRAINT fk_spec_day_reference_lu_day FOREIGN KEY (day_id) REFERENCES lu_day(day_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_st_group_reference_contract; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY st_group_content
    ADD CONSTRAINT fk_st_group_reference_contract FOREIGN KEY (contract_id) REFERENCES contract_fact(contract_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_st_group_reference_lu_progr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY st_group
    ADD CONSTRAINT fk_st_group_reference_lu_progr FOREIGN KEY (program_id) REFERENCES lu_program(program_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_st_group_reference_lu_struc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY st_group
    ADD CONSTRAINT fk_st_group_reference_lu_struc FOREIGN KEY (patr_id) REFERENCES lu_structure(patr_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_st_group_reference_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY st_group_content
    ADD CONSTRAINT fk_st_group_reference_person FOREIGN KEY (user_id) REFERENCES person(person_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_st_group_reference_st_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY st_group_content
    ADD CONSTRAINT fk_st_group_reference_st_group FOREIGN KEY (group_id) REFERENCES st_group(group_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_st_group_reference_st_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY st_group_hist
    ADD CONSTRAINT fk_st_group_reference_st_group FOREIGN KEY (contract_id, group_id) REFERENCES st_group_content(contract_id, group_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_st_group_st_year; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY st_group
    ADD CONSTRAINT fk_st_group_st_year FOREIGN KEY (st_year_id) REFERENCES lu_st_year(st_year_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_st_groupy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY st_group
    ADD CONSTRAINT fk_st_groupy FOREIGN KEY (cur_st_year_id) REFERENCES lu_st_year(st_year_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

