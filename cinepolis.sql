--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.7
-- Dumped by pg_dump version 9.6.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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

--
-- Name: registra_movimiento(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION registra_movimiento() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
   BEGIN
      UPDATE membresia SET puntos_acumulados = puntos_acumulados + 50 WHERE membresia.idmembresia = NEW.idmembresia;
      RETURN NEW;
   END;   
$$;


ALTER FUNCTION public.registra_movimiento() OWNER TO usuario7;

--
-- Name: show_asientos(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION show_asientos(funcion_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE asi INT;
    BEGIN
      SELECT asientos INTO asi FROM funciones WHERE idfunciones = funcion_id;
      RETURN asi;
    END;
    $$;


ALTER FUNCTION public.show_asientos(funcion_id integer) OWNER TO usuario7;

--
-- Name: show_funciones(character, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION show_funciones(cine_nombre character, dia_fecha date) RETURNS TABLE(nombre character, clasificacion character, duracion text)
    LANGUAGE plpgsql
    AS $$
begin
  return query
  select p.nombre, p.clasificacion, p.duracion
    from cine c, funciones f, peliculas p
   where f.idpelicula = p.idpelicula and c.idcine = f.idcine and c.nombre = cine_nombre and f.fecha = dia_fecha;
end;
$$;


ALTER FUNCTION public.show_funciones(cine_nombre character, dia_fecha date) OWNER TO usuario7;

--
-- Name: show_movimientos(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION show_movimientos(membresia_id integer) RETURNS TABLE(id integer, fecha timestamp without time zone, puntos integer, descripcion character)
    LANGUAGE plpgsql
    AS $$
begin
  return query
  select m.idmembresia, m.fecha, m.puntos_ganados, m.descripcion
    from movimientos m
   where m.idmembresia = membresia_id;
end;
$$;


ALTER FUNCTION public.show_movimientos(membresia_id integer) OWNER TO usuario7;

--
-- Name: total_puntos_membresia(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION total_puntos_membresia(membresia_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
 declare puntos INT;
 BEGIN
    SELECT  puntos_acumulados into puntos FROM membresia
    WHERE idmembresia = membresia_id;
    RETURN puntos;
 END;
 $$;


ALTER FUNCTION public.total_puntos_membresia(membresia_id integer) OWNER TO usuario7;

--
-- Name: totalventa(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION totalventa(venta_id integer) RETURNS real
    LANGUAGE plpgsql
    AS $$
 declare total REAL;
 BEGIN
    SELECT  total_venta into total FROM venta
    WHERE idventa = venta_id;
    RETURN total;
 END;
 $$;


ALTER FUNCTION public.totalventa(venta_id integer) OWNER TO usuario7;

--
-- Name: venta_asientos(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION venta_asientos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
   BEGIN
       UPDATE funciones SET asientos = asientos - NEW.cantidad_boletos
       WHERE funciones.idfunciones = NEW.idfunciones; 
       IF (select f.asientos 
        from funciones f 
        where f.idfunciones = NEW.idfunciones) = 0 THEN
        UPDATE funciones SET disponible = 'no' WHERE idfunciones = NEW.idfunciones;
     END IF;     
      RETURN NEW;      
   END;
$$;


ALTER FUNCTION public.venta_asientos() OWNER TO usuario7;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: alimentos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE alimentos (
    idalimentos integer NOT NULL,
    idcategoria integer NOT NULL,
    nombre character(50) NOT NULL,
    descripcion character(100) NOT NULL,
    precio_venta real NOT NULL
);


ALTER TABLE alimentos OWNER TO usuario7;

--
-- Name: alimentos_idalimentos_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE alimentos_idalimentos_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE alimentos_idalimentos_seq OWNER TO usuario7;

--
-- Name: alimentos_idalimentos_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE alimentos_idalimentos_seq OWNED BY alimentos.idalimentos;


--
-- Name: boletos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE boletos (
    idboletos integer NOT NULL,
    idventa integer NOT NULL,
    idfunciones integer NOT NULL,
    idfans integer NOT NULL,
    codigo integer NOT NULL,
    fecha timestamp without time zone NOT NULL
);


ALTER TABLE boletos OWNER TO usuario7;

--
-- Name: boletos_idboletos_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE boletos_idboletos_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE boletos_idboletos_seq OWNER TO usuario7;

--
-- Name: boletos_idboletos_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE boletos_idboletos_seq OWNED BY boletos.idboletos;


--
-- Name: caja; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE caja (
    idcaja integer NOT NULL,
    idcine integer NOT NULL,
    venta_total real NOT NULL
);


ALTER TABLE caja OWNER TO usuario7;

--
-- Name: caja_idcaja_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE caja_idcaja_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE caja_idcaja_seq OWNER TO usuario7;

--
-- Name: caja_idcaja_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE caja_idcaja_seq OWNED BY caja.idcaja;


--
-- Name: cartelera; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cartelera (
    idcartelera integer NOT NULL,
    idcine integer NOT NULL,
    idfunciones integer NOT NULL,
    disponible character(10)
);


ALTER TABLE cartelera OWNER TO usuario7;

--
-- Name: cartelera_idcartelera_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cartelera_idcartelera_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cartelera_idcartelera_seq OWNER TO usuario7;

--
-- Name: cartelera_idcartelera_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cartelera_idcartelera_seq OWNED BY cartelera.idcartelera;


--
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE categoria (
    idcategoria integer NOT NULL,
    nombre character(50) NOT NULL
);


ALTER TABLE categoria OWNER TO usuario7;

--
-- Name: categoria_idcategoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE categoria_idcategoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categoria_idcategoria_seq OWNER TO usuario7;

--
-- Name: categoria_idcategoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE categoria_idcategoria_seq OWNED BY categoria.idcategoria;


--
-- Name: cine; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cine (
    idcine integer NOT NULL,
    direccion character(100) NOT NULL,
    estado character(50) NOT NULL,
    venta_total real NOT NULL,
    nombre character(50)
);


ALTER TABLE cine OWNER TO usuario7;

--
-- Name: cine_idcine_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cine_idcine_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cine_idcine_seq OWNER TO usuario7;

--
-- Name: cine_idcine_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cine_idcine_seq OWNED BY cine.idcine;


--
-- Name: detalle_venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE detalle_venta (
    iddetalleventa integer NOT NULL,
    idventa integer NOT NULL,
    idalimentos integer NOT NULL,
    idfunciones integer NOT NULL,
    idboletos integer NOT NULL,
    cantidad integer NOT NULL,
    precio_venta real NOT NULL,
    cantidad_boletos integer,
    idmembresia integer
);


ALTER TABLE detalle_venta OWNER TO usuario7;

--
-- Name: detalle_venta_iddetalleventa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE detalle_venta_iddetalleventa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE detalle_venta_iddetalleventa_seq OWNER TO usuario7;

--
-- Name: detalle_venta_iddetalleventa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE detalle_venta_iddetalleventa_seq OWNED BY detalle_venta.iddetalleventa;


--
-- Name: empleado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE empleado (
    idempleado integer NOT NULL,
    idcaja integer NOT NULL,
    idcine integer NOT NULL,
    nombre character(50) NOT NULL,
    apellido character(50) NOT NULL
);


ALTER TABLE empleado OWNER TO usuario7;

--
-- Name: empleado_idempleado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE empleado_idempleado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE empleado_idempleado_seq OWNER TO usuario7;

--
-- Name: empleado_idempleado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE empleado_idempleado_seq OWNED BY empleado.idempleado;


--
-- Name: fans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE fans (
    idfans integer NOT NULL,
    idcine integer NOT NULL,
    nombre character(50) NOT NULL,
    apellido character(50) NOT NULL,
    estado character(50) NOT NULL,
    direccion character(100) NOT NULL,
    num_telefono integer NOT NULL,
    email character(50) NOT NULL,
    credito integer NOT NULL
);


ALTER TABLE fans OWNER TO usuario7;

--
-- Name: fans_idfans_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE fans_idfans_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE fans_idfans_seq OWNER TO usuario7;

--
-- Name: fans_idfans_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE fans_idfans_seq OWNED BY fans.idfans;


--
-- Name: funciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE funciones (
    idfunciones integer NOT NULL,
    idpelicula integer NOT NULL,
    idcine integer NOT NULL,
    asientos integer NOT NULL,
    horario text NOT NULL,
    sala text NOT NULL,
    fecha date,
    disponible character(10)
);


ALTER TABLE funciones OWNER TO usuario7;

--
-- Name: funciones_idfunciones_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE funciones_idfunciones_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE funciones_idfunciones_seq OWNER TO usuario7;

--
-- Name: funciones_idfunciones_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE funciones_idfunciones_seq OWNED BY funciones.idfunciones;


--
-- Name: membresia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE membresia (
    idmembresia integer NOT NULL,
    idfans integer NOT NULL,
    num_tarjeta integer NOT NULL,
    fecha_caducidad timestamp without time zone NOT NULL,
    tipo character(50) NOT NULL,
    puntos_acumulados integer NOT NULL,
    registro_visitas integer NOT NULL
);


ALTER TABLE membresia OWNER TO usuario7;

--
-- Name: membresia_idmembresia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE membresia_idmembresia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE membresia_idmembresia_seq OWNER TO usuario7;

--
-- Name: membresia_idmembresia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE membresia_idmembresia_seq OWNED BY membresia.idmembresia;


--
-- Name: movimientos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE movimientos (
    idmovimientos integer NOT NULL,
    idmembresia integer NOT NULL,
    fecha timestamp without time zone NOT NULL,
    puntos_ganados integer NOT NULL,
    descripcion character(50) NOT NULL
);


ALTER TABLE movimientos OWNER TO usuario7;

--
-- Name: movimientos_idmovimientos_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE movimientos_idmovimientos_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE movimientos_idmovimientos_seq OWNER TO usuario7;

--
-- Name: movimientos_idmovimientos_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE movimientos_idmovimientos_seq OWNED BY movimientos.idmovimientos;


--
-- Name: peliculas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE peliculas (
    idpelicula integer NOT NULL,
    idcine integer NOT NULL,
    nombre character(50) NOT NULL,
    clasificacion character(50) NOT NULL,
    director character(50) NOT NULL,
    sinopsis character(500) NOT NULL,
    duracion text NOT NULL,
    idcategoria integer NOT NULL
);


ALTER TABLE peliculas OWNER TO usuario7;

--
-- Name: peliculas_idpelicula_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE peliculas_idpelicula_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE peliculas_idpelicula_seq OWNER TO usuario7;

--
-- Name: peliculas_idpelicula_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE peliculas_idpelicula_seq OWNED BY peliculas.idpelicula;


--
-- Name: tarjetas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tarjetas (
    idtarjeta integer NOT NULL,
    idfans integer NOT NULL,
    num_tarjeta integer NOT NULL,
    fecha_caducidad timestamp without time zone NOT NULL,
    tipo_tarjeta character(50) NOT NULL,
    banco character(50) NOT NULL
);


ALTER TABLE tarjetas OWNER TO usuario7;

--
-- Name: tarjetas_idtarjeta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tarjetas_idtarjeta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tarjetas_idtarjeta_seq OWNER TO usuario7;

--
-- Name: tarjetas_idtarjeta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tarjetas_idtarjeta_seq OWNED BY tarjetas.idtarjeta;


--
-- Name: venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE venta (
    idventa integer NOT NULL,
    idfans integer NOT NULL,
    idcaja integer NOT NULL,
    idempleado integer NOT NULL,
    idcine integer NOT NULL,
    total_venta real NOT NULL,
    fecha timestamp without time zone NOT NULL,
    metodo_pago text NOT NULL,
    idmembresia integer
);


ALTER TABLE venta OWNER TO usuario7;

--
-- Name: venta_idventa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE venta_idventa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE venta_idventa_seq OWNER TO usuario7;

--
-- Name: venta_idventa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE venta_idventa_seq OWNED BY venta.idventa;


--
-- Name: alimentos idalimentos; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY alimentos ALTER COLUMN idalimentos SET DEFAULT nextval('alimentos_idalimentos_seq'::regclass);


--
-- Name: boletos idboletos; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY boletos ALTER COLUMN idboletos SET DEFAULT nextval('boletos_idboletos_seq'::regclass);


--
-- Name: caja idcaja; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY caja ALTER COLUMN idcaja SET DEFAULT nextval('caja_idcaja_seq'::regclass);


--
-- Name: cartelera idcartelera; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cartelera ALTER COLUMN idcartelera SET DEFAULT nextval('cartelera_idcartelera_seq'::regclass);


--
-- Name: categoria idcategoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoria ALTER COLUMN idcategoria SET DEFAULT nextval('categoria_idcategoria_seq'::regclass);


--
-- Name: cine idcine; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cine ALTER COLUMN idcine SET DEFAULT nextval('cine_idcine_seq'::regclass);


--
-- Name: detalle_venta iddetalleventa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_venta ALTER COLUMN iddetalleventa SET DEFAULT nextval('detalle_venta_iddetalleventa_seq'::regclass);


--
-- Name: empleado idempleado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY empleado ALTER COLUMN idempleado SET DEFAULT nextval('empleado_idempleado_seq'::regclass);


--
-- Name: fans idfans; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fans ALTER COLUMN idfans SET DEFAULT nextval('fans_idfans_seq'::regclass);


--
-- Name: funciones idfunciones; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY funciones ALTER COLUMN idfunciones SET DEFAULT nextval('funciones_idfunciones_seq'::regclass);


--
-- Name: membresia idmembresia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY membresia ALTER COLUMN idmembresia SET DEFAULT nextval('membresia_idmembresia_seq'::regclass);


--
-- Name: movimientos idmovimientos; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movimientos ALTER COLUMN idmovimientos SET DEFAULT nextval('movimientos_idmovimientos_seq'::regclass);


--
-- Name: peliculas idpelicula; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY peliculas ALTER COLUMN idpelicula SET DEFAULT nextval('peliculas_idpelicula_seq'::regclass);


--
-- Name: tarjetas idtarjeta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tarjetas ALTER COLUMN idtarjeta SET DEFAULT nextval('tarjetas_idtarjeta_seq'::regclass);


--
-- Name: venta idventa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY venta ALTER COLUMN idventa SET DEFAULT nextval('venta_idventa_seq'::regclass);


--
-- Data for Name: alimentos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY alimentos (idalimentos, idcategoria, nombre, descripcion, precio_venta) FROM stdin;
1	1	Acarameladas                                      	Con un toque dulce                                                                                  	45
2	2	Gomitas                                           	Panditas y mas                                                                                      	20
3	4	ICE                                               	De distintos sabores                                                                                	50
4	3	Frappe                                            	Oreo o solo                                                                                         	48
5	1	Enchiladas                                        	Con un extra de picante                                                                             	53
6	2	Cornetto                                          	Chocolate o fresa                                                                                   	23
7	4	Coca cola                                         	Para disfrutar la movie                                                                             	24
8	3	Chocolate caliente                                	Para el frio                                                                                        	34
9	4	Sidral                                            	Para refrescarte                                                                                    	31
10	1	Chedar                                            	Para acompañar                                                                                      	47
\.


--
-- Name: alimentos_idalimentos_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('alimentos_idalimentos_seq', 1, false);


--
-- Data for Name: boletos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY boletos (idboletos, idventa, idfunciones, idfans, codigo, fecha) FROM stdin;
1	2	4	8	8283	2017-05-07 21:50:02
2	3	5	8	321321	2017-05-07 21:50:02
3	1	6	6	43453	2017-05-07 21:50:02
4	1	1	9	5454	2017-05-07 21:50:02
5	4	2	2	5454	2017-05-07 21:50:02
6	6	1	1	9393	2017-05-07 21:50:02
7	7	4	3	9393	2017-05-07 21:50:02
8	8	5	2	229	2017-05-07 21:50:02
9	9	6	4	9202	2017-05-07 21:50:02
10	1	1	5	10101	2017-05-07 21:50:02
\.


--
-- Name: boletos_idboletos_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('boletos_idboletos_seq', 1, false);


--
-- Data for Name: caja; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY caja (idcaja, idcine, venta_total) FROM stdin;
1	3	1000
2	4	2000
3	7	12000
4	9	12536
5	9	7890
6	8	4567
7	3	3425
8	2	7283
9	1	5463
10	5	2354
\.


--
-- Name: caja_idcaja_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('caja_idcaja_seq', 1, false);


--
-- Data for Name: cartelera; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cartelera (idcartelera, idcine, idfunciones, disponible) FROM stdin;
1	3	3	si        
2	3	3	si        
3	2	1	si        
4	2	9	si        
5	9	8	si        
6	8	3	si        
7	1	5	si        
8	7	6	si        
9	6	6	si        
10	5	1	si        
\.


--
-- Name: cartelera_idcartelera_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cartelera_idcartelera_seq', 1, false);


--
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY categoria (idcategoria, nombre) FROM stdin;
1	palomitas                                         
2	dulces                                            
3	cafeteria                                         
4	bebidas                                           
5	terror                                            
6	accion                                            
7	infantil                                          
8	comica                                            
9	suspenso                                          
10	animada                                           
\.


--
-- Name: categoria_idcategoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('categoria_idcategoria_seq', 1, false);


--
-- Data for Name: cine; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cine (idcine, direccion, estado, venta_total, nombre) FROM stdin;
1	Direccion Puebla                                                                                    	Puebla                                            	0	Angelopolis                                       
2	Direccion Puebla                                                                                    	Puebla                                            	0	Plaza Valle                                       
3	Direccion Veracruz                                                                                  	Veracruz                                          	0	Rio Blanco                                        
4	Direccion Veracruz                                                                                  	Veracruz                                          	0	Galerias                                          
5	Direccion Monterrey                                                                                 	Monterrey                                         	0	Plaza Cristal                                     
6	Direccion Chihuahua                                                                                 	Chihuahua                                         	0	Plaza Bicentenario                                
7	Direccion Quinatan                                                                                  	Quintana Roo                                      	0	Plaza O                                           
8	Direccion Morelos                                                                                   	Yucatan                                           	0	Cordoba                                           
9	Direccion Tabasco                                                                                   	Tabasco                                           	0	Americas                                          
10	Direccion Merida                                                                                    	Merida                                            	0	Estrellas                                         
\.


--
-- Name: cine_idcine_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cine_idcine_seq', 1, false);


--
-- Data for Name: detalle_venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY detalle_venta (iddetalleventa, idventa, idalimentos, idfunciones, idboletos, cantidad, precio_venta, cantidad_boletos, idmembresia) FROM stdin;
11	9	5	5	1	2	10	29	\N
12	9	5	5	1	2	10	1	\N
13	9	10	5	1	2	10	50	\N
14	9	10	10	1	2	10	50	\N
15	1	1	6	1	2	10	10	\N
1	2	9	2	1	2	123	\N	1
2	3	9	6	4	6	34	\N	2
3	4	10	7	5	7	45	\N	3
4	1	3	5	6	8	56	\N	4
5	2	2	4	2	9	67	\N	5
6	4	1	3	3	10	18	\N	6
7	5	6	2	4	34	90	\N	7
8	6	3	7	5	23	90	\N	8
9	7	5	8	6	12	12	\N	9
10	8	8	9	7	11	12	\N	10
17	1	1	6	1	2	10	10	9
\.


--
-- Name: detalle_venta_iddetalleventa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('detalle_venta_iddetalleventa_seq', 1, false);


--
-- Data for Name: empleado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY empleado (idempleado, idcaja, idcine, nombre, apellido) FROM stdin;
1	2	3	Juan                                              	Perez                                             
2	6	1	Mike                                              	Soto                                              
3	9	4	Juan                                              	Sanchez                                           
4	3	1	John                                              	Kii                                               
5	7	5	Mark                                              	John                                              
6	4	2	Sam                                               	Tyu                                               
7	6	6	Dwyne                                             	Kaa                                               
8	5	8	Sol                                               	Dos                                               
9	4	8	August                                            	Hash                                              
10	3	7	Dan                                               	Kio                                               
\.


--
-- Name: empleado_idempleado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('empleado_idempleado_seq', 1, false);


--
-- Data for Name: fans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY fans (idfans, idcine, nombre, apellido, estado, direccion, num_telefono, email, credito) FROM stdin;
1	3	Suriel                                            	Rosas                                             	Veracruz                                          	mi dir ojo                                                                                          	222828282	suriel@suriel.com                                 	200
2	7	Fernando                                          	Castillo                                          	Puebla                                            	mi dir pue                                                                                          	8282828	fer@fer.com                                       	367
3	3	Miguel                                            	Ponce                                             	Veracruz                                          	mi dir vera                                                                                         	828282	miguel@miguel.com                                 	340
4	4	Carlos                                            	Lopez                                             	Morelos                                           	dir en morelos                                                                                      	828282882	carlos@carlos.com                                 	109
5	8	Ricardo                                           	Urbina                                            	Yucatan                                           	mi dir en yuc                                                                                       	929292929	ric@ric.com                                       	890
6	5	Ismael                                            	Boni                                              	Tamaulipas                                        	mi dir en tama                                                                                      	929292	ism@ism.com                                       	234
7	5	Eduardo                                           	Herrera                                           	Veracruz                                          	dir en verac                                                                                        	919191	edu@edu.com                                       	879
8	9	Ana Karen                                         	Sanchez                                           	Veracruz                                          	verac direcc                                                                                        	29299292	ana@ana.com                                       	456
9	4	Ricardo                                           	Dorame                                            	Puebla                                            	direc en puebl                                                                                      	1919191	rica@rica.com                                     	234
10	5	Heron                                             	Zurita                                            	Puebla                                            	pueb direc                                                                                          	9292929	her@her.com                                       	189
\.


--
-- Name: fans_idfans_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('fans_idfans_seq', 1, false);


--
-- Data for Name: funciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY funciones (idfunciones, idpelicula, idcine, asientos, horario, sala, fecha, disponible) FROM stdin;
1	2	7	34	18.30	2	2017-05-07	si        
2	3	5	45	15.30	3	2017-05-08	si        
3	9	1	50	17.50	2	2017-05-09	si        
4	8	4	40	19.00	1	2017-05-12	si        
7	6	1	45	23.55	3	2017-05-12	si        
8	5	9	50	18.45	7	2017-05-12	si        
9	5	9	60	16.50	2	2017-05-09	si        
5	7	3	-50	20.30	6	2017-05-12	si        
10	7	1	0	13.45	5	2017-05-09	no        
6	4	2	40	23.00	6	2017-05-09	si        
\.


--
-- Name: funciones_idfunciones_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('funciones_idfunciones_seq', 1, false);


--
-- Data for Name: membresia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY membresia (idmembresia, idfans, num_tarjeta, fecha_caducidad, tipo, puntos_acumulados, registro_visitas) FROM stdin;
1	2	9202020	2017-05-07 21:50:02	fan                                               	829	2
2	1	2929202	2017-05-07 21:50:02	fanatico                                          	890	2
3	3	92020202	2017-05-07 21:50:02	fanatico                                          	234	2
4	2	1199191	2017-05-07 21:50:02	super fan                                         	233	2
5	10	829290	2017-05-07 21:50:02	fan                                               	290	2
6	9	8910920	2017-05-07 21:50:02	super fan                                         	192	2
7	1	9202002	2017-05-07 21:50:02	super fan                                         	190	2
8	8	92001020	2017-05-07 21:50:02	fan                                               	89	2
10	6	92020202	2017-05-07 21:50:02	fanatico                                          	198	2
9	5	92010029	2017-05-07 21:50:02	super fan                                         	839	2
\.


--
-- Name: membresia_idmembresia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('membresia_idmembresia_seq', 1, false);


--
-- Data for Name: movimientos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY movimientos (idmovimientos, idmembresia, fecha, puntos_ganados, descripcion) FROM stdin;
1	2	2017-05-07 21:50:02	23	compro tal cosa                                   
2	3	2017-05-07 21:50:02	12	compro tal cosa                                   
3	7	2017-05-07 21:50:02	12	compro tal cosa                                   
4	1	2017-05-07 21:50:02	19	compro tal cosa                                   
5	2	2017-05-07 21:50:02	90	compro tal cosa                                   
6	3	2017-05-07 21:50:02	89	compro tal cosa                                   
7	10	2017-05-07 21:50:02	90	compro tal cosa                                   
8	4	2017-05-07 21:50:02	12	compro tal cosa                                   
9	5	2017-05-07 21:50:02	12	compro tal cosa                                   
10	9	2017-05-07 21:50:02	11	compro tal cosa                                   
\.


--
-- Name: movimientos_idmovimientos_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('movimientos_idmovimientos_seq', 1, false);


--
-- Data for Name: peliculas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY peliculas (idpelicula, idcine, nombre, clasificacion, director, sinopsis, duracion, idcategoria) FROM stdin;
1	2	Barco Fatasma                                     	C                                                 	Mike Marq                                         	aJDASJ DSA DSA DS AD SA DSAD                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        	120 min	5
2	3	Duro de matar                                     	B                                                 	Mark Webb                                         	JSAKJS LKSA SA S SA S A S S                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         	90 min	6
3	1	Intensamente                                      	A                                                 	Christopher Eds                                   	SDOKSD SDSAD SD SAD SADEDEW                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         	140 min	7
4	2	Mision Imposible                                  	B                                                 	Carl Grimes                                       	ASJDOPA DSOAJDPASO POJDAS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           	130 min	6
5	3	Maze Runner                                       	B                                                 	Mark Webb                                         	isajdias sadsa sdpojsad                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             	90 min	9
6	4	Cars                                              	A                                                 	Edson Jr                                          	opsjdpo doajsd pojda óajd                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           	110 min	10
7	9	Toy Story                                         	A                                                 	John Typ                                          	kjakjs jdajk lkaja jsnsn dndndn aj                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  	120 min	7
8	8	IT                                                	C                                                 	Mike Marq                                         	ojao oaj aojkw kalaam lljalan                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       	130 min	5
9	7	Megamente                                         	A                                                 	Jacob Huu                                         	oakssosam asskldandaklxcm slkad                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     	110 min	10
10	7	The Hangover                                      	C                                                 	Carl Breh                                         	sjadpo poasdopamsd xpoasmpos                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        	120 min	8
\.


--
-- Name: peliculas_idpelicula_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('peliculas_idpelicula_seq', 1, false);


--
-- Data for Name: tarjetas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tarjetas (idtarjeta, idfans, num_tarjeta, fecha_caducidad, tipo_tarjeta, banco) FROM stdin;
1	2	920	2017-05-07 21:50:02	credito                                           	SANTANDER                                         
2	3	8181	2017-05-07 21:50:02	debito                                            	SANTANDER                                         
3	8	8282	2017-05-07 21:50:02	debito                                            	BANAMEX                                           
4	9	718	2017-05-07 21:50:02	credito                                           	HSBC                                              
5	3	89	2017-05-07 21:50:02	debito                                            	BANCOMER                                          
6	9	78	2017-05-07 21:50:02	debito                                            	HSBC                                              
7	7	67	2017-05-07 21:50:02	credito                                           	BANAMEX                                           
8	2	56	2017-05-07 21:50:02	debito                                            	HSBC                                              
9	4	45	2017-05-07 21:50:02	debito                                            	BANCOMER                                          
10	1	34	2017-05-07 21:50:02	credito                                           	SANTANDER                                         
\.


--
-- Name: tarjetas_idtarjeta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tarjetas_idtarjeta_seq', 1, false);


--
-- Data for Name: venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY venta (idventa, idfans, idcaja, idempleado, idcine, total_venta, fecha, metodo_pago, idmembresia) FROM stdin;
1	2	9	1	1	980	2017-05-07 21:50:02	efectivo	1
2	3	9	4	2	182	2017-05-07 21:50:02	tarjeta	2
3	2	2	5	1	234	2017-05-07 21:50:02	tarjeta	3
4	3	3	2	3	456	2017-05-07 21:50:02	efectivo	4
5	4	2	3	4	345	2017-05-07 21:50:02	tarjeta	5
6	5	4	1	1	765	2017-05-07 21:50:02	tarjeta	6
7	5	6	2	7	987	2017-05-07 21:50:02	efectivo	7
8	6	6	9	8	890	2017-05-07 21:50:02	efectivo	8
9	8	7	10	2	189	2017-05-07 21:50:02	efectivo	9
10	8	8	7	9	78	2017-05-07 21:50:02	tarjeta	10
\.


--
-- Name: venta_idventa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('venta_idventa_seq', 1, false);


--
-- Name: alimentos alimentos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY alimentos
    ADD CONSTRAINT alimentos_pkey PRIMARY KEY (idalimentos);


--
-- Name: boletos boletos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY boletos
    ADD CONSTRAINT boletos_pkey PRIMARY KEY (idboletos);


--
-- Name: caja caja_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY caja
    ADD CONSTRAINT caja_pkey PRIMARY KEY (idcaja);


--
-- Name: cartelera cartelera_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cartelera
    ADD CONSTRAINT cartelera_pkey PRIMARY KEY (idcartelera);


--
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (idcategoria);


--
-- Name: cine cine_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cine
    ADD CONSTRAINT cine_pkey PRIMARY KEY (idcine);


--
-- Name: detalle_venta detalle_venta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_venta
    ADD CONSTRAINT detalle_venta_pkey PRIMARY KEY (iddetalleventa);


--
-- Name: empleado empleado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY empleado
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (idempleado);


--
-- Name: fans fans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fans
    ADD CONSTRAINT fans_pkey PRIMARY KEY (idfans);


--
-- Name: funciones funciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY funciones
    ADD CONSTRAINT funciones_pkey PRIMARY KEY (idfunciones);


--
-- Name: membresia membresia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY membresia
    ADD CONSTRAINT membresia_pkey PRIMARY KEY (idmembresia);


--
-- Name: movimientos movimientos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movimientos
    ADD CONSTRAINT movimientos_pkey PRIMARY KEY (idmovimientos);


--
-- Name: peliculas peliculas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY peliculas
    ADD CONSTRAINT peliculas_pkey PRIMARY KEY (idpelicula);


--
-- Name: tarjetas tarjetas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tarjetas
    ADD CONSTRAINT tarjetas_pkey PRIMARY KEY (idtarjeta);


--
-- Name: venta venta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY venta
    ADD CONSTRAINT venta_pkey PRIMARY KEY (idventa);


--
-- Name: detalle_venta movimiento_membresia_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER movimiento_membresia_trigger AFTER INSERT ON detalle_venta FOR EACH ROW EXECUTE PROCEDURE registra_movimiento();


--
-- Name: detalle_venta venta_asiento_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER venta_asiento_trigger AFTER INSERT ON detalle_venta FOR EACH ROW EXECUTE PROCEDURE venta_asientos();


--
-- Name: alimentos alimentos_idcategoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY alimentos
    ADD CONSTRAINT alimentos_idcategoria_fkey FOREIGN KEY (idcategoria) REFERENCES categoria(idcategoria);


--
-- Name: boletos boletos_idfans_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY boletos
    ADD CONSTRAINT boletos_idfans_fkey FOREIGN KEY (idfans) REFERENCES fans(idfans);


--
-- Name: boletos boletos_idfunciones_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY boletos
    ADD CONSTRAINT boletos_idfunciones_fkey FOREIGN KEY (idfunciones) REFERENCES funciones(idfunciones);


--
-- Name: boletos boletos_idventa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY boletos
    ADD CONSTRAINT boletos_idventa_fkey FOREIGN KEY (idventa) REFERENCES venta(idventa);


--
-- Name: caja caja_idcine_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY caja
    ADD CONSTRAINT caja_idcine_fkey FOREIGN KEY (idcine) REFERENCES cine(idcine);


--
-- Name: cartelera cartelera_idcine_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cartelera
    ADD CONSTRAINT cartelera_idcine_fkey FOREIGN KEY (idcine) REFERENCES cine(idcine);


--
-- Name: cartelera cartelera_idfunciones_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cartelera
    ADD CONSTRAINT cartelera_idfunciones_fkey FOREIGN KEY (idfunciones) REFERENCES funciones(idfunciones);


--
-- Name: detalle_venta detalle_venta_idalimentos_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_venta
    ADD CONSTRAINT detalle_venta_idalimentos_fkey FOREIGN KEY (idalimentos) REFERENCES alimentos(idalimentos);


--
-- Name: detalle_venta detalle_venta_idboletos_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_venta
    ADD CONSTRAINT detalle_venta_idboletos_fkey FOREIGN KEY (idboletos) REFERENCES boletos(idboletos);


--
-- Name: detalle_venta detalle_venta_idfunciones_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_venta
    ADD CONSTRAINT detalle_venta_idfunciones_fkey FOREIGN KEY (idfunciones) REFERENCES funciones(idfunciones);


--
-- Name: detalle_venta detalle_venta_idmembresia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_venta
    ADD CONSTRAINT detalle_venta_idmembresia_fkey FOREIGN KEY (idmembresia) REFERENCES membresia(idmembresia);


--
-- Name: detalle_venta detalle_venta_idventa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY detalle_venta
    ADD CONSTRAINT detalle_venta_idventa_fkey FOREIGN KEY (idventa) REFERENCES venta(idventa);


--
-- Name: empleado empleado_idcaja_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY empleado
    ADD CONSTRAINT empleado_idcaja_fkey FOREIGN KEY (idcaja) REFERENCES caja(idcaja);


--
-- Name: empleado empleado_idcine_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY empleado
    ADD CONSTRAINT empleado_idcine_fkey FOREIGN KEY (idcine) REFERENCES cine(idcine);


--
-- Name: fans fans_idcine_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fans
    ADD CONSTRAINT fans_idcine_fkey FOREIGN KEY (idcine) REFERENCES cine(idcine);


--
-- Name: funciones funciones_idcine_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY funciones
    ADD CONSTRAINT funciones_idcine_fkey FOREIGN KEY (idcine) REFERENCES cine(idcine);


--
-- Name: funciones funciones_idpelicula_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY funciones
    ADD CONSTRAINT funciones_idpelicula_fkey FOREIGN KEY (idpelicula) REFERENCES peliculas(idpelicula);


--
-- Name: membresia membresia_idfans_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY membresia
    ADD CONSTRAINT membresia_idfans_fkey FOREIGN KEY (idfans) REFERENCES fans(idfans);


--
-- Name: movimientos movimientos_idmembresia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movimientos
    ADD CONSTRAINT movimientos_idmembresia_fkey FOREIGN KEY (idmembresia) REFERENCES membresia(idmembresia);


--
-- Name: peliculas peliculas_idcategoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY peliculas
    ADD CONSTRAINT peliculas_idcategoria_fkey FOREIGN KEY (idcategoria) REFERENCES categoria(idcategoria);


--
-- Name: peliculas peliculas_idcine_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY peliculas
    ADD CONSTRAINT peliculas_idcine_fkey FOREIGN KEY (idcine) REFERENCES cine(idcine);


--
-- Name: tarjetas tarjetas_idfans_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tarjetas
    ADD CONSTRAINT tarjetas_idfans_fkey FOREIGN KEY (idfans) REFERENCES fans(idfans);


--
-- Name: venta venta_idcaja_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY venta
    ADD CONSTRAINT venta_idcaja_fkey FOREIGN KEY (idcaja) REFERENCES caja(idcaja);


--
-- Name: venta venta_idcine_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY venta
    ADD CONSTRAINT venta_idcine_fkey FOREIGN KEY (idcine) REFERENCES cine(idcine);


--
-- Name: venta venta_idempleado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY venta
    ADD CONSTRAINT venta_idempleado_fkey FOREIGN KEY (idempleado) REFERENCES empleado(idempleado);


--
-- Name: venta venta_idfans_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY venta
    ADD CONSTRAINT venta_idfans_fkey FOREIGN KEY (idfans) REFERENCES fans(idfans);


--
-- Name: venta venta_idmembresia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY venta
    ADD CONSTRAINT venta_idmembresia_fkey FOREIGN KEY (idmembresia) REFERENCES membresia(idmembresia);


--
-- PostgreSQL database dump complete
--

