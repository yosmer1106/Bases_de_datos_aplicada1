CREATE TABLE USUARIO(
    id_usuario NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR2(30) UNIQUE,
    nombre VARCHAR2(50) NOT NULL,
    biografia VARCHAR2(150),
    foto_perfil VARCHAR2(255),
    tipo_cuenta CHAR(1),
    esta_verificado CHECK(1),
    fecha_registro DATE
);

CREATE TABLE CHAT_GRUPAL(
    id_chat NUMBER GENERATED ALWAYS as IDENTITY PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    fecha_creacion DATE
);

CREATE TABLE PUBLICACIONES(
    id_publicacion NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tipo_contenido CHAR(1),
    url_archivo VARCHAR2(250),
    fecha_hora DATE,
    ubicacion VARCHAR2(100),
    pie_foto VARCHAR2(2000)
    id_usuario NUMBER REFERENCES USUARIO(id_usuario)
);


CREATE TABLE HISTORIAS(
    id_historia NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    url_contenido VARCHAR2(250),
    tipo_contenido CHAR(1),
    fecha_creacion DATE,
    fecha_expiracion DATE,
    es_mejores_amigos CHAR(1),
    estado CHAR(1),
    id_usuario NUMBER REFERENCES USUARIO(id_usuario)
);

CREATE TABLE EN_VIVO(
    id_live NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    url_en_vivo VARCHAR2(250),
    espectadores INT, 
    fecha_inicio DATE,
    fecha_fin DATE,
    estado CHAR(1),
    id_usuario NUMBER REFERENCES USUARIO(id_usuario)
);

CREATE TABLE MENSAJE(
    id_mensaje NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_remitente NUMBER NOT NULL ,
    id_receptor NUMBER,
    id_chat_grupal NUMBER ,
    id_historia_respondida NUMBER,
    tipo_contenido CHAR(1),
    fecha_hora_envio DATE,
    estado CHAR(1)
);
