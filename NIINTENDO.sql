DROP TABLE ACCESORIO_PRUEBA CASCADE CONSTRAINTS;
DROP TABLE JUGADOR CASCADE CONSTRAINTS;
DROP TABLE VIDEOJUEGO CASCADE CONSTRAINTS;
DROP TABLE FRANQUICIA CASCADE CONSTRAINTS;
DROP TABLE CONSOLA CASCADE CONSTRAINTS;


DELETE FROM consola WHERE id_consola = 3;

COMMIT;

CREATE TABLE CONSOLA(
    id_consola NUMBER(4) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_consola VARCHAR2(20) NOT NULL UNIQUE, 
    tipo_consola VARCHAR2(20) NOT NULL CHECK (tipo_consola IN ('SOBREMESA', 'PORTATIL', 'HIBRIDA')),
    anio_lanzamiento NUMBER(4) NOT NULL CHECK (anio_lanzamiento BETWEEN 1983 AND 2030),
    precio_referencia_usd NUMBER(6,2) NOT NULL CHECK (precio_referencia_usd > 0),
    estado_fabricacion VARCHAR2(15) DEFAULT 'ACTIVA' NOT NULL CHECK(estado_fabricacion IN ('ACTIVA', 'DESCONTINUADA'))
);

CREATE TABLE FRANQUICIA(
    id_franquicia NUMBER(4) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_franquicia VARCHAR2(60) NOT NULL UNIQUE,
    creador_principal VARCHAR2(80) NULL,
    anio_debut NUMBER(4) NOT NULL CHECK (anio_debut >= 1980),
    estudio_principal VARCHAR2(60) DEFAULT 'NINTENDO EPD' NOT NULL 
);

CREATE TABLE VIDEOJUEGO(
    id_juego NUMBER(6) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    codigo_catalogo VARCHAR2(10) NOT NULL UNIQUE,
    titulo_juego VARCHAR2(100) NOT NULL,
    id_franquicia NUMBER(4) NOT NULL REFERENCES FRANQUICIA(id_franquicia),
    id_consola NUMBER(4) NOT NULL REFERENCES CONSOLA (id_consola),
    clasificacion_esrb VARCHAR2(5) NOT NULL CHECK (clasificacion_esrb IN ('E', 'E10+', 'T', 'M')),
    precio_clp NUMBER(8) NOT NULL CHECK (precio_clp >= 0 ),
    puntaje_metratic NUMBER(3) CHECK (puntaje_metratic BETWEEN 0 AND 100),
    stock_fisico NUMBER(5) DEFAULT 0 NOT NULL CHECK (stock_fisico >= 0 ),
    fecha_lanzamiento DATE NOT NULL 
);

CREATE TABLE JUGADOR(
    id_jugador NUMBER(6) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nickname VARCHAR2(30) NOT NULL UNIQUE,
    email VARCHAR2(100) NOT NULL UNIQUE,
    pais VARCHAR2(40) DEFAULT 'Chile' NOT NULL,
    monedas_oro NUMBER(6) DEFAULT 0 NOT NULL CHECK (monedas_oro >= 0 ),
    suscripcion_online VARCHAR2(15) DEFAULT 'GRATUITA' NOT NULL CHECK (suscripcion_online IN ('GRATUITA', 'INDIVIDUAL', 'FAMILIAR', 'EXPANSION')),
    id_juego_favorito NUMBER(6) REFERENCES VIDEOJUEGO (id_juego) 
);

---CREACION TABLA ACCESORIO PRUEBA
CREATE TABLE ACCESORIO_PRUEBA(
    id_accesorio NUMBER(4) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_accesorio VARCHAR2(40) NOT NULL,
    precio_usd NUMBER(5, 2) NOT NULL CHECK (precio_usd > 0),
    id_consola NUMBER(4) NOT NULL REFERENCES CONSOLA (id_consola)
);


--- LOS ALTER TABLEE-----



---UTILIZAR ALTER SOBRE LA TABLA JUGADOR PARA AGREGAR NUEVA COLUMNA LLAMADA FECHA REGISTRO---
ALTER TABLE JUGADOR ADD fecha_registro  DATE DEFAULT SYSDATE NOT NULL;


---UTILIZAR ALTER SOBRE LA TABLA JUGADOR PARA AGREGAR NIVEL CUENTA---
ALTER TABLE JUGADOR ADD nivel_cuenta NUMBER(3) DEFAULT 1 NOT NULL CHECK (nivel_cuenta BETWEEN 1 AND 99);


---MODIFICAR LA TABLA DE ACCESORIO PRUEBA Y AMPLIAR LA COLUMNA NOMBRE ACCESORIO---
ALTER TABLE ACCESORIO_PRUEBA MODIFY nombre_accesorio VARCHAR2(100);


---AGREGAR UNA COLUMNA A ACCESORIO PRUEBA LLAMADA COLOR EDICION----

ALTER TABLE ACCESORIO_PRUEBA ADD color_edicion VARCHAR2(25);


---ELIMINAR LA MISMA COLUMNA COLOR EDICION----
ALTER TABLE ACCESORIO_PRUEBA DROP COLUMN color_edicion;


---ELIMINAR POR COMPLETO LA TABLA ACCESORIO PRUEBA---
DROP TABLE ACCESORIO_PRUEBA;


---MEDIANTE LA TABLA VIDEOJUEGO AGREGAR UNA NUEVA COLUMNA LLAMADA DESCUENTO_PORCENTAJE.
ALTER TABLE VIDEOJUEGO ADD descuento_porcentaje NUMBER(3) DEFAULT 0 NOT NULL CHECK (descuento_porcentaje BETWEEN 0 AND 80);


---LOS INSERT INTO---


---INSERTAR DATOS EN LA TABLA CONSOLA---
INSERT INTO CONSOLA(nombre_consola, tipo_consola, anio_lanzamiento, precio_referencia_usd, estado_fabricacion ) VALUES
 ('Nintendo Switch', 'HIBRIDA', 2017, 299.99, 'ACTIVA');
COMMIT;


 ---INSERTAR 3 CONSOLAS MAS EN CONSOLA LA 2, 3, 4---
INSERT INTO CONSOLA(nombre_consola, tipo_consola, anio_lanzamiento, precio_referencia_usd) VALUES 
 ('Nintendo Switch 2', 'HIBRIDA', 2025, 499.99);
COMMIT;


INSERT INTO CONSOLA(nombre_consola, tipo_consola, anio_lanzamiento, precio_referencia_usd, estado_fabricacion) VALUES 
 ('Nitendo 3DS', 'PORTATIL', 2011, 169.99, 'DESCONTINUADA');
COMMIT;



INSERT INTO CONSOLA(nombre_consola, tipo_consola, anio_lanzamiento, precio_referencia_usd, estado_fabricacion) VALUES 
 ('Nintendo GameCube', 'SOBREMESA', 2001, 199.99, 'DESCONTINUADA');
COMMIT;


 ---INSERTAR 6 FRANQUICIAS EN LA TABLA FRANQUICIA---

 --1---
INSERT INTO FRANQUICIA(nombre_franquicia, creador_principal, anio_debut) VALUES 
 ('Super Mario', 'Shigeru Miyamoto', 1985);
COMMIT;

---2---
INSERT INTO FRANQUICIA(nombre_franquicia, creador_principal, anio_debut) VALUES 
 ('The Legend of Zelda', 'Shigeru Miyamoto', 1986);
COMMIT;

---3---
INSERT INTO FRANQUICIA(nombre_franquicia, creador_principal, anio_debut, estudio_principal) VALUES 
 ('Pokemon', 'Satoshi Tajiri', 1996, 'Game Freak');
COMMIT;

---4---
INSERT INTO FRANQUICIA(nombre_franquicia, creador_principal, anio_debut, estudio_principal) VALUES 
 ('Metroid', 'Gunpei Yokoi', 1986, 'MercurySteam');
COMMIT;

---5---
INSERT INTO FRANQUICIA(nombre_franquicia, creador_principal, anio_debut, estudio_principal) VALUES 
 ('Super Smash Bros', 'Masahiro Sakurai', 1999, 'Bandai');  
COMMIT;

---6---
INSERT INTO FRANQUICIA(nombre_franquicia, creador_principal, anio_debut, estudio_principal) VALUES 
 ('Splatoon', NULL, 2015, DEFAULT );
COMMIT;


 ---INSERTAR LOS 3 PRIMEROS VIDEOJUEGOS DEL CATALOGO VIDEOJUEGOS---

---1---
INSERT INTO VIDEOJUEGO(codigo_catalogo, titulo_juego, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metratic, stock_fisico, fecha_lanzamiento) VALUES 
('NSW-001', 'The Legend of Zelda: Breath of the Wild', 2, 1, 'E10+', 54990, 97, 45, TO_DATE('2017-03-03', 'YYYY-MM-DD'));
COMMIT;

---2----
INSERT INTO VIDEOJUEGO(codigo_catalogo, titulo_juego, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metratic, stock_fisico, fecha_lanzamiento) VALUES 
('NSW-002', 'Super Mario Odyssey', 1, 1, 'E10+', 49990, 97, 60, TO_DATE('2017-10-27', 'YYYY-MM-DD'));
COMMIT;

---3---
INSERT INTO VIDEOJUEGO(codigo_catalogo, titulo_juego, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metratic, stock_fisico, fecha_lanzamiento) VALUES 
('NSW-003', 'Metroid Dread', 4, 1, 'T', 44990, 88, 15, TO_DATE('2021-10-08', 'YYYY-MM-DD' ));
COMMIT;


---INSERTAR 4 VIDEOJUEGOS ADICIONALES EN VIDEOJUEGOS---

---4---
INSERT INTO VIDEOJUEGO(codigo_catalogo, titulo_juego, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metratic, stock_fisico, fecha_lanzamiento) VALUES 
('NSW-004', 'Super Smash Bros. Ultimate', 5, 1, 'E10+', 59990, 93, 80, TO_DATE('2018-12-07','YYYY-MM-DD' ));
COMMIT;

---5---
INSERT INTO VIDEOJUEGO(codigo_catalogo, titulo_juego, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metratic, stock_fisico, fecha_lanzamiento) VALUES 
('NSW-005', 'Pokemon Escarlata', 3, 1, 'E', 49990, 72, 30, TO_DATE('2022-11-18', 'YYYY-MM-DD' ));
COMMIT;

---6---
INSERT INTO VIDEOJUEGO(codigo_catalogo, titulo_juego, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metratic, stock_fisico, fecha_lanzamiento) VALUES 
('NS2-001', 'Mario Kart World', 1, 2, 'E', 69990, NULL, DEFAULT, TO_DATE('2025-06-05', 'YYYY-MM-DD' ));
COMMIT;

---7---
INSERT INTO VIDEOJUEGO(codigo_catalogo, titulo_juego, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metratic, stock_fisico, fecha_lanzamiento) VALUES 
('3DS-001', 'Pokemon Sol', 3, 3, 'E', 29990, 87, 5, TO_DATE('2016-11-18',  'YYYY-MM-DD' ));
COMMIT;


---REGISTRAR LOS PRIMEROS 4 JUGADORES EN LA TABLA JUGADOR---

---1---
INSERT INTO JUGADOR(nickname, email, pais, monedas_oro, suscripcion_online, id_juego_favorito) VALUES 
('LinkHyrule99', 'link@hyrule.cl', DEFAULT, 1200, 'EXPANSION', 1);
COMMIT;

---2---
INSERT INTO JUGADOR(nickname, email, pais, monedas_oro, suscripcion_online, id_juego_favorito) VALUES 
('SamusHunter', 'samus@zebes.cl', 'Chile', 450, 'INDIVIDUAL', 3);
COMMIT;

---3---
INSERT INTO JUGADOR(nickname, email, pais, id_juego_favorito) VALUES 
('PikaTrainer', 'ash@kanto.pe', 'Peru',  NULL);
COMMIT;

---4---
INSERT INTO JUGADOR(nickname, email, pais, monedas_oro, suscripcion_online, id_juego_favorito) VALUES 
('MarioSpeedrun', 'mario@champinon.ar', 'argentina', 3500, 'FAMILIAR', 2);
COMMIT;


---FALLO 1 PROVOCAR Y CORREGIR VIOLACION DE CHECK---

INSERT INTO VIDEOJUEGO(codigo_catalogo, titulo_juego, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metratic, stock_fisico, fecha_lanzamiento) VALUES 
('NSW-008', 'The Legend of Zelda: Tears of the Kingdom', 2, 1, 'E10+', 64990, 96, 50, TO_DATE('2023-05-12', 'YYYY-MM-DD' ));
COMMIT;


---FALLO 2 PROVOCAR Y CORREGIR VIOLACION DE FOREIGN KEY---
INSERT INTO VIDEOJUEGO(codigo_catalogo, titulo_juego, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metratic, stock_fisico, fecha_lanzamiento) VALUES 
('GCN-001', 'Super Smash Bros. Melee', 5, 4, 'T', 39990, 92, 0, TO_DATE('2001-11-21', 'YYYY-MM-DD' ));
COMMIT;

---FALLO 3 PROVOCAR Y CORREGIR VIOLACION UNIQUE---
---5---
INSERT INTO JUGADOR(nickname, email, pais, monedas_oro, suscripcion_online, id_juego_favorito) VALUES 
('ZeldaWisdom', 'zelda@hyrule.cl', 'Chile', 800, 'EXPANSION', 8);
COMMIT;

---6---
INSERT INTO JUGADOR(nickname, email, pais, monedas_oro, suscripcion_online, id_juego_favorito) VALUES 
('KirbyGourmet', 'kirby@dreamland.mx', 'Mexico', 150, 'GRATUITA', NULL);
COMMIT;


---INSERCIONES DE REGISTROS TEMPORALES---


INSERT INTO VIDEOJUEGO(codigo_catalogo, titulo_juego, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metratic, stock_fisico, fecha_lanzamiento) VALUES 
('NSW-999', 'Proyecto Secreto Cancelado', 6, 1, 'T', 10000, NULL, 0, SYSDATE);
COMMIT;

INSERT INTO JUGADOR(nickname, email, pais, monedas_oro, suscripcion_online, id_juego_favorito) VALUES 
('BotSpam01', 'spam@bot.com', 'Desconocido', 0, 'GRATUITA', 12);
COMMIT;


---ACTUALIZACION DE REGISTRO CON LOS UPDATE---

UPDATE VIDEOJUEGO SET stock_fisico = 75 WHERE id_juego = 5;
COMMIT;


UPDATE JUGADOR SET suscripcion_online = 'INDIVIDUAL', id_juego_favorito = 5 WHERE id_jugador = 3;
COMMIT;


UPDATE VIDEOJUEGO SET puntaje_metratic = 94, stock_fisico = 120 WHERE id_juego = 6;
COMMIT;

UPDATE JUGADOR SET monedas_oro = monedas_oro + 250 WHERE pais = 'Chile';
COMMIT;


UPDATE VIDEOJUEGO SET precio_clp = ROUND(precio_clp * 0.85) WHERE id_consola = 1 AND precio_clp > 50000;
COMMIT;

UPDATE FRANQUICIA SET estudio_principal = 'Nintendo EPD Kyoto' WHERE id_franquicia IN (1, 2);
COMMIT;


UPDATE VIDEOJUEGO SET stock_fisico = stock_fisico + 30 WHERE id_consola = 1 AND stock_fisico BETWEEN 1 AND 20;
COMMIT;

---PONIENDO APRUEBA EL CHECK EN UPDATE (EVITANDO SALTO NEGATIVO )---

UPDATE JUGADOR SET monedas_oro = monedas_oro - 150 WHERE id_jugador = 6;
COMMIT;

UPDATE JUGADOR SET id_juego_favorito = NULL WHERE id_juego_favorito = 12;
COMMIT;

UPDATE JUGADOR SET monedas_oro = monedas_oro + 500 WHERE (suscripcion_online = 'EXPANSION' OR suscripcion_online = 'FAMILIAR') AND id_juego_favorito IS NOT NULL;
COMMIT;

---DELETEE FROM---
--- ELIMINAR CUENTA  BOT CLAVE PRIMARIA----
DELETE FROM JUGADOR WHERE id_jugador = 7;
COMMIT;

---ELIMINAR VIDEOJUEGO CANCELADO POR SU CODIGO CATALOGO---
DELETE FROM videojuego WHERE codigo_catalogo = 'NSW-999';
COMMIT;

---ELIMINAR FRANQUICIA SIN VIDEOJUEGOS ASOCIADOS---
DELETE FROM FRANQUICIA 










SELECT codigo_catalogo AS codigo, titulo AS nombre_videojuego, clasificacion_esrb AS esrb, precio_clp AS precio_actual FROM VIDEOJUEGO;

SELECT titulo, precio_clp, ROUND(precio_clp * 1.19) AS precio_con_iva, ROUND(precio_clp / 950, 2) AS precio_estimado_usd FROM VIDEOJUEGO;

SELECT titulo, puntaje_metratic, precio_clp FROM VIDEOJUEGO WHERE puntaje_metratic >= 90 ORDER BY puntaje_metratic DESC, titulo ASC;

