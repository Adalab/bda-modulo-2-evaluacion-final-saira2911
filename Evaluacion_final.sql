USE sakila;

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
SELECT DISTINCT `title`
	FROM `film`;
    
-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
SELECT `title`
	FROM `film`
WHERE `rating` = 'PG-13';

-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
SELECT `title`, `description`
	FROM `film`
WHERE `description` LIKE '%amazing%'; 

-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
SELECT `title`
	FROM `film`
WHERE `length` > '120';

-- 5. Recupera los nombres de todos los actores.
SELECT `first_name` -- no se si pide solo el nombre o el nombre completo, en tal caso añadiría `last_name` al SELECT
	FROM `actor`;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
SELECT `first_name`, `last_name`
	FROM `actor`
WHERE `last_name` = 'Gibson';

-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
SELECT `first_name`
	FROM `actor`
WHERE `actor_id` BETWEEN 10 AND 20;

-- 8. Encuentra el título de las películas en la tabla `film` que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
SELECT `title`
	FROM `film`
WHERE `rating` NOT IN ('R', 'PG-13');

-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla `film` y muestra la clasificación junto con el recuento.
SELECT COUNT(`film_id`) AS `movies number`, `rating`
	FROM `film`
GROUP BY `rating`;

-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
SELECT COUNT(`inventory_id`) AS `rented movies`, `customer_id`, `first_name`, `last_name` -- cada id_inventario se refiere a una pelicula, por lo que sabiendo en num de inventarios relacionados con el cliente sabemos el num de peliculas que ha alquilado
	FROM `customer`
LEFT JOIN `rental`
	USING (`customer_id`)
GROUP BY `customer_id`; -- agrupamos por cliente

-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

-- Category -> film_category -> inventory -> rental. 
-- Hacemos joins entre tablas hasta unir las que contienen los datos que nos solicitan, hacemos LEFT JOIN por si existe 
-- un genero del que no se haya alquilado ninguna pelicula. Contamos inventory_id ya que correcponde al total de peliculas  
-- alquiladas incluyendo duplicados (misma pelicula alquilada varias veces) y agrupamos por los nombres de las categorias.
SELECT COUNT(`r`.`inventory_id`) AS `rented movies`, `c`.`name` AS `category`
	FROM `category` AS `c`
LEFT JOIN `film_category` AS `fc`
	USING (category_id)
LEFT JOIN `inventory` AS `i`
	USING (`film_id`)
LEFT JOIN `rental` AS `r`
	USING (inventory_id)
GROUP BY `c`.`name`;

-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla `film` y muestra la clasificación junto con el promedio de duración.
SELECT AVG(`length`) AS `average length`, `rating`
	FROM `film`
GROUP BY `rating`;

-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".

-- actor -> film_actor -> film 
-- hacemos inner join porque buscamos una pelicula en concreto.
SELECT `first_name`, `last_name`
	FROM `actor`
INNER JOIN `film_actor`
	USING (`actor_id`)
INNER JOIN `film`
	USING (`film_id`)
WHERE `title` = 'Indian Love';

-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
SELECT `title`, `description`
	FROM `film`
WHERE `description` LIKE '% dog %' OR `description` LIKE '% cat %'; -- ponemos espacios para que no coja palabras que contengan dog o cat

-- 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla `film_actor`.
-- No hay ningun actor que no haya actuado en alguna pelicula.
SELECT `first_name`, `last_name`
	FROM `actor`
LEFT JOIN `film_actor` -- hacemos left join para coger TODOS los actores
	USING (`actor_id`)
WHERE `film_id` IS NULL;


-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".

-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.

-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla `film`.

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre 
-- de la categoría junto con el promedio de duración.

-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad 
-- de películas en las que han actuado.

-- 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta 
-- para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.

-- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". 
-- Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y 
-- luego exclúyelos de la lista de actores.

## BONUS

-- 24. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la 
-- tabla `film`.

-- 25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar 
-- el nombre y apellido de los actores y el número de películas en las que han actuado juntos.