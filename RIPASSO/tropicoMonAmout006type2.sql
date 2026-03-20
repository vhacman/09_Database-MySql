-- 6) Produrre l'elenco di tutti tipi di edificio che producono risorse (solo producono, non ne richiedono)
SELECT 
		* 
FROM
	BuildingType 
where 
	input_resource_id is null 
AND 
	output_resource_id is not null
	