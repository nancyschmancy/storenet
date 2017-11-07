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
02379	Sandra	Gordon	257-01-7493	7493G	024	02-AM
66277	Elizabeth	Walker	398-86-8785	8785W	022	02-AM
20730	Maxwell	Tucker	273-86-0982	0982T	021	02-AM
52252	Jeanne	Ryan	360-67-3843	3843R	003	02-AM
68602	Kevin	Gonzalez	471-10-5440	5440G	008	02-AM
98762	Emily	Stevens	807-01-0599	0599S	003	02-AM
22542	Christopher	Gilbert	475-48-5721	5721G	007	02-AM
44118	Logan	Miller	474-77-5118	5118M	003	01-SM
53964	Gary	Medina	224-41-9270	9270M	024	02-AM
90959	Tamara	Hall	066-25-7083	7083H	013	02-AM
75982	Thomas	Monroe	076-21-9146	9146M	013	02-AM
05578	Christopher	Thomas	445-97-1629	1629T	017	02-AM
86719	Brittney	Johnson	009-65-1245	1245J	020	02-AM
27984	Amy	Craig	077-31-7999	7999C	004	02-AM
27757	Gregory	Lutz	792-43-2086	2086L	009	02-AM
41276	Melvin	Morrow	332-51-8230	8230M	022	02-AM
80753	William	Osborne	815-42-1664	1664O	008	02-AM
60494	Brenda	Morris	832-95-7060	7060M	006	02-AM
56832	Renee	Thompson	483-68-9926	9926T	005	02-AM
73355	Christopher	Murphy	717-45-1216	1216M	022	01-SM
28987	Doris	Snow	131-11-3311	3311S	012	02-AM
23463	William	Moore	123-44-5637	5637M	004	02-AM
00291	Shelly	Rogers	450-73-3479	3479R	001	02-AM
64012	Jeffrey	Bridges	179-77-5051	5051B	016	02-AM
16076	Angela	Myers	042-34-1883	1883M	022	03-SS
36963	John	Townsend	777-36-9786	9786T	017	02-AM
18262	Susan	Good	595-60-4816	4816G	022	03-SS
72558	Brittany	Travis	547-79-5394	5394T	002	02-AM
60918	Christopher	Wade	164-67-4758	4758W	020	02-AM
30638	Michelle	Hernandez	401-63-5104	5104H	021	02-AM
66944	John	Craig	787-90-8429	8429C	001	02-AM
45641	Patricia	Petersen	796-83-0367	0367P	001	01-SM
26616	Jessica	Payne	682-32-1234	1234P	007	02-AM
32712	Laura	Lee	179-16-4946	4946L	003	03-SS
44907	Gabrielle	Perkins	331-23-8554	8554P	019	02-AM
39049	Diamond	Gill	626-43-0320	0320G	013	01-SM
80044	Jacob	Thornton	733-44-3304	3304T	016	02-AM
08568	Laura	Cabrera	529-88-1635	1635C	017	01-SM
91158	Ashley	Carter	680-69-6695	6695C	016	01-SM
06041	Christina	Hayes	017-39-6386	6386H	008	01-SM
64230	Heather	Charles	645-01-4507	4507C	023	02-AM
41151	Carmen	Palmer	766-86-0612	0612P	012	02-AM
11814	Kevin	Tran	236-17-7247	7247T	002	02-AM
90939	Michelle	Huff	432-31-7267	7267H	003	03-SS
72035	Eddie	Williams	127-38-6025	6025W	013	03-SS
74321	Angela	Burns	147-43-3148	3148B	006	02-AM
12387	Christopher	Johnson	493-90-6603	6603J	023	02-AM
58728	John	Brennan	170-11-7526	7526B	022	03-SS
03074	Joseph	Hayden	319-98-6810	6810H	016	03-SS
57924	Katrina	Miller	762-92-6694	6694M	006	01-SM
78822	Cassie	Brown	351-18-6201	6201B	007	01-SM
46851	Timothy	Calderon	662-45-9888	9888C	023	01-SM
90950	Sherri	Sellers	378-75-8939	8939S	014	02-AM
55151	Martha	Lawrence	635-14-7962	7962L	013	03-SS
10288	Zachary	Underwood	101-48-9905	9905U	018	02-AM
32166	Alexis	Grimes	481-64-0714	0714G	016	03-SS
06330	Crystal	Mckenzie	419-61-5362	5362M	006	03-SS
34992	Stephanie	Brennan	148-05-5528	5528B	010	02-AM
18231	Krystal	Reed	553-48-7539	7539R	019	02-AM
83144	Rebekah	Moore	066-20-6293	6293M	013	03-SS
00960	Dalton	Bell	400-67-0987	0987B	010	02-AM
01649	Steven	Wolf	381-87-2250	2250W	003	03-SS
74555	Justin	Turner	139-99-3637	3637T	011	02-AM
56086	Jamie	Kelly	274-10-5503	5503K	020	01-SM
37431	Christopher	Villegas	572-02-9020	9020V	018	02-AM
23442	David	Perez	564-08-3133	3133P	022	03-SS
71871	James	Brown	743-15-9087	9087B	008	03-SS
35796	Andrew	Brady	763-48-9917	9917B	007	03-SS
42135	Lisa	Rodriguez	514-29-5681	5681R	016	03-SS
24161	Jennifer	Thompson	022-60-9146	9146T	020	03-SS
12044	Joel	Wheeler	629-86-6479	6479W	015	02-AM
21160	Sharon	Adams	873-47-2837	2837A	007	03-SS
13002	Travis	Washington	113-76-1922	1922W	006	03-SS
64665	Frederick	Carroll	695-69-5151	5151C	006	03-SS
08207	James	Fox	133-28-0694	0694F	021	01-SM
78013	Kevin	Chandler	465-39-9677	9677C	003	03-SS
99780	Sergio	Bailey	149-77-3652	3652B	002	01-SM
20241	Michael	Barnett	868-10-5048	5048B	016	03-SS
58841	Diamond	Manning	540-72-3927	3927M	014	02-AM
56705	Renee	Sanchez	881-57-1623	1623S	002	03-SS
67400	James	Bailey	054-29-9128	9128B	009	02-AM
51296	Michael	Holmes	222-79-5416	5416H	003	03-SS
99618	Victoria	Thompson	156-60-6801	6801T	019	01-SM
16435	Geoffrey	Miller	002-31-9577	9577M	020	03-SS
85937	Amanda	Harrison	040-22-3156	3156H	016	03-SS
88037	Luke	Walker	311-18-8292	8292W	015	02-AM
67449	John	White	750-64-6728	6728W	018	01-SM
06500	Ronald	Daniels	558-38-9996	9996D	016	03-SS
48749	James	Nelson	060-08-4877	4877N	009	01-SM
00521	Wanda	Smith	124-35-6688	6688S	011	02-AM
85766	Joseph	Clark	027-32-4710	4710C	016	03-SS
23112	Michelle	Lopez	520-21-7980	7980L	007	03-SS
87749	Henry	Hunt	513-28-9569	9569H	016	03-SS
27952	Kimberly	Taylor	225-35-7842	7842T	013	03-SS
50870	Jennifer	Robinson	521-81-3457	3457R	013	03-SS
97380	Dawn	Moreno	015-11-9621	9621M	003	03-SS
03624	Jacob	Johnson	692-78-7640	7640J	003	03-SS
13862	James	Shelton	360-77-8541	8541S	014	01-SM
60615	Amanda	Cox	187-72-6899	6899C	013	03-SS
25044	John	Randall	812-74-9347	9347R	020	03-SS
55575	Jennifer	Serrano	336-93-1293	1293S	004	01-SM
47269	Julia	Jordan	316-53-9995	9995J	014	03-SS
69873	Tammy	Stephens	465-50-3280	3280S	001	03-SS
25730	Kathleen	Booth	037-30-2024	2024B	004	03-SS
77935	Mary	Adams	230-21-5197	5197A	015	01-SM
45103	Bryan	Huber	185-57-6709	6709H	016	03-SS
37237	Daniel	Thomas	711-31-4513	4513T	009	03-SS
48189	Michelle	Burke	247-94-9707	9707B	018	03-SS
96739	Jason	Ayala	625-30-9663	9663A	002	03-SS
48892	Isabella	Coleman	690-56-5678	5678C	021	03-SS
35389	Steven	Reid	089-50-9175	9175R	021	03-SS
88425	Anna	Browning	160-26-9324	9324B	004	03-SS
94483	Jennifer	Berg	141-95-8656	8656B	016	03-SS
33058	Jason	Harrison	279-08-2895	2895H	024	01-SM
74983	Elizabeth	Smith	084-60-9622	9622S	006	03-SS
73269	Melody	Christian	733-06-3146	3146C	014	03-SS
31912	Carmen	Franklin	793-58-4045	4045F	012	01-SM
54116	Adriana	Torres	159-60-1317	1317T	012	03-SS
61906	Teresa	Martin	116-38-2613	2613M	009	03-SS
58199	Jennifer	Garcia	570-16-3557	3557G	010	01-SM
30465	Melissa	Warren	595-42-4381	4381W	005	02-AM
74939	Robert	Rodriguez	649-86-5539	5539R	022	03-SS
11949	Derek	Montgomery	488-17-0474	0474M	014	03-SS
74179	Sarah	King	832-96-7193	7193K	018	03-SS
60420	Regina	Murray	682-42-6360	6360M	016	03-SS
89539	Jacob	Butler	769-16-2423	2423B	020	03-SS
23459	Michelle	Hunt	037-53-0690	0690H	019	03-SS
55918	Ruth	Wilson	368-61-5395	5395W	018	03-SS
88595	Brandon	Williams	163-43-1553	1553W	021	03-SS
24092	Kevin	Horn	813-86-7098	7098H	007	03-SS
18709	Charles	Combs	616-07-0301	0301C	016	03-SS
32841	Evan	Smith	267-76-3387	3387S	010	03-SS
97362	Richard	Higgins	690-30-6641	6641H	018	03-SS
36426	Cameron	Steele	105-18-4095	4095S	020	03-SS
64236	Tracy	Guerra	178-88-4915	4915G	004	03-SS
61076	Jack	Lloyd	230-62-3163	3163L	021	03-SS
87475	Gregory	Hill	442-64-7297	7297H	018	03-SS
33471	Robyn	Parker	017-52-9290	9290P	007	03-SS
88961	Judy	Daniels	650-98-8834	8834D	024	03-SS
23445	Christina	Kennedy	038-04-5991	5991K	009	03-SS
61927	Anthony	Daniels	708-57-6603	6603D	015	03-SS
29224	Joshua	Chang	728-80-9815	9815C	002	03-SS
72095	Steven	Garcia	577-39-8207	8207G	004	03-SS
33391	Priscilla	Perez	865-70-5271	5271P	018	03-SS
88257	Troy	Burns	079-25-8840	8840B	019	03-SS
34785	Dennis	Lawrence	753-32-8951	8951L	021	03-SS
77401	Erin	Richardson	898-46-9518	9518R	003	03-SS
11113	Stephanie	Gonzalez	618-02-9975	9975G	003	03-SS
24261	Andrew	Ford	889-34-9488	9488F	004	03-SS
73519	Matthew	Leon	782-67-4980	4980L	016	03-SS
34249	Mariah	Garcia	273-88-4960	4960G	003	03-SS
70202	Brendan	Elliott	143-05-2561	2561E	001	03-SS
69844	Bonnie	Harris	016-39-3258	3258H	016	03-SS
13665	Debbie	Dean	122-65-8019	8019D	016	03-SS
62616	Christina	Anderson	022-61-6373	6373A	004	03-SS
41904	Steven	Mcfarland	464-78-7743	7743M	014	03-SS
50025	Wanda	Zamora	523-88-2926	2926Z	008	03-SS
29156	Chelsea	Castillo	200-10-4105	4105C	003	03-SS
00556	Stephanie	Johnson	061-89-0787	0787J	006	03-SS
56578	Aaron	Lee	052-40-3825	3825L	024	03-SS
46204	Dalton	Murray	327-82-7727	7727M	012	03-SS
11701	Deborah	Guerrero	226-93-6534	6534G	022	03-SS
64830	Heather	Mckee	192-29-6189	6189M	005	01-SM
89870	David	Wilkerson	276-75-3266	3266W	020	03-SS
83635	April	Benson	213-05-3562	3562B	014	03-SS
74864	Sydney	Morris	585-26-2728	2728M	005	03-SS
86483	Tiffany	Ferrell	223-37-8153	8153F	007	03-SS
78030	Jessica	Perez	050-10-0292	0292P	019	03-SS
24963	Nicole	Bender	384-04-2090	2090B	013	03-SS
42914	Brenda	Parker	250-95-3565	3565P	006	03-SS
68833	Steven	Wallace	784-23-8024	8024W	004	03-SS
10213	Jacob	Best	627-78-4950	4950B	010	03-SS
19032	Travis	Ford	121-94-3054	3054F	007	03-SS
68006	Tyler	Haynes	373-67-8961	8961H	023	03-SS
66395	Claudia	King	841-65-9854	9854K	012	03-SS
96754	Colleen	Ramos	733-24-1374	1374R	008	03-SS
94580	Julie	Maldonado	012-68-2988	2988M	004	03-SS
72550	Faith	Weaver	688-64-3392	3392W	007	03-SS
91802	Joanna	Wong	499-88-7484	7484W	003	03-SS
49206	Anthony	Tate	563-04-8023	8023T	005	03-SS
85741	Kendra	Kennedy	538-33-8734	8734K	005	03-SS
59051	Jeanette	Palmer	062-94-3082	3082P	021	03-SS
69740	Cynthia	Adams	436-40-4303	4303A	015	03-SS
69627	Cassandra	Gardner	291-14-3718	3718G	017	03-SS
25383	Lawrence	Harper	500-54-4841	4841H	006	03-SS
66788	Tanya	Chapman	108-37-6062	6062C	019	03-SS
42889	Kendra	Moore	160-31-5489	5489M	014	03-SS
94658	Jason	Edwards	504-21-2986	2986E	021	03-SS
96685	Rachel	Huerta	408-03-4591	4591H	023	03-SS
83590	Richard	Chavez	573-34-1439	1439C	014	03-SS
39504	David	Wood	750-53-9069	9069W	024	03-SS
38784	Melinda	Suarez	869-65-8644	8644S	002	03-SS
64349	Katherine	Kelley	595-81-7266	7266K	009	03-SS
98780	Tyler	Norman	329-88-1018	1018N	019	03-SS
95179	Christina	Delgado	838-90-3022	3022D	024	03-SS
51513	Kimberly	Paul	681-92-2888	2888P	005	03-SS
14040	Mary	Williams	827-16-9443	9443W	010	03-SS
02538	Jesse	Brooks	206-06-0017	0017B	004	03-SS
01670	Donna	Davis	503-11-2602	2602D	020	03-SS
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
001	Karen Ville Mall	4293 Patricia Road\nPort Bobbybury, IN 84691-1277	(840) 311-5136	ALL
002	Stewart Extension Mall	Unit 7578 Box 1962\nDPO AE 94320	(275) 579-9227	D01
003	Davis Row Mall	7115 Alexander Canyon\nScottport, WY 94327-9099	(684) 511-8179	D01
004	Baker Way Mall	0308 Davis Rest\nSamanthaberg, VI 06126	(698) 290-8837	D02
005	Frederick Lakes Mall	62258 Smith Hill Apt. 947\nWhitebury, NM 44476	(091) 069-9014	D05
006	Steven Crossing Mall	24926 Allen Falls Suite 882\nNorth Michelleshire, PA 35509-9623	(148) 551-6316	D02
007	Lewis Run Mall	26799 George Prairie\nHarrisfurt, OR 78264	(536) 505-0736	D03
008	Garcia Wall Mall	050 Rebecca Union Apt. 067\nReedfort, VT 96723-7678	(297) 666-4828	D99
009	Moore Road Mall	705 Sarah Mews Apt. 742\nChristinestad, AZ 31044	(316) 734-2772	D01
010	Baker Corner Mall	069 Thompson Ridges Apt. 995\nWest Carolineton, NC 10065-7311	(444) 325-4316	D02
011	Makayla Shore Mall	644 Anderson Loop Apt. 197\nCaitlinview, RI 25253-4955	(838) 444-2324	D01
012	Stephanie Camp Mall	03611 Brandon Way\nNew Jennifer, VA 57809-7298	(952) 999-2730	ALL
013	Christina Mills Mall	7036 Bradley Turnpike Suite 299\nSouth Sandra, MN 43731-8639	(015) 957-5578	D99
014	Alicia Valley Mall	Unit 1308 Box 4748\nDPO AP 24114-0655	(853) 051-7322	D04
015	Chris Landing Mall	156 Cantu Mountain\nKristintown, PA 04128	(109) 620-7551	D03
016	Williams Vista Mall	7296 Kevin Stream Suite 272\nJenniferport, MI 50291	(420) 681-9890	ALL
017	Yang Parks Mall	6239 Campbell Hollow\nNew Christopherton, CA 18803-5989	(857) 519-9891	D99
018	Phyllis Square Mall	3075 Dean Cape\nEast Miranda, NH 35975-0198	(486) 338-8166	D02
019	Chelsey Light Mall	5658 Morrow Roads Suite 994\nNorth Dawnberg, AL 07209-3490	(865) 860-3935	D04
020	Chad Ridge Mall	Unit 1954 Box 4037\nDPO AP 96035-8688	(967) 836-0599	D03
021	Joshua Crossroad Mall	584 Leblanc Center\nSamuelbury, NM 68252	(522) 270-5702	D05
022	Marissa Estate Mall	594 Nguyen Station\nEast Clarence, CT 74732-1064	(374) 631-1406	D04
023	Andrea Ports Mall	3598 Kirk Burgs\nMichelleville, MD 01427	(869) 223-6457	ALL
024	Matthew Junctions Mall	PSC 6754, Box 4221\nAPO AE 79297	(341) 884-9853	D03
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

