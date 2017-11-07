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
    comm_id integer NOT NULL,
    complete boolean,
    assigner character varying(5),
    assignee character varying(5)
);


ALTER TABLE action OWNER TO vagrant;

--
-- Name: comms; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE comms (
    comm_id integer NOT NULL,
    title character varying(75) NOT NULL,
    date timestamp without time zone NOT NULL,
    text text NOT NULL,
    audience character varying(3),
    pos_id character varying(5)
);


ALTER TABLE comms OWNER TO vagrant;

--
-- Name: comms_comm_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE comms_comm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comms_comm_id_seq OWNER TO vagrant;

--
-- Name: comms_comm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE comms_comm_id_seq OWNED BY comms.comm_id;


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
    comm_id integer NOT NULL,
    emp_id character varying(5) NOT NULL,
    was_read boolean NOT NULL
);


ALTER TABLE was_read OWNER TO vagrant;

--
-- Name: comm_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY comms ALTER COLUMN comm_id SET DEFAULT nextval('comms_comm_id_seq'::regclass);


--
-- Data for Name: action; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY action (comm_id, complete, assigner, assignee) FROM stdin;
\.


--
-- Data for Name: comms; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY comms (comm_id, title, date, text, audience, pos_id) FROM stdin;
\.


--
-- Name: comms_comm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('comms_comm_id_seq', 1, false);


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
18988	Alyssa	Johnson	469-42-8960	8960J	020	02-AM
78602	Mary	Drake	754-83-5381	5381D	020	02-AM
10741	Johnny	Long	771-51-9270	9270L	011	02-AM
98864	Sue	Evans	739-23-1659	1659E	006	02-AM
37240	Andrew	Wheeler	132-63-0613	0613W	008	02-AM
17555	Kevin	Fox	109-52-8504	8504F	009	02-AM
56859	Anne	Chapman	168-52-3351	3351C	012	02-AM
46861	Rhonda	Steele	140-21-3239	3239S	024	02-AM
17592	Jennifer	Oconnell	880-66-1505	1505O	021	02-AM
64864	Phillip	Ingram	106-05-3947	3947I	020	01-SM
66730	Henry	Crawford	182-37-0829	0829C	022	02-AM
76335	Ashley	Powell	175-48-6673	6673P	003	02-AM
45917	Eric	Hunter	337-54-7761	7761H	007	02-AM
42917	Kara	Allen	798-14-3262	3262A	016	02-AM
4897	Paul	Parker	818-52-0103	0103P	006	02-AM
4154	Diana	Anderson	629-58-4424	4424A	007	02-AM
82832	Maria	Bailey	374-36-0800	0800B	021	02-AM
19948	Nathan	Hernandez	495-77-8715	8715H	023	02-AM
48262	Michael	Duncan	394-62-2846	2846D	015	02-AM
81567	Steven	Perez	667-91-4414	4414P	018	02-AM
52057	Jessica	Johnson	582-66-9393	9393J	006	01-SM
58352	Heather	Watson	276-23-7324	7324W	002	02-AM
45265	Courtney	Smith	184-55-5800	5800S	021	01-SM
26170	Justin	Ochoa	573-32-4019	4019O	009	02-AM
56372	Jerry	Jones	103-30-1854	1854J	011	02-AM
79777	Emily	Gamble	750-82-2848	2848G	024	02-AM
10536	David	Walters	760-31-4699	4699W	024	01-SM
92396	Amy	Thompson	233-08-6139	6139T	020	03-SS
71611	Lauren	Doyle	880-81-9752	9752D	018	02-AM
48127	Robert	Barker	342-38-2784	2784B	004	02-AM
17047	Wendy	Miranda	592-41-6970	6970M	003	02-AM
69900	Kristin	Wagner	419-95-3935	3935W	004	02-AM
26548	Jennifer	Miller	356-64-9587	9587M	022	02-AM
49771	Brian	Webb	526-82-5700	5700W	006	03-SS
99344	Erin	Roberts	232-54-3820	3820R	008	02-AM
30328	Jillian	Ortiz	074-99-4890	4890O	023	02-AM
94613	Michael	Bates	252-54-4266	4266B	017	02-AM
38636	Robert	Berry	368-72-8549	8549B	017	02-AM
87508	Brittany	Thomas	239-44-6844	6844T	016	02-AM
99308	Michael	Cline	834-86-8660	8660C	020	03-SS
76480	David	Cruz	576-22-5512	5512C	006	03-SS
19335	Charles	Serrano	648-87-8999	8999S	002	02-AM
56134	Emily	Diaz	692-23-8206	8206D	006	03-SS
80514	Vanessa	Shaw	658-48-2540	2540S	024	03-SS
34220	Karen	Green	726-90-3692	3692G	017	01-SM
97518	Craig	Mckee	225-31-0882	0882M	003	01-SM
75953	Jessica	Fitzgerald	627-72-0444	0444F	008	01-SM
29131	Valerie	Anderson	812-45-7243	7243A	007	01-SM
66637	Katie	Thomas	272-10-0407	0407T	023	01-SM
1619	Ronald	Whitaker	363-03-9116	9116W	006	03-SS
92328	Jennifer	Hernandez	366-18-2931	2931H	001	02-AM
30600	Brian	Dalton	017-13-3714	3714D	015	02-AM
22757	Sara	Reeves	455-29-3304	3304R	015	01-SM
44871	Jennifer	Mcneil	896-08-4524	4524M	002	01-SM
10150	Cynthia	Jones	142-82-1712	1712J	011	01-SM
69396	Steve	Horn	498-49-7818	7818H	017	03-SS
49514	Samantha	Duke	774-05-8765	8765D	016	01-SM
82017	Lindsay	Drake	370-41-8806	8806D	022	01-SM
91722	Charles	Smith	613-99-3740	3740S	002	03-SS
86405	Jocelyn	Garcia	145-98-6144	6144G	009	01-SM
62662	Christopher	Taylor	460-51-4431	4431T	006	03-SS
64390	Carl	Roberson	472-13-8613	8613R	023	03-SS
94288	Jennifer	Cole	580-65-6382	6382C	017	03-SS
32309	Jeremy	West	330-90-8255	8255W	010	02-AM
70113	Christina	Hutchinson	131-63-6700	6700H	020	03-SS
71145	Jesse	Reilly	438-80-6299	6299R	008	03-SS
3500	Pamela	Mckay	815-31-0890	0890M	019	02-AM
36630	Edward	Williams	317-46-5578	5578W	024	03-SS
8268	Melissa	Edwards	765-46-6179	6179E	004	01-SM
86545	Jessica	Hernandez	204-32-6925	6925H	017	03-SS
8470	Kathleen	Ferguson	361-93-2401	2401F	023	03-SS
23575	Nicole	Porter	822-27-4725	4725P	006	03-SS
58983	Mark	Moore	630-82-5945	5945M	015	03-SS
99890	Monica	Saunders	770-51-9643	9643S	021	03-SS
82573	Renee	Cooper	470-72-6695	6695C	009	03-SS
16117	Kevin	Carpenter	497-28-4999	4999C	011	03-SS
56834	Robert	Smith	859-79-3105	3105S	005	02-AM
18621	David	Gould	436-70-3054	3054G	015	03-SS
82689	James	Bridges	422-13-6507	6507B	008	03-SS
43795	Marie	Griffin	841-96-3105	3105G	013	02-AM
36946	Manuel	Murphy	526-97-8604	8604M	008	03-SS
24107	Jennifer	Gonzalez	864-18-5990	5990G	016	03-SS
18811	Alexander	White	078-87-4936	4936W	010	02-AM
50475	Christine	Phillips	757-24-2645	2645P	020	03-SS
28280	Jasmine	Murray	582-48-3027	3027M	001	02-AM
24710	Melissa	Barrett	670-43-0877	0877B	001	01-SM
92684	Sarah	Faulkner	011-22-7068	7068F	008	03-SS
47213	Kathleen	Dixon	282-85-9595	9595D	021	03-SS
46517	Brandon	Hamilton	256-95-8845	8845H	013	02-AM
97706	Leslie	Carter	198-71-5121	5121C	013	01-SM
11209	Michelle	Marshall	469-27-4663	4663M	022	03-SS
9420	Mark	Odom	661-22-5556	5556O	006	03-SS
23393	Barbara	Rodriguez	601-16-4787	4787R	002	03-SS
75332	William	Young	610-32-1543	1543Y	011	03-SS
19305	Adriana	Ingram	724-99-8092	8092I	016	03-SS
10415	Lisa	Collins	249-07-0084	0084C	009	03-SS
87215	Michael	Perez	080-57-7766	7766P	005	02-AM
63504	Ralph	Fisher	268-86-7456	7456F	013	03-SS
2691	Ashley	Roman	165-80-5578	5578R	009	03-SS
86074	Joseph	King	074-98-5134	5134K	015	03-SS
83410	Jessica	Bell	809-23-9351	9351B	015	03-SS
8974	Molly	Avila	115-68-2806	2806A	020	03-SS
7552	Sean	Ramos	829-12-6175	6175R	018	01-SM
72211	Robert	Brown	560-24-9032	9032B	016	03-SS
24121	Jeffrey	Gordon	141-22-0616	0616G	006	03-SS
78469	Sara	Cooper	127-16-7544	7544C	021	03-SS
91654	Richard	Harris	240-29-6186	6186H	015	03-SS
95258	Kevin	Henry	109-87-4654	4654H	021	03-SS
80905	Brianna	Mclaughlin	560-34-4573	4573M	002	03-SS
28584	Andrew	Hayden	762-71-8293	8293H	019	02-AM
49336	Andrea	Parrish	242-18-1884	1884P	022	03-SS
16218	Andrea	Mccormick	738-19-1686	1686M	018	03-SS
92122	Lisa	Ryan	456-96-9863	9863R	021	03-SS
11722	Mark	Perez	005-48-5025	5025P	019	01-SM
10869	Gary	Benson	367-34-7719	7719B	019	03-SS
18933	Paul	Horn	374-89-3078	3078H	004	03-SS
70858	Bryan	Powers	664-07-5915	5915P	010	01-SM
91686	Christian	Lewis	078-48-7401	7401L	001	03-SS
32518	Ashley	Williamson	364-87-5438	5438W	009	03-SS
75974	Thomas	Bradshaw	034-97-3002	3002B	005	01-SM
17297	James	Todd	186-47-3442	3442T	009	03-SS
22712	Nicole	Winters	704-45-2888	2888W	018	03-SS
51715	Daniel	Johnson	669-50-4895	4895J	009	03-SS
52568	Shaun	Smith	530-19-9383	9383S	016	03-SS
69986	Larry	Ochoa	191-28-5305	5305O	019	03-SS
13774	Justin	Freeman	118-19-3447	3447F	016	03-SS
66801	Rachel	Price	617-74-9383	9383P	005	03-SS
51415	Carlos	Dickerson	383-97-3445	3445D	014	02-AM
93047	Megan	Pierce	353-08-0241	0241P	024	03-SS
19502	Jeanette	Phillips	188-92-4792	4792P	019	03-SS
59963	William	Lewis	523-40-8258	8258L	021	03-SS
57473	Dana	Drake	636-36-6675	6675D	020	03-SS
7736	Robert	Long	703-88-8434	8434L	008	03-SS
57402	Andrew	Harrell	210-39-5419	5419H	007	03-SS
54656	Kelsey	Hughes	233-15-2373	2373H	002	03-SS
872	Kyle	Lambert	399-92-7224	7224L	008	03-SS
94248	Joshua	Anderson	615-49-1553	1553A	008	03-SS
91150	Adrian	Malone	425-70-7582	7582M	006	03-SS
63523	Alicia	Daniels	458-02-9980	9980D	022	03-SS
92923	Carolyn	Foster	469-84-8548	8548F	017	03-SS
32336	Vincent	Martinez	367-31-4036	4036M	005	03-SS
29102	James	Dean	431-79-2859	2859D	005	03-SS
2380	David	Parker	040-26-4965	4965P	001	03-SS
39829	Angela	Lawrence	708-27-9082	9082L	021	03-SS
73875	Brianna	Cardenas	251-47-6175	6175C	002	03-SS
39108	Laura	Kelley	087-32-8103	8103K	013	03-SS
13371	Nicholas	Gray	734-20-0514	0514G	003	03-SS
83985	Mark	Murphy	427-93-9427	9427M	020	03-SS
88111	Regina	Wilson	749-52-1384	1384W	006	03-SS
94947	Carl	Thompson	638-49-0832	0832T	006	03-SS
13210	Kyle	Holland	528-90-3764	3764H	015	03-SS
19118	Erin	Ray	692-36-0383	0383R	023	03-SS
13154	Brandon	Haynes	645-38-0107	0107H	011	03-SS
86813	Emily	Clark	334-43-3531	3531C	022	03-SS
16849	Alex	Anthony	879-62-6354	6354A	012	02-AM
43176	Sandra	Collins	357-71-0085	0085C	023	03-SS
965	Joshua	Livingston	439-36-9984	9984L	020	03-SS
17841	Stephanie	Williams	474-20-7969	7969W	011	03-SS
78085	Garrett	Stevens	776-27-9709	9709S	022	03-SS
43707	Donna	Baldwin	159-31-8221	8221B	004	03-SS
76524	Rebecca	Jones	856-32-2999	2999J	023	03-SS
8115	Brandon	Barrera	560-32-7208	7208B	023	03-SS
63526	Breanna	Mendoza	771-55-7549	7549M	012	01-SM
10737	Deanna	Fields	837-62-8975	8975F	015	03-SS
28052	Carolyn	Hunt	581-66-4285	4285H	024	03-SS
59142	Candace	Davidson	738-69-5135	5135D	008	03-SS
83296	Michael	Rasmussen	454-27-4441	4441R	010	03-SS
53865	Samuel	Wells	797-22-4970	4970W	001	03-SS
34596	Daniel	Moore	038-61-4061	4061M	019	03-SS
84260	Donald	Torres	165-26-3730	3730T	011	03-SS
62907	Michael	Smith	762-90-1770	1770S	012	03-SS
69753	Toni	Thompson	768-38-3335	3335T	019	03-SS
98635	Timothy	Murillo	700-56-8290	8290M	023	03-SS
86230	Brandon	Hurst	764-47-2470	2470H	003	03-SS
94599	Natalie	Benitez	400-54-1802	1802B	010	03-SS
98018	Amanda	Patton	754-10-5083	5083P	021	03-SS
13507	Pamela	Taylor	087-74-1271	1271T	001	03-SS
4843	Stephanie	Castillo	464-91-8750	8750C	007	03-SS
56731	Jacob	Grimes	814-55-6785	6785G	005	03-SS
88740	Laura	Daniels	490-42-4482	4482D	006	03-SS
35206	Amanda	Christian	090-51-1535	1535C	011	03-SS
92256	Justin	Stewart	486-39-8740	8740S	003	03-SS
92193	Lisa	Grant	543-48-7900	7900G	015	03-SS
17546	Katherine	Bell	242-57-5839	5839B	017	03-SS
70151	Megan	Coleman	354-41-8436	8436C	011	03-SS
33186	Anthony	Villarreal	440-27-5309	5309V	015	03-SS
48026	Joshua	Keller	532-26-1666	1666K	015	03-SS
116	Jonathon	Stone	511-02-1573	1573S	015	03-SS
55711	Annette	Davis	465-67-6094	6094D	024	03-SS
72459	Charlotte	Cruz	452-02-6208	6208C	008	03-SS
21380	Douglas	Schaefer	032-35-3798	3798S	011	03-SS
23509	Laura	Miller	896-66-8229	8229M	010	03-SS
3994	Darius	Thompson	474-91-6529	6529T	012	03-SS
55505	Monique	Good	037-70-6573	6573G	012	03-SS
42434	Michael	Mcpherson	516-60-1371	1371M	012	03-SS
65686	Natalie	Blackburn	280-27-8357	8357B	016	03-SS
62619	Stephanie	Woods	208-95-9437	9437W	022	03-SS
33972	Brian	Casey	655-31-6228	6228C	016	03-SS
77722	Susan	Owen	352-21-9101	9101O	015	03-SS
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
-- Data for Name: stores; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY stores (store_id, name, address, phone, district_id) FROM stdin;
001	John Isle Mall	1452 Kristina Overpass\nNew Jamesmouth, LA 97104-2911	(469) 630-0147	D03
002	Jennifer Mission Mall	773 Sheppard Light Apt. 518\nBakerside, MA 47912-7431	(869) 324-6129	D01
003	Jonathan Island Mall	PSC 1707, Box 1745\nAPO AP 16515-2836	(318) 230-5443	D03
004	Young Center Mall	USNS Oconnell\nFPO AE 44703	(231) 080-9760	D99
005	Pitts Course Mall	48593 Graham Creek\nSouth Renee, CT 84712	(462) 710-6094	D05
006	Hernandez Vista Mall	745 Nathaniel Curve\nRileyhaven, VI 57197	(101) 935-7971	D99
007	Jason Landing Mall	583 Jose Loop\nNorth Reneeport, PW 62173	(769) 277-8568	ALL
008	Randall Walks Mall	52211 Jeff Burgs\nWest Courtneyview, LA 74542-8266	(584) 950-5585	D02
009	Crane Street Mall	USNV Dawson\nFPO AA 14006	(893) 634-1320	D99
010	Wright Circles Mall	440 Ashley Valleys Apt. 693\nCarlaberg, ID 88786-2924	(067) 585-2623	D03
011	Anderson Locks Mall	62907 Clay Brooks Apt. 025\nJamesfort, MH 50930-0393	(921) 914-5101	D01
012	William Prairie Mall	54888 Rodriguez Valley Apt. 242\nGarciaburgh, OH 28506-0453	(813) 752-9167	D05
013	Watson Walks Mall	45107 Stephen Village Apt. 192\nSouth Patricia, TN 62267-6851	(558) 427-4221	D04
014	Caroline Forge Mall	081 Christopher Union Suite 241\nNorth Ryan, IA 73906-8837	(780) 658-6646	D01
015	Davis Mountain Mall	78224 Robinson Ford\nKathleenfort, WA 99271	(268) 980-5747	D01
016	Christopher Shoals Mall	070 Timothy Spurs\nPort Stephanieburgh, SD 06581-9728	(947) 799-4547	D02
017	Harrison Pike Mall	Unit 3085 Box 0035\nDPO AE 53497-6964	(685) 739-4880	D02
018	Williams Via Mall	01063 James Isle\nWest Nancy, CA 86828	(431) 126-3565	ALL
019	Richardson Islands Mall	5218 Barry Canyon Suite 969\nBushville, IL 87900-5352	(224) 947-9444	D02
020	Ramirez Mountains Mall	028 Corey Extensions\nLauraland, VI 07337-9537	(256) 885-1432	D03
021	Gray Islands Mall	PSC 7098, Box 7809\nAPO AP 70141	(022) 376-1355	D05
022	Fernandez Mill Mall	4233 Moore Spring\nLake Keithmouth, IL 49407-8507	(909) 096-8636	D01
023	Williams Fort Mall	3457 Ryan Locks Apt. 732\nNorth Emily, AS 70429	(456) 900-8667	D04
024	Michael Ridge Mall	824 Wood Plaza\nDanielfurt, FL 79590	(435) 150-3004	ALL
999	Corporate Headquarters	123 Main Street\nAnywhere, USA 12345	(415) 555-1234	D99
\.


--
-- Data for Name: was_read; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY was_read (comm_id, emp_id, was_read) FROM stdin;
\.


--
-- Name: action_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY action
    ADD CONSTRAINT action_pkey PRIMARY KEY (comm_id);


--
-- Name: comms_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY comms
    ADD CONSTRAINT comms_pkey PRIMARY KEY (comm_id);


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
-- Name: stores_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (store_id);


--
-- Name: was_read_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY was_read
    ADD CONSTRAINT was_read_pkey PRIMARY KEY (comm_id);


--
-- Name: action_comm_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY action
    ADD CONSTRAINT action_comm_id_fkey FOREIGN KEY (comm_id) REFERENCES comms(comm_id);


--
-- Name: comms_pos_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY comms
    ADD CONSTRAINT comms_pos_id_fkey FOREIGN KEY (pos_id) REFERENCES positions(pos_id);


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
-- Name: stores_district_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY stores
    ADD CONSTRAINT stores_district_id_fkey FOREIGN KEY (district_id) REFERENCES districts(district_id);


--
-- Name: was_read_comm_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY was_read
    ADD CONSTRAINT was_read_comm_id_fkey FOREIGN KEY (comm_id) REFERENCES comms(comm_id);


--
-- Name: was_read_emp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY was_read
    ADD CONSTRAINT was_read_emp_id_fkey FOREIGN KEY (emp_id) REFERENCES employees(emp_id);


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

