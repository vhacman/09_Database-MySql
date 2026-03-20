-- 7.4) Stampare nome e cognome di tutti i cittadini impiegati nella produzione di materie prime di qualunque tipo

SELECT
	citizen.first_name, citizen.last_name
FROM
	resource
		INNER JOIN buildingType ON resource.id = buildingType.output_resource_id
		INNER JOIN building ON buildingType.id = building.building_type_id
		INNER JOIN citizen ON citizen.job_building_id = building.id
WHERE
	resource.is_processed = false; -- solo materie prime, non beni lavorati
