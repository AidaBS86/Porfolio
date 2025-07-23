-- Para este ejerccio utilizaremos la BBDD Sakila que hemos estado utilizando durante el repaso de SQL

USE sakila;

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.

SELECT DISTINCT title		-- Uso el distinct para evitar duplicados
FROM film;

-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".

SELECT * FROM film;			-- Selecciono toda la tabla para asegurar donde está el dato que piden

SELECT title título, rating clasificación_por_edad		-- Pongo un alias a cada columna que pido, y añado rating para verificar
FROM film
WHERE rating = 'PG-13';		-- Uso el where la columna donde esta el dato y el igual para buscar solo lo que piden

-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.

SELECT title título, description descripción		
FROM film
WHERE description LIKE '%amazing%';					-- Uso el like para buscar la palabra solicitada en cualquier posición de la frase

-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.

SELECT title título, length duración			-- Saco también la columna length para verificar que sale lo que pido			
FROM film
WHERE length > 120;								-- Uso el mayor que para sacar lo que me piden

-- 5. Encuentra los nombres de todos los actores, muestralos en una sola columna que se llame nombre_actor y contenga nombre y apellido.

SELECT CONCAT(first_name, ' ', last_name) nombre_actor		-- Uso el concat para unir la info de las dos columnas y añado un espacio entre medias
FROM actor;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.

SELECT CONCAT(first_name, ' ', last_name) nombre_actor		
FROM actor
WHERE last_name = 'Gibson';				-- Uso el igual para sacar lo que piden

-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.

SELECT first_name nombre
FROM actor
WHERE actor_id BETWEEN 10 AND 20;		-- Uso el between para añadir el rango que me piden

-- 8. Encuentra el título de las películas en la tabla film que no tengan clasificacion "R" ni "PG-13".

SELECT title título, rating clasificación_por_edad		-- De nuevo añado rating para verificar
FROM film
WHERE rating NOT IN ('R', 'PG-13');				-- Uso el not in para añadir las dos condiciones solicitadas

-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.

SELECT rating clasificación_por_edad, COUNT(title) recuento_películas_clasificación_por_edad   -- Uso el count con title, aunque se podría usar con un *
FROM film
GROUP BY rating;				-- Agrupo por rating para que sea la base del recuento

/* 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su
nombre y apellido junto con la cantidad de películas alquiladas.*/

SELECT * FROM customer;			-- Selecciono las dos tablas implicadas para ver las columnas de cada una
SELECT * FROM rental;

SELECT c.customer_id id_cliente, CONCAT(c.first_name, ' ', c.last_name) nombre_cliente, COUNT(r.rental_id) cantidad_películas_alquiladas
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id		-- La uno por la columna en común con un inner join (aunque un natural join también serviría puesto que se llaman igual en ambas tablas)
GROUP BY c.customer_id;								-- Hago un count en select de rental_id agrupandolo por customer_id para sacar lo que piden

-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

SELECT * FROM rental;						-- Selecciono las 4 tablas implicadas para ver las columnas de cada una y como relacionarlas
SELECT * FROM film_category;
SELECT * FROM category;
SELECT * FROM inventory;

SELECT c.name nombre_categoria, COUNT(r.rental_id) recuento_alquileres_por_categorias		-- Hago count sobre rental_id
FROM category c																				-- Empiezo por la tabla 'clave'
JOIN film_category f ON c.category_id = f.category_id										-- La uno a la tabla que tiene la misma columna...
JOIN inventory i ON i.film_id = f.film_id													-- y así sucesivamente...
JOIN rental r ON i.inventory_id = r.inventory_id											-- hasta llegar a la tabla que tiene los otros datos que interesan
GROUP BY c.name
ORDER BY recuento_alquileres_por_categorias DESC;																			-- Y hago una agrupación por la categoria para que sea la base del count

/* 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y
muestra la clasificación junto con el promedio de duración.*/

SELECT * FROM film;

SELECT rating clasificación_por_edad, AVG(length) promedio_duración_en_clasificación		-- Uso el avg para sacar el promedio de duración...
FROM film
WHERE rating NOT IN ('R', 'G')
GROUP BY rating			-- ...con respecto al rating
HAVING promedio_duración_en_clasificación >113;
-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".

SELECT * FROM actor;
SELECT * FROM film;
SELECT * FROM film_actor;

SELECT CONCAT(a.first_name, ' ', a.last_name) nombres_actores_de_Indian_Love
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id							-- Voy usando el inner join para llegar de la tabla principal...
JOIN film f ON f.film_id = fa.film_id									-- a la tabla de donde saco la condición que se pide.
WHERE f.title = 'Indian Love';

-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.

SELECT title título
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%';		-- Uso el like para buscar ambas condiciones

-- 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.

SELECT a.actor_id actores_que_no_salen_en_ninguna_película		-- Le doy el alias de lo que se pide
FROM actor a
LEFT JOIN film_actor f ON f.actor_id = a.actor_id		-- Uso un left join para que salgan los nulos, si los hay, en la columna film_actor
WHERE f.film_id IS NULL;								-- Y condiciono a que solo se vean los nulos de film_actor (NO HAY NINGUNO)

-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

SELECT title películas_entre_2005_y_2010			-- Le doy el alias de lo que se pide
FROM film
WHERE release_year BETWEEN 2005 AND 2010;			-- Uso el between para sacar el rango solicitado

-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".

SELECT * FROM film;
SELECT * FROM film_category;
SELECT * FROM category;

SELECT f.title películas_de_categoría_Familiar			 -- Le doy el alias de lo que se pide
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Family';


-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.

SELECT * FROM actor;
SELECT * FROM film_actor;

SELECT a.first_name nombre, a.last_name apellido
FROM actor a
JOIN film_actor f ON a.actor_id = f.actor_id			
GROUP BY f.actor_id										-- Agrupo por actor_id...
HAVING COUNT(f.film_id) > 10;							-- para contar los film_id de cada actor y sacar los que tienen mas de 10 film_id

-- Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.

SELECT title película, rating, length				-- Saco rating y length para verificar que está correcto
FROM film
WHERE rating = 'R' AND length > 120;				-- Pongo dos condiciones usando el and

/* 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120
minutos y muestra el nombre de la categoría junto con el promedio de duración.*/

SELECT * FROM category;
SELECT * FROM film;
SELECT * FROM film_category;

SELECT c.name categoría, AVG(f.length) promedio_duración_superior_120		-- Le doy el alias de lo que se pide
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id			-- Uno las tablas por su columna común
JOIN film f ON f.film_id = fc.film_id
GROUP BY c.category_id											-- Agrupo por categoria id...	
HAVING AVG(f.length) > 120;										-- para contar el promedio de la duración y añadir la condición de mayor a 120

/* 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor
junto con la cantidad de películas en las que han actuado.*/

SELECT * FROM actor;
SELECT * FROM film_actor;

SELECT CONCAT(a.first_name, ' ', a.last_name) nombre_actor, COUNT(f.film_id) número_de_películas_hechas		-- Le doy el alias de lo que se pide
FROM actor a
JOIN film_actor f ON f.actor_id = a.actor_id					-- Uno las tablas por su columna común
GROUP BY a.actor_id												-- Agrupo por id de actor...
HAVING COUNT(f.film_id) > 5;									-- para contar el número de film id y condicionar a que sea mayor de 5

/* 22. Encuentra el título de todas las películas que fueron alquiladas durante más de 5 días. Utiliza una
subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona
las películas correspondientes. Pista: Usamos DATEDIFF para calcular la diferencia entre una
fecha y otra, ej: DATEDIFF(fecha_inicial, fecha_final)*/

SELECT * FROM film;
SELECT * FROM rental;
SELECT * FROM inventory;

SELECT DISTINCT f.title películas_alquiladas_durante_mas_de_5_días		-- Le doy el alias de lo que se pide
FROM film f
JOIN inventory i ON i.film_id = f.film_id								-- Uno con la tabla que puede unir las dos que necesito
WHERE i.inventory_id IN(												-- Pongo la condición de que inventory_id esté en... (aquí uso inventory_id porque el número de inventario es por película, aunque se llamen igual, si lo pongo por film_id solo saldrían las alquiladas por nombre único)
	SELECT r.rental_id													-- la subconsulta de...
    FROM rental r
    JOIN inventory i ON i.inventory_id = r.inventory_id					-- unir a la tabla que me lleva a los datos necesarios...
    WHERE DATEDIFF(r.return_date, r.rental_date) >5);					-- y sacar solo los que cumplen la condición solicitada

/* 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la
categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en
películas de la categoría "Horror" y luego exclúyelos de la lista de actores.*/

SELECT * FROM actor;
SELECT * FROM category;
SELECT * FROM film_category;
SELECT * FROM film_actor;

SELECT CONCAT(a.first_name, ' ', a.last_name) nombre_actor_sin_películas_terror			-- Le doy el alias de lo que se pide
FROM actor a
WHERE a.actor_id NOT IN(										-- ... con el where not in al actor id cambio la condición para sacar lo solicitado.
	SELECT a.actor_id											-- Hago primero la subconsulta unidendo las tablas necesarias y después la uno a la consulta principal...
	FROM actor a
	JOIN film_actor fa ON fa.actor_id = a.actor_id
	JOIN film_category fc ON fc.film_id = fa.film_id
	JOIN category c ON fc.category_id = c.category_id
	WHERE c.name = 'Horror');									-- ...incluyo en la subconsulta la condición y...
    
/* 24. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180
minutos en la tabla film con subconsultas.*/

SELECT * FROM category;
SELECT * FROM film;
SELECT * FROM film_category;

SELECT f.title películas_comedia_duración_mayor_180				-- Le doy el alias de lo que se pide
FROM film f
WHERE f.film_id IN(												-- ...con el where in al film id.
	SELECT f.film_id											-- Hago primero la subconsulta unidendo las tablas necesarias y después la uno a la consulta principal...
	FROM film f
	JOIN film_category fc ON fc.film_id = f.film_id
	JOIN category c ON c.category_id = fc.category_id
	WHERE c.name = 'Comedy') AND f.length > 180;				-- ...pongo una condición en la subconsulta y otra fuera para sacar lo que solicitan y...

/* 25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La
consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que
han actuado juntos. Pista: Podemos hacer un JOIN de una tabla consigo misma, poniendole un
alias diferente.*/

SELECT * FROM actor;
SELECT * FROM film_actor;

SELECT CONCAT(a1.first_name, ' ', a1.last_name) nombre_actor1, CONCAT(a2.first_name, ' ', a2.last_name) nombre_actor2, COUNT(f1.film_id) número_películas_en_colaboración
FROM film_actor f1, film_actor f2, actor a1, actor a2			-- Hago un self join sobre las tablas film_actor y actor
WHERE f1.film_id = f2.film_id									-- Condiciono a que el film id 1 sea igual al film id2 para sacar las películas en las que coinciden +
  AND f1.actor_id < f2.actor_id									-- para que no se repitan, con el nombre invertido, uso el menor que sobre actor id1 y 2 +
  AND f1.actor_id = a1.actor_id									-- que actor id de f1 sea = actor id de a1 para sacar el nombre del 1er actor +
  AND f2.actor_id = a2.actor_id									-- que actor id de f2 sea = actor id de a2 para sacar el nombre del 2o actor
GROUP BY a1.actor_id, a2.actor_id								-- Agrupo por cada actor id, 1 y 2...
HAVING COUNT(f1.film_id) > 1;									-- ...para poder contar las film id en las que coinciden y condiciono a que sean mas de 1
    