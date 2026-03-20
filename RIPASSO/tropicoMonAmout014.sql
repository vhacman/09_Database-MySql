-- 14) Quanti soldi mi ha reso ogni edificio produttivo dal 1960 al 1965?
--     Presentare il ricavo diviso per edificio.

SELECT
	building.id AS idEdificio,
	buildingType.name AS tipoEdificio,
	resource.name AS risorsaProdotta,
	SUM(pb.market_value) AS ricavoTotale
FROM
	Production_Batch pb
		INNER JOIN building ON building.id = pb.building_id
		INNER JOIN buildingType ON buildingType.id = building.building_type_id
		INNER JOIN resource ON resource.id = buildingType.output_resource_id
WHERE
	pb.production_date BETWEEN '1960-01-01' AND '1965-12-31'
GROUP BY
	building.id, buildingType.name, resource.name
ORDER BY
	ricavoTotale DESC;
