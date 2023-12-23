/* creacion de tablas */
/* punto 1*/
CREATE TABLE peliculas (
  id serial PRIMARY KEY,
  nombre varchar(255) NOT NULL,
  anno integer NOT NULL
);

CREATE TABLE tags (
  id serial PRIMARY KEY,
  tag varchar(255) NOT NULL
);

CREATE TABLE peliculas_tags (
  pelicula_id integer REFERENCES peliculas (id),
  tag_id integer REFERENCES tags (id),
  PRIMARY KEY (pelicula_id, tag_id)
);

/* insert de datos */
/* punto 2 */

INSERT INTO peliculas (nombre, anno) VALUES
('El padrino', 1972),
('El señor de los anillos: La comunidad del anillo', 2001),
('Star Wars: Episodio IV - Una nueva esperanza', 1977),
('Parque Jurásico', 1993),
('Titanic', 1997);

INSERT INTO tags (tag) VALUES
('Drama'),
('Acción'),
('Fantasía'),
('Ciencia ficción'),
('Romance');

INSERT INTO peliculas_tags (pelicula_id, tag_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 2),
(2, 3);

/* punto 3 */
select P.nombre, count(PT.tag_id) cantidad_tags from peliculas P
left join peliculas_tags as PT on
P.id = PT.pelicula_id
group by P.nombre


/* crecion de tablas */
/* punto 4 */
CREATE TABLE preguntas (
  id SERIAL PRIMARY KEY,
  pregunta VARCHAR(255) NOT NULL,
  respuesta_correcta VARCHAR(255) NOT NULL   
);

CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  edad INT NOT NULL
);

CREATE TABLE respuestas (
  id SERIAL PRIMARY KEY,
  respuesta VARCHAR(255) NOT NULL,
  usuario_id INT NOT NULL,
  pregunta_id INT NOT NULL,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
  FOREIGN KEY (pregunta_id) REFERENCES preguntas(id)
);

/* punto 5 */
INSERT INTO usuarios (nombre, edad)
VALUES
  ('Juan', 25),
  ('María', 20),
  ('Pedro', 30),
  ('Ana', 35),
  ('Luis', 40);

INSERT INTO preguntas (pregunta, respuesta_correcta)
VALUES
  ('¿Cuál es la capital de España?', 'Madrid'),
  ('¿Cuál es el nombre del presidente de los Estados Unidos?', 'Joe Biden'),
  ('¿Cuál es el nombre del primer hombre que pisó la Luna?', 'Neil Armstrong'),
  ('¿Cuál es el nombre del afluente más largo del río Paraná?', 'Uruguay'),
  ('¿Cuál es el nombre del volcán más alto de Chile?', 'Ojos del Salado');

INSERT INTO respuestas (respuesta, usuario_id, pregunta_id)
VALUES
  ('Madrid', 1, 1),
  ('Madrid', 2, 1),
  ('Joe Biden', 1, 2),
  ('Santiago', 2, 3),
  ('Mont Blanc', 3, 4),
  ('Aconcagua', 4, 5);
  
/*punto 6 */
select nombre, RC.respuestas_correctas from usuarios U
join (
select R.usuario_id, count(R.usuario_id) respuestas_correctas from respuestas R
join preguntas P on R.pregunta_id = P.id and R.respuesta = P.respuesta_correcta
group by R.usuario_id) as RC
on U.id = RC.usuario_id

/* punto 7 */

select P.pregunta,count(RC.respuestas_correctas) cantidad_usuarios from preguntas P
left join (
select P.id,  count(R.usuario_id) respuestas_correctas from respuestas R
join preguntas P on R.pregunta_id = P.id and R.respuesta = P.respuesta_correcta
group by P.id, R.usuario_id) as RC
on P.id = RC.id
group by P.pregunta, P.id
order by P.id

/* punto 8 */
ALTER TABLE respuestas
DROP CONSTRAINT respuestas_usuario_id_fkey,
ADD FOREIGN KEY 
 (usuario_id) REFERENCES usuarios (id) ON DELETE CASCADE;

/* punto 9 */
ALTER TABLE usuarios
ADD CONSTRAINT ck_edad CHECK (edad >= 18);

/* punto 10 */
ALTER TABLE usuarios
ADD COLUMN email VARCHAR(255) UNIQUE;




