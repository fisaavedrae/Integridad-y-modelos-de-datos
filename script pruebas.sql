select * from usuarios;
select * from respuestas;
--update respuestas set usuario_id = 3 where id = 3
select * from preguntas;

--insert into usuarios (nombre, edad, email) values ('felipe',19,'asd@as.cl')
--delete from usuarios where id = 1


ALTER TABLE respuestas
DROP CONSTRAINT respuestas_usuario_id_fkey,
ADD FOREIGN KEY 
 (usuario_id) REFERENCES usuarios (id) ON DELETE CASCADE;
