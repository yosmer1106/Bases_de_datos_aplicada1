CREATE TABLE CANCION(
    id_cancion NUMBER,
    titulo VARCHAR2(200),
    artista VARCHAR2(200),
    album VARCHAR2(200),
    genero VARCHAR2(200),
    duracion_segundos NUMBER,
    fecha_lanzamiento DATE

);


INSERT INTO CANCION(id_cancion, titulo, artista, album, genero, duracion_segundos, fecha_lanzamiento) VALUES (1, 'Don Cry', 'Use you', 'illusions', 'Guns and Roses', 200, DATE '1991-09-17');