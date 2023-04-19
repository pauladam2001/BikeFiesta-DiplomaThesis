--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.active_storage_attachments OWNER TO pauladam;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_attachments_id_seq OWNER TO pauladam;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.active_storage_blobs OWNER TO pauladam;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_blobs_id_seq OWNER TO pauladam;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


ALTER TABLE public.active_storage_variant_records OWNER TO pauladam;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_variant_records_id_seq OWNER TO pauladam;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO pauladam;

--
-- Name: assets; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.assets (
    id bigint NOT NULL,
    post_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    user_id integer,
    is_bicycle boolean DEFAULT false
);


ALTER TABLE public.assets OWNER TO pauladam;

--
-- Name: assets_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.assets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assets_id_seq OWNER TO pauladam;

--
-- Name: assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.assets_id_seq OWNED BY public.assets.id;


--
-- Name: brandnames; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.brandnames (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.brandnames OWNER TO pauladam;

--
-- Name: brandnames_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.brandnames_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.brandnames_id_seq OWNER TO pauladam;

--
-- Name: brandnames_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.brandnames_id_seq OWNED BY public.brandnames.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.categories OWNER TO pauladam;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO pauladam;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: colors; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.colors (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.colors OWNER TO pauladam;

--
-- Name: colors_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.colors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.colors_id_seq OWNER TO pauladam;

--
-- Name: colors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.colors_id_seq OWNED BY public.colors.id;


--
-- Name: component_groups; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.component_groups (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.component_groups OWNER TO pauladam;

--
-- Name: component_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.component_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.component_groups_id_seq OWNER TO pauladam;

--
-- Name: component_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.component_groups_id_seq OWNED BY public.component_groups.id;


--
-- Name: costs; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.costs (
    id bigint NOT NULL,
    amount double precision,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    day date
);


ALTER TABLE public.costs OWNER TO pauladam;

--
-- Name: costs_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.costs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.costs_id_seq OWNER TO pauladam;

--
-- Name: costs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.costs_id_seq OWNED BY public.costs.id;


--
-- Name: favorites; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.favorites (
    id bigint NOT NULL,
    user_id integer,
    post_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.favorites OWNER TO pauladam;

--
-- Name: favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.favorites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.favorites_id_seq OWNER TO pauladam;

--
-- Name: favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.favorites_id_seq OWNED BY public.favorites.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.locations (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    short character varying
);


ALTER TABLE public.locations OWNER TO pauladam;

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locations_id_seq OWNER TO pauladam;

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: materials; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.materials (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.materials OWNER TO pauladam;

--
-- Name: materials_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.materials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.materials_id_seq OWNER TO pauladam;

--
-- Name: materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.materials_id_seq OWNED BY public.materials.id;


--
-- Name: message_statuses; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.message_statuses (
    id bigint NOT NULL,
    message_id bigint NOT NULL,
    user_id bigint NOT NULL,
    room_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.message_statuses OWNER TO pauladam;

--
-- Name: message_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.message_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.message_statuses_id_seq OWNER TO pauladam;

--
-- Name: message_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.message_statuses_id_seq OWNED BY public.message_statuses.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.messages (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    room_id bigint NOT NULL,
    content text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.messages OWNER TO pauladam;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO pauladam;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    post_id integer,
    notified_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    message character varying,
    notification_type character varying
);


ALTER TABLE public.notifications OWNER TO pauladam;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_id_seq OWNER TO pauladam;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: participants; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.participants (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    room_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    last_read_at timestamp without time zone
);


ALTER TABLE public.participants OWNER TO pauladam;

--
-- Name: participants_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.participants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.participants_id_seq OWNER TO pauladam;

--
-- Name: participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.participants_id_seq OWNED BY public.participants.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.posts (
    id bigint NOT NULL,
    name character varying,
    description text,
    price double precision,
    user_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    views integer DEFAULT 0,
    short_description text,
    year integer,
    sale_price double precision,
    sale_price_expiration timestamp without time zone,
    color_id integer,
    location_id integer,
    brandname_id integer,
    is_active integer DEFAULT 0,
    size character varying,
    category_id integer,
    material_id integer,
    condition character varying,
    component_group_id integer,
    electric boolean,
    sold boolean DEFAULT false,
    buyer_id integer,
    sold_date timestamp without time zone,
    leave_review_notification_sent boolean DEFAULT false,
    shipped boolean DEFAULT false,
    sale_percentage double precision,
    shipped_date timestamp without time zone
);


ALTER TABLE public.posts OWNER TO pauladam;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posts_id_seq OWNER TO pauladam;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: purchases; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.purchases (
    id bigint NOT NULL,
    seller_id integer,
    buyer_id integer,
    post_id integer,
    amount double precision,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    status character varying,
    shipping_details text,
    payment_details text,
    on_hold boolean DEFAULT false,
    money_sent_to_seller boolean DEFAULT false
);


ALTER TABLE public.purchases OWNER TO pauladam;

--
-- Name: purchases_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.purchases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchases_id_seq OWNER TO pauladam;

--
-- Name: purchases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.purchases_id_seq OWNED BY public.purchases.id;


--
-- Name: relationships; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.relationships (
    id bigint NOT NULL,
    follower_id integer,
    followed_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.relationships OWNER TO pauladam;

--
-- Name: relationships_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.relationships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.relationships_id_seq OWNER TO pauladam;

--
-- Name: relationships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.relationships_id_seq OWNED BY public.relationships.id;


--
-- Name: reports; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.reports (
    id bigint NOT NULL,
    user_id integer,
    post_id integer,
    message text,
    title character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    solved boolean DEFAULT false
);


ALTER TABLE public.reports OWNER TO pauladam;

--
-- Name: reports_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reports_id_seq OWNER TO pauladam;

--
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.reports_id_seq OWNED BY public.reports.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.reviews (
    id bigint NOT NULL,
    reviewer_id integer,
    reviewed_id integer,
    message text,
    grade integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.reviews OWNER TO pauladam;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviews_id_seq OWNER TO pauladam;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: rooms; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.rooms (
    id bigint NOT NULL,
    name character varying,
    is_private boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.rooms OWNER TO pauladam;

--
-- Name: rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rooms_id_seq OWNER TO pauladam;

--
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.rooms_id_seq OWNED BY public.rooms.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO pauladam;

--
-- Name: stats; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.stats (
    id bigint NOT NULL,
    analysis_start_time timestamp without time zone,
    analysis_end_time timestamp without time zone,
    end_date date,
    total_revenue double precision,
    total_spent double precision,
    total_profit double precision,
    roi double precision,
    total_views integer,
    total_posts integer,
    total_transactions integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    period character varying,
    validating_posts integer,
    banned_posts integer,
    active_posts integer,
    sold_not_shipped_posts integer,
    sold_shipped_posts integer,
    user_id integer,
    user_views integer,
    followers integer,
    following integer,
    user_posts integer,
    user_revenue double precision,
    user_spent double precision
);


ALTER TABLE public.stats OWNER TO pauladam;

--
-- Name: stats_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stats_id_seq OWNER TO pauladam;

--
-- Name: stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.stats_id_seq OWNED BY public.stats.id;


--
-- Name: suggestions; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.suggestions (
    id bigint NOT NULL,
    user_id integer,
    message text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    solved boolean DEFAULT false
);


ALTER TABLE public.suggestions OWNER TO pauladam;

--
-- Name: suggestions_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.suggestions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suggestions_id_seq OWNER TO pauladam;

--
-- Name: suggestions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.suggestions_id_seq OWNED BY public.suggestions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: pauladam
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    uid character varying,
    avatar_url character varying,
    role character varying DEFAULT 'normal'::character varying,
    provider character varying,
    first_name character varying,
    last_name character varying,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    full_name character varying,
    code character varying,
    phone character varying,
    code_expiration_date timestamp without time zone,
    archived boolean DEFAULT false,
    rating double precision,
    paypal_email character varying,
    discount double precision,
    sms_opt_in boolean DEFAULT false,
    showed_rules boolean DEFAULT false
);


ALTER TABLE public.users OWNER TO pauladam;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: pauladam
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO pauladam;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pauladam
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: assets id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.assets ALTER COLUMN id SET DEFAULT nextval('public.assets_id_seq'::regclass);


--
-- Name: brandnames id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.brandnames ALTER COLUMN id SET DEFAULT nextval('public.brandnames_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: colors id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.colors ALTER COLUMN id SET DEFAULT nextval('public.colors_id_seq'::regclass);


--
-- Name: component_groups id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.component_groups ALTER COLUMN id SET DEFAULT nextval('public.component_groups_id_seq'::regclass);


--
-- Name: costs id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.costs ALTER COLUMN id SET DEFAULT nextval('public.costs_id_seq'::regclass);


--
-- Name: favorites id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.favorites ALTER COLUMN id SET DEFAULT nextval('public.favorites_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: materials id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.materials ALTER COLUMN id SET DEFAULT nextval('public.materials_id_seq'::regclass);


--
-- Name: message_statuses id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.message_statuses ALTER COLUMN id SET DEFAULT nextval('public.message_statuses_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: participants id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.participants ALTER COLUMN id SET DEFAULT nextval('public.participants_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: purchases id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.purchases ALTER COLUMN id SET DEFAULT nextval('public.purchases_id_seq'::regclass);


--
-- Name: relationships id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.relationships ALTER COLUMN id SET DEFAULT nextval('public.relationships_id_seq'::regclass);


--
-- Name: reports id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.reports ALTER COLUMN id SET DEFAULT nextval('public.reports_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: rooms id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.rooms ALTER COLUMN id SET DEFAULT nextval('public.rooms_id_seq'::regclass);


--
-- Name: stats id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.stats ALTER COLUMN id SET DEFAULT nextval('public.stats_id_seq'::regclass);


--
-- Name: suggestions id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.suggestions ALTER COLUMN id SET DEFAULT nextval('public.suggestions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.active_storage_attachments (id, name, record_type, record_id, blob_id, created_at) FROM stdin;
1	avatar	User	21	1	2023-01-15 15:56:44.640124
2	avatar	User	22	2	2023-01-15 16:44:23.043611
3	avatar	User	23	3	2023-01-15 16:45:37.117742
4	avatar	User	24	4	2023-01-16 10:54:11.059511
5	avatar	User	25	5	2023-01-16 10:57:40.699448
6	avatar	User	26	6	2023-01-16 11:12:10.94086
7	avatar	User	27	7	2023-01-16 11:12:57.069475
8	avatar	User	28	8	2023-01-16 11:19:50.361972
9	avatar	User	29	9	2023-01-16 11:24:47.745735
10	avatar	User	30	10	2023-01-16 12:10:06.564135
12	avatar	User	31	12	2023-01-16 12:14:04.545353
14	avatar	User	32	14	2023-01-16 12:28:38.195175
15	avatar	User	33	15	2023-01-16 12:39:34.223218
16	avatar	User	34	16	2023-01-16 12:42:25.89026
17	image	Asset	2	17	2023-01-19 12:14:30.606441
18	image	Asset	4	18	2023-01-19 12:15:50.400031
19	image	Asset	3	19	2023-01-19 12:15:50.408381
20	image	Asset	5	20	2023-01-19 12:19:05.810051
21	image	Asset	6	21	2023-01-19 12:19:10.40367
22	image	Asset	7	22	2023-01-19 15:24:50.881131
23	image	Asset	8	23	2023-01-20 09:44:40.667204
24	avatar	User	38	24	2023-01-26 13:20:05.556864
25	avatar	User	40	25	2023-01-26 13:26:56.987944
26	avatar	User	41	26	2023-01-26 16:18:44.192526
27	avatar	User	42	27	2023-01-26 16:27:05.495504
28	avatar	User	43	28	2023-01-26 16:29:22.755929
29	avatar	User	44	29	2023-01-26 16:30:31.305648
30	image	Asset	9	30	2023-02-03 09:52:19.46166
31	image	Asset	10	31	2023-02-03 09:58:31.608103
32	image	Asset	12	32	2023-02-09 14:24:41.721934
33	image	Asset	13	33	2023-02-09 14:24:41.723211
34	image	Asset	14	34	2023-02-09 14:24:41.814905
43	proof	Purchase	1	43	2023-02-21 08:39:17.862915
44	image	Asset	15	44	2023-03-16 14:06:07.045594
45	image	Asset	16	45	2023-03-19 15:06:49.955283
46	avatar	User	50	46	2023-03-29 07:08:08.506029
47	avatar	User	51	47	2023-03-29 07:13:40.256304
48	avatar	User	52	48	2023-03-29 07:31:51.623262
49	avatar	User	53	49	2023-03-29 10:12:17.874675
50	avatar	User	54	50	2023-03-29 10:13:35.298062
52	avatar	User	55	52	2023-03-29 10:18:23.721185
\.


--
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, service_name, byte_size, checksum, created_at) FROM stdin;
1	t4m24y6jll30lh0bwy1o24p4sya9	download.jpeg	image/jpeg	{"identified":true,"analyzed":true}	local	5187	pYORaVOZQUFjirL2/1QOIA==	2023-01-15 15:56:44.63358
2	1qtuv9zm1e68z0oxewotajjtovwy	download.jpeg	image/jpeg	{"identified":true,"analyzed":true}	local	5187	pYORaVOZQUFjirL2/1QOIA==	2023-01-15 16:44:23.041617
3	5vd5n9svmczndfilf7j3m6rn43d5	download.jpeg	image/jpeg	{"identified":true,"analyzed":true}	local	5187	pYORaVOZQUFjirL2/1QOIA==	2023-01-15 16:45:37.114881
4	hilplhwi7r7sv247hq8j7e2nvqzc	buletin.jpeg	image/jpeg	{"identified":true,"analyzed":true}	local	1937712	/FMtR8/RialcH+6nt7H0mw==	2023-01-16 10:54:11.054895
5	6axd8nh10qqawd4u7c4hib0arpw2	buletin.jpeg	image/jpeg	{"identified":true,"analyzed":true}	local	1937712	/FMtR8/RialcH+6nt7H0mw==	2023-01-16 10:57:40.696763
6	ded8g8pcg7hwrexfpyqz2m5lnmbx	buletin.jpeg	image/jpeg	{"identified":true,"analyzed":true}	local	1937712	/FMtR8/RialcH+6nt7H0mw==	2023-01-16 11:12:10.938745
7	vsimd4i55e548dvmsopo3b389ko3	buletin.jpeg	image/jpeg	{"identified":true,"analyzed":true}	local	1937712	/FMtR8/RialcH+6nt7H0mw==	2023-01-16 11:12:57.067745
8	mv93v7vk5x9b35mccrzqrvsxhjve	buletin.jpeg	image/jpeg	{"identified":true,"analyzed":true}	cloudinary	1937712	/FMtR8/RialcH+6nt7H0mw==	2023-01-16 11:19:50.360048
9	u78yt8i8y8rcn0phxdnp2tepoz9w	image.jpg	image/jpeg	{"identified":true,"analyzed":true}	cloudinary	1937712	/FMtR8/RialcH+6nt7H0mw==	2023-01-16 11:24:47.744572
10	ynd4r1b9wkji0brpa5exkoua1tiv	face0.jpg	image/jpeg	{"identified":true,"analyzed":true}	cloudinary	1937712	/FMtR8/RialcH+6nt7H0mw==	2023-01-16 12:10:06.56226
12	4w1l67bgbbbwgdsyx4l4kodz71if	image.jpg	image/jpeg	{"identified":true,"analyzed":true}	cloudinary	7323	QHB2PATxE3o1nWScjOp0zw==	2023-01-16 12:14:04.543928
22	w8qeeedjn4qk9l2ueubelum7dech	bicycle.jpeg	image/jpeg	{"identified":true,"analyzed":true}	cloudinary	78509	/YC+B9xhxpo0WkNbNJ1aJw==	2023-01-19 15:24:50.878827
14	2tqnj95ezpp7y23bio2rw0se80o1	image607125619.jpg	image/jpeg	{"identified":true,"analyzed":true}	cloudinary	7323	QHB2PATxE3o1nWScjOp0zw==	2023-01-16 12:28:38.192207
15	9ht4sxd9z9g3cftv53bbpd4j925f	back-arrow.png	image/png	{"identified":true,"analyzed":true}	cloudinary	368	TcDCFpC1XYmx/yDExWeJ2A==	2023-01-16 12:39:34.220661
16	e31z8tlvjonncbu1vf094pqv9ur9	back-arrow.png	image/png	{"identified":true,"analyzed":true}	cloudinary	368	TcDCFpC1XYmx/yDExWeJ2A==	2023-01-16 12:42:25.888514
17	yyd7284st0jteu2owc13hwaugbyt	basketball-ball.png	image/png	{"identified":true,"analyzed":true}	cloudinary	41819	FnGlt6WjyD1HnaPzCcUc6Q==	2023-01-19 12:14:30.602775
19	1xls7liwlwnfcvhz7xiojmwjhsmb	back-arrow.png	image/png	{"identified":true,"analyzed":true}	cloudinary	368	TcDCFpC1XYmx/yDExWeJ2A==	2023-01-19 12:15:50.404484
18	7eyv9y2ftrc7ppf46f8qlh6j9les	basketball-ball.png	image/png	{"identified":true,"analyzed":true}	cloudinary	41819	FnGlt6WjyD1HnaPzCcUc6Q==	2023-01-19 12:15:50.397103
20	nhw5k7d0ish61cxi6pqsh5jgrgod	basketball-ball.png	image/png	{"identified":true,"analyzed":true}	cloudinary	41819	FnGlt6WjyD1HnaPzCcUc6Q==	2023-01-19 12:19:05.807855
21	r85udd9ohxmecaok0zpfg167hznq	back-arrow.png	image/png	{"identified":true,"analyzed":true}	cloudinary	368	TcDCFpC1XYmx/yDExWeJ2A==	2023-01-19 12:19:10.400695
23	9u1d67fwg0apedruipevapok6xvx	basketball-ball.png	image/png	{"identified":true,"analyzed":true}	cloudinary	41819	FnGlt6WjyD1HnaPzCcUc6Q==	2023-01-20 09:44:40.664852
24	hb8npjaj5x3kof6iglc9706jkc9t	bicycle.jpeg	image/jpeg	{"identified":true,"analyzed":true}	cloudinary	78509	/YC+B9xhxpo0WkNbNJ1aJw==	2023-01-26 13:20:05.548797
25	yvrrbvemwvwa85qwkhlufplkx458	basketball-ball.png	image/png	{"identified":true,"analyzed":true}	cloudinary	41819	FnGlt6WjyD1HnaPzCcUc6Q==	2023-01-26 13:26:56.984288
26	pyx5lqnyxg003noddqc4jhmnua02	back-arrow.png	image/png	{"identified":true,"analyzed":true}	cloudinary	368	TcDCFpC1XYmx/yDExWeJ2A==	2023-01-26 16:18:44.187866
27	9tt1dim0szytr1jeexfjyfy5xqar	basketball-ball.png	image/png	{"identified":true,"analyzed":true}	cloudinary	41819	FnGlt6WjyD1HnaPzCcUc6Q==	2023-01-26 16:27:05.493684
28	r8egxaar943quexaro5wkr0wmj5c	back-arrow.png	image/png	{"identified":true,"analyzed":true}	cloudinary	368	TcDCFpC1XYmx/yDExWeJ2A==	2023-01-26 16:29:22.754074
29	zgy3za7wxkpxy52y80p8ywmotcu7	basketball-ball.png	image/png	{"identified":true,"analyzed":true}	cloudinary	41819	FnGlt6WjyD1HnaPzCcUc6Q==	2023-01-26 16:30:31.303901
30	3bga1dw5p9ql0qad7wzsdv0fbn4h	bike3.jpg	image/jpeg	{"identified":true,"analyzed":true}	cloudinary	4017092	2L8uClxolk2WsF2M0B2lDA==	2023-02-03 09:52:19.459277
31	2tfkdxp97hafb69dyg38a4zux8x1	bicycle.jpeg	image/jpeg	{"identified":true,"analyzed":true}	cloudinary	78509	/YC+B9xhxpo0WkNbNJ1aJw==	2023-02-03 09:58:31.605959
32	2cemha3l068qswgcodal0xgir0di	basketball-ball.png	image/png	{"identified":true,"analyzed":true}	cloudinary	41819	FnGlt6WjyD1HnaPzCcUc6Q==	2023-02-09 14:24:41.71534
33	xueicguja3c86ergl4qonlz9tgw6	back-arrow.png	image/png	{"identified":true,"analyzed":true}	cloudinary	368	TcDCFpC1XYmx/yDExWeJ2A==	2023-02-09 14:24:41.71737
34	axgbxr97np3wwhu424fojftpgqlw	buletin.jpg	image/jpeg	{"identified":true,"analyzed":true}	cloudinary	1937712	/FMtR8/RialcH+6nt7H0mw==	2023-02-09 14:24:41.812814
43	byc1ud5p05zuv3uykz1jmhbsqaer	download (1).jpeg	image/jpeg	{"identified":true,"analyzed":true}	cloudinary	5126	L+3xQmLnSXVyfu2+WvAZnw==	2023-02-21 08:39:17.860368
46	1806q9gnn6fez83aclucpt4onk2f	james.jpeg	image/jpeg	{"identified":true}	cloudinary	415368	9MfKzc6iW93CsKARPfAGBA==	2023-03-29 07:08:08.50059
44	x2cxnbuvfgjso2e30rguw984d0u8	james.jpeg	image/jpeg	{"identified":true,"analyzed":true}	cloudinary	415368	9MfKzc6iW93CsKARPfAGBA==	2023-03-16 14:06:07.041486
45	uby7ifji9f1ryki2n4xk5k103vou	GT-Force-Carbon-Pro-01-e8d9218.jpg	image/jpeg	{"identified":true,"analyzed":true}	cloudinary	129303	M4hOp9Hamo7CfO10SSyDSg==	2023-03-19 15:06:49.95195
47	hiuj6bkoyfcmcy3ovemyozym7wrz	james.jpeg	image/jpeg	{"identified":true}	cloudinary	415368	9MfKzc6iW93CsKARPfAGBA==	2023-03-29 07:13:40.253759
48	cxnb8wraigbrgosjux9avk5vsync	james.jpeg	image/jpeg	{"identified":true}	cloudinary	415368	9MfKzc6iW93CsKARPfAGBA==	2023-03-29 07:31:51.621121
49	qgyz090559js8d83zna0tsa9fi9p	james.jpeg	image/jpeg	{"identified":true}	cloudinary	415368	9MfKzc6iW93CsKARPfAGBA==	2023-03-29 10:12:17.871327
50	1ctac2whdnce654fta6u7kgfgv2t	james.jpeg	image/jpeg	{"identified":true}	cloudinary	415368	9MfKzc6iW93CsKARPfAGBA==	2023-03-29 10:13:35.295908
52	ed4xqdw3llxqqclgpt911oscplu1	image646031180.jpg	image/jpeg	{"identified":true,"analyzed":true}	cloudinary	12570	kT3atiDyXHHfbw4xLNNBYg==	2023-03-29 10:18:23.719008
\.


--
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2023-01-13 20:10:52.6267	2023-01-13 20:10:52.6267
\.


--
-- Data for Name: assets; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.assets (id, post_id, created_at, updated_at, user_id, is_bicycle) FROM stdin;
1	1	2023-01-16 13:48:46.135145	2023-01-16 13:48:46.135145	\N	f
2	33	2023-01-19 12:14:30.560298	2023-01-19 12:14:30.614583	36	f
4	33	2023-01-19 12:15:50.38668	2023-01-19 12:15:50.402861	36	f
3	33	2023-01-19 12:15:50.383551	2023-01-19 12:15:50.410413	36	f
5	33	2023-01-19 12:19:05.787328	2023-01-19 12:19:05.811894	36	f
6	33	2023-01-19 12:19:10.388445	2023-01-19 12:19:10.405915	36	f
7	36	2023-01-19 15:24:50.855191	2023-01-19 15:24:50.883382	36	f
8	39	2023-01-20 09:44:40.638187	2023-01-20 09:44:40.669652	36	f
9	43	2023-02-03 09:52:19.434532	2023-02-03 09:57:24.152314	46	t
10	44	2023-02-03 09:58:31.593067	2023-02-03 09:58:54.38973	46	t
11	44	2023-02-09 14:21:50.379359	2023-02-09 14:21:50.379359	46	t
13	46	2023-02-09 14:24:41.701821	2023-02-09 14:24:41.726582	36	f
14	46	2023-02-09 14:24:41.80308	2023-02-09 14:24:41.816985	36	f
12	46	2023-02-09 14:24:41.690735	2023-02-09 14:25:18.60428	36	t
15	47	2023-03-16 14:06:07.025939	2023-03-16 14:06:07.050212	36	f
16	45	2023-03-19 15:06:49.941009	2023-03-19 15:07:50.323172	36	t
\.


--
-- Data for Name: brandnames; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.brandnames (id, name, created_at, updated_at) FROM stdin;
68	Trek	2023-04-01 16:38:30.012288	2023-04-01 16:38:30.012288
69	Specialized	2023-04-01 16:38:34.663936	2023-04-01 16:38:34.663936
70	Giant	2023-04-01 16:38:38.822704	2023-04-01 16:38:38.822704
71	Bergamont	2023-04-01 16:38:43.368183	2023-04-01 16:38:43.368183
72	Cannondale	2023-04-01 16:38:48.661844	2023-04-01 16:38:48.661844
73	Scott	2023-04-01 16:38:58.374175	2023-04-01 16:38:58.374175
74	Bianchi	2023-04-01 16:39:04.067828	2023-04-01 16:39:04.067828
75	Merida	2023-04-01 16:39:15.055986	2023-04-01 16:39:15.055986
76	Orbea	2023-04-01 16:39:19.579299	2023-04-01 16:39:19.579299
77	Raleigh	2023-04-01 16:39:24.523616	2023-04-01 16:39:24.523616
78	Cube	2023-04-01 16:39:41.135221	2023-04-01 16:39:41.135221
79	Ghost	2023-04-01 16:39:46.152825	2023-04-01 16:39:46.152825
80	Lapierre	2023-04-01 16:39:57.397332	2023-04-01 16:39:57.397332
81	GT	2023-04-01 16:40:47.578914	2023-04-01 16:40:47.578914
82	Santa Cruz	2023-04-01 16:40:52.261008	2023-04-01 16:40:52.261008
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.categories (id, name, created_at, updated_at) FROM stdin;
2	Gravel	2023-04-01 16:41:47.878851	2023-04-01 16:41:47.878851
3	Mountain	2023-04-01 16:41:52.407394	2023-04-01 16:41:52.407394
4	Road	2023-04-01 16:41:55.803945	2023-04-01 16:41:55.803945
5	Cyclocross	2023-04-01 16:42:04.0852	2023-04-01 16:42:04.0852
6	Touring	2023-04-01 16:42:11.41599	2023-04-01 16:42:11.41599
7	BMX	2023-04-01 16:42:23.920765	2023-04-01 16:42:23.920765
8	Folding	2023-04-01 16:42:34.36802	2023-04-01 16:42:34.36802
9	Cruiser	2023-04-01 16:42:38.087787	2023-04-01 16:42:38.087787
10	Fat	2023-04-01 16:42:45.358266	2023-04-01 16:42:45.358266
11	City	2023-04-01 16:42:48.794509	2023-04-01 16:42:53.516784
12	Kids	2023-04-01 16:42:58.435483	2023-04-01 16:42:58.435483
13	Tandem	2023-04-01 16:43:07.076149	2023-04-01 16:43:07.076149
14	Recumbent	2023-04-01 16:43:14.564307	2023-04-01 16:43:14.564307
\.


--
-- Data for Name: colors; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.colors (id, name, created_at, updated_at) FROM stdin;
23	White	2023-04-01 16:36:03.973573	2023-04-01 16:36:03.973573
24	Black	2023-04-01 16:36:08.561213	2023-04-01 16:36:08.561213
25	Red	2023-04-01 16:36:13.313675	2023-04-01 16:36:13.313675
26	Blue	2023-04-01 16:36:18.915077	2023-04-01 16:36:18.915077
27	Green	2023-04-01 16:36:27.349148	2023-04-01 16:36:27.349148
28	Yellow	2023-04-01 16:36:32.383029	2023-04-01 16:36:32.383029
29	Orange	2023-04-01 16:36:36.302201	2023-04-01 16:36:36.302201
30	Gray	2023-04-01 16:36:40.519194	2023-04-01 16:36:40.519194
31	Brown	2023-04-01 16:36:47.422854	2023-04-01 16:36:47.422854
32	Purple	2023-04-01 16:37:06.343516	2023-04-01 16:37:06.343516
33	Pink	2023-04-01 16:37:35.856956	2023-04-01 16:37:35.856956
34	Olive	2023-04-01 16:37:40.761256	2023-04-01 16:37:40.761256
35	Turquoise	2023-04-01 16:37:53.613347	2023-04-01 16:37:53.613347
\.


--
-- Data for Name: component_groups; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.component_groups (id, name, created_at, updated_at) FROM stdin;
5	Shimano Deore	2023-04-01 16:45:08.062233	2023-04-01 16:45:08.062233
6	Shimano Deore SLX	2023-04-01 16:45:14.882143	2023-04-01 16:45:14.882143
7	Shimano Deore LX	2023-04-01 16:45:24.248621	2023-04-01 16:45:24.248621
8	Shimano Deore XT	2023-04-01 16:45:31.302578	2023-04-01 16:45:31.302578
9	Shimano Deore XTR	2023-04-01 16:45:38.770071	2023-04-01 16:45:38.770071
10	Shimano Ultegra	2023-04-01 16:45:49.616999	2023-04-01 16:45:49.616999
11	Shimano Dura-Ace	2023-04-01 16:45:57.293528	2023-04-01 16:45:57.293528
12	Shimano Tiagra	2023-04-01 16:46:29.38319	2023-04-01 16:46:29.38319
14	SRAM GX Eagle	2023-04-01 16:46:53.816343	2023-04-01 16:47:48.204535
13	SRAM NX Eagle	2023-04-01 16:46:45.192678	2023-04-01 16:47:53.464268
16	SRAM X01 Eagle	2023-04-01 16:47:17.221624	2023-04-01 16:48:00.350461
15	SRAM XX1 Eagle	2023-04-01 16:47:05.924631	2023-04-01 16:48:04.794895
17	SRAM Red	2023-04-01 16:48:18.635845	2023-04-01 16:48:18.635845
18	SRAM Force	2023-04-01 16:48:23.186582	2023-04-01 16:48:23.186582
19	Shimano Alivio	2023-04-01 16:49:14.610828	2023-04-01 16:49:14.610828
20	Shimano Altus	2023-04-01 16:49:23.113647	2023-04-01 16:49:23.113647
21	Shimano Acera	2023-04-01 16:49:34.667212	2023-04-01 16:49:34.667212
\.


--
-- Data for Name: costs; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.costs (id, amount, description, created_at, updated_at, day) FROM stdin;
4	123	first cost	2023-03-09 12:50:35.325548	2023-03-09 12:50:35.325548	2023-03-09
5	14	Refund for paul.adrian2001@yahoo.com	2023-03-12 12:12:43.827639	2023-03-12 12:12:43.827639	2023-03-12
6	15	Refund for paul.adrian2001@yahoo.com	2023-03-12 12:13:33.242719	2023-03-12 12:13:33.242719	2023-03-12
\.


--
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.favorites (id, user_id, post_id, created_at, updated_at) FROM stdin;
29	36	46	2023-03-19 15:25:28.903763	2023-03-19 15:25:28.903763
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.locations (id, name, created_at, updated_at, short) FROM stdin;
1	Alba	2023-01-18 13:03:50.153189	2023-02-14 11:02:11.014157	AB
2	Arad	2023-01-18 13:03:50.161858	2023-02-14 11:02:11.018207	AR
3	Argeş	2023-01-18 13:03:50.163349	2023-02-14 11:02:11.020392	AG
4	Bacău	2023-01-18 13:03:50.164708	2023-02-14 11:02:11.022441	BC
5	Bihor	2023-01-18 13:03:50.166321	2023-02-14 11:02:11.024805	BH
6	Bistriţa-Năsăud	2023-01-18 13:03:50.167643	2023-02-14 11:02:11.026827	BN
7	Botoşani	2023-01-18 13:03:50.168991	2023-02-14 11:02:11.028719	BT
8	Brăila	2023-01-18 13:03:50.170325	2023-02-14 11:02:11.030723	BR
9	Braşov	2023-01-18 13:03:50.171635	2023-02-14 11:02:11.032755	BV
10	Bucureşti	2023-01-18 13:03:50.17292	2023-02-14 11:02:11.034604	B
11	Buzău	2023-01-18 13:03:50.174209	2023-02-14 11:02:11.043197	BZ
12	Călăraşi	2023-01-18 13:03:50.175551	2023-02-14 11:02:11.045203	CL
13	Caraş-Severin	2023-01-18 13:03:50.176724	2023-02-14 11:02:11.047182	CS
14	Cluj	2023-01-18 13:03:50.177888	2023-02-14 11:02:11.048882	CJ
15	Constanţa	2023-01-18 13:03:50.179063	2023-02-14 11:02:11.051287	CT
16	Covasna	2023-01-18 13:03:50.180216	2023-02-14 11:02:11.052953	CV
17	Dâmboviţa	2023-01-18 13:03:50.181417	2023-02-14 11:02:11.054572	DB
18	Dolj	2023-01-18 13:03:50.182592	2023-02-14 11:02:11.05615	DJ
19	Galaţi	2023-01-18 13:03:50.183939	2023-02-14 11:02:11.058053	GL
20	Giurgiu	2023-01-18 13:03:50.185101	2023-02-14 11:02:11.059952	GR
21	Gorj	2023-01-18 13:03:50.186276	2023-02-14 11:02:11.061574	GJ
22	Harghita	2023-01-18 13:03:50.187455	2023-02-14 11:02:11.063173	HR
23	Hunedoara	2023-01-18 13:03:50.188657	2023-02-14 11:02:11.065607	HD
24	Ialomiţa	2023-01-18 13:03:50.189827	2023-02-14 11:02:11.067643	IL
25	Iaşi	2023-01-18 13:03:50.191042	2023-02-14 11:02:11.069241	IS
26	Ilfov	2023-01-18 13:03:50.192975	2023-02-14 11:02:11.070793	IF
27	Maramureş	2023-01-18 13:03:50.194416	2023-02-14 11:02:11.07235	MM
28	Mehedinţi	2023-01-18 13:03:50.195624	2023-02-14 11:02:11.074108	MH
29	Mureş	2023-01-18 13:03:50.196858	2023-02-14 11:02:11.07559	MS
30	Neamţ	2023-01-18 13:03:50.197922	2023-02-14 11:02:11.07703	NT
31	Olt	2023-01-18 13:03:50.199042	2023-02-14 11:02:11.078311	OT
32	Prahova	2023-01-18 13:03:50.200135	2023-02-14 11:02:11.079733	PH
33	Sălaj	2023-01-18 13:03:50.201374	2023-02-14 11:02:11.081022	SJ
34	Satu Mare	2023-01-18 13:03:50.202495	2023-02-14 11:02:11.082323	SM
35	Sibiu	2023-01-18 13:03:50.203597	2023-02-14 11:02:11.083582	SB
36	Suceava	2023-01-18 13:03:50.205479	2023-02-14 11:02:11.085206	SV
37	Teleorman	2023-01-18 13:03:50.206709	2023-02-14 11:02:11.086319	TR
38	Timiş	2023-01-18 13:03:50.208253	2023-02-14 11:02:11.087465	TM
39	Tulcea	2023-01-18 13:03:50.209336	2023-02-14 11:02:11.088602	TL
40	Vâlcea	2023-01-18 13:03:50.210452	2023-02-14 11:02:11.089854	VL
41	Vaslui	2023-01-18 13:03:50.211472	2023-02-14 11:02:11.090998	VS
42	Vrancea	2023-01-18 13:03:50.212481	2023-02-14 11:02:11.092137	VN
\.


--
-- Data for Name: materials; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.materials (id, name, created_at, updated_at) FROM stdin;
2	Steel	2023-04-01 16:50:14.561622	2023-04-01 16:50:14.561622
3	Aluminium	2023-04-01 16:50:18.96545	2023-04-01 16:50:18.96545
4	Titanium	2023-04-01 16:50:31.260825	2023-04-01 16:50:31.260825
1	Carbon Fiber	2023-01-25 12:28:55.72999	2023-04-01 16:50:34.593788
5	Hybrid	2023-04-01 16:50:46.405132	2023-04-01 16:50:46.405132
\.


--
-- Data for Name: message_statuses; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.message_statuses (id, message_id, user_id, room_id, created_at, updated_at) FROM stdin;
23	189	49	16	2023-03-20 18:59:36.415705	2023-03-20 18:59:36.415705
24	190	49	14	2023-03-20 18:59:46.409526	2023-03-20 18:59:46.409526
34	200	49	29	2023-03-31 16:02:17.819947	2023-03-31 16:02:17.819947
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.messages (id, user_id, room_id, content, created_at, updated_at) FROM stdin;
91	36	5	PAaH0FioGB8Knsfc1cLdj6SO24kDWUObzjVV3Ue2sQ==--BqeiSAiR0MsmlFIg--hiIfAPQD+9zHCDlpInTdag==	2023-03-01 17:32:12.535646	2023-03-01 17:32:12.535646
92	36	5	Q8ut1j42zhiTlwQ27QTBpqGf1IZJMF1k--oowpMRBveu2f465z--XGxLUB7LFMS3inMOj3cKIg==	2023-03-01 17:32:17.473203	2023-03-01 17:32:17.473203
93	46	5	bUeJQePfx9zYerN/2VV2jOSos29U+kE=--fmyJvtu5BkbNzB3n--gV4I/8w2oL568xELRHevzg==	2023-03-01 17:33:09.229164	2023-03-01 17:33:09.229164
94	46	5	XvrOoc3QPBgw+d6C3eYwWMskJYo=--EcWrMLbKlgHFTlg9--Au4hIOaOd5IziIUNilh0mg==	2023-03-01 17:34:21.0757	2023-03-01 17:34:21.0757
95	36	8	S6Cgzt8mKA23DjbJbi+8tE7VhkTsFkWn--K9XBFg4brqCVzVFi--OZW9gPB8m24ZZLF/gLBpzA==	2023-03-01 18:46:38.379523	2023-03-01 18:46:38.379523
96	36	8	NrXg+qzmumtvpx4m1ZNPo8x7HyN1XxkBSlNowfOo1z5PAg==--vsW8AZffh7ggNFcU--+LoVT71cAZV/movAZiJ8EQ==	2023-03-01 18:46:47.21486	2023-03-01 18:46:47.21486
97	36	8	i+b97FeWNefT7vyfS4ZsknY3ztKbEdO/asyphduU--zfDNilZyMwBcabUZ--K8OTH10KAr/Nk+9wirRiUg==	2023-03-01 18:48:10.143259	2023-03-01 18:48:10.143259
98	36	8	8SQrYxgC+vVLhajKiV8A2yOnEuCifi2aglsOVcMo4dz4qq4P4tUccBY3qV8b+wp5dsJ350mEAT53gYcEeCxsbxZTwkA5DOFeMrsZSpc6IL0bn3hTPYTIfGSKrya0+w4eTWGvYdVmobOYdlWcjO8U0juRT6FPZJ/2v6aSYfGqntwcXppLhUSn5HpZwJZKLKHueOM=--W8ghkYfHpgeCcNap--Tey+CFUCeO4CtINhbpj0wQ==	2023-03-01 18:48:36.144887	2023-03-01 18:48:36.144887
99	36	8	oIqMcHuCvKBD/nvYT6yfwSnTQSfYbftlLDNNNUZAMziiTJzknjl7jcS+DRIX0lf3SDiG79k8sO0ZcnW2agG3ZNzsb3iT5MvilA==--f9V4zCQepCv7MSr+--qDJyKoPL//BWNXXhDnOMmA==	2023-03-01 18:48:47.808461	2023-03-01 18:48:47.808461
100	46	8	mqj0u/NW70c0JNuYUnIvDyvFzarbRPXqKV8hJ/kBTeFo/w==--kRFTAkiU7h8D92xp--v2GtSauJR/D4IqPOiMIkzQ==	2023-03-01 18:55:10.318935	2023-03-01 18:55:10.318935
101	46	8	nyVyEh0gu0QEemcVfI+zEEo5bVI=--tATVvjakjJLGrSIF--8NG2gBWzL7EmXp9b/1gcDg==	2023-03-01 18:55:15.568214	2023-03-01 18:55:15.568214
102	46	8	CL7ujvdrXJzIYcnP2Huu--/BxTboVVDpVIanLs--uZmYJn54u23vDnm8L3X1tA==	2023-03-01 18:57:38.869412	2023-03-01 18:57:38.869412
103	36	8	ebeq6Mv5nopBE1PMZlErqMg=--i3zYuY0lzX1mg4Lf--8NRsRXwib5nKoEa9ZZPs3g==	2023-03-01 18:58:31.988676	2023-03-01 18:58:31.988676
104	46	8	Ca/aS37HfSQsrb7aYPs=--ontzW3ztBDai0rzU--aNIgWrti2Xlz0yVmR+fo/w==	2023-03-01 18:58:37.528965	2023-03-01 18:58:37.528965
105	46	8	zSi8TY+wobKsou5ztw==--Ja/CmdyjK312/V6j--vrfV+vIFt/3PwSs/Wj7O+g==	2023-03-01 18:58:42.688568	2023-03-01 18:58:42.688568
106	36	8	bSn8fKSuMWJQvsTVyQ==--vYoFYYFKlxsuCj8o--bmZi2IDLvQc3vLLaLPsExw==	2023-03-01 18:58:46.746961	2023-03-01 18:58:46.746961
107	36	8	dWJrZK5iahbsxNejreA=--wJNed3Ewe0B+7c3X--l6o7EQ0kqh8SFMPnPqS4ig==	2023-03-01 18:58:53.292384	2023-03-01 18:58:53.292384
108	36	8	24aIyi3sQrTLJawc--2f87t92hKBS99gMi--v5JZwuqbPuqKpm6Balf1tw==	2023-03-01 18:58:55.289751	2023-03-01 18:58:55.289751
109	36	8	HK8mp9mRfOZJacoVWA==--Gg2cgpl61a6oNX//--RpHOZD/U2TsxqMbsQTmAJw==	2023-03-01 18:58:56.536481	2023-03-01 18:58:56.536481
110	46	8	4vRw+AWsxRGKuFQaDQ==--enZSMSwd3XsHVdvr--aq/YbymL7pTh9O1jFki1eQ==	2023-03-01 18:59:04.03842	2023-03-01 18:59:04.03842
111	46	8	WrQQrtcaxDI2dIYZ--RpWau8O7mJqG/dyc--HXqKgLiKGWIhiZ6drmj+2w==	2023-03-01 19:00:10.54028	2023-03-01 19:00:10.54028
112	46	8	dxnk6rhFLoZf9k1Q--rcVfBOdFDsZYsvUM--+gsmk0vyLtbnvXKaZHMhoQ==	2023-03-01 19:00:15.939705	2023-03-01 19:00:15.939705
113	36	8	IRzj+89HtRgnHebllid/LxA=--4FqYfhrK1oLCMXkT--LoFg6X0v7Ni5t9Vzv1DUCQ==	2023-03-01 19:00:39.699295	2023-03-01 19:00:39.699295
114	46	8	HNgvYuYKoi3SS6cwZM2ht9Kjqz4VErA94g==--Y5V9b1RvgJwALO/4--gSKlbd6pK4dS96AoiWXzpQ==	2023-03-01 19:01:02.033888	2023-03-01 19:01:02.033888
115	46	8	j1BrQNCEvouKBSZB7frxffRsh8E=--6VTc/0yc9fDe7d+2--wIfW3em85IQhL6Eo1aq58g==	2023-03-01 19:01:32.709369	2023-03-01 19:01:32.709369
116	46	8	yWaeYg+xru2G3JHxCpRxS0ou+nUh--LvNMqOdhnAOIPWG4--Fb9fifAgCXl11nEtubldrQ==	2023-03-01 19:01:37.265318	2023-03-01 19:01:37.265318
117	36	8	mm+V67hGuCD8o8uRdush37EvMp2iRDpl--dmw31IaEOaSjivhE--+UMJGdG2BFnbN+gf5GB3cQ==	2023-03-01 19:01:41.643923	2023-03-01 19:01:41.643923
118	46	8	4CmZiodyoeN4Uo5UWDQo--61yDXRFSdA9yKjM3--qC3GLYW/1YsrX8E4vs/MxQ==	2023-03-01 19:04:44.138087	2023-03-01 19:04:44.138087
119	36	8	EXyFudYdiRrVPFSqyg==--bBdW5Qnrr7oiVBqd--2wj100kgcpDuMlmY/ey5BA==	2023-03-01 19:04:47.481127	2023-03-01 19:04:47.481127
120	36	8	bVlwFOgBTj2YnCcF7i3H--Rcrytzu846SL7Reu--h8E2vshjkTflKHeVk5Ctkw==	2023-03-01 19:05:38.646881	2023-03-01 19:05:38.646881
121	46	8	qaippHhB9THEzIduAQX51doTUKU=--VueRTYbbHMgC4bbr--6XrK6jV/4dp7dc0IQUttCA==	2023-03-01 19:05:44.137586	2023-03-01 19:05:44.137586
122	46	8	KrchW6esCuB+a7Gr3Q==--5MfGXpfU/UtLHstg--s5H6CaEBPafF2JngvtwX7A==	2023-03-01 19:05:46.87657	2023-03-01 19:05:46.87657
123	36	8	gcBJabwhTKAJQ4D07g==--RDoLOUSNDE7gS1UJ--KDKs7yPdujcjvpfB7DU4AQ==	2023-03-01 19:05:51.665553	2023-03-01 19:05:51.665553
124	36	8	ru1m7BWNlhaKUy358HrGsuylStwYFG7GmA==--K7JIPWZGOu6Kbp0y--mmyFo1Jf9bSZoWmVRuhWLA==	2023-03-01 19:06:42.211452	2023-03-01 19:06:42.211452
125	46	8	I6qCbEVV5O21AdBmMM01--waTq5ecL2sx/Vesn--hGij4Lm882xXafpuEOxMog==	2023-03-01 19:06:46.381986	2023-03-01 19:06:46.381986
126	36	8	UgLErQtqQ+PcQux7uN5PLjWl5ugy--LbrPB54teGfYeYhm--f2e/mAqMT9GLjjOBnYWTVg==	2023-03-01 19:07:23.644737	2023-03-01 19:07:23.644737
127	46	8	mBln0MdPUzwnXgSHgjEnjufNa6UNp7oH6Lxqal0=--u7RqVSsnL2Qreqz9--wnMcGRvAofg4fDhFJ6ejPg==	2023-03-01 19:07:29.679363	2023-03-01 19:07:29.679363
128	36	8	W0gHSI57zdVW8+Ad2gmxvpZCXLaTLRczdv1vo/EF--YEurwp11EXBfwT0y--z6ldH2yERvT4ahsNLOkubQ==	2023-03-01 19:09:10.328348	2023-03-01 19:09:10.328348
129	46	8	yLBUEGBrTUOS67aBZPQ=--a1hJlfmazurmLfPj--wa5r3BMF41CtxnmJQQ98hA==	2023-03-01 19:09:13.707724	2023-03-01 19:09:13.707724
130	36	8	vnCvG4HUN6WoX1gPX/d0H8F5MEShrHWHVKWTss36ZV0+1FCRoMqhykh4WjBtdH+poA973Tvr8kyBk37K2ZzGLdir0hSpOXZQrKZbdPCbJYT/iRykx0KyOeqjGkPnVZwp5IQWHk2XqnIGMx1e2L8atw7zROkr31AQSjLwDaE3T+ZF7aUgZH+CthscLXViP9Y5PJMK9oXmOp6C/cLIVpdrnow/Z2rB6gXtpafxIXVDAI2yJt7Z77hfr8nkgQ1/yDs=--PmaKumP6uP1cFmht--ZjTc/pXLcYTeBvJgWH0nsw==	2023-03-01 19:10:56.465758	2023-03-01 19:10:56.465758
131	46	8	Z58UsiYjiuRKYBSCQjZYIZmynd4=--tUSJyvQn8a+m6kzA--VfYLAFTugjv/pNpb9kyp+w==	2023-03-01 19:27:46.598234	2023-03-01 19:27:46.598234
132	37	8	jlE2M5QCdbY8uvGhUw==--lKzt3gvhodooB9Tf--XaN8/KM4c07C4KUGCFWD1g==	2023-03-02 07:28:03.565414	2023-03-02 07:28:03.565414
133	37	5	yxAJipaVmJAg627g92dV--vHb58SUyH6+FdnoR--cP77mVcCEr5HLmjgiq7fMQ==	2023-03-02 11:22:42.422807	2023-03-02 11:22:42.422807
134	37	5	gOPhyVICryoAid2QorB1--oyCgesgDt6FliA0i--xoVEN+VwGWIKcsjfVLlNgw==	2023-03-02 11:22:45.961136	2023-03-02 11:22:45.961136
135	37	5	s+BF3pi5FQ2WV98b1A==--w2CHoFJmd6ivz5ag--JHB0ISqLmDPewIebC95CXg==	2023-03-02 11:24:01.53221	2023-03-02 11:24:01.53221
136	37	5	W1epAMfFqqcl4Nmdgg==--9rojKK+qK6Ftitpo--2s/yGK2VGdx9nJr/AGaxYA==	2023-03-02 11:24:03.76461	2023-03-02 11:24:03.76461
137	37	5	B/vjbr3vs6lgcxDkxDo0Lzoz6cDD1tOWoCMFgtSiBNbRVfpYCLWU+CAjT7U4jvHf/z9pcckIZQHy4ydsNAvPi0odf4taG+226z20SGJ6sg9U2glZ7RYsS4RnoByGkFJtGM2yaguODkL5HStTgXVVo/oMY/MbMbU1srCM9xA2D8zVL1ctDd/BXQXTeasEZflsAUkVXzrfieoQo4t0Zg5N72eid6vG4xwVh8stl9ncA99lJ/aAnULe--j9ZSz0FWk50vP1vz--L6JmdzD5S+VXGKNCexvHXg==	2023-03-02 11:28:04.154592	2023-03-02 11:28:04.154592
138	37	6	MmrRB5HgdfUM13nC4xKa--gNaLzS3vA5MsekLG--JwtdJHnKKVRBRM9/tLXVlw==	2023-03-07 16:35:27.116428	2023-03-07 16:35:27.116428
139	37	6	d4/WoIqt/h2dnrXn0yU=--hUc6+u6UExKdSwj5--ZWdTztNS/qBHzHDLm5rpVA==	2023-03-07 16:35:31.774552	2023-03-07 16:35:31.774552
140	37	6	EGMMqIeyS0zxv3yvqPbdGCX3jyPlC+py4gDZvE5fnIoV3Ph8+teO5iE=--e4BxcrSeTHVh1Xnv--STHgFlu8nLG/c+sn3t/Mxw==	2023-03-07 16:35:38.454565	2023-03-07 16:35:38.454565
141	37	6	D/gdnz+dpVs+5fB996sHNX3PzpKloqVMX7Ydb3kaM7E=--VHlkXboEF4Erj7VS--7x2wIgTaZGfj+zO0eFX19w==	2023-03-07 16:35:42.43076	2023-03-07 16:35:42.43076
142	37	6	xi6eQA7P6MbxFY6j+oIEWtkcNXJb+QMZ0CunGaIophm6+xotGFkipBwFD3J10Ulw6oy8--XyyxG7pDQrcY3rBi--ipRA48ncis66CnTm7jKSFg==	2023-03-07 16:35:46.900917	2023-03-07 16:35:46.900917
144	37	5	W1epAMfFqqcl4Nmdgg==--9rojKK+qK6Ftitpo--2s/yGK2VGdx9nJr/AGaxYA==	2023-03-07 17:47:12.809147	2023-03-07 17:47:12.809147
145	37	5	W1epAMfFqqcl4Nmdgg==--9rojKK+qK6Ftitpo--2s/yGK2VGdx9nJr/AGaxYA==	2023-03-07 18:23:43.143113	2023-03-07 18:23:43.143113
146	37	5	W1epAMfFqqcl4Nmdgg==--9rojKK+qK6Ftitpo--2s/yGK2VGdx9nJr/AGaxYA==	2023-03-07 18:24:00.224101	2023-03-07 18:24:00.224101
147	37	5	W1epAMfFqqcl4Nmdgg==--9rojKK+qK6Ftitpo--2s/yGK2VGdx9nJr/AGaxYA==	2023-03-07 18:24:17.747461	2023-03-07 18:24:17.747461
143	36	20	A9vJFdNS34m222E5cT6878o8q3GidengnY73eTSoPEIYXgdd--iL1gJsCqwTwPaiBH--VViUYHKAwsY5f8Iuz30pwQ==	2023-03-07 17:16:45.280748	2023-03-07 18:43:28.105004
148	37	14	xOKB+wb9D3gOjq0pIA==--U6/QmrY8GdQK06tQ--VrkmCX27D43CxK20JllU1A==	2023-03-07 19:11:48.230828	2023-03-07 19:11:48.230828
150	37	8	AJEY8D+mx5m+8SVuzCw=--b/l07NVJbVviK4PD--CPLV4Z59D0KrsVmLTIHypg==	2023-03-07 19:22:33.401648	2023-03-07 19:22:33.401648
152	36	20	FqDUZlAH4PCxSCpOBFlnaaJho1rwcrTIYQXVer7TnFmV--ZveaxJd5KntOPZGJ--jY+ZvhOBk0Tqa/q5ZhxUkw==	2023-03-07 19:25:14.08296	2023-03-07 19:25:14.08296
153	37	20	V30A/e4/jkVFKv/vtSRjMTyJCOfUffO/jeDy7X4=--SwB5d8OcNTyMsYuy--RA3xDdd9oNGHRBFGI/7aRQ==	2023-03-07 19:25:23.061776	2023-03-07 19:25:23.061776
154	36	20	tAqCJxLDJ5P2dKEo4g==--dmi6ELARd+xiGxel--Xk3E45GqCo9pffZbWeZBSA==	2023-03-07 19:25:31.004059	2023-03-07 19:25:31.004059
158	37	25	Abn4v6VKj3WmrNI0Cw==--zn3MwtaEsTeY3A/R--T5HMmOnF3x2UlxSkVMtIVg==	2023-03-07 20:09:34.734194	2023-03-07 20:09:34.734194
159	37	25	XY3nD9KbQZ9/VUUMiW8oo95M1nf+QflW/azpOi9z8Q==--s5Cus+Pw4h5WC3Ne--yIyGa26z78jWkcq0jci+ag==	2023-03-07 20:18:35.502192	2023-03-07 20:18:35.502192
160	37	20	sLz1tQQ1Y5lRdWEA9XkL3nU1tz48hA==--AlVl2OB6fbd0QIqT--N/Fl1IdF5Wd7aqlc8cacew==	2023-03-07 20:18:43.247603	2023-03-07 20:18:43.247603
161	46	25	KSThGy7ITlKmOpY8Fb3tDy9soX1NeQ==--f5gxJd9lIXiKPuO4--/EEtnz0eEsbrCcjdEx8cAg==	2023-03-16 12:41:19.991638	2023-03-16 12:41:19.991638
162	37	20	xIQ6GZ4I2V3Js280Iw==--sMgNnrmxfpuC8aOv--o5Vt6edzWQUgm2rwLZKDuA==	2023-03-19 16:33:28.390541	2023-03-19 16:33:28.390541
163	36	20	dXAJNhhbRqgC6xM7EtyA8A==--TG8sAOhTmqc8J3MA--I2hMKKLoEwT4vWRh33kFxA==	2023-03-19 16:41:03.704907	2023-03-19 16:41:03.704907
164	49	8	6gNXkW8hg5rtyqAAFwErOrBAcipP--cvgKq2UmvHIhUypv--yH5tgy/zbFIu7nhrxkTSrA==	2023-03-20 16:09:02.527491	2023-03-20 16:09:02.527491
165	49	4	QyN/HUW1Cr0PmkvfyZzQHGs=--m92YMb6/JIjK4mYq--VtEhw9MPrJOjBijWvQMd1w==	2023-03-20 16:09:09.705915	2023-03-20 16:09:09.705915
166	49	13	1TjjeQ4yz/pdT5k5BDu02pc=--o48AemcU/vI8cNvw--qSUptb4F0fnTJ6km3L1vrg==	2023-03-20 16:09:14.219831	2023-03-20 16:09:14.219831
167	49	13	m6u4z7EGd4PtGO6umA==--tOrmgeSTnGgwj5MT--tWqKkmRaEGRCEI0maSX+kw==	2023-03-20 16:12:01.214776	2023-03-20 16:12:01.214776
168	49	13	IvMvlczv/kUMkYdDHqxB5b/q--Cwi9+zTwcXxt70i4--fdSGjcpT2vLfq2p59WDSnQ==	2023-03-20 16:14:40.491566	2023-03-20 16:14:40.491566
169	49	13	NhkY7NgMZmiOaC+bx5g=--g1bCoYWsWLf3gYSc--d4hf4dGwN1MkcyIyMMVf4w==	2023-03-20 16:14:58.23589	2023-03-20 16:14:58.23589
170	49	13	tR/EK/aqcOGuFL27wG0B--AgqQG6xDzOwkAJKP--vX2t/14gwYvWneNl1Op1QA==	2023-03-20 16:16:25.245272	2023-03-20 16:16:25.245272
171	49	13	uS/u0YU6DqYpm4VnUnqbu+lnPnDh--R+KW7P4rPRIPwPqV--eAioftQOwNlaUZQZb7QP0w==	2023-03-20 17:05:11.300406	2023-03-20 17:05:11.300406
172	49	13	5rEE44g43NlL+eIbraMJ--wDeOr5sxrV3GOldc--tj69/r5nI7YfpgTodQbBjQ==	2023-03-20 17:05:24.243331	2023-03-20 17:05:24.243331
173	49	15	BHoN3nNXbAl8Giq9cZgIK1QhMoyHAIUZ--6SfrN9dtfLPv3nag--xMdu0PhLxD1sZ8JNJVjRdw==	2023-03-20 17:06:04.169381	2023-03-20 17:06:04.169381
174	49	5	t/rCnREkYymV0LCqDpQINFu4sXI3G0jrPR/jAQ==--GqjIyLzokObyc1a8--YlHXhsbjXkBn/+bB78eQ2A==	2023-03-20 17:07:05.844276	2023-03-20 17:07:05.844276
175	49	13	XOdRMMcqrQZuxRBA0jI7iwcDoyyyHR8dwKEMJQ==--YLGWSX9uYWid2//6--JK25fLS3X7N9GZajPOc3rQ==	2023-03-20 17:50:40.592876	2023-03-20 17:50:40.592876
176	49	5	YUhe7ThzKQSnpFeONJx6--1405jwhRe3KG7i71--WFBxEqRhoxXWAeDPdym8lw==	2023-03-20 17:50:54.138367	2023-03-20 17:50:54.138367
177	49	27	9tYSoE6wMpT1J6osQ1e8F0drUyIozee4lQ==--dH0eFVJdEu8cxRak--qD2SJ+bBk/azMP81nvfgmg==	2023-03-20 17:56:54.109888	2023-03-20 17:56:54.109888
178	49	27	60EzDzPCUy7GsmDm6Un0Ci0QZWjxV4pfvaA=--engFfD3IabZdiOxC--xECCARI/Zh8K/k0fHcKpLw==	2023-03-20 18:10:04.670642	2023-03-20 18:10:04.670642
179	49	27	C8o56jWlfEEBm0KqNsE=--gZ1XkGtmG9qoX0vU--kJYyrOb4SbqZcUhByq2nBw==	2023-03-20 18:48:42.856854	2023-03-20 18:48:42.856854
180	37	27	pm5+rY8K9MESxSUDq8xwAzRDZan0HUW3lvJQKYQYKA==--wNIfeq+mcfxLJEAm--fnPJxSFVcofOy8YMml0WTQ==	2023-03-20 18:49:04.496402	2023-03-20 18:49:04.496402
181	49	27	wN9bQklNIepkVNdApeMm3KdBrF56jsU=--UBlBm09nQhPWzC7C--OYW23xpy7l0CZn3f/qoFMA==	2023-03-20 18:49:11.070235	2023-03-20 18:49:11.070235
182	49	16	WTK1DqWnyhYzEPWmtyXG--F7eJItbFvUbj2QyI--JVlvjm6hPdwKPxSwLs56BA==	2023-03-20 18:49:31.112159	2023-03-20 18:49:31.112159
183	37	16	/q95wobqn+mkuNcBq9Kty8jNk8yS--gYCmb6GSdUhUdQYH--2h1iOdRrwHgOgEzDzWnFAg==	2023-03-20 18:49:35.925818	2023-03-20 18:49:35.925818
184	49	16	+daLGK65hEdLnVUKuJBOFlDUcmKdw9mUVw==--cb32wUw5fzznf9MD--WZ7pQGyUsBGkeY8e7XAh/A==	2023-03-20 18:49:43.672089	2023-03-20 18:49:43.672089
185	49	27	pdn3Yn2gfIZ/uMfgHQ==--FRvY4MGoz7yvHJJj--VtcTbrWwBtu3Qx9+Mbgr7g==	2023-03-20 18:54:33.348799	2023-03-20 18:54:33.348799
186	37	27	WTNcsPWwsvWMyzPHwA==--JsupGEyagF1XWIyI--sppzRbGg3eHCTv/DT8HKCQ==	2023-03-20 18:54:39.289821	2023-03-20 18:54:39.289821
187	37	15	4NLEOyj537+0N0Onrahohg==--feLKEwgQgbTP3PmS--floXDADg6k5Me0mQnvMV0A==	2023-03-20 18:54:54.153811	2023-03-20 18:54:54.153811
188	49	15	j+GSdgVlo7idX8yxxAjw--vpEUIC/wL2u5XRQe--dJoVZ8BOa9/yz9B34cDfQg==	2023-03-20 18:57:01.99603	2023-03-20 18:57:01.99603
189	37	16	gniLNX3CUlVT3UKDGF/lo8aWJZ2fTucvviM=--agsGNEZ0LaS7pC9N--xC/d0/LhM5SlbL7K12OE0A==	2023-03-20 18:59:36.397576	2023-03-20 18:59:36.397576
190	37	14	IOwzW8QKwScjRYT32osgoV6DhP0=--QkWIURGbt13uTuiT--QCfV6qlstOlS5P6xm/6Peg==	2023-03-20 18:59:46.394686	2023-03-20 18:59:46.394686
191	37	27	+UCHdrbLXrYHUc/ebPg=--rvtAl69NHOGWKFsV--jj8iJNhFVFT8EqFNXGVzRA==	2023-03-20 18:59:55.068864	2023-03-20 18:59:55.068864
192	37	20	1swSjS9HdZT5lUp2aSicSx8=--eA86yYxfKXZlNdUI--IPeeUIsy/9qcpTmT1wFV8Q==	2023-03-20 19:37:20.874699	2023-03-20 19:37:20.874699
193	36	20	9MIi/NmzjaCUOntSgmK5--KBOpG8Xf0lLzfE2Y--+LK1km7fFtl+s0ijiVC4ZQ==	2023-03-20 19:37:34.456705	2023-03-20 19:37:34.456705
194	36	20	snFaZZQdJw8L9GM6+L7r--93zv0qpwGVXAe7cu--8sl2y01Veq/bKyz8MUTGJA==	2023-03-29 06:02:32.991106	2023-03-29 06:02:32.991106
195	55	30	0AkDLzsKlZFvdPqEGN8f--qvNj5IZmYjPach8y--Duu0lVC9wUpeobIHPQgqaA==	2023-03-29 10:20:25.728347	2023-03-29 10:20:25.728347
196	55	30	OKWHCf3HIBDb54OT3Q==--4UfnS+WkaYH72YHZ--SUezR3AOPzw1AwBj+yFadA==	2023-03-29 10:21:24.997585	2023-03-29 10:21:24.997585
197	55	30	odCBSGroqS05/c2nRA==--A4Vpj1qdG3yRE7ix--z+HWe6/36mB5GjikHhPU/w==	2023-03-29 10:21:28.549213	2023-03-29 10:21:28.549213
198	55	30	bbwDPzpwKtzu7zTUig==--GU8ZPOWM6s3yZhAo--CzzzWsf+N/FuwcBp0HhmeQ==	2023-03-29 10:22:41.167533	2023-03-29 10:22:41.167533
199	37	30	tJL+38bZo6rOxLNYBuco--1cAAo9yXOj/jXCxB--06wmSdeF71WrGKoHx5qC3w==	2023-03-29 10:23:55.425586	2023-03-29 10:23:55.425586
200	36	29	q2+KBYq4xC1z4+0ERQACOpwF2GcuMA==--L1SRRv25vYGA+a3u--EnjkKIi9TEwMwkI9cxQ0Cw==	2023-03-31 16:02:17.796705	2023-03-31 16:02:17.796705
201	36	20	NsItT0E7URA4KKjhvFLVnFsIOX0=--fYMosey3LF++UG7f--ElDIt73EU1aEolzHxk88yA==	2023-04-12 07:18:53.963397	2023-04-12 07:18:53.963397
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.notifications (id, post_id, notified_id, created_at, updated_at, message, notification_type) FROM stdin;
8	46	36	2023-02-12 12:03:20.10156	2023-02-16 11:07:17.075499	Leave a review for 	review
10	\N	36	2023-02-12 12:36:50.410969	2023-02-16 11:07:36.690278	Your suggestion has been seen. Thank you	suggestion
11	\N	36	2023-02-16 11:05:01.092849	2023-02-20 12:06:01.30055	Please introduce your PayPal email	paypal_edit
13	\N	36	2023-02-20 15:44:25.811732	2023-02-20 15:44:25.811732	Cube Bike was bought. Ship it in 2 days	ship_bike
14	\N	46	2023-02-26 10:55:55.282844	2023-02-26 10:55:55.282844	Cannondale Bike was bought. Ship it in 2 days	ship_bike
16	44	36	2023-03-10 15:34:28.001321	2023-03-10 15:34:28.001321	Download your invoice for	invoice
17	\N	46	2023-03-12 12:12:16.173425	2023-03-12 12:12:16.173425	€15 were refunded to you	money_sent
18	\N	46	2023-03-12 12:12:43.803171	2023-03-12 12:12:43.803171	€14 were refunded to you	money_sent
19	\N	46	2023-03-12 12:13:33.231976	2023-03-12 12:13:33.231976	€15 were refunded to you	money_sent
20	\N	46	2023-03-12 14:33:16.528741	2023-03-12 14:33:16.528741	€15 were refunded to you	money_sent
23	\N	55	2023-03-29 10:18:24.784461	2023-03-29 10:18:24.784461	Please introduce your PayPal email	paypal_edit
\.


--
-- Data for Name: participants; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.participants (id, user_id, room_id, created_at, updated_at, last_read_at) FROM stdin;
1	46	7	2023-02-26 13:34:43.636774	2023-02-26 13:34:43.636774	\N
2	36	7	2023-02-26 13:34:43.650095	2023-02-26 13:34:43.650095	\N
3	37	20	2023-03-01 19:23:37.357105	2023-03-20 18:18:37.419794	2023-03-20 18:18:37.414861
18	37	25	2023-03-07 20:09:30.902278	2023-03-20 18:18:41.147677	2023-03-20 18:18:41.140713
34	36	29	2023-03-20 18:56:49.861515	2023-03-20 18:56:49.861515	\N
35	49	29	2023-03-20 18:56:49.869602	2023-03-20 18:56:49.869602	\N
36	37	30	2023-03-29 10:20:22.525902	2023-03-29 10:20:22.525902	\N
37	55	30	2023-03-29 10:20:22.536121	2023-03-29 10:20:22.536121	\N
38	51	31	2023-03-29 10:23:50.626614	2023-03-29 10:23:50.626614	\N
39	37	31	2023-03-29 10:23:50.63384	2023-03-29 10:23:50.63384	\N
7	37	6	2023-03-07 19:06:04.507397	2023-03-07 19:19:23.423968	2023-03-07 19:19:23.415568
4	36	20	2023-03-01 19:23:37.375647	2023-03-20 15:29:41.103304	2023-03-20 15:29:41.099661
23	37	27	2023-03-20 16:05:11.246601	2023-03-20 16:05:11.255339	2023-03-20 16:05:11.251257
24	49	8	2023-03-20 16:08:57.550461	2023-03-20 16:08:57.553859	2023-03-20 16:08:57.553666
25	49	14	2023-03-20 16:09:05.026188	2023-03-20 16:09:05.030922	2023-03-20 16:09:05.030731
26	49	4	2023-03-20 16:09:06.792845	2023-03-20 16:09:06.795652	2023-03-20 16:09:06.795537
16	37	12	2023-03-07 20:06:56.151701	2023-03-07 20:06:56.156685	2023-03-07 20:06:56.156428
9	37	8	2023-03-07 19:10:13.731273	2023-03-07 20:06:58.101036	2023-03-07 20:06:58.092807
20	37	26	2023-03-12 10:59:13.304826	2023-03-19 16:32:39.419455	2023-03-19 16:32:39.4152
19	37	26	2023-03-12 10:59:13.292013	2023-03-19 16:32:40.471091	2023-03-19 16:32:40.467059
28	49	17	2023-03-20 17:04:53.829127	2023-03-20 17:04:53.833366	2023-03-20 17:04:53.83321
29	49	18	2023-03-20 17:04:59.831255	2023-03-20 17:04:59.834185	2023-03-20 17:04:59.834072
8	37	13	2023-03-07 19:09:18.344813	2023-03-20 17:05:16.236156	2023-03-20 17:05:16.230487
12	37	4	2023-03-07 19:19:20.662793	2023-03-20 17:05:27.079219	2023-03-20 17:05:27.074692
17	46	25	2023-03-07 20:09:30.891944	2023-03-16 12:55:51.984086	2023-03-16 12:55:51.977506
30	49	15	2023-03-20 17:05:59.336819	2023-03-20 17:05:59.353376	2023-03-20 17:05:59.353141
11	37	14	2023-03-07 19:11:45.653549	2023-03-19 16:36:25.761627	2023-03-19 16:36:25.757144
27	49	13	2023-03-20 16:09:10.965531	2023-03-20 17:50:35.797865	2023-03-20 17:50:35.790819
31	49	5	2023-03-20 17:07:01.739304	2023-03-20 17:50:50.493207	2023-03-20 17:50:50.482959
10	37	5	2023-03-07 19:11:34.780771	2023-03-20 17:51:47.552731	2023-03-20 17:51:47.548019
32	46	28	2023-03-20 18:09:59.288592	2023-03-20 18:09:59.288592	\N
33	49	28	2023-03-20 18:09:59.328147	2023-03-20 18:09:59.35139	2023-03-20 18:09:59.347103
22	49	27	2023-03-20 16:05:11.236998	2023-03-20 18:10:00.064935	2023-03-20 18:10:00.059639
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.posts (id, name, description, price, user_id, created_at, updated_at, views, short_description, year, sale_price, sale_price_expiration, color_id, location_id, brandname_id, is_active, size, category_id, material_id, condition, component_group_id, electric, sold, buyer_id, sold_date, leave_review_notification_sent, shipped, sale_percentage, shipped_date) FROM stdin;
44	Cannondale Bike	This is a beautiful Cannondale Bike.	124	46	2023-03-09 00:00:00	2023-03-29 06:04:28.198809	199	This is a beautiful Cannondale Bike.	2020	\N	\N	22	2	49	-2	S	1	1	good	2	t	t	36	2023-02-26 10:55:39.742338	f	f	\N	\N
46	try	try	234	36	2023-03-09 00:00:00	2023-03-20 19:34:06.040134	84	try	2023	224.64	2023-02-12 12:10:01.36474	22	2	49	1	XXS	1	1	brand_new	2	t	f	\N	\N	f	f	\N	\N
45	Cube Bike	This is a beautiful Cube Bike	550	36	2023-03-09 00:00:00	2023-04-09 17:24:29.444696	157	This is a beautiful Cube Bike	2013	\N	\N	35	5	82	1	XL	14	5	ok	21	f	f	\N	\N	f	f	\N	\N
\.


--
-- Data for Name: purchases; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.purchases (id, seller_id, buyer_id, post_id, amount, created_at, updated_at, status, shipping_details, payment_details, on_hold, money_sent_to_seller) FROM stdin;
1	36	46	46	250	2023-03-09 00:00:00	2023-03-09 12:03:35.560122	AUTHORIZED_PROOF	\N	\N	f	f
2	46	36	44	124	2023-03-09 00:00:00	2023-03-09 12:03:35.564233	AUTHORIZED_NO_PROOF	---\n:full_name: Adam Paul\n:address: Aleea Valeriu Bologa 3\n:county: AR\n:city: Archiş\n:zip_code: '400436'\n	---\n:authorization_code: 24K71121U9507602A\n:amount: 12400.0\n	f	f
\.


--
-- Data for Name: relationships; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.relationships (id, follower_id, followed_id, created_at, updated_at) FROM stdin;
19	36	46	2023-02-10 18:19:59.222943	2023-02-10 18:19:59.222943
20	46	36	2023-03-16 12:29:49.919843	2023-03-16 12:29:49.919843
21	55	36	2023-03-29 10:24:50.448878	2023-03-29 10:24:50.448878
\.


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.reports (id, user_id, post_id, message, title, created_at, updated_at, solved) FROM stdin;
2	36	44	din pacate acest anunt are poze false, nu sunt prezente poze cu biciclete. Va rog sa verificati si daca puteti sa il stergeti. Multumesc mult!	title	2023-02-10 18:20:41.740067	2023-02-10 18:38:53.072911	f
1	36	44	this is my first report for a bike	my first report	2023-02-10 18:15:52.031561	2023-02-10 18:59:28.074599	t
3	36	46	idk	idk	2023-03-12 14:34:55.674298	2023-03-12 14:34:55.674298	f
4	36	46	try	try	2023-03-12 14:35:26.381311	2023-03-12 14:35:26.381311	f
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.reviews (id, reviewer_id, reviewed_id, message, grade, created_at, updated_at) FROM stdin;
2	46	36	This will be a way longer review in order to check how it fits in the admin table. Thanks for your understanding!	4	2023-02-11 16:06:46.808153	2023-03-07 12:35:03.954079
3	46	36	This will be a way longer review in order to check how it fits in the admin table. Thanks for your understanding!	4	2023-03-07 13:06:55.401915	2023-03-07 13:06:55.401915
4	46	36	This will be a way longer review in order to check how it fits in the admin table. Thanks for your understanding!	4	2023-03-07 13:06:58.733412	2023-03-07 13:06:58.733412
5	46	36	This will be a way longer review in order to check how it fits in the admin table. Thanks for your understanding!	4	2023-03-07 13:07:00.766817	2023-03-07 13:07:00.766817
6	46	36	This will be a way longer review in order to check how it fits in the admin table. Thanks for your understanding!	4	2023-03-07 13:07:02.266957	2023-03-07 13:07:02.266957
7	46	36	This will be a way longer review in order to check how it fits in the admin table. Thanks for your understanding!	4	2023-03-07 13:07:08.562976	2023-03-07 13:07:08.562976
8	46	36	This will be a way longer review in order to check how it fits in the admin table. Thanks for your understanding!	4	2023-03-07 13:07:13.260229	2023-03-07 13:07:13.260229
9	46	36	This will be a way longer review in order to check how it fits in the admin table. Thanks for your understanding!	4	2023-03-07 13:07:14.908491	2023-03-07 13:07:14.908491
11	46	36	This will be a way longer review in order to check how it fits in the admin table. Thanks for your understanding!	4	2023-03-07 13:07:17.952163	2023-03-07 13:07:17.952163
\.


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.rooms (id, name, is_private, created_at, updated_at) FROM stdin;
7	private_36_46	t	2023-02-26 13:34:43.614182	2023-02-26 13:34:43.614182
15	try8	f	2023-02-26 14:01:38.193083	2023-02-26 14:01:38.193083
16	try9	f	2023-02-26 14:01:51.160018	2023-02-26 14:01:51.160018
17	try10	f	2023-02-26 14:02:22.002312	2023-02-26 14:02:22.002312
18	try11	f	2023-02-26 14:05:36.860802	2023-02-26 14:05:36.860802
19	try12	f	2023-02-26 14:10:35.686441	2023-02-26 14:10:35.686441
23	General	f	2023-03-07 16:36:06.9728	2023-03-07 16:36:06.9728
4	Travel	f	2023-02-26 11:40:05.859561	2023-03-07 17:45:46.45611
1	music	f	2023-02-26 11:23:21.36715	2023-03-07 17:46:49.809855
12	try5	f	2023-02-26 13:59:22.560117	2023-03-07 18:48:20.423152
11	try4	f	2023-02-26 13:48:48.432193	2023-03-07 18:48:21.484318
10	try3	f	2023-02-26 13:44:30.364735	2023-03-07 18:48:22.482003
6	Try1	f	2023-02-26 11:49:42.261116	2023-03-07 19:06:34.275966
13	try6	f	2023-02-26 14:00:00.199814	2023-03-07 19:09:18.328547
8	try2	f	2023-02-26 13:43:20.541387	2023-03-07 19:10:13.713165
20	private_36_37	t	2023-03-01 19:23:37.319627	2023-03-07 19:11:29.83494
5	Sport	f	2023-02-26 11:47:39.192306	2023-03-07 19:11:34.757351
14	try7	f	2023-02-26 14:01:07.18601	2023-03-07 19:11:45.6413
25	private_37_46	t	2023-03-07 20:09:30.88101	2023-03-07 20:09:30.88101
26	private_37_37	t	2023-03-12 10:59:13.27797	2023-03-12 10:59:13.27797
27	private_37_49	t	2023-03-20 16:05:11.211801	2023-03-20 16:05:11.211801
28	private_46_49	t	2023-03-20 18:09:59.247002	2023-03-20 18:09:59.247002
29	private_36_49	t	2023-03-20 18:56:49.850812	2023-03-20 18:56:49.850812
30	private_37_55	t	2023-03-29 10:20:22.503464	2023-03-29 10:20:22.503464
31	private_37_51	t	2023-03-29 10:23:50.618756	2023-03-29 10:23:50.618756
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.schema_migrations (version) FROM stdin;
20230113200718
20230114113512
20230114115015
20230114115128
20230115152220
20230116134549
20230116134642
20230116150513
20230118124319
20230118124423
20230118124448
20230118130313
20230118130504
20230118145348
20230118145501
20230118155836
20230119071425
20230119113742
20230119141549
20230119152107
20230119152154
20230120090440
20230123065632
20230125120144
20230125120209
20230125120257
20230125120336
20230126072724
20230126110828
20230127085400
20230127085444
20230127085841
20230127090314
20230127091927
20230203105230
20230209161612
20230210165721
20230210171017
20230210172244
20230211080406
20230211140406
20230211140449
20230211143228
20230211161138
20230212113449
20230212113821
20230212120656
20230213081018
20230214105903
20230216084016
20230216084812
20230216091402
20230216092420
20230216092537
20230216094418
20230216110322
20230220115756
20230220152048
20230220152246
20230224074616
20230224095509
20230224112720
20230226111542
20230226115302
20230226132007
20230307172524
20230307184651
20230307191251
20230309100551
20230309100724
20230309101420
20230309104517
20230309112649
20230309123327
20230310153839
20230310154504
20230310191457
20230310192920
20230313115106
20230320160120
20230320165832
20230329054935
20230403195917
\.


--
-- Data for Name: stats; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.stats (id, analysis_start_time, analysis_end_time, end_date, total_revenue, total_spent, total_profit, roi, total_views, total_posts, total_transactions, created_at, updated_at, period, validating_posts, banned_posts, active_posts, sold_not_shipped_posts, sold_shipped_posts, user_id, user_views, followers, following, user_posts, user_revenue, user_spent) FROM stdin;
4	\N	\N	\N	0	0	0	\N	191	3	0	2023-03-09 12:13:42.633309	2023-03-09 12:14:10.02504	grand-total	0	0	2	1	0	\N	\N	\N	\N	\N	\N	\N
3	\N	\N	2023-03-09	23.67	15.2	8.470000000000002	52.46	191	3	0	2023-03-09 12:06:59.007647	2023-03-09 16:41:58.256	daily-total	0	0	2	1	0	\N	\N	\N	\N	\N	\N	\N
5	\N	\N	2023-03-08	13.2	3.53	9.67	23.34	191	3	0	2023-03-09 16:15:48.478937	2023-03-09 16:42:11.457617	daily-total	0	0	2	1	0	\N	\N	\N	\N	\N	\N	\N
6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2023-03-10 19:31:14.211044	2023-03-10 19:31:14.233642	user-total	\N	\N	\N	\N	\N	36	7	0	1	2	250	124
7	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2023-03-10 19:31:14.23593	2023-03-10 19:31:14.241127	user-total	\N	\N	\N	\N	\N	46	186	1	0	1	124	250
8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2023-03-10 19:31:23.10507	2023-03-10 19:31:23.113402	user-grand-total	\N	\N	\N	\N	\N	\N	193	\N	\N	3	374	374
\.


--
-- Data for Name: suggestions; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.suggestions (id, user_id, message, created_at, updated_at, solved) FROM stdin;
1	36	This is my first suggestion	2023-02-12 12:23:09.206418	2023-02-12 12:36:50.354624	t
2	36	\N	2023-02-12 12:55:47.832796	2023-02-12 12:55:47.832796	f
3	36	\N	2023-02-12 13:08:57.920756	2023-02-12 13:08:57.920756	f
4	36	asdas	2023-02-12 13:10:46.709641	2023-02-12 13:10:46.709641	f
5	36	try	2023-03-12 14:19:42.220803	2023-03-12 14:19:42.220803	f
6	36	another	2023-03-12 14:20:21.89144	2023-03-12 14:20:21.89144	f
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: pauladam
--

COPY public.users (id, email, encrypted_password, uid, avatar_url, role, provider, first_name, last_name, reset_password_token, reset_password_sent_at, remember_created_at, created_at, updated_at, full_name, code, phone, code_expiration_date, archived, rating, paypal_email, discount, sms_opt_in, showed_rules) FROM stdin;
52	paul@test.com	$2a$12$.WwZ1o2lsE7/MYaBrYaQzu5LR42N1NFXUiKS9Xe0FBFmpQsmeHBzq	\N	\N	normal	\N	Paulica	Adamel	\N	\N	\N	2023-03-29 07:31:51.612245	2023-03-29 07:31:51.625267	Paulica Adamel	\N	+40773346603	\N	f	\N	\N	\N	t	f
53	p@gmail.com	$2a$12$QucKEgIeUI.mfg8X2EvOCuZUmLIzrRXi.JUb9PzU1iF3SZbXdz4/a	\N	\N	normal	\N	Paul	asd	\N	\N	\N	2023-03-29 10:12:17.856747	2023-03-29 10:12:17.877721	Paul asd	\N	+40773346603	\N	f	\N	\N	\N	t	f
54	a@b.com	$2a$12$o9UEHhzy19vCraz2n4wgj.oaq6Z2klcLHJXmDWBGX9g6CLAm0WSUm	\N	\N	normal	\N	aaa	aaaa	\N	\N	\N	2023-03-29 10:13:35.284973	2023-03-29 10:13:35.300151	aaa aaaa	\N	+40773346603	\N	f	\N	\N	\N	t	f
46	paul.adrian2001@yahoo.com	$2a$12$29qhsCeT4w/YMbUjfXShbuG3w2mtsJ3Qbx7CFDqCtrValcajkln8W	\N	\N	normal	\N	Adrian	Adam	8548be42993e0d349a04a8ef5deffdab4cb20158d6641a1fbc515146dec12450	2023-03-13 20:37:56.351868	\N	2023-02-02 10:05:27.687981	2023-03-15 15:20:36.092772	Adrian Adam	\N	+40773346603	\N	f	4	try@yahoo.com	5	f	f
49	admin2@admin.com	$2a$12$U5MiODaxggUdkdVna/pFTuBOCv7AX.sySzpiVF2zRgEfwxiebKcLi	\N	\N	admin	\N	Second	Admin	\N	\N	\N	2023-03-20 16:03:57.43441	2023-03-20 16:05:05.810636	Second Admin	\N	\N	\N	f	\N	\N	\N	f	f
55	b@b.com	$2a$12$kSRpSjlhtvA11/VLGdxqp.3jE05ldNwsNBQSJ7/qj2qpAd0WpqZ6a	\N	\N	normal	\N	Paul	Adam	\N	\N	\N	2023-03-29 10:18:22.119983	2023-03-29 10:18:23.72317	Paul Adam	\N	+40773346603	\N	f	\N	\N	\N	t	f
50	daria.andrioaie@gmail.com	$2a$12$pwcMzYv05FYf6aZCSJUNqud.Qqic3WOVod6WE7PfPA34/s/0BwPry	\N	\N	normal	\N	Daria	Andrioaie	\N	\N	\N	2023-03-29 07:08:08.487052	2023-03-29 07:08:08.513331	Daria Andrioaie	\N	+40773346603	\N	f	\N	\N	\N	t	f
51	daria@gmail.com	$2a$12$bdXcN2RVbpW8jQiQMohI.uON3vu24lCEtL0AEjIpz9mwiyitoBJWa	\N	\N	normal	\N	Daria	Adamel	\N	\N	\N	2023-03-29 07:13:40.24574	2023-03-29 07:13:40.259753	Daria Adamel	\N	+40773346603	\N	f	\N	\N	\N	t	f
36	paul.adrian242001@gmail.com	$2a$12$Ru0uPbEdId46mW7nztLd..032HtJd6kUsijMIBOeFBrXZ59JfzAj6	111798472958254535751	https://lh3.googleusercontent.com/a/AGNmyxaAeGAeG6UuFaPjGmvS_Wq_fAT9WIAzLZmyvnQ0ow=s96-c	normal	google_oauth2	\N	\N	\N	\N	\N	2023-02-26 09:03:24.074612	2023-04-03 20:05:27.510551	Paul Adam	\N	+40773346603	\N	f	4	try@yahoo.com	\N	f	t
37	admin@admin.com	$2a$12$RLRVCxonybSuKRhPJtXE3uGUFQ6.6oAAd6w5Vi4w4MXrTnVWyjwr6	\N	\N	admin	\N	admin	admin	\N	\N	\N	2023-01-17 20:24:49.301795	2023-02-11 08:30:10.529176	admin admin	\N	+40773346603	\N	f	\N	\N	\N	f	f
\.


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 52, true);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 52, true);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 1, false);


--
-- Name: assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.assets_id_seq', 16, true);


--
-- Name: brandnames_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.brandnames_id_seq', 82, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.categories_id_seq', 14, true);


--
-- Name: colors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.colors_id_seq', 35, true);


--
-- Name: component_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.component_groups_id_seq', 21, true);


--
-- Name: costs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.costs_id_seq', 6, true);


--
-- Name: favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.favorites_id_seq', 29, true);


--
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.locations_id_seq', 42, true);


--
-- Name: materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.materials_id_seq', 5, true);


--
-- Name: message_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.message_statuses_id_seq', 35, true);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.messages_id_seq', 201, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.notifications_id_seq', 23, true);


--
-- Name: participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.participants_id_seq', 39, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.posts_id_seq', 47, true);


--
-- Name: purchases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.purchases_id_seq', 2, true);


--
-- Name: relationships_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.relationships_id_seq', 21, true);


--
-- Name: reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.reports_id_seq', 4, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.reviews_id_seq', 11, true);


--
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.rooms_id_seq', 31, true);


--
-- Name: stats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.stats_id_seq', 8, true);


--
-- Name: suggestions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.suggestions_id_seq', 6, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pauladam
--

SELECT pg_catalog.setval('public.users_id_seq', 55, true);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- Name: brandnames brandnames_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.brandnames
    ADD CONSTRAINT brandnames_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: colors colors_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.colors
    ADD CONSTRAINT colors_pkey PRIMARY KEY (id);


--
-- Name: component_groups component_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.component_groups
    ADD CONSTRAINT component_groups_pkey PRIMARY KEY (id);


--
-- Name: costs costs_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.costs
    ADD CONSTRAINT costs_pkey PRIMARY KEY (id);


--
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: materials materials_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.materials
    ADD CONSTRAINT materials_pkey PRIMARY KEY (id);


--
-- Name: message_statuses message_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.message_statuses
    ADD CONSTRAINT message_statuses_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: participants participants_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.participants
    ADD CONSTRAINT participants_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: purchases purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT purchases_pkey PRIMARY KEY (id);


--
-- Name: relationships relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.relationships
    ADD CONSTRAINT relationships_pkey PRIMARY KEY (id);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: stats stats_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.stats
    ADD CONSTRAINT stats_pkey PRIMARY KEY (id);


--
-- Name: suggestions suggestions_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.suggestions
    ADD CONSTRAINT suggestions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_brandnames_on_name; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE UNIQUE INDEX index_brandnames_on_name ON public.brandnames USING btree (name);


--
-- Name: index_categories_on_name; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE UNIQUE INDEX index_categories_on_name ON public.categories USING btree (name);


--
-- Name: index_colors_on_name; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE UNIQUE INDEX index_colors_on_name ON public.colors USING btree (name);


--
-- Name: index_component_groups_on_name; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE UNIQUE INDEX index_component_groups_on_name ON public.component_groups USING btree (name);


--
-- Name: index_costs_on_amount_and_description; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE UNIQUE INDEX index_costs_on_amount_and_description ON public.costs USING btree (amount, description);


--
-- Name: index_materials_on_name; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE UNIQUE INDEX index_materials_on_name ON public.materials USING btree (name);


--
-- Name: index_message_statuses_on_message_id; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE INDEX index_message_statuses_on_message_id ON public.message_statuses USING btree (message_id);


--
-- Name: index_message_statuses_on_room_id; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE INDEX index_message_statuses_on_room_id ON public.message_statuses USING btree (room_id);


--
-- Name: index_message_statuses_on_user_id; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE INDEX index_message_statuses_on_user_id ON public.message_statuses USING btree (user_id);


--
-- Name: index_messages_on_room_id; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE INDEX index_messages_on_room_id ON public.messages USING btree (room_id);


--
-- Name: index_messages_on_user_id; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE INDEX index_messages_on_user_id ON public.messages USING btree (user_id);


--
-- Name: index_participants_on_room_id; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE INDEX index_participants_on_room_id ON public.participants USING btree (room_id);


--
-- Name: index_participants_on_user_id; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE INDEX index_participants_on_user_id ON public.participants USING btree (user_id);


--
-- Name: index_posts_on_buyer_id; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE INDEX index_posts_on_buyer_id ON public.posts USING btree (buyer_id);


--
-- Name: index_posts_on_is_active; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE INDEX index_posts_on_is_active ON public.posts USING btree (is_active);


--
-- Name: index_posts_on_is_active_and_user_id; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE INDEX index_posts_on_is_active_and_user_id ON public.posts USING btree (is_active, user_id);


--
-- Name: index_posts_on_user_id; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE INDEX index_posts_on_user_id ON public.posts USING btree (user_id);


--
-- Name: index_relationships_on_followed_id; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE INDEX index_relationships_on_followed_id ON public.relationships USING btree (followed_id);


--
-- Name: index_relationships_on_follower_id; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE INDEX index_relationships_on_follower_id ON public.relationships USING btree (follower_id);


--
-- Name: index_relationships_on_follower_id_and_followed_id; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE UNIQUE INDEX index_relationships_on_follower_id_and_followed_id ON public.relationships USING btree (follower_id, followed_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: stats_common_query; Type: INDEX; Schema: public; Owner: pauladam
--

CREATE INDEX stats_common_query ON public.stats USING btree (end_date, period);


--
-- Name: participants fk_rails_08123987c8; Type: FK CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.participants
    ADD CONSTRAINT fk_rails_08123987c8 FOREIGN KEY (room_id) REFERENCES public.rooms(id);


--
-- Name: messages fk_rails_273a25a7a6; Type: FK CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT fk_rails_273a25a7a6 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: message_statuses fk_rails_84d0ab84d6; Type: FK CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.message_statuses
    ADD CONSTRAINT fk_rails_84d0ab84d6 FOREIGN KEY (message_id) REFERENCES public.messages(id);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: message_statuses fk_rails_9d9d8fce0f; Type: FK CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.message_statuses
    ADD CONSTRAINT fk_rails_9d9d8fce0f FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: messages fk_rails_a8db0fb63a; Type: FK CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT fk_rails_a8db0fb63a FOREIGN KEY (room_id) REFERENCES public.rooms(id);


--
-- Name: message_statuses fk_rails_b223515ebb; Type: FK CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.message_statuses
    ADD CONSTRAINT fk_rails_b223515ebb FOREIGN KEY (room_id) REFERENCES public.rooms(id);


--
-- Name: participants fk_rails_b9a3c50f15; Type: FK CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.participants
    ADD CONSTRAINT fk_rails_b9a3c50f15 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: pauladam
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- PostgreSQL database dump complete
--

