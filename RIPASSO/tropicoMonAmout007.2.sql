-- 7.2) Quali cittadini producono mais? Stampare nome e cognome.

SELECT
	citizen.first_name, citizen.last_name
FROM
	resource
		INNER JOIN buildingType ON resource.id = buildingType.output_resource_id
		INNER JOIN building ON buildingType.id = building.building_type_id
		INNER JOIN citizen ON citizen.job_building_id = building.id
WHERE
	resource.name = 'Mais';
