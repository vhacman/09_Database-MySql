-- 6) Produrre l'elenco di tutti tipi di edificio che producono risorse (solo producono, non ne richiedono)
SELECT 
		* 
FROM
	BuildingType 
inner join 
		resource 
on 
	resource.id = BuildingType.output_resource_id 
AND 
	BuildingType.input_resource_id is null
	