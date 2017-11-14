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
    action_id integer NOT NULL,
    post_id character varying(14) NOT NULL,
    emp_id character varying(5),
    action_item character varying(100) NOT NULL,
    assigned_date timestamp without time zone,
    deadline timestamp without time zone NOT NULL,
    complete boolean NOT NULL,
    complete_date timestamp without time zone
);


ALTER TABLE action OWNER TO vagrant;

--
-- Name: action_action_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE action_action_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE action_action_id_seq OWNER TO vagrant;

--
-- Name: action_action_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE action_action_id_seq OWNED BY action.action_id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE categories (
    cat_id character varying(3) NOT NULL,
    name character varying(25) NOT NULL
);


ALTER TABLE categories OWNER TO vagrant;

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
    post_id character varying(14) NOT NULL,
    title character varying(75) NOT NULL,
    date timestamp without time zone NOT NULL,
    text text NOT NULL,
    emp_id character varying(5) NOT NULL,
    cat_id character varying(3) NOT NULL
);


ALTER TABLE posts OWNER TO vagrant;

--
-- Name: read_receipt; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE read_receipt (
    receipt_id integer NOT NULL,
    post_id character varying(14) NOT NULL,
    emp_id character varying(5) NOT NULL,
    was_read boolean NOT NULL,
    read_date timestamp without time zone
);


ALTER TABLE read_receipt OWNER TO vagrant;

--
-- Name: read_receipt_receipt_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE read_receipt_receipt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE read_receipt_receipt_id_seq OWNER TO vagrant;

--
-- Name: read_receipt_receipt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE read_receipt_receipt_id_seq OWNED BY read_receipt.receipt_id;


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
-- Name: action_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY action ALTER COLUMN action_id SET DEFAULT nextval('action_action_id_seq'::regclass);


--
-- Name: receipt_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY read_receipt ALTER COLUMN receipt_id SET DEFAULT nextval('read_receipt_receipt_id_seq'::regclass);


--
-- Data for Name: action; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY action (action_id, post_id, emp_id, action_item, assigned_date, deadline, complete, complete_date) FROM stdin;
3	20171114054424	00004	BLAH	2017-11-14 05:44:24.487227	2017-11-17 00:00:00	f	\N
\.


--
-- Name: action_action_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('action_action_id_seq', 3, true);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY categories (cat_id, name) FROM stdin;
mis	Miscellaneous
mar	Marketing
opr	Operations
mds	Markdowns
vix	Visual Merchandising
evt	Events
pro	Promotions
hrp	Human Resources/Payroll
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
D99	Corporate HQ
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY employees (emp_id, fname, lname, ssn, password, store_id, pos_id) FROM stdin;
00000	Karen	Stone	742-99-7298	a	017	02-AM
00001	David	Choi	724-37-1490	a	014	02-AM
00002	James	Chapman	377-74-7375	a	006	02-AM
00003	Joshua	Carroll	190-01-9473	a	001	02-AM
00004	Nicolas	Peterson	129-21-2619	a	017	02-AM
00005	Lori	Jordan	228-37-5726	a	010	02-AM
00006	Steven	Maddox	662-75-5698	a	008	02-AM
00007	Matthew	Russo	713-17-2839	a	023	02-AM
00008	Carrie	Jones	787-20-2342	a	008	02-AM
00009	David	Reynolds	748-13-2226	a	019	02-AM
00010	Alexandra	Richards	512-41-3593	a	024	02-AM
00011	Susan	Willis	617-43-3208	a	010	02-AM
00012	Jonathan	Herrera	769-39-8773	a	013	02-AM
00013	Charles	Allen	559-87-8796	a	020	02-AM
00014	Denise	Walker	443-06-8722	a	024	02-AM
00015	Jaclyn	Mitchell	560-96-4506	a	021	02-AM
00016	Zachary	Holmes	797-96-7810	a	012	02-AM
00017	Kim	Villarreal	339-14-5968	a	022	02-AM
00018	Alisha	Peters	125-37-4295	a	007	02-AM
00019	Crystal	Wells	002-51-1915	a	017	01-SM
00020	Michael	Cox	036-85-7665	a	011	02-AM
00021	Dennis	Perry	500-83-6601	a	020	02-AM
00022	Frank	Duarte	237-38-3686	a	009	02-AM
00023	Rachel	Clark	820-48-2625	a	003	02-AM
00024	Brian	Smith	477-08-5839	a	017	03-SS
00025	Richard	Woods	684-28-7820	a	016	02-AM
00026	Robert	Petersen	180-36-7449	a	016	02-AM
00027	Ronald	Rodriguez	256-53-9539	a	023	02-AM
00028	Scott	Evans	341-92-8006	a	008	01-SM
00029	Scott	Miller	650-68-2577	a	012	02-AM
00030	Lisa	Herring	172-01-8328	a	003	02-AM
00031	Rachel	Gonzalez	817-53-1596	a	004	02-AM
00032	Mario	Johnson	773-33-6463	a	010	01-SM
00033	Mitchell	Cline	209-53-0904	a	021	02-AM
00034	Michael	King	283-68-3946	a	017	03-SS
00035	Donald	Alvarez	025-14-0784	a	007	02-AM
00036	Teresa	Sanchez	105-17-1056	a	011	02-AM
00037	Lisa	Cox	680-17-9758	a	007	01-SM
00038	Christopher	Moore	157-03-4019	a	012	01-SM
00039	Julie	Robles	539-91-3033	a	019	02-AM
00040	Travis	Moore	319-78-9785	a	023	01-SM
00041	Janet	Davis	207-54-5621	a	006	02-AM
00042	Daniel	Henry	399-81-6939	a	012	03-SS
00043	Henry	Walker	133-45-7807	a	014	02-AM
00044	Amanda	Cooper	780-91-7155	a	005	02-AM
00045	Keith	White	831-82-2573	a	004	02-AM
00046	Mary	Atkins	093-64-6857	a	022	02-AM
00047	Alyssa	Cunningham	658-21-5859	a	009	02-AM
00048	Philip	Wilson	249-97-7556	a	015	02-AM
00049	Sarah	Harris	828-36-7453	a	011	01-SM
00050	Stephanie	Gomez	287-86-1084	a	018	02-AM
00051	Hector	Turner	430-81-6049	a	023	03-SS
00052	Sonia	Nelson	005-29-0894	a	013	02-AM
00053	Maria	Marsh	602-18-8826	a	024	01-SM
00054	Morgan	Davidson	690-75-8104	a	006	01-SM
00055	Travis	Santiago	420-73-2959	a	024	03-SS
00056	Daisy	Wilson	725-42-9074	a	004	01-SM
00057	Kelly	Fields	568-18-1633	a	002	02-AM
00058	Amanda	Carpenter	762-04-7429	a	010	03-SS
00059	Steven	Phillips	590-04-2634	a	003	01-SM
00060	Scott	Gardner	663-20-1760	a	014	01-SM
00061	Nathaniel	Williams	001-05-9851	a	016	01-SM
00062	Troy	Roy	845-65-5104	a	001	02-AM
00063	Tracy	Yates	816-89-0543	a	005	02-AM
00064	Robert	Hatfield	638-76-8547	a	003	03-SS
00065	Amanda	Gonzales	775-21-9436	a	023	03-SS
00066	Anthony	Phillips	262-86-0533	a	020	01-SM
00067	Emily	Stewart	671-56-2522	a	016	03-SS
00068	Brandi	Mason	594-19-4875	a	014	03-SS
00069	Thomas	Stevens	115-48-0653	a	001	01-SM
00070	Thomas	Short	142-67-5048	a	008	03-SS
00071	Adam	Johnson	472-03-9735	a	018	02-AM
00072	Rebecca	Price	336-24-1215	a	010	03-SS
00073	Leroy	Dunn	081-49-9740	a	012	03-SS
00074	Michelle	Burton	551-95-0326	a	021	01-SM
00075	Curtis	Vargas	563-68-5699	a	016	03-SS
00076	Matthew	Anderson	106-02-4393	a	016	03-SS
00077	Allison	Li	005-44-7065	a	017	03-SS
00078	Jill	Howe	111-14-8411	a	021	03-SS
00079	Jake	Scott	417-76-3803	a	014	03-SS
00080	Donald	Anderson	175-64-8781	a	016	03-SS
00081	David	Armstrong	030-93-2773	a	016	03-SS
00082	Stephanie	Clark	755-69-4038	a	012	03-SS
00083	Michael	Santiago	407-45-7586	a	003	03-SS
00084	Caitlin	Steele	595-91-1863	a	020	03-SS
00085	Holly	Valentine	718-79-3181	a	009	01-SM
00086	Tonya	Rocha	576-90-9578	a	015	02-AM
00087	Richard	Melendez	622-03-5929	a	024	03-SS
00088	Cody	Perry	883-99-3523	a	022	01-SM
00089	Anna	Coleman	155-07-3178	a	023	03-SS
00090	Leslie	Sims	771-46-3841	a	004	03-SS
00091	Vincent	Carlson	162-65-8820	a	019	01-SM
00092	Jacob	Howell	608-88-5640	a	005	01-SM
00093	Justin	Harris	450-58-5607	a	023	03-SS
00094	Robert	Cabrera	356-74-4249	a	018	01-SM
00095	Debra	Ashley	414-18-0925	a	016	03-SS
00096	Lindsey	Sanchez	704-26-4152	a	020	03-SS
00097	John	Jones	010-38-2828	a	015	01-SM
00098	Jorge	Reed	779-28-1842	a	011	03-SS
00099	Chad	Boyd	259-52-6646	a	024	03-SS
00100	Eric	Spencer	306-15-3335	a	012	03-SS
00101	Thomas	Riley	542-43-2690	a	004	03-SS
00102	Kenneth	Chavez	377-48-8890	a	015	03-SS
00103	Dustin	Hubbard	725-68-5693	a	012	03-SS
00104	Ryan	Norman	525-16-6641	a	018	03-SS
00105	Zachary	Farrell	331-21-4836	a	003	03-SS
00106	Charles	Sullivan	895-40-4935	a	013	01-SM
00107	Suzanne	Baker	660-88-4852	a	010	03-SS
00108	Matthew	Glass	590-94-4405	a	003	03-SS
00109	William	Juarez	892-99-0518	a	009	03-SS
00110	Timothy	Baker	734-82-9659	a	002	02-AM
00111	Angelica	Johnson	470-87-2303	a	018	03-SS
00112	Rachel	Sullivan	223-24-0933	a	022	03-SS
00113	Rachel	Fletcher	418-91-5033	a	013	03-SS
00114	Brittney	Oneal	710-18-8139	a	004	03-SS
00115	Christopher	Blevins	600-80-1157	a	018	03-SS
00116	Gary	Baker	608-77-5719	a	007	03-SS
00117	Brian	Bentley	715-41-5688	a	016	03-SS
00118	Stephanie	Edwards	520-49-0984	a	003	03-SS
00119	Willie	Mcguire	815-87-5223	a	024	03-SS
00120	Lisa	Hill	760-31-5708	a	006	03-SS
00121	Ariel	Mullins	530-39-4582	a	003	03-SS
00122	Anna	White	072-79-9416	a	017	03-SS
00123	Curtis	Gonzalez	163-71-7529	a	020	03-SS
00124	Holly	Baldwin	190-64-8889	a	023	03-SS
00125	John	Cobb	869-76-5342	a	003	03-SS
00126	Michael	Pitts	625-23-7448	a	003	03-SS
00127	Richard	Ramos	289-65-0252	a	019	03-SS
00128	Michael	Russell	015-05-8047	a	022	03-SS
00129	Ann	Lutz	254-83-4995	a	018	03-SS
00130	Shawn	Gallegos	348-60-2172	a	012	03-SS
00131	Isaac	Gonzalez	544-82-3414	a	004	03-SS
00132	Tiffany	Hendricks	780-87-5380	a	010	03-SS
00133	Donna	Miller	577-85-8727	a	016	03-SS
00134	Sara	West	712-78-4140	a	014	03-SS
00135	Adrian	Rodriguez	457-60-1590	a	011	03-SS
00136	Joseph	Rodriguez	489-17-8331	a	020	03-SS
00137	Amber	Price	732-75-3810	a	001	03-SS
00138	Ruben	Jefferson	378-04-1822	a	019	03-SS
00139	Jennifer	Oneill	607-99-9280	a	018	03-SS
00140	Nicholas	Hudson	042-41-1854	a	014	03-SS
00141	Linda	Maldonado	080-58-8298	a	014	03-SS
00142	Marissa	Johnson	009-82-8512	a	011	03-SS
00143	James	Fernandez	572-71-2768	a	001	03-SS
00144	Travis	Miller	808-63-6940	a	024	03-SS
00145	Matthew	Schwartz	397-42-2265	a	022	03-SS
00146	Alexandra	Mcintosh	186-10-6467	a	013	03-SS
00147	Erica	Walker	313-75-5569	a	021	03-SS
00148	Anthony	Cook	602-06-5569	a	013	03-SS
00149	Kenneth	Lee	097-73-4381	a	013	03-SS
00150	Norman	Bradford	050-71-6043	a	013	03-SS
00151	Rhonda	Anderson	786-79-5067	a	022	03-SS
00152	Elizabeth	Martinez	330-55-4443	a	004	03-SS
00153	Denise	Scott	700-02-3405	a	004	03-SS
00154	Elizabeth	Petty	596-26-0812	a	007	03-SS
00155	Matthew	Peck	645-38-7656	a	022	03-SS
00156	Alicia	Soto	284-41-4999	a	012	03-SS
00157	Julie	Davis	284-61-6030	a	007	03-SS
00158	Zachary	Brown	168-55-5808	a	019	03-SS
00159	Stephen	Morrison	458-80-4027	a	005	03-SS
00160	Renee	Johnson	163-18-7926	a	009	03-SS
00161	Linda	Mccall	119-71-4952	a	005	03-SS
00162	John	Olson	336-77-4431	a	008	03-SS
00163	Chad	Parsons	695-25-7969	a	007	03-SS
00164	Jesse	Scott	464-14-0728	a	003	03-SS
00165	Alex	Juarez	020-32-5617	a	003	03-SS
00166	Steven	Garcia	714-20-4052	a	007	03-SS
00167	Kim	Tran	342-14-7110	a	017	03-SS
00168	Alex	Taylor	280-74-7484	a	003	03-SS
00169	Tara	Brown	630-49-2273	a	004	03-SS
00170	Alexandra	Robinson	628-90-6612	a	016	03-SS
00171	Jonathan	Bruce	437-28-7562	a	007	03-SS
00172	Wendy	Murphy	424-02-9892	a	022	03-SS
00173	Marc	Cole	539-42-4628	a	005	03-SS
00174	Deborah	Macdonald	401-72-0818	a	023	03-SS
00175	Morgan	Brooks	391-28-2386	a	014	03-SS
00176	Shannon	Sharp	477-01-0685	a	019	03-SS
00177	Gregory	Choi	083-43-1198	a	009	03-SS
00178	Susan	Rodriguez	305-09-4715	a	019	03-SS
00179	Randall	Valdez	519-12-6672	a	023	03-SS
00180	Alexander	Jenkins	046-77-9412	a	004	03-SS
00181	Michael	Bryant	842-25-0261	a	018	03-SS
00182	Michael	Gallegos	760-29-3537	a	010	03-SS
00183	Barbara	Chambers	836-34-7871	a	020	03-SS
00184	Michelle	Jones	516-93-0490	a	007	03-SS
00185	Mary	Escobar	361-46-7528	a	011	03-SS
00186	Jennifer	Davis	079-96-5454	a	020	03-SS
00187	Robin	Delgado	112-47-6536	a	006	03-SS
00188	Andrew	Lee	343-34-5258	a	017	03-SS
00189	Juan	Figueroa	030-78-3966	a	012	03-SS
00190	Walter	Obrien	631-13-8745	a	004	03-SS
00191	Robert	Browning	515-41-8368	a	020	03-SS
00192	Timothy	Mayo	884-12-5117	a	020	03-SS
00193	Angela	Freeman	008-32-1879	a	013	03-SS
00194	Troy	Rodgers	755-08-5836	a	011	03-SS
00195	Ellen	Meyer	695-13-3058	a	002	01-SM
00196	Sharon	Henderson	402-73-1114	a	019	03-SS
00197	Christopher	Thompson	695-91-5575	a	022	03-SS
00198	Jennifer	Weaver	870-15-5391	a	020	03-SS
00199	Barbara	Smith	729-56-8921	a	019	03-SS
00200	Benjamin	Buckley	806-29-6293	a	005	03-SS
00201	Lance	Tucker	282-20-4928	a	013	03-SS
00202	Christine	Russo	886-40-5589	a	012	03-SS
00203	Amy	White	351-78-0034	a	014	03-SS
00204	Cheryl	Reynolds	500-49-9738	a	012	03-SS
00205	Mary	Banks	746-02-3472	a	012	03-SS
00206	Pamela	Taylor	577-78-6273	a	018	03-SS
00207	Dalton	Collins	143-16-4633	a	022	03-SS
00208	Cody	Carpenter	436-98-0003	a	024	03-SS
00209	Joseph	Garcia	590-45-1626	a	001	03-SS
00210	Erin	Sullivan	314-30-3315	a	010	03-SS
00211	Melanie	Franklin	690-03-4430	a	020	03-SS
00212	Dennis	Sanchez	125-99-2265	a	011	03-SS
00213	Crystal	Mullins	726-83-2982	a	001	03-SS
00214	Kenneth	Holder	793-91-0709	a	009	03-SS
00215	Joe	Gibson	703-63-5497	a	010	03-SS
00216	Derrick	Clark	464-47-1135	a	018	03-SS
00217	Briana	Walker	049-20-5863	a	006	03-SS
00218	Travis	Mullins	188-78-2910	a	009	03-SS
00219	Amy	Weber	006-54-5935	a	005	03-SS
00220	Matthew	Martinez	438-30-6347	a	007	03-SS
00221	Emily	Davis	407-87-7615	a	007	03-SS
00222	Jenna	Powell	150-27-1283	a	020	03-SS
00223	Jeremiah	Snyder	504-78-3428	a	010	03-SS
00224	Kaylee	Cowan	108-53-0895	a	016	03-SS
00225	Robin	Williams	188-88-1865	a	013	03-SS
00226	Benjamin	Scott	511-43-2369	a	024	03-SS
00227	Kimberly	Juarez	822-18-3499	a	002	03-SS
00228	Kimberly	Willis	195-92-7021	a	005	03-SS
00229	Desiree	Molina	021-85-7907	a	013	03-SS
00230	Tyler	Cox	507-99-5060	a	017	03-SS
00231	Miranda	Thomas	265-78-3937	a	006	03-SS
00232	Amy	Foster	307-65-3677	a	021	03-SS
00233	James	Miller	354-28-6541	a	017	03-SS
00234	Gordon	Howard	638-55-9092	a	006	03-SS
00235	Devin	Berg	160-89-2180	a	006	03-SS
00236	Jon	Jones	673-24-7750	a	001	03-SS
00237	Brandon	Thompson	359-50-7912	a	015	03-SS
00238	Brent	Solomon	469-46-7226	a	019	03-SS
00239	Rodney	Adams	519-39-7603	a	003	03-SS
00240	Andres	Walker	123-93-2998	a	014	03-SS
00241	Ricky	Thomas	794-65-1436	a	024	03-SS
00242	Travis	Hardin	698-82-7910	a	022	03-SS
00243	Kendra	Walker	102-71-1322	a	013	03-SS
00244	Michael	Morgan	320-80-5659	a	008	03-SS
00245	Ronald	Davis	563-68-8016	a	021	03-SS
00246	Stephanie	Bolton	740-68-6762	a	012	03-SS
00247	Gloria	Schroeder	535-99-7173	a	007	03-SS
00248	Rebecca	Kramer	313-85-6471	a	016	03-SS
00249	Robin	Mccormick	011-65-1613	a	019	03-SS
00250	Jerry	Morris	621-78-3835	a	012	03-SS
00251	Jason	Hernandez	635-04-2928	a	016	03-SS
00252	Stephanie	Thomas	856-12-4590	a	021	03-SS
00253	Jessica	Castro	076-48-8691	a	011	03-SS
00254	Jacqueline	Morales	657-02-5032	a	024	03-SS
00255	Steven	Miles	285-79-2444	a	007	03-SS
00256	Heather	Obrien	330-15-1367	a	008	03-SS
00257	Matthew	Mccarty	311-61-0845	a	002	03-SS
00258	Janice	Jimenez	498-42-9644	a	002	03-SS
00259	Angela	Romero	810-74-6731	a	010	03-SS
00260	Karen	Oliver	848-58-7117	a	004	03-SS
00261	Carla	Pham	609-12-1504	a	017	03-SS
00262	Matthew	Barrett	196-74-2134	a	023	03-SS
00263	Bradley	Hayes	528-83-6371	a	004	03-SS
00264	Jennifer	Bright	082-40-5066	a	020	03-SS
00265	Wanda	Payne	070-97-2214	a	013	03-SS
00266	Emily	Crane	207-32-2457	a	022	03-SS
00267	James	Cummings	659-03-3452	a	024	03-SS
00268	Madeline	Johnson	194-52-1421	a	016	03-SS
00269	Ann	Craig	453-63-3191	a	001	03-SS
00270	Danielle	Williams	289-02-5082	a	018	03-SS
00271	Angela	Leon	732-22-2005	a	015	03-SS
00272	Nicholas	Lopez	193-56-7821	a	004	03-SS
00273	Brooke	Carlson	119-76-6577	a	002	03-SS
00274	Brian	Wilson	717-05-5663	a	006	03-SS
00275	Rebecca	Frederick	397-04-7398	a	020	03-SS
00276	Kristin	Johnson	811-28-5789	a	012	03-SS
00277	Lisa	Weaver	601-68-0893	a	017	03-SS
00278	Andrew	Buckley	304-28-0422	a	024	03-SS
00279	Angelica	Chavez	060-23-0062	a	014	03-SS
00280	Victoria	Guerrero	393-53-4697	a	010	03-SS
00281	Stephen	Evans	469-96-1757	a	008	03-SS
00282	Kimberly	Christensen	017-24-4997	a	021	03-SS
00283	Christopher	Kirk	375-31-4803	a	018	03-SS
00284	Jon	Arnold	356-16-8577	a	010	03-SS
00285	Steven	Schaefer	356-80-8400	a	008	03-SS
00286	Charles	Hill	589-89-9634	a	022	03-SS
00287	Matthew	Chapman	280-50-9213	a	005	03-SS
00288	Lauren	Bowers	787-05-9790	a	015	03-SS
00289	Jamie	Moore	786-26-1805	a	005	03-SS
00290	Sara	Ross	138-70-8585	a	001	03-SS
00291	Christopher	Lyons	841-06-5861	a	015	03-SS
00292	Samantha	Romero	776-22-4530	a	010	03-SS
00293	Gregory	Gilbert	573-44-2045	a	020	03-SS
00294	Sarah	Wang	736-13-2623	a	006	03-SS
00295	Andrew	Vega	835-02-7172	a	018	03-SS
00296	Michael	Macias	597-12-9076	a	010	03-SS
00297	Richard	Austin	474-64-8902	a	016	03-SS
00298	Mary	Kim	626-50-4171	a	009	03-SS
00299	Laurie	Hogan	709-80-4700	a	003	03-SS
09332	Nancy	Reyes	123-45-6789	f	999	99-HQ
63734	Nidhi	Sharma	689-07-7172	f	999	10-DM
46270	Erin	Cusick	712-23-0275	f	999	10-DM
76033	Anjou	Ahlborn-Kay	773-46-4548	f	999	10-DM
78468	Courtney	Cohan	079-79-6504	f	999	10-DM
30722	Ariana	Patterson	521-76-4322	f	999	10-DM
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

COPY posts (post_id, title, date, text, emp_id, cat_id) FROM stdin;
20171114054424	Presbyterian. I'm a Presbyterian.	2017-11-14 05:44:24.487227	Japan and with Mexico and with Vietnam and with Saudi Arabia and with everybody.	09332	mis
20171114060006	Social Security; you've been paying your Security.	2017-11-14 06:00:06.314555	Most importantly, I brought my Bible.	09332	mis
20171114060313	House. But you don't want.	2017-11-14 06:03:13.479162	Trump building right opposite the New York, many other places have our jobs.	09332	mis
\.


--
-- Data for Name: read_receipt; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY read_receipt (receipt_id, post_id, emp_id, was_read, read_date) FROM stdin;
1	20171114054424	00003	f	\N
2	20171114054424	00062	f	\N
3	20171114054424	00069	f	\N
4	20171114054424	00057	f	\N
5	20171114054424	00110	f	\N
6	20171114054424	00195	f	\N
7	20171114054424	00023	f	\N
8	20171114054424	00030	f	\N
9	20171114054424	00059	f	\N
10	20171114054424	00031	f	\N
11	20171114054424	00045	f	\N
12	20171114054424	00056	f	\N
13	20171114054424	00044	f	\N
14	20171114054424	00063	f	\N
15	20171114054424	00092	f	\N
16	20171114054424	00002	f	\N
17	20171114054424	00041	f	\N
18	20171114054424	00054	f	\N
19	20171114054424	00018	f	\N
20	20171114054424	00035	f	\N
21	20171114054424	00037	f	\N
22	20171114054424	00006	f	\N
23	20171114054424	00008	f	\N
24	20171114054424	00028	f	\N
25	20171114054424	00022	f	\N
26	20171114054424	00047	f	\N
27	20171114054424	00085	f	\N
28	20171114054424	00005	f	\N
29	20171114054424	00011	f	\N
30	20171114054424	00032	f	\N
31	20171114054424	00020	f	\N
32	20171114054424	00036	f	\N
33	20171114054424	00049	f	\N
34	20171114054424	00016	f	\N
35	20171114054424	00029	f	\N
36	20171114054424	00038	f	\N
37	20171114054424	00012	f	\N
38	20171114054424	00052	f	\N
39	20171114054424	00106	f	\N
40	20171114054424	00001	f	\N
41	20171114054424	00043	f	\N
42	20171114054424	00060	f	\N
43	20171114054424	00048	f	\N
44	20171114054424	00086	f	\N
45	20171114054424	00097	f	\N
46	20171114054424	00025	f	\N
47	20171114054424	00026	f	\N
48	20171114054424	00061	f	\N
50	20171114054424	00004	f	\N
51	20171114054424	00019	f	\N
52	20171114054424	00050	f	\N
53	20171114054424	00071	f	\N
54	20171114054424	00094	f	\N
55	20171114054424	00009	f	\N
56	20171114054424	00039	f	\N
57	20171114054424	00091	f	\N
58	20171114054424	00013	f	\N
59	20171114054424	00021	f	\N
60	20171114054424	00066	f	\N
61	20171114054424	00015	f	\N
62	20171114054424	00033	f	\N
63	20171114054424	00074	f	\N
64	20171114054424	00017	f	\N
65	20171114054424	00046	f	\N
66	20171114054424	00088	f	\N
67	20171114054424	00007	f	\N
68	20171114054424	00027	f	\N
69	20171114054424	00040	f	\N
70	20171114054424	00010	f	\N
71	20171114054424	00014	f	\N
72	20171114054424	00053	f	\N
74	20171114054424	63734	f	\N
75	20171114054424	46270	f	\N
76	20171114054424	76033	f	\N
77	20171114054424	78468	f	\N
78	20171114054424	30722	f	\N
73	20171114054424	09332	t	2017-11-14 05:44:27.949474
79	20171114060006	00003	f	\N
80	20171114060006	00062	f	\N
81	20171114060006	00069	f	\N
82	20171114060006	00057	f	\N
83	20171114060006	00110	f	\N
84	20171114060006	00195	f	\N
85	20171114060006	00023	f	\N
86	20171114060006	00030	f	\N
87	20171114060006	00059	f	\N
88	20171114060006	00031	f	\N
89	20171114060006	00045	f	\N
90	20171114060006	00056	f	\N
91	20171114060006	00044	f	\N
92	20171114060006	00063	f	\N
93	20171114060006	00092	f	\N
94	20171114060006	00002	f	\N
95	20171114060006	00041	f	\N
96	20171114060006	00054	f	\N
97	20171114060006	00018	f	\N
98	20171114060006	00035	f	\N
99	20171114060006	00037	f	\N
100	20171114060006	00006	f	\N
101	20171114060006	00008	f	\N
102	20171114060006	00028	f	\N
103	20171114060006	00022	f	\N
104	20171114060006	00047	f	\N
105	20171114060006	00085	f	\N
106	20171114060006	00005	f	\N
107	20171114060006	00011	f	\N
108	20171114060006	00032	f	\N
109	20171114060006	00020	f	\N
110	20171114060006	00036	f	\N
111	20171114060006	00049	f	\N
112	20171114060006	00016	f	\N
113	20171114060006	00029	f	\N
114	20171114060006	00038	f	\N
115	20171114060006	00012	f	\N
116	20171114060006	00052	f	\N
117	20171114060006	00106	f	\N
118	20171114060006	00001	f	\N
119	20171114060006	00043	f	\N
120	20171114060006	00060	f	\N
121	20171114060006	00048	f	\N
122	20171114060006	00086	f	\N
123	20171114060006	00097	f	\N
124	20171114060006	00025	f	\N
125	20171114060006	00026	f	\N
126	20171114060006	00061	f	\N
128	20171114060006	00004	f	\N
129	20171114060006	00019	f	\N
130	20171114060006	00050	f	\N
131	20171114060006	00071	f	\N
132	20171114060006	00094	f	\N
133	20171114060006	00009	f	\N
134	20171114060006	00039	f	\N
135	20171114060006	00091	f	\N
127	20171114060006	00000	t	2017-11-14 06:22:05.746367
136	20171114060006	00013	f	\N
137	20171114060006	00021	f	\N
138	20171114060006	00066	f	\N
139	20171114060006	00015	f	\N
140	20171114060006	00033	f	\N
141	20171114060006	00074	f	\N
142	20171114060006	00017	f	\N
143	20171114060006	00046	f	\N
144	20171114060006	00088	f	\N
145	20171114060006	00007	f	\N
146	20171114060006	00027	f	\N
147	20171114060006	00040	f	\N
148	20171114060006	00010	f	\N
149	20171114060006	00014	f	\N
150	20171114060006	00053	f	\N
152	20171114060006	63734	f	\N
153	20171114060006	46270	f	\N
154	20171114060006	76033	f	\N
155	20171114060006	78468	f	\N
156	20171114060006	30722	f	\N
151	20171114060006	09332	t	2017-11-14 06:00:10.682291
157	20171114060313	00003	f	\N
158	20171114060313	00062	f	\N
159	20171114060313	00069	f	\N
160	20171114060313	00057	f	\N
161	20171114060313	00110	f	\N
162	20171114060313	00195	f	\N
163	20171114060313	00023	f	\N
164	20171114060313	00030	f	\N
165	20171114060313	00059	f	\N
166	20171114060313	00031	f	\N
167	20171114060313	00045	f	\N
168	20171114060313	00056	f	\N
169	20171114060313	00044	f	\N
170	20171114060313	00063	f	\N
171	20171114060313	00092	f	\N
172	20171114060313	00002	f	\N
173	20171114060313	00041	f	\N
174	20171114060313	00054	f	\N
175	20171114060313	00018	f	\N
176	20171114060313	00035	f	\N
177	20171114060313	00037	f	\N
178	20171114060313	00006	f	\N
179	20171114060313	00008	f	\N
180	20171114060313	00028	f	\N
181	20171114060313	00022	f	\N
182	20171114060313	00047	f	\N
183	20171114060313	00085	f	\N
184	20171114060313	00005	f	\N
185	20171114060313	00011	f	\N
186	20171114060313	00032	f	\N
187	20171114060313	00020	f	\N
188	20171114060313	00036	f	\N
189	20171114060313	00049	f	\N
190	20171114060313	00016	f	\N
191	20171114060313	00029	f	\N
192	20171114060313	00038	f	\N
193	20171114060313	00012	f	\N
194	20171114060313	00052	f	\N
195	20171114060313	00106	f	\N
196	20171114060313	00001	f	\N
197	20171114060313	00043	f	\N
198	20171114060313	00060	f	\N
199	20171114060313	00048	f	\N
200	20171114060313	00086	f	\N
201	20171114060313	00097	f	\N
202	20171114060313	00025	f	\N
203	20171114060313	00026	f	\N
204	20171114060313	00061	f	\N
206	20171114060313	00004	f	\N
207	20171114060313	00019	f	\N
208	20171114060313	00050	f	\N
209	20171114060313	00071	f	\N
210	20171114060313	00094	f	\N
211	20171114060313	00009	f	\N
212	20171114060313	00039	f	\N
213	20171114060313	00091	f	\N
214	20171114060313	00013	f	\N
215	20171114060313	00021	f	\N
216	20171114060313	00066	f	\N
217	20171114060313	00015	f	\N
218	20171114060313	00033	f	\N
219	20171114060313	00074	f	\N
220	20171114060313	00017	f	\N
221	20171114060313	00046	f	\N
222	20171114060313	00088	f	\N
223	20171114060313	00007	f	\N
224	20171114060313	00027	f	\N
225	20171114060313	00040	f	\N
226	20171114060313	00010	f	\N
227	20171114060313	00014	f	\N
228	20171114060313	00053	f	\N
230	20171114060313	63734	f	\N
231	20171114060313	46270	f	\N
232	20171114060313	76033	f	\N
233	20171114060313	78468	f	\N
234	20171114060313	30722	f	\N
229	20171114060313	09332	t	2017-11-14 06:03:23.09374
49	20171114054424	00000	t	2017-11-14 06:17:10.112585
205	20171114060313	00000	t	2017-11-14 06:22:11.375831
\.


--
-- Name: read_receipt_receipt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('read_receipt_receipt_id_seq', 234, true);


--
-- Data for Name: stores; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY stores (store_id, name, address, phone, district_id) FROM stdin;
001	Jane Spurs Mall	92994 Robert Brooks\nAnitashire, UT 63267-8402	(472) 228-1640	D02
002	Rogers Tunnel Mall	USNS Soto\nFPO AP 55076-0835	(181) 437-0325	D05
003	Nash Gardens Mall	47047 Pineda Hollow Suite 901\nPort Markshire, HI 47221-9763	(514) 239-2527	D03
004	Smith Glen Mall	USCGC Nash\nFPO AE 13048-3103	(079) 723-7430	D05
005	Gibson Cliff Mall	0920 Pamela Shore\nEast Lisaberg, KS 27938	(440) 518-3282	D03
006	Maria Cliff Mall	29807 Robin Forest Apt. 239\nIsaacland, NV 98434-2217	(725) 860-0522	D01
007	Tiffany Locks Mall	0678 Aaron Knolls Apt. 769\nMichelleberg, VI 07218	(659) 212-3899	D05
008	Hannah Spurs Mall	63809 Mann Expressway Apt. 376\nSouth Elizabeth, UT 94813-5114	(747) 301-7979	D03
009	Michael Camp Mall	USCGC Scott\nFPO AA 99453-3322	(577) 672-1225	D02
010	Michelle Station Mall	47344 Angela Harbors\nRhodesstad, KS 58989-7628	(822) 958-2671	D01
011	Anderson Stravenue Mall	042 Thomas Pines Apt. 925\nCherylmouth, NH 63917	(509) 595-4943	D05
012	Hunt Springs Mall	166 Timothy Bypass\nNew Michael, GA 04742-9328	(835) 450-5578	D01
013	Trujillo Valleys Mall	384 Johnson Inlet\nTraciside, AL 10715	(191) 743-4215	D05
014	Adams Road Mall	9025 Erin Cliffs\nKarenberg, GU 10361-0255	(961) 583-4157	D04
015	Jennifer Flat Mall	70447 Olsen Expressway\nAmberburgh, KS 84717-7289	(263) 538-3055	D05
016	Leonard Fort Mall	7199 Clark Shoal\nNew Danielfort, TX 92052-4357	(876) 041-6647	D05
017	Amanda Cove Mall	PSC 0690, Box 4145\nAPO AE 70429	(345) 456-7119	D05
018	Ricky Tunnel Mall	59386 Daniel Radial Apt. 627\nPort Paul, MA 50358	(483) 000-9217	D04
019	Matthew Estates Mall	19229 Courtney Burgs Apt. 799\nMurphyview, SD 44541	(318) 880-6834	D04
020	Alfred Way Mall	063 Kara Well Suite 149\nElizabethshire, CA 20594	(687) 200-9233	D02
021	David Heights Mall	100 Morgan Way\nLake Ashleyside, AZ 76459	(242) 604-5958	D03
022	Howell Bridge Mall	67174 Hudson Lodge Apt. 106\nAnnmouth, OK 55534	(068) 391-8098	D04
023	Sanchez Shoal Mall	666 Mcclain Street Apt. 688\nSouth Richard, LA 42050-0809	(900) 128-4310	D01
024	Kara Port Mall	2020 Kyle Square Apt. 169\nKimberlyside, NC 29140-1630	(313) 969-4591	D02
999	Corporate Headquarters	123 Main Street\nAnywhere, USA 12345	(415) 555-1234	D99
\.


--
-- Name: action_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY action
    ADD CONSTRAINT action_pkey PRIMARY KEY (action_id, post_id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (cat_id);


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
-- Name: read_receipt_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY read_receipt
    ADD CONSTRAINT read_receipt_pkey PRIMARY KEY (receipt_id);


--
-- Name: stores_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (store_id);


--
-- Name: action_emp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY action
    ADD CONSTRAINT action_emp_id_fkey FOREIGN KEY (emp_id) REFERENCES employees(emp_id);


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
-- Name: posts_cat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_cat_id_fkey FOREIGN KEY (cat_id) REFERENCES categories(cat_id);


--
-- Name: posts_emp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_emp_id_fkey FOREIGN KEY (emp_id) REFERENCES employees(emp_id);


--
-- Name: read_receipt_emp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY read_receipt
    ADD CONSTRAINT read_receipt_emp_id_fkey FOREIGN KEY (emp_id) REFERENCES employees(emp_id);


--
-- Name: read_receipt_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY read_receipt
    ADD CONSTRAINT read_receipt_post_id_fkey FOREIGN KEY (post_id) REFERENCES posts(post_id);


--
-- Name: stores_district_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY stores
    ADD CONSTRAINT stores_district_id_fkey FOREIGN KEY (district_id) REFERENCES districts(district_id);


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

