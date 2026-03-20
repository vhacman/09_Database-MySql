-- 10) Raggruppare gli edifici per tipo:
--     Stampare il nome del tipo dell'edificio e il numero di edifici di quel tipo sull'isola

SELECT
	buildingType.name AS tipoEdificio,
	COUNT(building.id) AS numeroEdifici
FROM
	buildingType
		INNER JOIN building ON buildingType.id = building.building_type_id
GROUP BY
	buildingType.id, buildingType.name;
