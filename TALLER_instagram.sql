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

CREATE TABLE SEGUIDOR(
    id_seguidor NUMBER REFERENCES USUARIO(id_usuario),
    id_seguido NUMBER REFERENCES USUARIO(id_usuario),
    estado CHAR(1),
    fecha_seguimiento DATE
);

CREATE TABLE MIEMBROS_CHAT(
    id_chat NUMBER REFERENCES CHAT_GRUPAL(id_chat),
    id_usuario NUMBER REFERENCES USUARIOS(id_usuario),
    fecha_union DATE,
    es_admin CHAR(1)
),

CREATE TABLE PUBLICACIONES(
    id_publicacion NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tipo_contenido CHAR(1),
    url_archivo VARCHAR2(250),
    fecha_hora DATE,
    ubicacion VARCHAR2(100),
    pie_foto VARCHAR2(2000),
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

CREATE TABLE INSTANTANEA(
    id_instantanea NUMBER GENERATED ALWAYS AS IDENDITY PRIMARY KEY,
    fecha_hora DATE,
    privacidad CHAR(1),
    reaccion_instantaneas VARCHAR2(10),
    id_usuario NUMBER REFERENCES USUARIO(id_usuario)
);

CREATE TABLE VISUALIZACION_INSTANT

CREATE TABLE NOTA(
    id_nota NUMBER GENERATED ALWAYS AS IDENDITY PRIMARY KEY,
    texto VARCHAR2(80),
    titulo_cancion VARCHAR2(100),
    artista_cancion VARCHAR2(100),
    es_mejores_amigos CHAR(1),
    fecha_creacion DATE,
    fecha_expiracion DATE,
    id_usuario NUMBER REFERENCES USUARIO(id_usuario)
);

CREATE TABLE COMENTARIOS(
    id_comentario NUMBER GENERATED ALWAYS AS IDENDITY PRIMARY KEY,
    texto VARCHAR2(250),
    fecha_hora DATE,
    id_usuario NUMBER REFERENCES USUARIO(id_usuario),

    id_publicacion NUMBER REFERENCES PUBLICACIONES(id_publicacion),
    id_live NUMBER REFERENCES EN_VIVO(id_live),
    id_historia NUMBER REFERENCES HISTORIAS(id_historia),
    id_nota NUMBER REFERENCES NOTA(id_nota)
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

CREATE TABLE REACCION(
    id_usuario NUMBER REFERENCES USUARIO(id_usuario),
    id_mensaje NUMBER REFERENCES MENSAJE(id_mensaje),
    emoji VARCHAR2(10),
    fecha_hora DATE
);

CREATE TABLE ME_GUSTA(
    id_usuario NUMBER REFERENCES USUARIO(id_usuario),
    id_publicacion NUMBER REFERENCES PUBLICACIONES(id_publicacion),
    id_historia NUMBER REFERENCES HISTORIAS(id_historia),
    id_comentario NUMBER REFERENCES COMENTARIOS(id_comentario),
    id_nota NUMBER REFERENCES NOTA(id_nota)
);


COMMIT;   





