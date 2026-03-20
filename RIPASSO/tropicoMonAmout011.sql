-- 11) Quanto tabacco è stato prodotto dal 1960 al 1965?

SELECT
	SUM(pb.amount) AS tabaccoProdotto
FROM
	Production_Batch pb
		INNER JOIN building ON building.id = pb.building_id
		INNER JOIN buildingType ON buildingType.id = building.building_type_id
		INNER JOIN resource ON resource.id = buildingType.output_resource_id
WHERE
	resource.name = 'Tabacco'
	AND pb.production_date BETWEEN '1960-01-01' AND '1965-12-31';
