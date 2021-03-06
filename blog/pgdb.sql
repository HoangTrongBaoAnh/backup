PGDMP         3                y            blog1    13.5    13.5 ?    ~           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    16395    blog1    DATABASE     i   CREATE DATABASE blog1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1252';
    DROP DATABASE blog1;
                postgres    false            ?            1259    16398 
   categories    TABLE     ?   CREATE TABLE public.categories (
    id bigint NOT NULL,
    content text NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.categories;
       public         heap    postgres    false            ?            1259    16396    categories_id_seq    SEQUENCE     z   CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.categories_id_seq;
       public          postgres    false    201            ?           0    0    categories_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;
          public          postgres    false    200            ?            1259    16410    child_caregories    TABLE     ?   CREATE TABLE public.child_caregories (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    category_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
 $   DROP TABLE public.child_caregories;
       public         heap    postgres    false            ?            1259    16408    child_caregories_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.child_caregories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.child_caregories_id_seq;
       public          postgres    false    203            ?           0    0    child_caregories_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.child_caregories_id_seq OWNED BY public.child_caregories.id;
          public          postgres    false    202            ?            1259    16419    failed_jobs    TABLE     ?   CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone NOT NULL
);
    DROP TABLE public.failed_jobs;
       public         heap    postgres    false            ?            1259    16417    failed_jobs_id_seq    SEQUENCE     {   CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.failed_jobs_id_seq;
       public          postgres    false    205            ?           0    0    failed_jobs_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;
          public          postgres    false    204            ?            1259    16431    images    TABLE     ?   CREATE TABLE public.images (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    picture character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.images;
       public         heap    postgres    false            ?            1259    16429    images_id_seq    SEQUENCE     v   CREATE SEQUENCE public.images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.images_id_seq;
       public          postgres    false    207            ?           0    0    images_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.images_id_seq OWNED BY public.images.id;
          public          postgres    false    206            ?            1259    16440 
   migrations    TABLE     ?   CREATE TABLE public.migrations (
    id bigint NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);
    DROP TABLE public.migrations;
       public         heap    postgres    false            ?            1259    16438    migrations_id_seq    SEQUENCE     z   CREATE SEQUENCE public.migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.migrations_id_seq;
       public          postgres    false    209            ?           0    0    migrations_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;
          public          postgres    false    208            ?            1259    16447    model_has_permissions    TABLE     ?   CREATE TABLE public.model_has_permissions (
    permission_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);
 )   DROP TABLE public.model_has_permissions;
       public         heap    postgres    false            ?            1259    16453    model_has_roles    TABLE     ?   CREATE TABLE public.model_has_roles (
    role_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);
 #   DROP TABLE public.model_has_roles;
       public         heap    postgres    false            ?            1259    16459    oauth_access_tokens    TABLE     e  CREATE TABLE public.oauth_access_tokens (
    id character varying(100) NOT NULL,
    user_id bigint,
    client_id bigint NOT NULL,
    name character varying(255),
    scopes text,
    revoked smallint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone
);
 '   DROP TABLE public.oauth_access_tokens;
       public         heap    postgres    false            ?            1259    16468    oauth_auth_codes    TABLE     ?   CREATE TABLE public.oauth_auth_codes (
    id character varying(100) NOT NULL,
    user_id bigint NOT NULL,
    client_id bigint NOT NULL,
    scopes text,
    revoked smallint NOT NULL,
    expires_at timestamp(0) without time zone
);
 $   DROP TABLE public.oauth_auth_codes;
       public         heap    postgres    false            ?            1259    16479    oauth_clients    TABLE     ?  CREATE TABLE public.oauth_clients (
    id bigint NOT NULL,
    user_id bigint,
    name character varying(255) NOT NULL,
    secret character varying(100),
    provider character varying(255),
    redirect text NOT NULL,
    personal_access_client smallint NOT NULL,
    password_client smallint NOT NULL,
    revoked smallint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
 !   DROP TABLE public.oauth_clients;
       public         heap    postgres    false            ?            1259    16477    oauth_clients_id_seq    SEQUENCE     }   CREATE SEQUENCE public.oauth_clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.oauth_clients_id_seq;
       public          postgres    false    215            ?           0    0    oauth_clients_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.oauth_clients_id_seq OWNED BY public.oauth_clients.id;
          public          postgres    false    214            ?            1259    16492    oauth_personal_access_clients    TABLE     ?   CREATE TABLE public.oauth_personal_access_clients (
    id bigint NOT NULL,
    client_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
 1   DROP TABLE public.oauth_personal_access_clients;
       public         heap    postgres    false            ?            1259    16490 $   oauth_personal_access_clients_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.oauth_personal_access_clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.oauth_personal_access_clients_id_seq;
       public          postgres    false    217            ?           0    0 $   oauth_personal_access_clients_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.oauth_personal_access_clients_id_seq OWNED BY public.oauth_personal_access_clients.id;
          public          postgres    false    216            ?            1259    16498    oauth_refresh_tokens    TABLE     ?   CREATE TABLE public.oauth_refresh_tokens (
    id character varying(100) NOT NULL,
    access_token_id character varying(100) NOT NULL,
    revoked smallint NOT NULL,
    expires_at timestamp(0) without time zone
);
 (   DROP TABLE public.oauth_refresh_tokens;
       public         heap    postgres    false            ?            1259    16506    order_products    TABLE     ?   CREATE TABLE public.order_products (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    product_id bigint NOT NULL,
    quantity integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
 "   DROP TABLE public.order_products;
       public         heap    postgres    false            ?            1259    16504    order_products_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.order_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.order_products_id_seq;
       public          postgres    false    220            ?           0    0    order_products_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.order_products_id_seq OWNED BY public.order_products.id;
          public          postgres    false    219            ?            1259    16515    orders    TABLE     ?   CREATE TABLE public.orders (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    total integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.orders;
       public         heap    postgres    false            ?            1259    16513    orders_id_seq    SEQUENCE     v   CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.orders_id_seq;
       public          postgres    false    222            ?           0    0    orders_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;
          public          postgres    false    221            ?            1259    16522    password_resets    TABLE     ?   CREATE TABLE public.password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);
 #   DROP TABLE public.password_resets;
       public         heap    postgres    false            ?            1259    16531    permissions    TABLE     ?   CREATE TABLE public.permissions (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.permissions;
       public         heap    postgres    false            ?            1259    16529    permissions_id_seq    SEQUENCE     {   CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.permissions_id_seq;
       public          postgres    false    225            ?           0    0    permissions_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;
          public          postgres    false    224            ?            1259    16544    ratings    TABLE     ?   CREATE TABLE public.ratings (
    id bigint NOT NULL,
    rating double precision NOT NULL,
    category_id bigint,
    shoe_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.ratings;
       public         heap    postgres    false            ?            1259    16542    ratings_id_seq    SEQUENCE     w   CREATE SEQUENCE public.ratings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.ratings_id_seq;
       public          postgres    false    227            ?           0    0    ratings_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.ratings_id_seq OWNED BY public.ratings.id;
          public          postgres    false    226            ?            1259    16551    role_has_permissions    TABLE     m   CREATE TABLE public.role_has_permissions (
    permission_id bigint NOT NULL,
    role_id bigint NOT NULL
);
 (   DROP TABLE public.role_has_permissions;
       public         heap    postgres    false            ?            1259    16559    roles    TABLE     ?   CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.roles;
       public         heap    postgres    false            ?            1259    16557    roles_id_seq    SEQUENCE     u   CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.roles_id_seq;
       public          postgres    false    230            ?           0    0    roles_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;
          public          postgres    false    229            ?            1259    16572    shoes    TABLE     ?  CREATE TABLE public.shoes (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    content text NOT NULL,
    category_id bigint,
    childcategory_id bigint,
    picture character varying(255),
    price integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    collection integer,
    rating double precision
);
    DROP TABLE public.shoes;
       public         heap    postgres    false            ?            1259    16570    shoes_id_seq    SEQUENCE     u   CREATE SEQUENCE public.shoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.shoes_id_seq;
       public          postgres    false    232            ?           0    0    shoes_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.shoes_id_seq OWNED BY public.shoes.id;
          public          postgres    false    231            ?            1259    16584    users    TABLE     ?  CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    picture character varying(255),
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.users;
       public         heap    postgres    false            ?            1259    16582    users_id_seq    SEQUENCE     u   CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    234            ?           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    233            ?           2604    16401    categories id    DEFAULT     n   ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);
 <   ALTER TABLE public.categories ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    200    201    201            ?           2604    16413    child_caregories id    DEFAULT     z   ALTER TABLE ONLY public.child_caregories ALTER COLUMN id SET DEFAULT nextval('public.child_caregories_id_seq'::regclass);
 B   ALTER TABLE public.child_caregories ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    202    203    203            ?           2604    16422    failed_jobs id    DEFAULT     p   ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);
 =   ALTER TABLE public.failed_jobs ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    205    204    205            ?           2604    16434 	   images id    DEFAULT     f   ALTER TABLE ONLY public.images ALTER COLUMN id SET DEFAULT nextval('public.images_id_seq'::regclass);
 8   ALTER TABLE public.images ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    206    207    207            ?           2604    16443    migrations id    DEFAULT     n   ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);
 <   ALTER TABLE public.migrations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    208    209    209            ?           2604    16482    oauth_clients id    DEFAULT     t   ALTER TABLE ONLY public.oauth_clients ALTER COLUMN id SET DEFAULT nextval('public.oauth_clients_id_seq'::regclass);
 ?   ALTER TABLE public.oauth_clients ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    215    215            ?           2604    16495     oauth_personal_access_clients id    DEFAULT     ?   ALTER TABLE ONLY public.oauth_personal_access_clients ALTER COLUMN id SET DEFAULT nextval('public.oauth_personal_access_clients_id_seq'::regclass);
 O   ALTER TABLE public.oauth_personal_access_clients ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            ?           2604    16509    order_products id    DEFAULT     v   ALTER TABLE ONLY public.order_products ALTER COLUMN id SET DEFAULT nextval('public.order_products_id_seq'::regclass);
 @   ALTER TABLE public.order_products ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    220    220            ?           2604    16518 	   orders id    DEFAULT     f   ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);
 8   ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    221    222            ?           2604    16534    permissions id    DEFAULT     p   ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);
 =   ALTER TABLE public.permissions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    224    225            ?           2604    16547 
   ratings id    DEFAULT     h   ALTER TABLE ONLY public.ratings ALTER COLUMN id SET DEFAULT nextval('public.ratings_id_seq'::regclass);
 9   ALTER TABLE public.ratings ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    227    227            ?           2604    16562    roles id    DEFAULT     d   ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
 7   ALTER TABLE public.roles ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    229    230            ?           2604    16575    shoes id    DEFAULT     d   ALTER TABLE ONLY public.shoes ALTER COLUMN id SET DEFAULT nextval('public.shoes_id_seq'::regclass);
 7   ALTER TABLE public.shoes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    231    232    232            ?           2604    16587    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    233    234            Z          0    16398 
   categories 
   TABLE DATA           I   COPY public.categories (id, content, created_at, updated_at) FROM stdin;
    public          postgres    false    201   ??       \          0    16410    child_caregories 
   TABLE DATA           Z   COPY public.child_caregories (id, title, category_id, created_at, updated_at) FROM stdin;
    public          postgres    false    203   8?       ^          0    16419    failed_jobs 
   TABLE DATA           [   COPY public.failed_jobs (id, connection, queue, payload, exception, failed_at) FROM stdin;
    public          postgres    false    205   ??       `          0    16431    images 
   TABLE DATA           Q   COPY public.images (id, product_id, picture, created_at, updated_at) FROM stdin;
    public          postgres    false    207   ڛ       b          0    16440 
   migrations 
   TABLE DATA           :   COPY public.migrations (id, migration, batch) FROM stdin;
    public          postgres    false    209   j?       c          0    16447    model_has_permissions 
   TABLE DATA           T   COPY public.model_has_permissions (permission_id, model_type, model_id) FROM stdin;
    public          postgres    false    210   Ý       d          0    16453    model_has_roles 
   TABLE DATA           H   COPY public.model_has_roles (role_id, model_type, model_id) FROM stdin;
    public          postgres    false    211   ??       e          0    16459    oauth_access_tokens 
   TABLE DATA           ?   COPY public.oauth_access_tokens (id, user_id, client_id, name, scopes, revoked, created_at, updated_at, expires_at) FROM stdin;
    public          postgres    false    212   ?       f          0    16468    oauth_auth_codes 
   TABLE DATA           _   COPY public.oauth_auth_codes (id, user_id, client_id, scopes, revoked, expires_at) FROM stdin;
    public          postgres    false    213   ??       h          0    16479    oauth_clients 
   TABLE DATA           ?   COPY public.oauth_clients (id, user_id, name, secret, provider, redirect, personal_access_client, password_client, revoked, created_at, updated_at) FROM stdin;
    public          postgres    false    215   ??       j          0    16492    oauth_personal_access_clients 
   TABLE DATA           ^   COPY public.oauth_personal_access_clients (id, client_id, created_at, updated_at) FROM stdin;
    public          postgres    false    217   ~?       k          0    16498    oauth_refresh_tokens 
   TABLE DATA           X   COPY public.oauth_refresh_tokens (id, access_token_id, revoked, expires_at) FROM stdin;
    public          postgres    false    218   ??       m          0    16506    order_products 
   TABLE DATA           d   COPY public.order_products (id, order_id, product_id, quantity, created_at, updated_at) FROM stdin;
    public          postgres    false    220   Ң       o          0    16515    orders 
   TABLE DATA           L   COPY public.orders (id, user_id, total, created_at, updated_at) FROM stdin;
    public          postgres    false    222   b?       p          0    16522    password_resets 
   TABLE DATA           C   COPY public.password_resets (email, token, created_at) FROM stdin;
    public          postgres    false    223   ߣ       r          0    16531    permissions 
   TABLE DATA           S   COPY public.permissions (id, name, guard_name, created_at, updated_at) FROM stdin;
    public          postgres    false    225   ??       t          0    16544    ratings 
   TABLE DATA           [   COPY public.ratings (id, rating, category_id, shoe_id, created_at, updated_at) FROM stdin;
    public          postgres    false    227   ?       u          0    16551    role_has_permissions 
   TABLE DATA           F   COPY public.role_has_permissions (permission_id, role_id) FROM stdin;
    public          postgres    false    228   ??       w          0    16559    roles 
   TABLE DATA           M   COPY public.roles (id, name, guard_name, created_at, updated_at) FROM stdin;
    public          postgres    false    230   ??       y          0    16572    shoes 
   TABLE DATA           ?   COPY public.shoes (id, title, content, category_id, childcategory_id, picture, price, created_at, updated_at, collection, rating) FROM stdin;
    public          postgres    false    232   ?       {          0    16584    users 
   TABLE DATA           ~   COPY public.users (id, name, email, email_verified_at, password, picture, remember_token, created_at, updated_at) FROM stdin;
    public          postgres    false    234   q?       ?           0    0    categories_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.categories_id_seq', 54, true);
          public          postgres    false    200            ?           0    0    child_caregories_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.child_caregories_id_seq', 7, true);
          public          postgres    false    202            ?           0    0    failed_jobs_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);
          public          postgres    false    204            ?           0    0    images_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.images_id_seq', 16, true);
          public          postgres    false    206            ?           0    0    migrations_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.migrations_id_seq', 19, true);
          public          postgres    false    208            ?           0    0    oauth_clients_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.oauth_clients_id_seq', 3, true);
          public          postgres    false    214            ?           0    0 $   oauth_personal_access_clients_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.oauth_personal_access_clients_id_seq', 2, true);
          public          postgres    false    216            ?           0    0    order_products_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.order_products_id_seq', 10, true);
          public          postgres    false    219            ?           0    0    orders_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.orders_id_seq', 7, true);
          public          postgres    false    221            ?           0    0    permissions_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.permissions_id_seq', 1, false);
          public          postgres    false    224            ?           0    0    ratings_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.ratings_id_seq', 22, true);
          public          postgres    false    226            ?           0    0    roles_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.roles_id_seq', 3, true);
          public          postgres    false    229            ?           0    0    shoes_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.shoes_id_seq', 13, true);
          public          postgres    false    231            ?           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 4, true);
          public          postgres    false    233            ?           2606    16407    categories PRIMARY 
   CONSTRAINT     R   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT "PRIMARY" PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.categories DROP CONSTRAINT "PRIMARY";
       public            postgres    false    201            ?           2606    16416    child_caregories PRIMARY00000 
   CONSTRAINT     ]   ALTER TABLE ONLY public.child_caregories
    ADD CONSTRAINT "PRIMARY00000" PRIMARY KEY (id);
 I   ALTER TABLE ONLY public.child_caregories DROP CONSTRAINT "PRIMARY00000";
       public            postgres    false    203            ?           2606    16428    failed_jobs PRIMARY00001 
   CONSTRAINT     X   ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT "PRIMARY00001" PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.failed_jobs DROP CONSTRAINT "PRIMARY00001";
       public            postgres    false    205            ?           2606    16437    images PRIMARY00002 
   CONSTRAINT     S   ALTER TABLE ONLY public.images
    ADD CONSTRAINT "PRIMARY00002" PRIMARY KEY (id);
 ?   ALTER TABLE ONLY public.images DROP CONSTRAINT "PRIMARY00002";
       public            postgres    false    207            ?           2606    16446    migrations PRIMARY00003 
   CONSTRAINT     W   ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT "PRIMARY00003" PRIMARY KEY (id);
 C   ALTER TABLE ONLY public.migrations DROP CONSTRAINT "PRIMARY00003";
       public            postgres    false    209            ?           2606    16451 "   model_has_permissions PRIMARY00004 
   CONSTRAINT     ?   ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT "PRIMARY00004" PRIMARY KEY (permission_id, model_id, model_type);
 N   ALTER TABLE ONLY public.model_has_permissions DROP CONSTRAINT "PRIMARY00004";
       public            postgres    false    210    210    210            ?           2606    16457    model_has_roles PRIMARY00005 
   CONSTRAINT     w   ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT "PRIMARY00005" PRIMARY KEY (role_id, model_id, model_type);
 H   ALTER TABLE ONLY public.model_has_roles DROP CONSTRAINT "PRIMARY00005";
       public            postgres    false    211    211    211            ?           2606    16466     oauth_access_tokens PRIMARY00006 
   CONSTRAINT     `   ALTER TABLE ONLY public.oauth_access_tokens
    ADD CONSTRAINT "PRIMARY00006" PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.oauth_access_tokens DROP CONSTRAINT "PRIMARY00006";
       public            postgres    false    212            ?           2606    16475    oauth_auth_codes PRIMARY00007 
   CONSTRAINT     ]   ALTER TABLE ONLY public.oauth_auth_codes
    ADD CONSTRAINT "PRIMARY00007" PRIMARY KEY (id);
 I   ALTER TABLE ONLY public.oauth_auth_codes DROP CONSTRAINT "PRIMARY00007";
       public            postgres    false    213            ?           2606    16488    oauth_clients PRIMARY00008 
   CONSTRAINT     Z   ALTER TABLE ONLY public.oauth_clients
    ADD CONSTRAINT "PRIMARY00008" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.oauth_clients DROP CONSTRAINT "PRIMARY00008";
       public            postgres    false    215            ?           2606    16497 *   oauth_personal_access_clients PRIMARY00009 
   CONSTRAINT     j   ALTER TABLE ONLY public.oauth_personal_access_clients
    ADD CONSTRAINT "PRIMARY00009" PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.oauth_personal_access_clients DROP CONSTRAINT "PRIMARY00009";
       public            postgres    false    217            ?           2606    16502 !   oauth_refresh_tokens PRIMARY00010 
   CONSTRAINT     a   ALTER TABLE ONLY public.oauth_refresh_tokens
    ADD CONSTRAINT "PRIMARY00010" PRIMARY KEY (id);
 M   ALTER TABLE ONLY public.oauth_refresh_tokens DROP CONSTRAINT "PRIMARY00010";
       public            postgres    false    218            ?           2606    16512    order_products PRIMARY00011 
   CONSTRAINT     [   ALTER TABLE ONLY public.order_products
    ADD CONSTRAINT "PRIMARY00011" PRIMARY KEY (id);
 G   ALTER TABLE ONLY public.order_products DROP CONSTRAINT "PRIMARY00011";
       public            postgres    false    220            ?           2606    16521    orders PRIMARY00012 
   CONSTRAINT     S   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT "PRIMARY00012" PRIMARY KEY (id);
 ?   ALTER TABLE ONLY public.orders DROP CONSTRAINT "PRIMARY00012";
       public            postgres    false    222            ?           2606    16540    permissions PRIMARY00013 
   CONSTRAINT     X   ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT "PRIMARY00013" PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.permissions DROP CONSTRAINT "PRIMARY00013";
       public            postgres    false    225            ?           2606    16550    ratings PRIMARY00014 
   CONSTRAINT     T   ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT "PRIMARY00014" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.ratings DROP CONSTRAINT "PRIMARY00014";
       public            postgres    false    227            ?           2606    16555 !   role_has_permissions PRIMARY00015 
   CONSTRAINT     u   ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT "PRIMARY00015" PRIMARY KEY (permission_id, role_id);
 M   ALTER TABLE ONLY public.role_has_permissions DROP CONSTRAINT "PRIMARY00015";
       public            postgres    false    228    228            ?           2606    16568    roles PRIMARY00016 
   CONSTRAINT     R   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT "PRIMARY00016" PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.roles DROP CONSTRAINT "PRIMARY00016";
       public            postgres    false    230            ?           2606    16581    shoes PRIMARY00017 
   CONSTRAINT     R   ALTER TABLE ONLY public.shoes
    ADD CONSTRAINT "PRIMARY00017" PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.shoes DROP CONSTRAINT "PRIMARY00017";
       public            postgres    false    232            ?           2606    16593    users PRIMARY00018 
   CONSTRAINT     R   ALTER TABLE ONLY public.users
    ADD CONSTRAINT "PRIMARY00018" PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.users DROP CONSTRAINT "PRIMARY00018";
       public            postgres    false    234            ?           1259    16452 /   model_has_permissions_model_id_model_type_index    INDEX     ?   CREATE INDEX model_has_permissions_model_id_model_type_index ON public.model_has_permissions USING btree (model_id, model_type);
 C   DROP INDEX public.model_has_permissions_model_id_model_type_index;
       public            postgres    false    210    210            ?           1259    16458 )   model_has_roles_model_id_model_type_index    INDEX     u   CREATE INDEX model_has_roles_model_id_model_type_index ON public.model_has_roles USING btree (model_id, model_type);
 =   DROP INDEX public.model_has_roles_model_id_model_type_index;
       public            postgres    false    211    211            ?           1259    16467 !   oauth_access_tokens_user_id_index    INDEX     d   CREATE INDEX oauth_access_tokens_user_id_index ON public.oauth_access_tokens USING btree (user_id);
 5   DROP INDEX public.oauth_access_tokens_user_id_index;
       public            postgres    false    212            ?           1259    16476    oauth_auth_codes_user_id_index    INDEX     ^   CREATE INDEX oauth_auth_codes_user_id_index ON public.oauth_auth_codes USING btree (user_id);
 2   DROP INDEX public.oauth_auth_codes_user_id_index;
       public            postgres    false    213            ?           1259    16489    oauth_clients_user_id_index    INDEX     X   CREATE INDEX oauth_clients_user_id_index ON public.oauth_clients USING btree (user_id);
 /   DROP INDEX public.oauth_clients_user_id_index;
       public            postgres    false    215            ?           1259    16503 *   oauth_refresh_tokens_access_token_id_index    INDEX     v   CREATE INDEX oauth_refresh_tokens_access_token_id_index ON public.oauth_refresh_tokens USING btree (access_token_id);
 >   DROP INDEX public.oauth_refresh_tokens_access_token_id_index;
       public            postgres    false    218            ?           1259    16528    password_resets_email_index    INDEX     X   CREATE INDEX password_resets_email_index ON public.password_resets USING btree (email);
 /   DROP INDEX public.password_resets_email_index;
       public            postgres    false    223            ?           1259    16541 "   permissions_name_guard_name_unique    INDEX     m   CREATE UNIQUE INDEX permissions_name_guard_name_unique ON public.permissions USING btree (name, guard_name);
 6   DROP INDEX public.permissions_name_guard_name_unique;
       public            postgres    false    225    225            ?           1259    16556 $   role_has_permissions_role_id_foreign    INDEX     h   CREATE INDEX role_has_permissions_role_id_foreign ON public.role_has_permissions USING btree (role_id);
 8   DROP INDEX public.role_has_permissions_role_id_foreign;
       public            postgres    false    228            ?           1259    16569    roles_name_guard_name_unique    INDEX     a   CREATE UNIQUE INDEX roles_name_guard_name_unique ON public.roles USING btree (name, guard_name);
 0   DROP INDEX public.roles_name_guard_name_unique;
       public            postgres    false    230    230            ?           1259    16594    users_email_unique    INDEX     L   CREATE UNIQUE INDEX users_email_unique ON public.users USING btree (email);
 &   DROP INDEX public.users_email_unique;
       public            postgres    false    234            Z   i   x?m?;
?0?g??@?~?A?C?^B1M?-?};Y?h}???TRQL?$1??AXi?c?q?P?dZ8??c???^?lR???????C2[??;??????^#?      \   u   x?m?1
?0??Y:E.??'ۡ?,]Bm?/?};:?????l{?7?昁?0???0c?.??Zm?⿗	9r?rc?i4~mJ?i????L?hm3]??m???!NM~p?Ag      ^      x?????? ? ?      `   ?   x???1
?0???:E.??')B?Y?:??j(ؠB??胧((p	?8???Y????kt??Qm ?g??V??Y#`?f???ٳF?"'VoͿx??T?qh?ٲF?	??_?6a???	?-?X??y?^?      b   I  x?e?ێ? ????l?e?	ZٵҀM?o?c?Ԙ???a?8?B???~}??U??G?!??Σ=A?r
??b|?`0?h???Ei???ް)^=?_E{c?#?9Z?H???S??A??셦?^s?D????)?S{d)?)4??qtߠ[?Xw??"ǋr?5???	?	g????^???pM????҃:?-=??t???I(H!z??v?`??V??qQ?x?<tvI?I??
??v7u?o?GN?Հ???,o.F???/W~YDA?i=??P.??K?K????ʘ?x????~??j?*???Z?y??f7]7?UЕ,o(????7???WUU??}?      c      x?????? ? ?      d       x?3?t,(??	-N-?4?2B?q??qqq ???      e   k  x??UK?G[?9Ż???vUi?s$Y?w???Bya??????ɢG????f	????9?Ω?g??6d<??V;?Z?aU'K֑"?8??|?ǟ_?~??>	a?"???R?<ar?.?=D??z?\??ާ	??.?َ/?ᵂw]?Kc?ű??u?V{l?#?eV/?'Ln?eB??F?T?ͩc???{?Zr??,?Ȍ?mϔ???Ts??l?bk5???wf??˷???????W?أG??i?h????2D?z??U?ɳ??<6Ϟ?y????Mi?j?3??z??̞0?aW??%?Zf???}???|So?F
Kr??iu??q>í ՞[?85kA?͌??ۋ	?'Ln??t*?i???????G??)??!??o???=???5??4k????53io-?^RO?ܰ+??lb+3?%-\l]?
j?Zr?????K"?H&??ҽ??5?;???}??<~??Ϙܰ????`r<=IPEE?ֵtocv8^,Ň,?:?(?>s?90?A??????<MT????0?a?x?	?ʰ????P9??????B7???U??ϱ!Z?s%??;"?踹ⷭa/?'Ln?5?-??:,?????H?H ??:7A/?&n???0ip??B"??O?6?L}???-^~????ܰO=? ?? ????k?VPYB&TLP?tߛ1TL?В??z???_f?E???%??|???]kr?9;?f??????1??4?|C?mڒ??ػ?Pm6?f#FVؔ?	;?O6??vmE?Ά?`K?{?`?,"?A?N~;??J1D<?K?[?ݚ嘜?&?n?؇Ҟ0?a??	9*??m?;w׬w ???}`?N(???ݢ?vq?N,,?D? ><??f~R??'Ln????u??d??      f      x?????? ? ?      h   ?   x???K?0?u9E/???f??5?M?h?J???h?????n?o??c????~?@fL`'? ?i?itϮ?/???mН?????}y<<L碗?8?5?9ŵ?????1\?FYU?E?I,?v0iڔڴ??3??R??H?L?5-wM????<?8???X?+?7mែ)?˴¡Tw?A֋?/(??? ?T?      j   '   x?3?4?4202?54?52W04?22?22?&????? ?U?      k      x?????? ? ?      m   ?   x????!?v? ??6??뿎?)???ɿ?/?0GIEQ?"v?Ck?e??????????????C?ɨ??YHƸ?'?"d?y3nT?{`??????뿲??N??sP???k?#`a=c|?????L+      o   m   x?u???@C??Y?*\ze???G??(UE??,SL,??8ȡ?1?f?wU??h?gƫc????=?I??v??0??c?e?2??i??u?_XƵgC??az????7?z4?      p      x?????? ? ?      r      x?????? ? ?      t   w   x?m??1D?P?X??????_G??g?ȂӃ?P????ֲ?????1EH?!?U?u??Ѿ???L??]??
oeXrd?????T???rǰ;ӑ;???2>x??2Ǝ飪?2_-?      u      x?????? ? ?      w   7   x?3?,-N-?,OM?4202?54?52W04?24?21?&?eę????G??=... ?x      y   ]  x?}?]n?0 ?gs
.P?$$9DOЗ>D??0????)v??$PXaF"??N?5??t9?䙭?>o?dO?'?-R4.b?9?9?#\? RC0?(˂??}w?ڢ?E?,jlP?b#??چA?4??o??⍊?L??A?mQ֨?QLE/?F?v??N?4???\V4??B??????~R???????g6?????\)??b????I
?tJ??[?ou"?=u??"??j??cYdo????"{Ж>?鱬ub?:?m4??+p????ݝ\?ŕw?v???⢁???9?m?9?Y7Z??U??xj??^!?Sg????ȵ&D?ȹ???AР?u?׵???r??K?4?/#??      {     x?m?Mo?@??˯???uw????6?F?%E/?>?KqA???^?0??a?7???@&W	???_YF?<?<?+.????9o r?✑a?GU?u`o??k?>????V[?঍?:&???D???gX301T4?)l?@?1')
SsEHG??:,??%????]?̧}???f???Jv6??͞r?W??ֈl4X??ѓ???n?j?W??UST??Q?L?S?usV??ܬM;:'I???Y?2x??O???ױ?{+n????2d???!??N?@EQ~ /?vt     