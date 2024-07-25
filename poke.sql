-- creamos una tabla de pokemones
CREATE TABLE Pokemones(
-- coumnas
id_pokemon SERIAL PRIMARY KEY,
poke_nombre VARCHAR (50) UNIQUE NOT NULL,
tipo VARCHAR (50) NOT NULL,
habilidad VARCHAR(100) NOT NULL,
ataque INT NOT NULL,
defensa INT NOT NULL,
nivel INT CHECK (nivel >= 1 AND nivel <= 100)NOT NULL, -- con el check verifica condiones
salud INT CHECK (salud > 0 AND salud <= 1000) NOT NULL
);
-- vemos la tabla de los pokemones
 SELECT * FROM Pokemones
 -- le cargamos los datos 
 INSERT INTO Pokemones VALUES(1,'Guai','Incha','Revertir ataques',23,34,10,100);
 INSERT INTO Pokemones VALUES(2,'Pika','Insecto','Picar',40,10,12,1);
 INSERT INTO Pokemones VALUES(3,'Nini','asinomas','No trabajar ni estudiar',23,34,10,100);
 INSERT INTO Pokemones VALUES(4,'Sky','Natural','Controlar el clima',89,90,50,35);
 INSERT INTO Pokemones VALUES(5,'Anadie','Solitario','Sinceridad destrozante',99,40,28,80);
 INSERT INTO Pokemones VALUES(6,'Arasa','Planta','Dolor explosivo',100,37,70,120);
 -- insertar nuevo pokemon (Intercambiar los valores de algun pokemon nuevo 
 -- VALUES (6,'nombre','tipo','habilidad',ataque,defensa,nivel,salud))
 INSERT INTO Pokemones VALUES(?,?,?,?,?,?,?,?);
 
 -- Eliminar un registro de la tabla pokemones
 DELETE FROM Pokemones
 WHERE id_pokemon = ? --(poner el id)

 -----------------------------------------------------------------------------------------------------------
 -- Creamos una tabla de entrenadores 
CREATE TABLE Entrenadores  (
-- Columnas
id_entrenador SERIAL PRIMARY KEY,
nombre_entrenador VARCHAR (40) UNIQUE NOT NULL,
ciudad VARCHAR (50)NOT NULL,
experiencia INT CHECK (experiencia >= 0) NOT NULL
);
-- vemos el contenido de la tabla
SELECT * FROM Entrenadores 

-- Insertamos el contenido de las tablas
INSERT INTO Entrenadores VALUES(1,'Lucho Flores','Luque',430);
INSERT INTO Entrenadores VALUES(2,'Casimiro Buenavista','Bella Vista',50);
INSERT INTO Entrenadores VALUES(3,'Susu Fernandez','Ciudad del Este',92);
INSERT INTO Entrenadores VALUES(4,'Lucia Fleitas','Luque',134);
INSERT INTO Entrenadores VALUES(5,'Claudia Dominguez','San Sebastian',33);
INSERT INTO Entrenadores VALUES(6,'Arami Benitez','Villa Elisa',10000);
INSERT INTO Entrenadores VALUES(7,'Yanni','Kenedy',9999);
INSERT INTO Entrenadores VALUES(8,'Sol','Asuncion',7777);
-- Insertar datos si se desea
-- values (id,nombre,ciudad,experiencia)
INSERT INTO Entrenadores VALUES(?,?,?);
 -- Eliminar un registro de la tabla Entrenadores
 DELETE FROM Entrenadores
 WHERE id_entrenador = ? --(poner el id)
----------------------------------------------------------

--Creamos la tabla compuesta de dos tablas mas (Pokemones-Entrenadores)
CREATE TABLE Entrenadores_Pokemones(
id_pokemon INT UNIQUE,
id_entrenador INT,
PRIMARY KEY (id_pokemon,id_entrenador),
FOREIGN KEY (id_pokemon) REFERENCES Pokemones(id_pokemon) ON DELETE CASCADE,
FOREIGN KEY (id_entrenador)REFERENCES Entrenadores(id_entrenador) ON DELETE CASCADE
--definimos una clave primaria compuesta para que no haya duplicaciones del id_entrenador y el id_pokemon
);
-- vemos las tablas de entrenadores_pokemones 
SELECT * FROM Entrenadores_Pokemones
-- insertamos los datos a la tabla de entrenadores_pokemones (Pokemones,entrenadores)
INSERT INTO Entrenadores_Pokemones VALUES (1,1);
INSERT INTO Entrenadores_Pokemones VALUES (2,1);
INSERT INTO Entrenadores_Pokemones VALUES (1,2); -- no se puede hacer que dos entrenadores tengan el mismo pokemon
INSERT INTO Entrenadores_Pokemones VALUES (3,2);
INSERT INTO Entrenadores_Pokemones VALUES (4,3);
INSERT INTO Entrenadores_Pokemones VALUES (5,4);
 -- Eliminar un registro de la tabla Entrenador_Pokemon
 DELETE FROM Entrenadores_Pokemones
 WHERE id_entrenador = ? --(poner el id)
-----------------------------------------------------------------------
--creamos la tabla batallas 
 CREATE TABLE Batallas(
 id_batlla SERIAL PRIMARY KEY,
 fecha DATE NOT NULL,
 luagar VARCHAR(100) NOT NULL
 );
 -- actualizamos la tabla de batallas y renombramos una columna
 ALTER TABLE Batallas
 RENAME COLUMN id_batlla TO id_batalla;
  -- vemos la tabla de Batallas
  SELECT * FROM Batallas
 --eliminamos el id de alguna batalla en especifico
 DELETE FROM Batallas
 WHERE id_batalla = ? --(poner el id)
--cargamos los datos a la tabla de batallas
INSERT INTO Batallas VALUES (1,'2024-01-14','Palacio de Luz');
INSERT INTO Batallas VALUES (2,'2024-12-03','Monte de Ypane');
INSERT INTO Batallas VALUES (3,'2024-11-29','Curva de la Muerte');
INSERT INTO Batallas VALUES (4,'2024-08-26','Luque');
INSERT INTO Batallas VALUES (5,'2024-05-03','Valle Oscuro');
INSERT INTO Batallas VALUES (6,'2020-06-07','Lisboa');
INSERT INTO Batallas VALUES (7,'2024-03-04','Peru');
-- si desea agg otra batalla Values (id, fecha, lugar)
INSERT INTO Batallas VALUES (?,?,?);
-- actalizamos el valor de una columna
UPDATE Batallas
SET lugar = 'Africa'
where lugar = 'Peru';
-------------------------------------------
-- Creamos la tabla de participantes batalla y el resulatado
CREATE TABLE Paraticipantes_batalla(
id_batalla INT REFERENCES Batallas(id_batalla) ON DELETE CASCADE,
id_entrenador INT,
id_pokemon INT,
Resultado VARCHAR (100) NOT NULL,
PRIMARY KEY (id_batalla,id_entrenador,id_pokemon),
FOREIGN KEY (id_entrenador,id_pokemon) REFERENCES Entrenadores_pokemones(id_entrenador,id_pokemon) ON DELETE CASCADE 
);
-- alteramos el nombre de la tabla 
ALTER TABLE Paraticipantes_batalla RENAME TO Participantes_batalla;
-- vemos la tabla de Participantes_batalla
SELECT * FROM Participantes_batalla
 -- Eliminar un registro de la tabla Participantes_Batalla
 DELETE FROM Participantes_batalla
 WHERE id_entrenador = ? --(poner el id)
 -- vemos la tabla conjuta de entrenadores con sus pokemones
 SELECT 
 e.id_entrenador,
 e.nombre_entrenador AS Entrenador,
 p.id_pokemon,
 p.poke_nombre AS Pokemones
 FROM Entrenadores e
 JOIN Entrenadores_Pokemones Ep ON e.id_entrenador = Ep.id_entrenador
 JOIN Pokemones p ON Ep.id_pokemon = p.id_pokemon
 ORDER BY e.nombre_entrenador, p.poke_nombre;

 -- Insertamos los datos a la tabla values (idbatalla,identrenador,idpokemon,resutado)
 INSERT INTO Participantes_batalla VALUES(1,1,1,'Gana Lucho y Guai');
 INSERT INTO Participantes_batalla VALUES(1,2,3,'Pierde Casimiro y Nini');
 INSERT INTO Participantes_batalla VALUES(2,1,2,'Gana Lucho y Pika');
 INSERT INTO Participantes_batalla VALUES(2,4,5,'Pierde Lucia y Anadie');


 -----------------------------------------------------------------------

-- MULTITABLE JOIN
SELECT 
     b.id_batalla AS id_batalla,
     b.fecha AS fecha_batalla,
     b.lugar AS lugar_batalla,
     e.id_entrenador AS id_entrenador,
     e.nombre_entrenador AS nombre_entrenador,
     p.id_pokemon AS id_pokemon,
     p.poke_nombre AS Pokemon_nombre,
     pb.resultado AS Resultado_Participantes
     
     FROM Batallas b
     
     JOIN Participantes_batalla pb ON b.id_batalla = pb.id_batalla
     JOIN Entrenadores e ON pb.id_entrenador = e.id_entrenador
     JOIN Pokemones p ON pb.id_pokemon = p.id_pokemon
     ORDER BY b.fecha, b.id_batalla;