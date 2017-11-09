--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.7
-- Dumped by pg_dump version 9.5.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: action; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE action (
    post_id integer NOT NULL,
    complete boolean,
    assigner character varying(5),
    assignee character varying(5)
);


ALTER TABLE action OWNER TO vagrant;

--
-- Name: districts; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE districts (
    district_id character varying(3) NOT NULL,
    name character varying(25) NOT NULL
);


ALTER TABLE districts OWNER TO vagrant;

--
-- Name: employees; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE employees (
    emp_id character varying(5) NOT NULL,
    fname character varying(25) NOT NULL,
    lname character varying(25) NOT NULL,
    ssn character varying(11) NOT NULL,
    password character varying(5) NOT NULL,
    store_id character varying(3) NOT NULL,
    pos_id character varying(5) NOT NULL
);


ALTER TABLE employees OWNER TO vagrant;

--
-- Name: positions; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE positions (
    pos_id character varying(5) NOT NULL,
    title character varying(25) NOT NULL
);


ALTER TABLE positions OWNER TO vagrant;

--
-- Name: posts; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE posts (
    post_id integer NOT NULL,
    title character varying(75) NOT NULL,
    date timestamp without time zone NOT NULL,
    text text NOT NULL,
    audience character varying(3),
    emp_id character varying(5) NOT NULL
);


ALTER TABLE posts OWNER TO vagrant;

--
-- Name: posts_post_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE posts_post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE posts_post_id_seq OWNER TO vagrant;

--
-- Name: posts_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE posts_post_id_seq OWNED BY posts.post_id;


--
-- Name: stores; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE stores (
    store_id character varying(3) NOT NULL,
    name character varying(255) NOT NULL,
    address character varying(255) NOT NULL,
    phone character varying(14) NOT NULL,
    district_id character varying(3) NOT NULL
);


ALTER TABLE stores OWNER TO vagrant;

--
-- Name: was_read; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE was_read (
    post_id integer NOT NULL,
    emp_id character varying(5) NOT NULL,
    was_read boolean NOT NULL
);


ALTER TABLE was_read OWNER TO vagrant;

--
-- Name: post_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY posts ALTER COLUMN post_id SET DEFAULT nextval('posts_post_id_seq'::regclass);


--
-- Data for Name: action; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY action (post_id, complete, assigner, assignee) FROM stdin;
\.


--
-- Data for Name: districts; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY districts (district_id, name) FROM stdin;
D05	Southeast
D04	Northeast
D03	Midwest
D02	Southwest
D01	Northwest
ALL	All Stores
D99	Corporate HQ
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY employees (emp_id, fname, lname, ssn, password, store_id, pos_id) FROM stdin;
11087	Andrew	Barker	875-02-4722	4722B	011	02-AM
13618	Richard	Morris	892-58-3937	3937M	024	02-AM
92301	Douglas	Hudson	620-19-5313	5313H	006	02-AM
51501	Nicholas	Ware	878-55-4464	4464W	012	02-AM
71171	David	Johnston	421-49-6795	6795J	009	02-AM
81014	Annette	Singh	667-19-1691	1691S	021	02-AM
31259	Robert	Kaufman	122-87-9967	9967K	011	02-AM
05512	Rebekah	Parker	372-25-8868	8868P	010	02-AM
91391	Alyssa	Dean	586-93-0342	0342D	012	02-AM
65075	Jane	Barrett	859-48-0576	0576B	005	02-AM
82931	Taylor	Scott	870-16-5661	5661S	012	01-SM
87365	Angel	Chambers	418-80-6992	6992C	002	02-AM
90235	Jason	Nunez	631-75-8387	8387N	008	02-AM
93851	Kathleen	Parks	266-42-4812	4812P	015	02-AM
55049	Scott	Gonzalez	631-64-9726	9726G	014	02-AM
62335	Adam	Compton	809-14-6517	6517C	005	02-AM
45642	Christina	Maxwell	592-77-0067	0067M	000	02-AM
54134	Jonathan	Escobar	333-48-7870	7870E	020	02-AM
68178	Angela	Allen	217-63-6558	6558A	020	02-AM
22708	Dustin	Chang	153-76-3196	3196C	023	02-AM
49737	Aaron	Hudson	360-64-5521	5521H	006	02-AM
98359	Crystal	Howell	622-28-5425	5425H	012	03-SS
84764	Kara	Miller	347-61-1303	1303M	014	02-AM
36405	Lindsay	Cook	416-36-7878	7878C	008	02-AM
80780	Philip	Richardson	183-79-4030	4030R	014	01-SM
66484	Amy	Rose	179-36-8421	8421R	010	02-AM
80050	Amanda	Woodard	096-23-0755	0755W	005	01-SM
30755	Stephen	Hawkins	515-33-2904	2904H	023	02-AM
69278	Roger	Ortiz	794-09-0962	0962O	020	01-SM
72477	Allison	Ayala	505-11-9381	9381A	015	02-AM
29185	Angela	Tucker	357-94-1892	1892T	012	03-SS
53491	Andrew	Carpenter	604-72-9072	9072C	015	01-SM
67938	Felicia	Reed	011-95-0774	0774R	009	02-AM
38138	Tiffany	Owens	777-16-0615	0615O	005	03-SS
96039	Frances	Lawson	089-53-3337	3337L	000	02-AM
78752	Chris	Warner	626-80-1170	1170W	024	02-AM
00465	Jessica	Gonzales	259-70-4872	4872G	008	01-SM
17911	Sherry	Jackson	529-80-4810	4810J	020	03-SS
42662	Caitlin	Brown	665-86-7000	7000B	013	02-AM
98877	Erin	Robertson	410-57-2475	2475R	014	03-SS
34035	Joanna	Lang	670-25-7705	7705L	003	02-AM
12274	Shirley	Anderson	212-90-0229	0229A	018	02-AM
59359	Autumn	Perry	468-36-8009	8009P	000	01-SM
18866	Allen	Cisneros	038-47-8699	8699C	008	03-SS
95319	Jessica	Bennett	255-55-0275	0275B	013	02-AM
57963	Cody	Tanner	306-98-6400	6400T	012	03-SS
20872	Lindsey	Maxwell	192-15-5399	5399M	009	01-SM
30189	Amy	Mcintyre	088-67-7273	7273M	024	01-SM
31756	Karen	Bush	641-21-4439	4439B	022	02-AM
94225	Andrew	Stephenson	646-30-4424	4424S	019	02-AM
58087	Patricia	York	433-86-0400	0400Y	015	03-SS
49608	Benjamin	Mason	069-43-9856	9856M	010	01-SM
82441	Sean	Hernandez	499-11-0032	0032H	018	02-AM
43340	Kathleen	Sloan	500-98-6853	6853S	010	03-SS
14464	Deborah	Powell	870-96-6911	6911P	024	03-SS
24617	Sarah	Campbell	331-11-3086	3086C	019	02-AM
50983	Charles	Zimmerman	137-62-5423	5423Z	015	03-SS
21569	Richard	Davis	509-31-4328	4328D	005	03-SS
99552	Joshua	Lloyd	295-59-6008	6008L	024	03-SS
19423	Susan	Gomez	090-94-2718	2718G	019	01-SM
48479	Stephen	Knight	482-13-5043	5043K	020	03-SS
15657	John	Nash	450-43-6523	6523N	024	03-SS
78502	John	Martinez	274-01-4270	4270M	022	02-AM
38733	David	Yates	012-47-5960	5960Y	018	01-SM
68748	Kimberly	Wallace	016-24-7791	7791W	005	03-SS
95172	Jennifer	Brooks	294-64-1640	1640B	024	03-SS
52205	Kevin	Weiss	027-83-9183	9183W	023	01-SM
88883	Ashley	Simmons	344-84-6413	6413S	016	02-AM
88133	Courtney	Maldonado	765-28-0042	0042M	014	03-SS
25759	Mark	Williams	816-95-3046	3046W	024	03-SS
57319	Debra	Summers	328-26-5189	5189S	015	03-SS
20879	Adam	Newman	003-84-3166	3166N	001	02-AM
76749	Justin	Mclaughlin	155-79-8846	8846M	002	02-AM
39264	Darlene	Owen	731-52-5742	5742O	022	01-SM
23086	Melvin	Boyd	348-12-2562	2562B	011	01-SM
16318	Jason	Spencer	038-68-5828	5828S	016	02-AM
12581	Deborah	Marshall	760-14-4621	4621M	013	01-SM
78450	Nathaniel	Clark	806-55-2642	2642C	021	02-AM
72092	Veronica	Bennett	791-39-7592	7592B	015	03-SS
52921	Alyssa	Smith	028-76-8699	8699S	000	03-SS
29801	Sara	Bullock	071-89-0617	0617B	020	03-SS
51966	Barbara	Nichols	655-12-0954	0954N	008	03-SS
81955	Leslie	Ramirez	040-93-3247	3247R	017	02-AM
12285	Jennifer	Cruz	445-58-5384	5384C	020	03-SS
06631	Samantha	Hill	311-24-6977	6977H	002	01-SM
90517	Amanda	Montgomery	279-02-6006	6006M	011	03-SS
36174	Shawn	Goodman	683-06-8041	8041G	013	03-SS
72652	Matthew	Sexton	696-72-7422	7422S	018	03-SS
16951	Julie	Taylor	532-43-9567	9567T	010	03-SS
05353	Cynthia	Clark	513-14-1316	1316C	023	03-SS
53052	Samantha	Oliver	414-13-8568	8568O	024	03-SS
52849	Ruth	Gibson	202-94-1163	1163G	010	03-SS
79916	Ronald	Wright	676-72-8337	8337W	016	01-SM
02177	Erica	Johnson	863-12-1931	1931J	009	03-SS
90419	Christine	Medina	021-91-8809	8809M	003	02-AM
70952	Michael	Price	040-24-8432	8432P	020	03-SS
42786	Katelyn	Williams	330-47-2012	2012W	013	03-SS
11239	Carla	Collins	796-49-8728	8728C	014	03-SS
55584	Lisa	Turner	607-16-4605	4605T	006	01-SM
36232	Cynthia	Collins	211-22-2024	2024C	015	03-SS
80739	Dylan	Ward	775-44-4426	4426W	021	01-SM
83502	Bobby	Hernandez	215-04-8942	8942H	018	03-SS
89299	Lori	Jones	206-50-2949	2949J	012	03-SS
32440	Christopher	Foley	472-58-1979	1979F	024	03-SS
34221	Natasha	Chambers	513-85-6292	6292C	014	03-SS
91765	Diane	Rodriguez	865-36-4774	4774R	021	03-SS
95907	Brandy	Turner	747-23-7990	7990T	022	03-SS
96268	Shannon	Sutton	621-84-6289	6289S	013	03-SS
74486	Isaac	Lynch	146-06-9563	9563L	021	03-SS
81903	Cheyenne	Dominguez	192-97-1518	1518D	011	03-SS
86956	Jennifer	Fox	389-87-1897	1897F	012	03-SS
34163	Chad	Davies	260-19-7679	7679D	013	03-SS
71027	Ricky	Fisher	505-62-2846	2846F	016	03-SS
42094	Patricia	Beck	084-04-0839	0839B	020	03-SS
49130	Laura	Harris	772-67-0271	0271H	001	02-AM
83060	David	Harmon	248-85-9343	9343H	007	02-AM
40694	Ann	Whitaker	375-49-5743	5743W	002	03-SS
55797	Ashley	Bridges	183-56-6938	6938B	003	01-SM
87783	Mary	Thomas	379-05-0351	0351T	005	03-SS
78307	Jasmine	Jacobs	050-80-3173	3173J	006	03-SS
12467	Carlos	Jones	758-15-0696	0696J	005	03-SS
47462	Ryan	Jones	020-49-4285	4285J	018	03-SS
12110	Erin	Griffin	095-17-6619	6619G	014	03-SS
02509	Christopher	Williams	741-40-9489	9489W	002	03-SS
46530	Don	Richard	607-46-3654	3654R	022	03-SS
00318	Thomas	Hunter	605-06-5677	5677H	019	03-SS
29812	Kenneth	Jones	055-65-0188	0188J	019	03-SS
64668	Xavier	Williams	028-12-8682	8682W	017	02-AM
88630	Judith	Hernandez	454-75-7727	7727H	001	01-SM
21820	Zoe	Arias	192-79-9320	9320A	009	03-SS
75340	Elizabeth	Meyer	522-49-8449	8449M	003	03-SS
67284	Katherine	Williamson	305-62-7183	7183W	015	03-SS
24619	Kelly	Gonzalez	240-57-8015	8015G	001	03-SS
33718	Nancy	Vaughn	348-12-3403	3403V	016	03-SS
08994	Lisa	Cooper	356-29-2458	2458C	018	03-SS
28070	Kevin	Brown	813-07-0477	0477B	015	03-SS
33869	Kelsey	Daniels	186-31-1446	1446D	015	03-SS
28729	Anthony	Durham	243-48-8193	8193D	007	02-AM
30519	Harold	Green	517-74-4011	4011G	002	03-SS
43959	Matthew	Day	540-65-0442	0442D	023	03-SS
98050	Melissa	Fisher	624-88-5008	5008F	018	03-SS
91933	Michael	Chavez	627-50-7890	7890C	011	03-SS
85128	Jeremy	Lynch	252-55-8652	8652L	012	03-SS
74537	Michael	Carr	362-78-3820	3820C	021	03-SS
67255	Norma	Farrell	247-55-0176	0176F	022	03-SS
47657	Samuel	Thompson	105-18-1842	1842T	023	03-SS
56475	Brittany	Mcintyre	114-38-5774	5774M	017	01-SM
45519	Kim	Ramirez	527-99-5491	5491R	000	03-SS
96624	Alexandra	Perez	566-26-7231	7231P	023	03-SS
39677	Rebecca	Wilson	170-87-9487	9487W	017	03-SS
06290	Kara	Wheeler	667-44-5750	5750W	018	03-SS
99784	Luis	Huff	865-86-9068	9068H	021	03-SS
46322	Christopher	Miranda	554-85-4703	4703M	006	03-SS
41908	Timothy	Wilson	291-46-8595	8595W	019	03-SS
49481	Vanessa	Garcia	071-87-1837	1837G	004	02-AM
21406	Beth	Medina	702-31-1697	1697M	000	03-SS
27733	Sandra	Russell	191-49-0442	0442R	002	03-SS
17781	Rachel	Farrell	516-32-0059	0059F	019	03-SS
54072	Michael	Reyes	670-32-1151	1151R	014	03-SS
16935	Shannon	Gonzalez	840-75-7302	7302G	002	03-SS
95993	Karen	Olson	563-76-9316	9316O	006	03-SS
40812	Sandra	Newman	206-35-9124	9124N	010	03-SS
81570	James	Alexander	306-08-5284	5284A	016	03-SS
67183	Andrew	Adams	793-08-0286	0286A	003	03-SS
92965	Amber	Baker	307-06-3638	3638B	016	03-SS
07373	Denise	Valenzuela	279-40-0886	0886V	000	03-SS
84950	Robert	Taylor	178-25-6043	6043T	008	03-SS
10729	Jason	Wilson	133-57-2126	2126W	017	03-SS
30004	Tom	Walker	178-24-1847	1847W	005	03-SS
95769	Megan	Martinez	393-35-1160	1160M	010	03-SS
21320	Michael	Bernard	509-87-9838	9838B	002	03-SS
58469	Samantha	Lee	145-30-8649	8649L	022	03-SS
35420	Nicholas	Owens	052-14-2466	2466O	012	03-SS
26020	Brian	Lawson	588-81-0229	0229L	015	03-SS
04934	Steven	Ford	529-53-0896	0896F	024	03-SS
71995	Marissa	Delacruz	188-75-2448	2448D	016	03-SS
03817	Jessica	Nicholson	792-64-6346	6346N	005	03-SS
90381	Cathy	Lane	098-13-4468	4468L	002	03-SS
82049	George	Doyle	218-33-5263	5263D	001	03-SS
96875	Michelle	Kramer	513-56-5356	5356K	003	03-SS
98399	Anne	Morgan	491-96-4896	4896M	003	03-SS
35207	Ariel	Morgan	324-16-7036	7036M	018	03-SS
94127	Diane	Green	216-48-5151	5151G	006	03-SS
86131	John	Johnson	724-29-6322	6322J	007	01-SM
47695	Lisa	Buck	403-78-1590	1590B	015	03-SS
53662	Ronnie	Payne	398-96-9786	9786P	024	03-SS
59515	Todd	Allen	332-38-8944	8944A	015	03-SS
15671	Kyle	Barry	167-70-9362	9362B	002	03-SS
71123	Lauren	Smith	339-95-5445	5445S	023	03-SS
91210	Jason	Reed	684-95-4841	4841R	014	03-SS
35369	Mitchell	Gonzalez	077-09-1919	1919G	000	03-SS
37287	Charles	Simpson	242-05-2226	2226S	023	03-SS
50177	Cindy	Brown	044-42-3995	3995B	012	03-SS
51197	Linda	Williams	107-45-0824	0824W	006	03-SS
53266	Erin	Garcia	267-32-8235	8235G	004	02-AM
24143	Laura	Mason	205-54-7664	7664M	024	03-SS
02007	Amy	Barrett	114-54-7681	7681B	017	03-SS
54957	Anita	King	019-44-2489	2489K	011	03-SS
69788	Courtney	Butler	267-97-9490	9490B	021	03-SS
20757	Christopher	Warren	291-09-3380	3380W	018	03-SS
56384	Alan	Ayala	421-36-5507	5507A	002	03-SS
55388	Jennifer	Cox	511-43-3347	3347C	003	03-SS
56516	James	Woods	699-69-2816	2816W	008	03-SS
34984	Christopher	Chapman	775-56-7450	7450C	007	03-SS
01106	James	Wiley	164-54-1324	1324W	009	03-SS
84005	David	Johnson	681-47-5439	5439J	006	03-SS
80586	Madeline	Gray	635-97-2192	2192G	018	03-SS
39158	Crystal	Ballard	127-24-7695	7695B	011	03-SS
16855	Katrina	Smith	231-54-5311	5311S	005	03-SS
40904	Paula	Lee	445-34-1049	1049L	020	03-SS
60005	Dominic	Phillips	776-55-9460	9460P	024	03-SS
31189	Denise	Lopez	321-43-9523	9523L	001	03-SS
93187	Patricia	Fields	134-64-8742	8742F	013	03-SS
55435	Victoria	Torres	795-62-7198	7198T	003	03-SS
08547	Allen	Stanley	781-40-5798	5798S	009	03-SS
86210	Tracy	Keller	026-37-4746	4746K	005	03-SS
21653	Tonya	Williams	876-34-3150	3150W	019	03-SS
92910	David	Lopez	692-77-6736	6736L	011	03-SS
67827	Marie	Wilson	027-78-9767	9767W	005	03-SS
76939	Daniel	Dennis	862-99-9183	9183D	005	03-SS
18105	Barbara	Nixon	538-21-2155	2155N	012	03-SS
24543	Anne	Howard	868-17-2012	2012H	009	03-SS
80628	James	Pacheco	529-59-1561	1561P	018	03-SS
47527	Carla	Jones	800-56-9562	9562J	021	03-SS
16256	Cameron	Molina	293-79-0992	0992M	024	03-SS
77236	Catherine	Ho	251-43-5649	5649H	024	03-SS
60569	Crystal	Huber	608-61-8790	8790H	023	03-SS
87798	Susan	Dean	427-93-8558	8558D	012	03-SS
48757	Michael	Moore	019-91-3952	3952M	005	03-SS
06538	Meghan	Mcdowell	791-72-7596	7596M	021	03-SS
04911	Beth	Sutton	536-50-5020	5020S	020	03-SS
52886	Corey	Reid	219-45-3227	3227R	001	03-SS
09637	Scott	Sullivan	709-68-2499	2499S	017	03-SS
09361	Nathan	Pope	190-19-0444	0444P	005	03-SS
49278	Todd	Martin	825-19-1608	1608M	011	03-SS
57594	Kathryn	White	672-95-3158	3158W	017	03-SS
53222	Kyle	Trujillo	836-88-8479	8479T	010	03-SS
25372	Michael	Evans	283-10-5696	5696E	015	03-SS
68727	Daniel	Payne	877-27-5392	5392P	004	01-SM
56245	Jeffrey	Mora	392-99-3720	3720M	005	03-SS
45574	Tyler	Golden	126-19-1656	1656G	008	03-SS
18132	Tyler	Johnson	202-22-3662	3662J	002	03-SS
97869	Kathryn	Barnes	839-90-4688	4688B	003	03-SS
69882	Marcus	Rosario	481-55-7932	7932R	008	03-SS
34469	Joseph	Jackson	775-95-5550	5550J	013	03-SS
96913	Sabrina	Harris	676-70-8281	8281H	024	03-SS
91314	Jose	Watts	837-06-7802	7802W	011	03-SS
10675	Kristin	Anderson	702-66-9875	9875A	013	03-SS
80815	Kathleen	Patel	084-12-3713	3713P	010	03-SS
66760	Dylan	Baker	317-83-3188	3188B	020	03-SS
48859	Megan	Carpenter	274-25-3404	3404C	004	03-SS
14527	Angela	Duncan	885-10-7247	7247D	017	03-SS
52951	Dana	Hamilton	707-29-7491	7491H	005	03-SS
43277	Paul	Anthony	603-44-7195	7195A	011	03-SS
65981	Anthony	Hall	882-78-4747	4747H	005	03-SS
96453	Sara	Robles	580-92-0660	0660R	018	03-SS
83105	Nicholas	Jones	460-95-6796	6796J	024	03-SS
49098	Kevin	Lane	504-14-4963	4963L	024	03-SS
54666	Justin	Snyder	490-56-6971	6971S	013	03-SS
54860	Ryan	Johnson	269-07-9531	9531J	024	03-SS
22934	Rebecca	Anderson	034-69-7164	7164A	004	03-SS
01466	Joshua	Levy	751-74-8911	8911L	017	03-SS
01427	Linda	Nichols	463-76-5191	5191N	003	03-SS
08378	Stanley	Bonilla	823-68-7372	7372B	009	03-SS
84385	Tiffany	Hernandez	264-75-3733	3733H	010	03-SS
04606	Justin	Cruz	078-69-1305	1305C	017	03-SS
39668	Steven	Richmond	071-77-5613	5613R	022	03-SS
00274	James	Mueller	411-45-8122	8122M	012	03-SS
93924	Danny	Owens	123-76-2870	2870O	020	03-SS
23264	Nicole	Hall	509-27-3408	3408H	008	03-SS
13746	Joshua	Barnes	058-04-0219	0219B	004	03-SS
40098	Jasmin	Davis	677-71-2336	2336D	000	03-SS
66085	Thomas	Kaiser	662-64-3892	3892K	011	03-SS
05962	Charles	Wilson	468-98-8203	8203W	005	03-SS
75184	William	Smith	253-85-5858	5858S	004	03-SS
42483	Stephanie	Johnson	367-92-3347	3347J	012	03-SS
03699	Steven	Mason	054-83-3860	3860M	008	03-SS
91329	Ashley	Evans	852-02-2303	2303E	013	03-SS
74951	Kevin	Johnston	690-22-0642	0642J	004	03-SS
72527	Darlene	Greene	037-89-0765	0765G	002	03-SS
62002	Angel	Terrell	102-70-9012	9012T	004	03-SS
84840	Raymond	Love	357-62-8127	8127L	001	03-SS
03313	Scott	Singh	086-31-1852	1852S	009	03-SS
40815	Dustin	Arnold	485-41-0074	0074A	012	03-SS
63787	Jessica	Larson	109-43-2417	2417L	023	03-SS
63312	Nathaniel	Hernandez	889-19-1929	1929H	022	03-SS
86550	James	Roberts	351-52-9869	9869R	021	03-SS
96723	Andre	Khan	092-21-8513	8513K	023	03-SS
65716	Ronald	Patel	078-58-2215	2215P	010	03-SS
76051	Stephen	Hall	526-77-6112	6112H	006	03-SS
78222	Wendy	Long	566-21-8967	8967L	002	03-SS
96350	Alejandro	Ramsey	186-90-5986	5986R	013	03-SS
42737	Lee	Mccormick	526-13-5392	5392M	010	03-SS
73212	Daniel	Preston	617-80-0230	0230P	023	03-SS
75760	Rachel	Murray	190-86-9655	9655M	023	03-SS
05930	Savannah	Johnson	786-34-0472	0472J	019	03-SS
38462	Patricia	Roberts	670-38-8786	8786R	022	03-SS
87304	Gregory	Hill	616-26-2915	2915H	012	03-SS
52337	Tina	Brooks	485-28-1400	1400B	014	03-SS
68169	Matthew	Bishop	188-17-4281	4281B	006	03-SS
09332	Nancy	Reyes	123-45-6789	f	999	99-HQ
\.


--
-- Data for Name: positions; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY positions (pos_id, title) FROM stdin;
02-AM	Assistant Manager
10-DM	District Manager
01-SM	Store Manager
03-SS	Sales Associate
99-HQ	Corporate Admin
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY posts (post_id, title, date, text, audience, emp_id) FROM stdin;
1	Hello dummy	2017-11-09 01:15:56.779188	BOO YEAH!	ALL	09332
2	Hello dummy	2017-11-09 01:16:14.105705	BOO YEAH!	ALL	09332
3	I am delirious	2017-11-09 01:18:32.471497	This is now going to serve as a log for myself. I think. Let's see how long I can make this.	ALL	09332
4	Hi dingdong	2017-11-09 01:57:25.285524	HOWLDY THERE	D01	09332
\.


--
-- Name: posts_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('posts_post_id_seq', 4, true);


--
-- Data for Name: stores; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY stores (store_id, name, address, phone, district_id) FROM stdin;
000	Lee Cliffs Mall	32423 Tammy Parkway Apt. 489\nLake Christopherborough, CO 15589-0388	(308) 037-5965	D01
001	Garner Point Mall	Unit 5048 Box 7994\nDPO AE 42272	(465) 945-3403	D01
002	Riley Prairie Mall	4872 Miller Mills\nLake Craig, WY 58465-2906	(886) 741-9878	D01
003	Pena Brooks Mall	139 Mcintosh Loaf Apt. 947\nJesseburgh, NJ 08220-1789	(369) 485-8934	D03
004	Robinson Shores Mall	130 Reed Trace\nTeresatown, AZ 34973-0198	(698) 935-3341	D99
005	Chambers Inlet Mall	891 Trevor Highway\nJenniferside, OH 94940	(259) 690-5970	D01
006	Andrew Forges Mall	451 Jimenez Port Apt. 118\nLake Joel, NY 67858	(021) 747-3494	D03
007	Sharp Views Mall	4842 Hutchinson Square\nLake Heather, FM 07590	(567) 196-3055	ALL
008	Berger Village Mall	655 Jennifer Cove\nHalebury, MD 35980-7157	(619) 669-3060	D05
009	William Wells Mall	0880 George Ways\nWest Juliechester, CT 06320-0331	(633) 393-8649	D99
010	Mark Island Mall	2061 Ballard Shores\nWest Kayla, UT 35787	(675) 541-9567	D03
011	Rebecca Square Mall	78535 Alicia Mission\nChristianport, OK 39714-7426	(552) 732-3192	D99
012	Camacho Villages Mall	106 Marcus Knoll Apt. 104\nHannahchester, NE 72087-2155	(491) 739-5206	D99
013	Howard Shore Mall	406 Cassandra Springs Apt. 247\nLake Jesseborough, DC 11745-4160	(125) 952-9493	ALL
014	Watts Meadow Mall	0012 Travis Manor Suite 934\nRichardville, OK 26689	(186) 660-7192	ALL
015	Le Extension Mall	732 Hood Turnpike Apt. 693\nBennettview, NC 72138	(040) 113-0798	D05
016	Campos Light Mall	3634 Schneider Port Apt. 165\nNew Joshuashire, AS 14139	(153) 641-2999	D99
017	Sarah Views Mall	299 Butler Cape\nJacksonbury, PW 57519-0940	(834) 989-2940	D04
018	Fitzgerald Viaduct Mall	275 Jennifer Fall\nNew Joeshire, VT 21133-4324	(068) 080-6035	D03
019	Taylor Extensions Mall	2858 Cruz Island\nStephanieside, FL 70155	(280) 096-6759	D03
020	Collins Cliff Mall	45290 Mitchell Loaf Apt. 758\nWalkerburgh, MP 67869-6626	(156) 561-6071	D05
021	Tara Land Mall	6304 Benson Field\nEast James, OR 74996-7180	(038) 554-7417	D99
022	Kimberly Pike Mall	09147 Carson Mill Suite 840\nKristineshire, OK 31954	(083) 977-8821	D01
023	Victor Loop Mall	120 Moss Manors\nNew Matthewville, TX 93273-1600	(123) 316-4807	ALL
024	Porter Haven Mall	1060 Farmer Tunnel\nEast Kathleenland, MN 65559	(255) 904-4112	D02
999	Corporate Headquarters	123 Main Street\nAnywhere, USA 12345	(415) 555-1234	D99
\.


--
-- Data for Name: was_read; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY was_read (post_id, emp_id, was_read) FROM stdin;
\.


--
-- Name: action_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY action
    ADD CONSTRAINT action_pkey PRIMARY KEY (post_id);


--
-- Name: districts_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY districts
    ADD CONSTRAINT districts_pkey PRIMARY KEY (district_id);


--
-- Name: employees_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (emp_id);


--
-- Name: positions_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY positions
    ADD CONSTRAINT positions_pkey PRIMARY KEY (pos_id);


--
-- Name: posts_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (post_id);


--
-- Name: stores_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (store_id);


--
-- Name: was_read_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY was_read
    ADD CONSTRAINT was_read_pkey PRIMARY KEY (post_id);


--
-- Name: action_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY action
    ADD CONSTRAINT action_post_id_fkey FOREIGN KEY (post_id) REFERENCES posts(post_id);


--
-- Name: employees_pos_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY employees
    ADD CONSTRAINT employees_pos_id_fkey FOREIGN KEY (pos_id) REFERENCES positions(pos_id);


--
-- Name: employees_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY employees
    ADD CONSTRAINT employees_store_id_fkey FOREIGN KEY (store_id) REFERENCES stores(store_id);


--
-- Name: posts_emp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_emp_id_fkey FOREIGN KEY (emp_id) REFERENCES employees(emp_id);


--
-- Name: stores_district_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY stores
    ADD CONSTRAINT stores_district_id_fkey FOREIGN KEY (district_id) REFERENCES districts(district_id);


--
-- Name: was_read_emp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY was_read
    ADD CONSTRAINT was_read_emp_id_fkey FOREIGN KEY (emp_id) REFERENCES employees(emp_id);


--
-- Name: was_read_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY was_read
    ADD CONSTRAINT was_read_post_id_fkey FOREIGN KEY (post_id) REFERENCES posts(post_id);


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

