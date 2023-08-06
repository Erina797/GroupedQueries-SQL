--Creando la Base de Datos // Creating the Database

CREATE DATABASE "desafio2-Natalia-Velasquez-931";
--Conectarse a la Base de Datos \c desafio2-Natalia-Velasquez-931 
--Datos Tabla

DROP TABLE enrolled;
CREATE TABLE IF NOT EXISTS enrolled(id SERIAL PRIMARY KEY, quantity INT, date_enrolled DATE, source VARCHAR);
INSERT INTO enrolled(quantity, date_enrolled, source) VALUES ( 44, '01/01/2021', 'Blog' );
INSERT INTO enrolled(quantity, date_enrolled, source) VALUES ( 56, '01/01/2021', 'Página' );
INSERT INTO enrolled(quantity, date_enrolled, source) VALUES ( 39, '01/02/2021', 'Blog' );
INSERT INTO enrolled(quantity, date_enrolled, source) VALUES ( 81, '01/02/2021', 'Página' );
INSERT INTO enrolled(quantity, date_enrolled, source) VALUES ( 12, '01/03/2021', 'Blog' );
INSERT INTO enrolled(quantity, date_enrolled, source) VALUES ( 91, '01/03/2021', 'Página' );
INSERT INTO enrolled(quantity, date_enrolled, source) VALUES ( 48, '01/04/2021', 'Blog' );
INSERT INTO enrolled(quantity, date_enrolled, source) VALUES ( 45, '01/04/2021', 'Página' );
INSERT INTO enrolled(quantity, date_enrolled, source) VALUES ( 55, '01/05/2021', 'Blog' );
INSERT INTO enrolled(quantity, date_enrolled, source) VALUES ( 33, '01/05/2021', 'Página' );
INSERT INTO enrolled(quantity, date_enrolled, source) VALUES ( 18, '01/06/2021', 'Blog' );
INSERT INTO enrolled(quantity, date_enrolled, source) VALUES ( 12, '01/06/2021', 'Página' );
INSERT INTO enrolled(quantity, date_enrolled, source) VALUES ( 34, '01/07/2021', 'Blog' );
INSERT INTO enrolled(quantity, date_enrolled, source) VALUES ( 24, '01/07/2021', 'Página' );
INSERT INTO enrolled(quantity, date_enrolled, source) VALUES ( 83, '01/08/2021', 'Blog' );
INSERT INTO enrolled(quantity, date_enrolled, source) VALUES ( 99, '01/08/2021', 'Página' );
--Pregunta 1: ¿Cuántos registros hay? // How many records are?
SELECT  COUNT(*)
FROM enrolled;
--Pregunta 2: ¿Cuántos inscritos hay en total? // How many people are enrolled IN total? //
SELECT  SUM(quantity) AS Total_enrolled
FROM enrolled;
--Pregunta 3: ¿Cuál o cuáles son los registros de mayor antigüedad? // Which one or wich are the oldier records?
--Subconsulta
SELECT  MIN(date_enrolled)
FROM enrolled;

SELECT  quantity
       ,date_enrolled
       ,source
FROM enrolled
GROUP BY  date_enrolled
         ,quantity
         ,source
HAVING date_enrolled = (
SELECT  MIN(date_enrolled)
FROM enrolled);
--Pregunta 4: ¿Cuántos inscritos hay por día? // How many people are enrolled per day? //
SELECT  date_enrolled
       ,SUM(quantity) AS "Total_Enrolled"
FROM enrolled
GROUP BY  date_enrolled
ORDER BY date_enrolled ASC;
--Pregunta 5: ¿Cuántos inscritos hay por fuente? // How many people are enrolled by source? //
SELECT  source
       ,SUM(quantity) AS "Total_Enrolled"
FROM enrolled
GROUP BY  source;
-- Pregunta 6: ¿Qué día se inscribieron la mayor cantidad de personas y cuántas personas se inscribieron en ese día? // What was the day of the most enrolled people? AND how many people was enrolled that day? //
SELECT  date_enrolled
       ,SUM(quantity) AS "Total_Enrolled"
FROM enrolled
GROUP BY  date_enrolled
ORDER BY SUM(quantity) DESC
LIMIT 1;
--Pregunta 7: ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog y cuántas personas fueron? // What was the day of the most enrolled people USING the blog? AND how many people was?
SELECT  date_enrolled
       ,source
       ,SUM(quantity)
FROM enrolled
GROUP BY  source
         ,date_enrolled
HAVING source = 'Blog'
ORDER BY SUM(quantity) DESC
LIMIT 1;
--Pregunta 8:¿Cuántas personas en promedio se inscriben en un día? // How many people are enrolled IN average per day? //
SELECT  AVG(totalday)
FROM
(
	SELECT  date_enrolled
	       ,SUM(quantity) AS totalday
	FROM enrolled
	GROUP BY  date_enrolled
) AS newtable;
--Pregunta 9: ¿Qué días se inscribieron más de 50 personas?// What days more than 50 people was enrolled? //
SELECT  date_enrolled
       ,SUM(quantity) AS "Total_Enrolled"
FROM enrolled
GROUP BY  date_enrolled
HAVING SUM(quantity) > 50
ORDER BY date_enrolled ASC;
--Pregunta 10: ¿Cuántas personas se registraron en promedio cada día a partir del tercer día? // How many people were enregistered IN average per day starting after the third day? //
SELECT  date_enrolled
       ,ROUND(AVG(totalday),1) AS "Average_Enrolled"
FROM
(
	SELECT  date_enrolled
	       ,SUM(quantity) AS totalday
	FROM enrolled
	GROUP BY  date_enrolled
	HAVING date_enrolled > '2021-02-01'
) AS newtable
GROUP BY  date_enrolled;
--Salir de la Base de Datos // Exit
FROM de Database \q
