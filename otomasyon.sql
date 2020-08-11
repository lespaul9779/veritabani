--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12.3

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

--
-- Name: hedefdepo(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.hedefdepo() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare 
hedeftoplam integer;
begin
select sum(adet) into hedeftoplam from hedef;
return hedeftoplam;
end;
$$;


ALTER FUNCTION public.hedefdepo() OWNER TO postgres;

--
-- Name: kulekle(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kulekle() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
begin
insert into kullanici(kulad,calisanid) values (new.ad,new.id);
return new;
end;
$$;


ALTER FUNCTION public.kulekle() OWNER TO postgres;

--
-- Name: odemeler(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.odemeler() RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare 
odemetoplam decimal;
begin
select sum(elektrik+gaz+su) into odemetoplam from odeme;
return odemetoplam;
end;
$$;


ALTER FUNCTION public.odemeler() OWNER TO postgres;

--
-- Name: odemetakip(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.odemetakip() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
insert into odemetakip(ay,yil,toplamtutar,durum,odemeid) 
values (new.ay,new.yil,new.elektrik+new.gaz+new.su,'Ödendi',new.id);
return new;
end;
$$;


ALTER FUNCTION public.odemetakip() OWNER TO postgres;

--
-- Name: ogrencibilgi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ogrencibilgi() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
begin
insert into ogrencibilgi(ogrenciid) values (new.id);
return new;
end;
$$;


ALTER FUNCTION public.ogrencibilgi() OWNER TO postgres;

--
-- Name: ogrenciucret(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ogrenciucret() RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare 
toplamgelir decimal;
begin
Select sum(ucret) into toplamgelir from ogrenciucret;
return toplamgelir;
end;
$$;


ALTER FUNCTION public.ogrenciucret() OWNER TO postgres;

--
-- Name: okdepo(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.okdepo() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare 
oktoplam integer;
begin
select sum(adet) into oktoplam from ok;
return oktoplam;
end;
$$;


ALTER FUNCTION public.okdepo() OWNER TO postgres;

--
-- Name: ucrettakip(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ucrettakip() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
insert into ucrettakip (ucret,ay,durum,ogrenciid) values (new.ucret,new.ay,'Ödendi',new.ogrenciid);
return new;
end;
$$;


ALTER FUNCTION public.ucrettakip() OWNER TO postgres;

--
-- Name: yaydepo(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.yaydepo() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare 
yaytoplam integer;
begin
select sum(adet) into yaytoplam from yay;
return yaytoplam;
end;
$$;


ALTER FUNCTION public.yaydepo() OWNER TO postgres;

--
-- Name: areas_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.areas_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.areas_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: calisanlar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.calisanlar (
    id integer NOT NULL,
    ad character varying(100),
    soyad character varying(100),
    tc character varying(100),
    tel character varying(100),
    gorev character varying(100)
);


ALTER TABLE public.calisanlar OWNER TO postgres;

--
-- Name: calisanlar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.calisanlar ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.calisanlar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999
    CACHE 1
);


--
-- Name: cities_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cities_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cities_seq OWNER TO postgres;

--
-- Name: counties_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.counties_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.counties_seq OWNER TO postgres;

--
-- Name: countries_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.countries_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.countries_seq OWNER TO postgres;

--
-- Name: hedef; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hedef (
    id integer NOT NULL,
    hedefad character varying(100),
    adet integer,
    boyut character varying(100)
);


ALTER TABLE public.hedef OWNER TO postgres;

--
-- Name: hedef_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.hedef ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.hedef_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999
    CACHE 1
);


--
-- Name: kasaba; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kasaba (
    kasabaid integer DEFAULT nextval('public.counties_seq'::regclass) NOT NULL,
    sehirid integer NOT NULL,
    kasabaad character varying(50) NOT NULL
);


ALTER TABLE public.kasaba OWNER TO postgres;

--
-- Name: kullanici; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kullanici (
    id integer NOT NULL,
    kulad character varying(100),
    calisanid integer,
    sifre integer NOT NULL
);


ALTER TABLE public.kullanici OWNER TO postgres;

--
-- Name: kullanici_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.kullanici ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.kullanici_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999
    CACHE 1
);


--
-- Name: kullanici_sifre_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.kullanici ALTER COLUMN sifre ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.kullanici_sifre_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999
    CACHE 1
);


--
-- Name: lisans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lisans (
    id integer NOT NULL,
    ad character varying(100),
    soyad character varying(100),
    dogumtarih character varying(100),
    babaad character varying(100),
    annead character varying(100),
    ogrenciid integer,
    il character varying(100)
);


ALTER TABLE public.lisans OWNER TO postgres;

--
-- Name: lisans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.lisans ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lisans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999
    CACHE 1
);


--
-- Name: neighborhoods_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.neighborhoods_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.neighborhoods_seq OWNER TO postgres;

--
-- Name: odeme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.odeme (
    id integer NOT NULL,
    ay character varying(100),
    yil character varying(100),
    elektrik double precision,
    gaz double precision,
    su double precision
);


ALTER TABLE public.odeme OWNER TO postgres;

--
-- Name: odeme_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.odeme ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.odeme_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999
    CACHE 1
);


--
-- Name: odemetakip; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.odemetakip (
    id integer NOT NULL,
    ay character varying(100),
    yil character varying(100),
    toplamtutar double precision,
    durum character varying(100),
    odemeid integer
);


ALTER TABLE public.odemetakip OWNER TO postgres;

--
-- Name: odemetakip_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.odemetakip ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.odemetakip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999
    CACHE 1
);


--
-- Name: ogrencibilgi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ogrencibilgi (
    id integer NOT NULL,
    ogrenciid integer NOT NULL,
    babaad character varying(100),
    annead character varying(100),
    tel character varying(100),
    dogumyeri character varying(100),
    mail character varying(100)
);


ALTER TABLE public.ogrencibilgi OWNER TO postgres;

--
-- Name: ogrencikayit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ogrencikayit (
    id integer NOT NULL,
    ad character varying(100),
    soyad character varying(100),
    dogumtarih character varying(100),
    il character varying(100),
    ilce character varying(100),
    tc character varying(100)
);


ALTER TABLE public.ogrencikayit OWNER TO postgres;

--
-- Name: ogrbilgi; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.ogrbilgi AS
 SELECT ob.id,
    (((ok.ad)::text || ' '::text) || (ok.soyad)::text) AS adsoyad,
    ob.babaad,
    ob.annead,
    ob.tel,
    ob.dogumyeri,
    ob.mail
   FROM (public.ogrencibilgi ob
     JOIN public.ogrencikayit ok ON ((ob.ogrenciid = ok.id)));


ALTER TABLE public.ogrbilgi OWNER TO postgres;

--
-- Name: ogrencibilgi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ogrencibilgi ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ogrencibilgi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999
    CACHE 1
);


--
-- Name: ogrencikayit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ogrencikayit ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ogrencikayit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999
    CACHE 1
);


--
-- Name: ogrenciucret; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ogrenciucret (
    id integer NOT NULL,
    ogrenciid integer NOT NULL,
    kayittarih character varying(100),
    ucret double precision,
    ay character varying(100),
    yil character varying(100)
);


ALTER TABLE public.ogrenciucret OWNER TO postgres;

--
-- Name: ogrenciucret_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ogrenciucret ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ogrenciucret_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999
    CACHE 1
);


--
-- Name: ogrucret; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.ogrucret AS
 SELECT ou.id,
    ou.ogrenciid,
    (((ok.ad)::text || ' '::text) || (ok.soyad)::text) AS adsoyad,
    ou.kayittarih,
    ou.ay,
    ou.yil,
    ou.ucret
   FROM (public.ogrenciucret ou
     JOIN public.ogrencikayit ok ON ((ou.ogrenciid = ok.id)));


ALTER TABLE public.ogrucret OWNER TO postgres;

--
-- Name: ok; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ok (
    id integer NOT NULL,
    okad character varying(100),
    adet integer,
    tur character varying(100)
);


ALTER TABLE public.ok OWNER TO postgres;

--
-- Name: ok_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ok ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ok_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999
    CACHE 1
);


--
-- Name: sahiplik; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sahiplik (
    id integer NOT NULL,
    ad character varying(100),
    soyad character varying(100),
    malzeme1 character varying(100),
    malzeme2 character varying(100)
);


ALTER TABLE public.sahiplik OWNER TO postgres;

--
-- Name: sahiplik_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.sahiplik ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sahiplik_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999
    CACHE 1
);


--
-- Name: sehir; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sehir (
    sehirid integer DEFAULT nextval('public.cities_seq'::regclass) NOT NULL,
    sehirad character varying(100) NOT NULL
);


ALTER TABLE public.sehir OWNER TO postgres;

--
-- Name: ucrettakip; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ucrettakip (
    id integer NOT NULL,
    ucret double precision,
    ay character varying(100),
    durum character varying(100),
    ogrenciid integer
);


ALTER TABLE public.ucrettakip OWNER TO postgres;

--
-- Name: ucretdurum; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.ucretdurum AS
 SELECT ut.ucret,
    ut.ay,
    ut.durum,
    (((ok.ad)::text || ' '::text) || (ok.soyad)::text) AS ogrenci
   FROM (public.ucrettakip ut
     JOIN public.ogrencikayit ok ON ((ut.ogrenciid = ok.id)));


ALTER TABLE public.ucretdurum OWNER TO postgres;

--
-- Name: ucrettakip_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ucrettakip ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ucrettakip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999
    CACHE 1
);


--
-- Name: yay; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yay (
    id integer NOT NULL,
    yayad character varying(100),
    adet integer,
    tur character varying(100)
);


ALTER TABLE public.yay OWNER TO postgres;

--
-- Name: yay_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.yay ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.yay_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999
    CACHE 1
);


--
-- Data for Name: calisanlar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.calisanlar (id, ad, soyad, tc, tel, gorev) FROM stdin;
1	Kağan	Erol	12762158645	(543) 515-9559	Yönetici
6	Mustafa	Erol	12756131321	(534) 868-4531	Danışman
\.


--
-- Data for Name: hedef; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hedef (id, hedefad, adet, boyut) FROM stdin;
1	avalon	10	60cm
\.


--
-- Data for Name: kasaba; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kasaba (kasabaid, sehirid, kasabaad) FROM stdin;
1	1	ALADAĞ
2	1	CEYHAN
3	1	ÇUKUROVA
4	1	FEKE
5	1	İMAMOĞLU
6	1	KARAİSALI
7	1	KARATAŞ
8	1	KOZAN
9	1	POZANTI
10	1	SAİMBEYLİ
11	1	SARIÇAM
12	1	SEYHAN
13	1	TUFANBEYLİ
14	1	YUMURTALIK
15	1	YÜREĞİR
16	2	BESNİ
17	2	ÇELİKHAN
18	2	GERGER
19	2	GÖLBAŞI
20	2	KAHTA
21	2	MERKEZ
22	2	SAMSAT
23	2	SİNCİK
24	2	TUT
25	3	BAŞMAKÇI
26	3	BAYAT
27	3	BOLVADİN
28	3	ÇAY
29	3	ÇOBANLAR
30	3	DAZKIRI
31	3	DİNAR
32	3	EMİRDAĞ
33	3	EVCİLER
34	3	HOCALAR
35	3	İHSANİYE
36	3	İSCEHİSAR
37	3	KIZILÖREN
38	3	MERKEZ
39	3	SANDIKLI
40	3	SİNANPAŞA
41	3	ŞUHUT
42	3	SULTANDAĞI
43	4	DİYADİN
44	4	DOĞUBAYAZIT
45	4	ELEŞKİRT
46	4	HAMUR
47	4	MERKEZ
48	4	PATNOS
49	4	TAŞLIÇAY
50	4	TUTAK
51	5	AĞAÇÖREN
52	5	ESKİL
53	5	GÜLAĞAÇ
54	5	GÜZELYURT
55	5	MERKEZ
56	5	ORTAKÖY
57	5	SARIYAHŞİ
58	6	GÖYNÜCEK
59	6	GÜMÜŞHACIKÖY
60	6	HAMAMÖZÜ
61	6	MERKEZ
62	6	MERZİFON
63	6	SULUOVA
64	6	TAŞOVA
65	7	AKYURT
66	7	ALTINDAĞ
67	7	AYAŞ
68	7	BALA
69	7	BEYPAZARI
70	7	ÇAMLIDERE
71	7	ÇANKAYA
72	7	ÇUBUK
73	7	ELMADAĞ
74	7	ETİMESGUT
75	7	EVREN
76	7	GÖLBAŞI
77	7	GÜDÜL
78	7	HAYMANA
79	7	KAHRAMANKAZAN
80	7	KALECİK
81	7	KEÇİÖREN
82	7	KIZILCAHAMAM
83	7	MAMAK
84	7	NALLIHAN
85	7	POLATLI
86	7	PURSAKLAR
87	7	ŞEREFLİKOÇHİSAR
88	7	SİNCAN
89	7	YENİMAHALLE
90	8	AKSEKİ
91	8	AKSU
92	8	ALANYA
93	8	DEMRE
94	8	DÖŞEMEALTI
95	8	ELMALI
96	8	FİNİKE
97	8	GAZİPAŞA
98	8	GÜNDOĞMUŞ
99	8	İBRADI
100	8	KAŞ
101	8	KEMER
102	8	KEPEZ
103	8	KONYAALTI
104	8	KORKUTELİ
105	8	KUMLUCA
106	8	MANAVGAT
107	8	MURATPAŞA
108	8	SERİK
109	9	ÇILDIR
110	9	DAMAL
111	9	GÖLE
112	9	HANAK
113	9	MERKEZ
114	9	POSOF
115	10	ARDANUÇ
116	10	ARHAVİ
117	10	BORÇKA
118	10	HOPA
119	10	MERKEZ
120	10	MURGUL
121	10	ŞAVŞAT
122	10	YUSUFELİ
123	11	BOZDOĞAN
124	11	BUHARKENT
125	11	ÇİNE
126	11	DİDİM
127	11	EFELER
128	11	GERMENCİK
129	11	İNCİRLİOVA
130	11	KARACASU
131	11	KARPUZLU
132	11	KOÇARLI
133	11	KÖŞK
134	11	KUŞADASI
135	11	KUYUCAK
136	11	NAZİLLİ
137	11	SÖKE
138	11	SULTANHİSAR
139	11	YENİPAZAR
140	12	ALTIEYLÜL
141	12	AYVALIK
142	12	BALYA
143	12	BANDIRMA
144	12	BİGADİÇ
145	12	BURHANİYE
146	12	DURSUNBEY
147	12	EDREMİT
148	12	ERDEK
149	12	GÖMEÇ
150	12	GÖNEN
151	12	HAVRAN
152	12	İVRİNDİ
153	12	KARESİ
154	12	KEPSUT
155	12	MANYAS
156	12	MARMARA
157	12	SAVAŞTEPE
158	12	SINDIRGI
159	12	SUSURLUK
160	13	AMASRA
161	13	KURUCAŞİLE
162	13	MERKEZ
163	13	ULUS
164	14	BEŞİRİ
165	14	GERCÜŞ
166	14	HASANKEYF
167	14	KOZLUK
168	14	MERKEZ
169	14	SASON
170	15	AYDINTEPE
171	15	DEMİRÖZÜ
172	15	MERKEZ
173	16	BOZÜYÜK
174	16	GÖLPAZARI
175	16	İNHİSAR
176	16	MERKEZ
177	16	OSMANELİ
178	16	PAZARYERİ
179	16	SÖĞÜT
180	16	YENİPAZAR
181	17	ADAKLI
182	17	GENÇ
183	17	KARLIOVA
184	17	KİĞI
185	17	MERKEZ
186	17	SOLHAN
187	17	YAYLADERE
188	17	YEDİSU
189	18	ADİLCEVAZ
190	18	AHLAT
191	18	GÜROYMAK
192	18	HİZAN
193	18	MERKEZ
194	18	MUTKİ
195	18	TATVAN
196	19	DÖRTDİVAN
197	19	GEREDE
198	19	GÖYNÜK
199	19	KIBRISCIK
200	19	MENGEN
201	19	MERKEZ
202	19	MUDURNU
203	19	SEBEN
204	19	YENİÇAĞA
205	20	AĞLASUN
206	20	ALTINYAYLA
207	20	BUCAK
208	20	ÇAVDIR
209	20	ÇELTİKÇİ
210	20	GÖLHİSAR
211	20	KARAMANLI
212	20	KEMER
213	20	MERKEZ
214	20	TEFENNİ
215	20	YEŞİLOVA
216	21	BÜYÜKORHAN
217	21	GEMLİK
218	21	GÜRSU
219	21	HARMANCIK
220	21	İNEGÖL
221	21	İZNİK
222	21	KARACABEY
223	21	KELES
224	21	KESTEL
225	21	MUDANYA
226	21	MUSTAFAKEMALPAŞA
227	21	NİLÜFER
228	21	ORHANELİ
229	21	ORHANGAZİ
230	21	OSMANGAZİ
231	21	YENİŞEHİR
232	21	YILDIRIM
233	22	AYVACIK
234	22	BAYRAMİÇ
235	22	BİGA
236	22	BOZCAADA
237	22	ÇAN
238	22	ECEABAT
239	22	EZİNE
240	22	GELİBOLU
241	22	GÖKÇEADA
242	22	LAPSEKİ
243	22	MERKEZ
244	22	YENİCE
245	23	ATKARACALAR
246	23	BAYRAMÖREN
247	23	ÇERKEŞ
248	23	ELDİVAN
249	23	ILGAZ
250	23	KIZILIRMAK
251	23	KORGUN
252	23	KURŞUNLU
253	23	MERKEZ
254	23	ORTA
255	23	ŞABANÖZÜ
256	23	YAPRAKLI
257	24	ALACA
258	24	BAYAT
259	24	BOĞAZKALE
260	24	DODURGA
261	24	İSKİLİP
262	24	KARGI
263	24	LAÇİN
264	24	MECİTÖZÜ
265	24	MERKEZ
266	24	OĞUZLAR
267	24	ORTAKÖY
268	24	OSMANCIK
269	24	SUNGURLU
270	24	UĞURLUDAĞ
271	25	ACIPAYAM
272	25	BABADAĞ
273	25	BAKLAN
274	25	BEKİLLİ
275	25	BEYAĞAÇ
276	25	BOZKURT
277	25	BULDAN
278	25	ÇAL
279	25	ÇAMELİ
280	25	ÇARDAK
281	25	ÇİVRİL
282	25	GÜNEY
283	25	HONAZ
284	25	KALE
285	25	MERKEZEFENDİ
286	25	PAMUKKALE
287	25	SARAYKÖY
288	25	SERİNHİSAR
289	25	TAVAS
290	26	BAĞLAR
291	26	BİSMİL
292	26	ÇERMİK
293	26	ÇINAR
294	26	ÇÜNGÜŞ
295	26	DİCLE
296	26	EĞİL
297	26	ERGANİ
298	26	HANİ
299	26	HAZRO
300	26	KAYAPINAR
301	26	KOCAKÖY
302	26	KULP
303	26	LİCE
304	26	SİLVAN
305	26	SUR
306	26	YENİŞEHİR
307	27	AKÇAKOCA
308	27	ÇİLİMLİ
309	27	CUMAYERİ
310	27	GÖLYAKA
311	27	GÜMÜŞOVA
312	27	KAYNAŞLI
313	27	MERKEZ
314	27	YIĞILCA
315	28	ENEZ
316	28	HAVSA
317	28	İPSALA
318	28	KEŞAN
319	28	LALAPAŞA
320	28	MERİÇ
321	28	MERKEZ
322	28	SÜLOĞLU
323	28	UZUNKÖPRÜ
324	29	AĞIN
325	29	ALACAKAYA
326	29	ARICAK
327	29	BASKİL
328	29	KARAKOÇAN
329	29	KEBAN
330	29	KOVANCILAR
331	29	MADEN
332	29	MERKEZ
333	29	PALU
334	29	SİVRİCE
335	30	ÇAYIRLI
336	30	İLİÇ
337	30	KEMAH
338	30	KEMALİYE
339	30	MERKEZ
340	30	OTLUKBELİ
341	30	REFAHİYE
342	30	TERCAN
343	30	ÜZÜMLÜ
344	31	AŞKALE
345	31	AZİZİYE
346	31	ÇAT
347	31	HINIS
348	31	HORASAN
349	31	İSPİR
350	31	KARAÇOBAN
351	31	KARAYAZI
352	31	KÖPRÜKÖY
353	31	NARMAN
354	31	OLTU
355	31	OLUR
356	31	PALANDÖKEN
357	31	PASİNLER
358	31	PAZARYOLU
359	31	ŞENKAYA
360	31	TEKMAN
361	31	TORTUM
362	31	UZUNDERE
363	31	YAKUTİYE
364	32	ALPU
365	32	BEYLİKOVA
366	32	ÇİFTELER
367	32	GÜNYÜZÜ
368	32	HAN
369	32	İNÖNÜ
370	32	MAHMUDİYE
371	32	MİHALGAZİ
372	32	MİHALIÇÇIK
373	32	ODUNPAZARI
374	32	SARICAKAYA
375	32	SEYİTGAZİ
376	32	SİVRİHİSAR
377	32	TEPEBAŞI
378	33	ARABAN
379	33	İSLAHİYE
380	33	KARKAMIŞ
381	33	NİZİP
382	33	NURDAĞI
383	33	OĞUZELİ
384	33	ŞAHİNBEY
385	33	ŞEHİTKAMİL
386	33	YAVUZELİ
387	34	ALUCRA
388	34	BULANCAK
389	34	ÇAMOLUK
390	34	ÇANAKÇI
391	34	DERELİ
392	34	DOĞANKENT
393	34	ESPİYE
394	34	EYNESİL
395	34	GÖRELE
396	34	GÜCE
397	34	KEŞAP
398	34	MERKEZ
399	34	PİRAZİZ
400	34	ŞEBİNKARAHİSAR
401	34	TİREBOLU
402	34	YAĞLIDERE
403	35	KELKİT
404	35	KÖSE
405	35	KÜRTÜN
406	35	MERKEZ
407	35	ŞİRAN
408	35	TORUL
409	36	ÇUKURCA
410	36	MERKEZ
411	36	ŞEMDİNLİ
412	36	YÜKSEKOVA
413	37	ALTINÖZÜ
414	37	ANTAKYA
415	37	ARSUZ
416	37	BELEN
417	37	DEFNE
418	37	DÖRTYOL
419	37	ERZİN
420	37	HASSA
421	37	İSKENDERUN
422	37	KIRIKHAN
423	37	KUMLU
424	37	PAYAS
425	37	REYHANLI
426	37	SAMANDAĞ
427	37	YAYLADAĞI
428	38	ARALIK
429	38	KARAKOYUNLU
430	38	MERKEZ
431	38	TUZLUCA
432	39	AKSU
433	39	ATABEY
434	39	EĞİRDİR
435	39	GELENDOST
436	39	GÖNEN
437	39	KEÇİBORLU
438	39	MERKEZ
439	39	ŞARKİKARAAĞAÇ
440	39	SENİRKENT
441	39	SÜTÇÜLER
442	39	ULUBORLU
443	39	YALVAÇ
444	39	YENİŞARBADEMLİ
445	40	ADALAR
446	40	ARNAVUTKÖY
447	40	ATAŞEHİR
448	40	AVCILAR
449	40	BAĞCILAR
450	40	BAHÇELİEVLER
451	40	BAKIRKÖY
452	40	BAŞAKŞEHİR
453	40	BAYRAMPAŞA
454	40	BEŞİKTAŞ
455	40	BEYKOZ
456	40	BEYLİKDÜZÜ
457	40	BEYOĞLU
458	40	BÜYÜKÇEKMECE
459	40	ÇATALCA
460	40	ÇEKMEKÖY
461	40	ESENLER
462	40	ESENYURT
463	40	EYÜP
464	40	FATİH
465	40	GAZİOSMANPAŞA
466	40	GÜNGÖREN
467	40	KADIKÖY
468	40	KAĞITHANE
469	40	KARTAL
470	40	KÜÇÜKÇEKMECE
471	40	MALTEPE
472	40	PENDİK
473	40	SANCAKTEPE
474	40	SARIYER
475	40	ŞİLE
476	40	SİLİVRİ
477	40	ŞİŞLİ
478	40	SULTANBEYLİ
479	40	SULTANGAZİ
480	40	TUZLA
481	40	ÜMRANİYE
482	40	ÜSKÜDAR
483	40	ZEYTİNBURNU
484	41	ALİAĞA
485	41	BALÇOVA
486	41	BAYINDIR
487	41	BAYRAKLI
488	41	BERGAMA
489	41	BEYDAĞ
490	41	BORNOVA
491	41	BUCA
492	41	ÇEŞME
493	41	ÇİĞLİ
494	41	DİKİLİ
495	41	FOÇA
496	41	GAZİEMİR
497	41	GÜZELBAHÇE
498	41	KARABAĞLAR
499	41	KARABURUN
500	41	KARŞIYAKA
501	41	KEMALPAŞA
502	41	KINIK
503	41	KİRAZ
504	41	KONAK
505	41	MENDERES
506	41	MENEMEN
507	41	NARLIDERE
508	41	ÖDEMİŞ
509	41	SEFERİHİSAR
510	41	SELÇUK
511	41	TİRE
512	41	TORBALI
513	41	URLA
514	42	AFŞİN
515	42	ANDIRIN
516	42	ÇAĞLAYANCERİT
517	42	DULKADİROĞLU
518	42	EKİNÖZÜ
519	42	ELBİSTAN
520	42	GÖKSUN
521	42	NURHAK
522	42	ONİKİŞUBAT
523	42	PAZARCIK
524	42	TÜRKOĞLU
525	43	EFLANİ
526	43	ESKİPAZAR
527	43	MERKEZ
528	43	OVACIK
529	43	SAFRANBOLU
530	43	YENİCE
531	44	AYRANCI
532	44	BAŞYAYLA
533	44	ERMENEK
534	44	KAZIMKARABEKİR
535	44	MERKEZ
536	44	SARIVELİLER
537	45	AKYAKA
538	45	ARPAÇAY
539	45	DİGOR
540	45	KAĞIZMAN
541	45	MERKEZ
542	45	SARIKAMIŞ
543	45	SELİM
544	45	SUSUZ
545	46	ABANA
546	46	AĞLI
547	46	ARAÇ
548	46	AZDAVAY
549	46	BOZKURT
550	46	ÇATALZEYTİN
551	46	CİDE
552	46	DADAY
553	46	DEVREKANİ
554	46	DOĞANYURT
555	46	HANÖNÜ
556	46	İHSANGAZİ
557	46	İNEBOLU
558	46	KÜRE
559	46	MERKEZ
560	46	PINARBAŞI
561	46	ŞENPAZAR
562	46	SEYDİLER
563	46	TAŞKÖPRÜ
564	46	TOSYA
565	47	AKKIŞLA
566	47	BÜNYAN
567	47	DEVELİ
568	47	FELAHİYE
569	47	HACILAR
570	47	İNCESU
571	47	KOCASİNAN
572	47	MELİKGAZİ
573	47	ÖZVATAN
574	47	PINARBAŞI
575	47	SARIOĞLAN
576	47	SARIZ
577	47	TALAS
578	47	TOMARZA
579	47	YAHYALI
580	47	YEŞİLHİSAR
581	51	ELBEYLİ
582	51	MERKEZ
583	51	MUSABEYLİ
584	51	POLATELİ
585	48	BAHŞİLİ
586	48	BALIŞEYH
587	48	ÇELEBİ
588	48	DELİCE
589	48	KARAKEÇİLİ
590	48	KESKİN
591	48	MERKEZ
592	48	SULAKYURT
593	48	YAHŞİHAN
594	49	BABAESKİ
595	49	DEMİRKÖY
596	49	KOFÇAZ
597	49	LÜLEBURGAZ
598	49	MERKEZ
599	49	PEHLİVANKÖY
600	49	PINARHİSAR
601	49	VİZE
602	50	AKÇAKENT
603	50	AKPINAR
604	50	BOZTEPE
605	50	ÇİÇEKDAĞI
606	50	KAMAN
607	50	MERKEZ
608	50	MUCUR
609	52	BAŞİSKELE
610	52	ÇAYIROVA
611	52	DARICA
612	52	DERİNCE
613	52	DİLOVASI
614	52	GEBZE
615	52	GÖLCÜK
616	52	İZMİT
617	52	KANDIRA
618	52	KARAMÜRSEL
619	52	KARTEPE
620	52	KÖRFEZ
621	53	AHIRLI
622	53	AKÖREN
623	53	AKŞEHİR
624	53	ALTINEKİN
625	53	BEYŞEHİR
626	53	BOZKIR
627	53	ÇELTİK
628	53	CİHANBEYLİ
629	53	ÇUMRA
630	53	DERBENT
631	53	DEREBUCAK
632	53	DOĞANHİSAR
633	53	EMİRGAZİ
634	53	EREĞLİ
635	53	GÜNEYSINIR
636	53	HADİM
637	53	HALKAPINAR
638	53	HÜYÜK
639	53	ILGIN
640	53	KADINHANI
641	53	KARAPINAR
642	53	KARATAY
643	53	KULU
644	53	MERAM
645	53	SARAYÖNÜ
646	53	SELÇUKLU
647	53	SEYDİŞEHİR
648	53	TAŞKENT
649	53	TUZLUKÇU
650	53	YALIHÜYÜK
651	53	YUNAK
652	54	ALTINTAŞ
653	54	ASLANAPA
654	54	ÇAVDARHİSAR
655	54	DOMANİÇ
656	54	DUMLUPINAR
657	54	EMET
658	54	GEDİZ
659	54	HİSARCIK
660	54	MERKEZ
661	54	PAZARLAR
662	54	ŞAPHANE
663	54	SİMAV
664	54	TAVŞANLI
665	55	AKÇADAĞ
666	55	ARAPGİR
667	55	ARGUVAN
668	55	BATTALGAZİ
669	55	DARENDE
670	55	DOĞANŞEHİR
671	55	DOĞANYOL
672	55	HEKİMHAN
673	55	KALE
674	55	KULUNCAK
675	55	PÜTÜRGE
676	55	YAZIHAN
677	55	YEŞİLYURT
678	56	AHMETLİ
679	56	AKHİSAR
680	56	ALAŞEHİR
681	56	DEMİRCİ
682	56	GÖLMARMARA
683	56	GÖRDES
684	56	KIRKAĞAÇ
685	56	KÖPRÜBAŞI
686	56	KULA
687	56	SALİHLİ
688	56	SARIGÖL
689	56	SARUHANLI
690	56	ŞEHZADELER
691	56	SELENDİ
692	56	SOMA
693	56	TURGUTLU
694	56	YUNUSEMRE
695	57	ARTUKLU
696	57	DARGEÇİT
697	57	DERİK
698	57	KIZILTEPE
699	57	MAZIDAĞI
700	57	MİDYAT
701	57	NUSAYBİN
702	57	ÖMERLİ
703	57	SAVUR
704	57	YEŞİLLİ
705	58	AKDENİZ
706	58	ANAMUR
707	58	AYDINCIK
708	58	BOZYAZI
709	58	ÇAMLIYAYLA
710	58	ERDEMLİ
711	58	GÜLNAR
712	58	MEZİTLİ
713	58	MUT
714	58	SİLİFKE
715	58	TARSUS
716	58	TOROSLAR
717	58	YENİŞEHİR
718	59	BODRUM
719	59	DALAMAN
720	59	DATÇA
721	59	FETHİYE
722	59	KAVAKLIDERE
723	59	KÖYCEĞİZ
724	59	MARMARİS
725	59	MENTEŞE
726	59	MİLAS
727	59	ORTACA
728	59	SEYDİKEMER
729	59	ULA
730	59	YATAĞAN
731	60	BULANIK
732	60	HASKÖY
733	60	KORKUT
734	60	MALAZGİRT
735	60	MERKEZ
736	60	VARTO
737	61	ACIGÖL
738	61	AVANOS
739	61	DERİNKUYU
740	61	GÜLŞEHİR
741	61	HACIBEKTAŞ
742	61	KOZAKLI
743	61	MERKEZ
744	61	ÜRGÜP
745	62	ALTUNHİSAR
746	62	BOR
747	62	ÇAMARDI
748	62	ÇİFTLİK
749	62	MERKEZ
750	62	ULUKIŞLA
751	63	AKKUŞ
752	63	ALTINORDU
753	63	AYBASTI
754	63	ÇAMAŞ
755	63	ÇATALPINAR
756	63	ÇAYBAŞI
757	63	FATSA
758	63	GÖLKÖY
759	63	GÜLYALI
760	63	GÜRGENTEPE
761	63	İKİZCE
762	63	KABADÜZ
763	63	KABATAŞ
764	63	KORGAN
765	63	KUMRU
766	63	MESUDİYE
767	63	PERŞEMBE
768	63	ULUBEY
769	63	ÜNYE
770	64	BAHÇE
771	64	DÜZİÇİ
772	64	HASANBEYLİ
773	64	KADİRLİ
774	64	MERKEZ
775	64	SUMBAS
776	64	TOPRAKKALE
777	65	ARDEŞEN
778	65	ÇAMLIHEMŞİN
779	65	ÇAYELİ
780	65	DEREPAZARI
781	65	FINDIKLI
782	65	GÜNEYSU
783	65	HEMŞİN
784	65	İKİZDERE
785	65	İYİDERE
786	65	KALKANDERE
787	65	MERKEZ
788	65	PAZAR
789	66	ADAPAZARI
790	66	AKYAZI
791	66	ARİFİYE
792	66	ERENLER
793	66	FERİZLİ
794	66	GEYVE
795	66	HENDEK
796	66	KARAPÜRÇEK
797	66	KARASU
798	66	KAYNARCA
799	66	KOCAALİ
800	66	PAMUKOVA
801	66	SAPANCA
802	66	SERDİVAN
803	66	SÖĞÜTLÜ
804	66	TARAKLI
805	67	19 MAYIS
806	67	ALAÇAM
807	67	ASARCIK
808	67	ATAKUM
809	67	AYVACIK
810	67	BAFRA
811	67	CANİK
812	67	ÇARŞAMBA
813	67	HAVZA
814	67	İLKADIM
815	67	KAVAK
816	67	LADİK
817	67	SALIPAZARI
818	67	TEKKEKÖY
819	67	TERME
820	67	VEZİRKÖPRÜ
821	67	YAKAKENT
822	71	AKÇAKALE
823	71	BİRECİK
824	71	BOZOVA
825	71	CEYLANPINAR
826	71	EYYÜBİYE
827	71	HALFETİ
828	71	HALİLİYE
829	71	HARRAN
830	71	HİLVAN
831	71	KARAKÖPRÜ
832	71	SİVEREK
833	71	SURUÇ
834	71	VİRANŞEHİR
835	68	BAYKAN
836	68	ERUH
837	68	KURTALAN
838	68	MERKEZ
839	68	PERVARİ
840	68	ŞİRVAN
841	68	TİLLO
842	69	AYANCIK
843	69	BOYABAT
844	69	DİKMEN
845	69	DURAĞAN
846	69	ERFELEK
847	69	GERZE
848	69	MERKEZ
849	69	SARAYDÜZÜ
850	69	TÜRKELİ
851	72	BEYTÜŞŞEBAP
852	72	CİZRE
853	72	GÜÇLÜKONAK
854	72	İDİL
855	72	MERKEZ
856	72	SİLOPİ
857	72	ULUDERE
858	70	AKINCILAR
859	70	ALTINYAYLA
860	70	DİVRİĞİ
861	70	DOĞANŞAR
862	70	GEMEREK
863	70	GÖLOVA
864	70	GÜRÜN
865	70	HAFİK
866	70	İMRANLI
867	70	KANGAL
868	70	KOYULHİSAR
869	70	MERKEZ
870	70	ŞARKIŞLA
871	70	SUŞEHRİ
872	70	ULAŞ
873	70	YILDIZELİ
874	70	ZARA
875	73	ÇERKEZKÖY
876	73	ÇORLU
877	73	ERGENE
878	73	HAYRABOLU
879	73	KAPAKLI
880	73	MALKARA
881	73	MARMARAEREĞLİSİ
882	73	MURATLI
883	73	SARAY
884	73	ŞARKÖY
885	73	SÜLEYMANPAŞA
886	74	ALMUS
887	74	ARTOVA
888	74	BAŞÇİFTLİK
889	74	ERBAA
890	74	MERKEZ
891	74	NİKSAR
892	74	PAZAR
893	74	REŞADİYE
894	74	SULUSARAY
895	74	TURHAL
896	74	YEŞİLYURT
897	74	ZİLE
898	75	AKÇAABAT
899	75	ARAKLI
900	75	ARSİN
901	75	BEŞİKDÜZÜ
902	75	ÇARŞIBAŞI
903	75	ÇAYKARA
904	75	DERNEKPAZARI
905	75	DÜZKÖY
906	75	HAYRAT
907	75	KÖPRÜBAŞI
908	75	MAÇKA
909	75	OF
910	75	ORTAHİSAR
911	75	ŞALPAZARI
912	75	SÜRMENE
913	75	TONYA
914	75	VAKFIKEBİR
915	75	YOMRA
916	76	ÇEMİŞGEZEK
917	76	HOZAT
918	76	MAZGİRT
919	76	MERKEZ
920	76	NAZIMİYE
921	76	OVACIK
922	76	PERTEK
923	76	PÜLÜMÜR
924	77	BANAZ
925	77	EŞME
926	77	KARAHALLI
927	77	MERKEZ
928	77	SİVASLI
929	77	ULUBEY
930	78	BAHÇESARAY
931	78	BAŞKALE
932	78	ÇALDIRAN
933	78	ÇATAK
934	78	EDREMİT
935	78	ERCİŞ
936	78	GEVAŞ
937	78	GÜRPINAR
938	78	İPEKYOLU
939	78	MURADİYE
940	78	ÖZALP
941	78	SARAY
942	78	TUŞBA
943	79	ALTINOVA
944	79	ARMUTLU
945	79	ÇİFTLİKKÖY
946	79	ÇINARCIK
947	79	MERKEZ
948	79	TERMAL
949	80	AKDAĞMADENİ
950	80	AYDINCIK
951	80	BOĞAZLIYAN
952	80	ÇANDIR
953	80	ÇAYIRALAN
954	80	ÇEKEREK
955	80	KADIŞEHRİ
956	80	MERKEZ
957	80	SARAYKENT
958	80	SARIKAYA
959	80	ŞEFAATLİ
960	80	SORGUN
961	80	YENİFAKILI
962	80	YERKÖY
963	81	ALAPLI
964	81	ÇAYCUMA
965	81	DEVREK
966	81	EREĞLİ
967	81	GÖKÇEBEY
968	81	KİLİMLİ
969	81	KOZLU
970	81	MERKEZ
\.


--
-- Data for Name: kullanici; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kullanici (id, kulad, calisanid, sifre) FROM stdin;
1	Mustafa	6	2
\.


--
-- Data for Name: lisans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lisans (id, ad, soyad, dogumtarih, babaad, annead, ogrenciid, il) FROM stdin;
1	Ahmet	Adıgüzel	01.01.1997	Ali	Fatma	1	OSMANİYE
\.


--
-- Data for Name: odeme; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.odeme (id, ay, yil, elektrik, gaz, su) FROM stdin;
1	Ocak	2020	50.89	258.54	65.56
2	Şubat	2020	60.89	242.5	65.56
\.


--
-- Data for Name: odemetakip; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.odemetakip (id, ay, yil, toplamtutar, durum, odemeid) FROM stdin;
1	Şubat	2020	368.95	Ödendi	2
\.


--
-- Data for Name: ogrencibilgi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ogrencibilgi (id, ogrenciid, babaad, annead, tel, dogumyeri, mail) FROM stdin;
1	3	Ali	Aslı	(564) 686-4653	KASTAMONU	hasan@gmail.com
\.


--
-- Data for Name: ogrencikayit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ogrencikayit (id, ad, soyad, dogumtarih, il, ilce, tc) FROM stdin;
1	Ahmet	Adıgüzel	01.01.1997	MANİSA	AKHİSAR	11111111111
3	Hasan	Soyadıgüzel	01.01.2001	SAKARYA	ERENLER	22222222222
\.


--
-- Data for Name: ogrenciucret; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ogrenciucret (id, ogrenciid, kayittarih, ucret, ay, yil) FROM stdin;
1	1	05.10.2020	300	Eylül	2020
2	3	02.08.2020	300	Eylül	2020
\.


--
-- Data for Name: ok; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ok (id, okad, adet, tur) FROM stdin;
1	helix	20	fiber
\.


--
-- Data for Name: sahiplik; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sahiplik (id, ad, soyad, malzeme1, malzeme2) FROM stdin;
1	Ahmet	Adıgüzel	impetus	helix
\.


--
-- Data for Name: sehir; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sehir (sehirid, sehirad) FROM stdin;
1	ADANA
2	ADIYAMAN
3	AFYONKARAHİSAR
4	AĞRI
5	AKSARAY
6	AMASYA
7	ANKARA
8	ANTALYA
9	ARDAHAN
10	ARTVİN
11	AYDIN
12	BALIKESİR
13	BARTIN
14	BATMAN
15	BAYBURT
16	BİLECİK
17	BİNGÖL
18	BİTLİS
19	BOLU
20	BURDUR
21	BURSA
22	ÇANAKKALE
23	ÇANKIRI
24	ÇORUM
25	DENİZLİ
26	DİYARBAKIR
27	DÜZCE
28	EDİRNE
29	ELAZIĞ
30	ERZİNCAN
31	ERZURUM
32	ESKİŞEHİR
33	GAZİANTEP
34	GİRESUN
35	GÜMÜŞHANE
36	HAKKARİ
37	HATAY
38	IĞDIR
39	ISPARTA
40	İSTANBUL
41	İZMİR
42	KAHRAMANMARAŞ
43	KARABÜK
44	KARAMAN
45	KARS
46	KASTAMONU
47	KAYSERİ
48	KIRIKKALE
49	KIRKLARELİ
50	KIRŞEHİR
51	KİLİS
52	KOCAELİ
53	KONYA
54	KÜTAHYA
55	MALATYA
56	MANİSA
57	MARDİN
58	MERSİN
59	MUĞLA
60	MUŞ
61	NEVŞEHİR
62	NİĞDE
63	ORDU
64	OSMANİYE
65	RİZE
66	SAKARYA
67	SAMSUN
68	SİİRT
69	SİNOP
70	SİVAS
71	ŞANLIURFA
72	ŞIRNAK
73	TEKİRDAĞ
74	TOKAT
75	TRABZON
76	TUNCELİ
77	UŞAK
78	VAN
79	YALOVA
80	YOZGAT
81	ZONGULDAK
\.


--
-- Data for Name: ucrettakip; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ucrettakip (id, ucret, ay, durum, ogrenciid) FROM stdin;
1	300	Eylül	Ödendi	3
\.


--
-- Data for Name: yay; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.yay (id, yayad, adet, tur) FROM stdin;
1	impetus	5	Makaralı
\.


--
-- Name: areas_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.areas_seq', 2438, false);


--
-- Name: calisanlar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.calisanlar_id_seq', 6, true);


--
-- Name: cities_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cities_seq', 82, false);


--
-- Name: counties_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.counties_seq', 971, false);


--
-- Name: countries_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.countries_seq', 233, false);


--
-- Name: hedef_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hedef_id_seq', 1, true);


--
-- Name: kullanici_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kullanici_id_seq', 1, true);


--
-- Name: kullanici_sifre_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kullanici_sifre_seq', 2, true);


--
-- Name: lisans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lisans_id_seq', 1, true);


--
-- Name: neighborhoods_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.neighborhoods_seq', 74914, false);


--
-- Name: odeme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.odeme_id_seq', 2, true);


--
-- Name: odemetakip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.odemetakip_id_seq', 1, true);


--
-- Name: ogrencibilgi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ogrencibilgi_id_seq', 1, true);


--
-- Name: ogrencikayit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ogrencikayit_id_seq', 3, true);


--
-- Name: ogrenciucret_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ogrenciucret_id_seq', 2, true);


--
-- Name: ok_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ok_id_seq', 1, true);


--
-- Name: sahiplik_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sahiplik_id_seq', 1, true);


--
-- Name: ucrettakip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ucrettakip_id_seq', 1, true);


--
-- Name: yay_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.yay_id_seq', 1, true);


--
-- Name: calisanlar calisanlar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calisanlar
    ADD CONSTRAINT calisanlar_pkey PRIMARY KEY (id);


--
-- Name: sehir cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sehir
    ADD CONSTRAINT cities_pkey PRIMARY KEY (sehirid);


--
-- Name: kasaba counties_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kasaba
    ADD CONSTRAINT counties_pkey PRIMARY KEY (kasabaid);


--
-- Name: hedef hedef_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hedef
    ADD CONSTRAINT hedef_pkey PRIMARY KEY (id);


--
-- Name: kullanici kullanici_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kullanici
    ADD CONSTRAINT kullanici_pkey PRIMARY KEY (id);


--
-- Name: lisans lisans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lisans
    ADD CONSTRAINT lisans_pkey PRIMARY KEY (id);


--
-- Name: odeme odeme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odeme
    ADD CONSTRAINT odeme_pkey PRIMARY KEY (id);


--
-- Name: odemetakip odemetakip_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.odemetakip
    ADD CONSTRAINT odemetakip_pkey PRIMARY KEY (id);


--
-- Name: ogrencibilgi ogrencibilgi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ogrencibilgi
    ADD CONSTRAINT ogrencibilgi_pkey PRIMARY KEY (id);


--
-- Name: ogrencikayit ogrencikayit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ogrencikayit
    ADD CONSTRAINT ogrencikayit_pkey PRIMARY KEY (id);


--
-- Name: ogrenciucret ogrenciucret_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ogrenciucret
    ADD CONSTRAINT ogrenciucret_pkey PRIMARY KEY (id);


--
-- Name: ok ok_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ok
    ADD CONSTRAINT ok_pkey PRIMARY KEY (id);


--
-- Name: sahiplik sahiplik_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sahiplik
    ADD CONSTRAINT sahiplik_pkey PRIMARY KEY (id);


--
-- Name: ucrettakip ucrettakip_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ucrettakip
    ADD CONSTRAINT ucrettakip_pkey PRIMARY KEY (id);


--
-- Name: yay yay_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yay
    ADD CONSTRAINT yay_pkey PRIMARY KEY (id);


--
-- Name: fk_counties_cityid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_counties_cityid ON public.kasaba USING btree (sehirid);


--
-- Name: fki_ogrencikayitfk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_ogrencikayitfk ON public.ogrencibilgi USING btree (ogrenciid);


--
-- Name: fki_ogrenciucretfk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_ogrenciucretfk ON public.ogrenciucret USING btree (ogrenciid);


--
-- Name: calisanlar kullaniciekle; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER kullaniciekle AFTER INSERT ON public.calisanlar FOR EACH ROW EXECUTE FUNCTION public.kulekle();


--
-- Name: odeme odemetakip; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER odemetakip AFTER INSERT ON public.odeme FOR EACH ROW EXECUTE FUNCTION public.odemetakip();


--
-- Name: ogrencikayit ogrencibilgiekle; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ogrencibilgiekle AFTER INSERT ON public.ogrencikayit FOR EACH ROW EXECUTE FUNCTION public.ogrencibilgi();


--
-- Name: ogrenciucret ucretodeme; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ucretodeme AFTER INSERT ON public.ogrenciucret FOR EACH ROW EXECUTE FUNCTION public.ucrettakip();


--
-- Name: kasaba fk_counties_cityid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kasaba
    ADD CONSTRAINT fk_counties_cityid FOREIGN KEY (sehirid) REFERENCES public.sehir(sehirid);


--
-- Name: ogrencibilgi ogrencikayitfk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ogrencibilgi
    ADD CONSTRAINT ogrencikayitfk FOREIGN KEY (ogrenciid) REFERENCES public.ogrencikayit(id) NOT VALID;


--
-- Name: ogrenciucret ogrenciucretfk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ogrenciucret
    ADD CONSTRAINT ogrenciucretfk FOREIGN KEY (ogrenciid) REFERENCES public.ogrencikayit(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

