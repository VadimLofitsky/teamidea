PGDMP                      	    x         	   testtask2    12.3    13.0 (    4           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            5           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            6           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            7           1262    16846 	   testtask2    DATABASE     f   CREATE DATABASE testtask2 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE testtask2;
                admin    false            �            1255    16914    fillbrands() 	   PROCEDURE     '  CREATE PROCEDURE public.fillbrands()
    LANGUAGE sql
    AS $$insert into brand(name, country) values
	('Adidas', 'DE'),
	('Audi', 'DE'),
	('Renault', 'FR'),
	('Geelee', 'CH'),
	('Vesta', 'RU'),
	('Ford', 'US'),
	('Porsche', 'DE'),
	('Rolls Royce', 'UK'),
	('KAMAZ', 'RU'),
	('Jeep', 'US');$$;
 $   DROP PROCEDURE public.fillbrands();
       public          postgres    false            �            1259    16898    goods    TABLE     }   CREATE TABLE public.goods (
    id integer NOT NULL,
    warehouseid integer,
    productid integer,
    quantity integer
);
    DROP TABLE public.goods;
       public         heap    admin    false            �            1259    16882    product    TABLE     ]   CREATE TABLE public.product (
    id integer NOT NULL,
    name text,
    brandid integer
);
    DROP TABLE public.product;
       public         heap    admin    false            �            1259    16860 	   warehouse    TABLE     J   CREATE TABLE public.warehouse (
    id integer NOT NULL,
    name text
);
    DROP TABLE public.warehouse;
       public         heap    admin    false            �            1259    16921    allgoods    VIEW       CREATE VIEW public.allgoods AS
 SELECT g.id,
    w.name AS warehouse,
    p.name AS product,
    g.quantity
   FROM ((public.goods g
     JOIN public.warehouse w ON ((g.warehouseid = w.id)))
     JOIN public.product p ON ((g.productid = p.id)))
  ORDER BY g.id;
    DROP VIEW public.allgoods;
       public          postgres    false    207    205    209    209    207    205    209    209            �            1259    16849    brand    TABLE     X   CREATE TABLE public.brand (
    id integer NOT NULL,
    name text,
    country text
);
    DROP TABLE public.brand;
       public         heap    admin    false            �            1259    16847    brand_id_seq    SEQUENCE     �   CREATE SEQUENCE public.brand_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.brand_id_seq;
       public          admin    false    203            8           0    0    brand_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.brand_id_seq OWNED BY public.brand.id;
          public          admin    false    202            �            1259    16896    goods_id_seq    SEQUENCE     �   CREATE SEQUENCE public.goods_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.goods_id_seq;
       public          admin    false    209            9           0    0    goods_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.goods_id_seq OWNED BY public.goods.id;
          public          admin    false    208            �            1259    16880    product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.product_id_seq;
       public          admin    false    207            :           0    0    product_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;
          public          admin    false    206            �            1259    16858    warehouse_id_seq    SEQUENCE     �   CREATE SEQUENCE public.warehouse_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.warehouse_id_seq;
       public          admin    false    205            ;           0    0    warehouse_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.warehouse_id_seq OWNED BY public.warehouse.id;
          public          admin    false    204            �
           2604    16852    brand id    DEFAULT     d   ALTER TABLE ONLY public.brand ALTER COLUMN id SET DEFAULT nextval('public.brand_id_seq'::regclass);
 7   ALTER TABLE public.brand ALTER COLUMN id DROP DEFAULT;
       public          admin    false    203    202    203            �
           2604    16901    goods id    DEFAULT     d   ALTER TABLE ONLY public.goods ALTER COLUMN id SET DEFAULT nextval('public.goods_id_seq'::regclass);
 7   ALTER TABLE public.goods ALTER COLUMN id DROP DEFAULT;
       public          admin    false    209    208    209            �
           2604    16885 
   product id    DEFAULT     h   ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);
 9   ALTER TABLE public.product ALTER COLUMN id DROP DEFAULT;
       public          admin    false    206    207    207            �
           2604    16863    warehouse id    DEFAULT     l   ALTER TABLE ONLY public.warehouse ALTER COLUMN id SET DEFAULT nextval('public.warehouse_id_seq'::regclass);
 ;   ALTER TABLE public.warehouse ALTER COLUMN id DROP DEFAULT;
       public          admin    false    204    205    205            +          0    16849    brand 
   TABLE DATA                 public          admin    false    203   �(       1          0    16898    goods 
   TABLE DATA                 public          admin    false    209   �)       /          0    16882    product 
   TABLE DATA                 public          admin    false    207   �+       -          0    16860 	   warehouse 
   TABLE DATA                 public          admin    false    205   �,       <           0    0    brand_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.brand_id_seq', 10, true);
          public          admin    false    202            =           0    0    goods_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.goods_id_seq', 51, true);
          public          admin    false    208            >           0    0    product_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.product_id_seq', 15, true);
          public          admin    false    206            ?           0    0    warehouse_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.warehouse_id_seq', 7, true);
          public          admin    false    204            �
           2606    16857    brand brand_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.brand
    ADD CONSTRAINT brand_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.brand DROP CONSTRAINT brand_pkey;
       public            admin    false    203            �
           2606    16903    goods goods_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.goods
    ADD CONSTRAINT goods_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.goods DROP CONSTRAINT goods_pkey;
       public            admin    false    209            �
           2606    16890    product product_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
       public            admin    false    207            �
           2606    16868    warehouse warehouse_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.warehouse
    ADD CONSTRAINT warehouse_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.warehouse DROP CONSTRAINT warehouse_pkey;
       public            admin    false    205            �
           1259    17196    idx_goods_pid    INDEX     D   CREATE INDEX idx_goods_pid ON public.goods USING btree (productid);
 !   DROP INDEX public.idx_goods_pid;
       public            admin    false    209            �
           1259    17197    idx_goods_wid    INDEX     F   CREATE INDEX idx_goods_wid ON public.goods USING btree (warehouseid);
 !   DROP INDEX public.idx_goods_wid;
       public            admin    false    209            �
           1259    17198    idx_prod_bid    INDEX     C   CREATE INDEX idx_prod_bid ON public.product USING btree (brandid);
     DROP INDEX public.idx_prod_bid;
       public            admin    false    207            �
           2606    16909    goods goods_productId_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.goods
    ADD CONSTRAINT "goods_productId_fkey" FOREIGN KEY (productid) REFERENCES public.product(id);
 F   ALTER TABLE ONLY public.goods DROP CONSTRAINT "goods_productId_fkey";
       public          admin    false    2723    209    207            �
           2606    16904    goods goods_warehouseId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.goods
    ADD CONSTRAINT "goods_warehouseId_fkey" FOREIGN KEY (warehouseid) REFERENCES public.warehouse(id);
 H   ALTER TABLE ONLY public.goods DROP CONSTRAINT "goods_warehouseId_fkey";
       public          admin    false    2720    209    205            �
           2606    16891    product product_brandId_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.product
    ADD CONSTRAINT "product_brandId_fkey" FOREIGN KEY (brandid) REFERENCES public.brand(id);
 H   ALTER TABLE ONLY public.product DROP CONSTRAINT "product_brandId_fkey";
       public          admin    false    207    203    2718            +   �   x��ѻ�0�ᝫ�7 !F<�Р��PM�84�������ۺ�����$��(�B�C��wh��5լ���ijx�Tb�]x���8��������{�"e�r4��Df�rLy1�^K'l,�T��Q�.�1�Vy��L���>G�Z3$3f�*O��7�8�N�#� ���i�j��U~F��#�s�W����,�Ė�7      1   �  x����jA��>������GN9x��hr7*FY�.!o���G(d�|��tu��֛��6��ۗt?�����0ni~>����?��v�?��p�w{�w����o�ޟ�ߖ�4/9IN��֋��
D���J�#����Kcű��@�
���)[��ƕm�VR[��$��B�� ���m��z���#�ګ%ZV�mPȵu�!�!��*�D�a$6z�5.Hn�-fU�ڐV�`�#JM�(��r���˵.Hy��Ri
"�^��CRه�[yk$n
K3�'h�$��+��ER��pDP��ߢ��;��Æ+W@{��m�ř��HjęMrB^s�q��G��T��[G�x�&d����Uq���(�7ręy)�T��`G��D����� -8!%����Fb���Zn��O���B�;-��6F�FR������u*��E�PG��<�f���\�      /     x����j�@��WqvI@���GWSkĐ�Vm���P�ƑQ�}��B�37���|o�da�C��oЍ��.�:�˱`]�:���t�	ږu��39~��MV/�/�Z+�ͳ�9�?�b�9:G�J�f9A˖�v��$Q�l�"r�AǗwt�X���"�����5�C(e-�N웶=K������
��	���f���(aϋ��g�(h梅}�Š�ͫ�/*�i��*h�?-�{<B�Hy����`U��O�̹�c��1���45���W      -   �   x���v
Q���W((M��L�+O,J��/-NU��L�Q�K�M�Ts�	uV�0�QP��/N�/�uN�+)J�Q�P״��$� #�AA���yd�c4ǻ(�8/?%��L3L@fd������̼�l2���;��d�Q��@��2����� P��N     