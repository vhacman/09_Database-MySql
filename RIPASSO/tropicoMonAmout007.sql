-- 7) Produrre l'elenco di tutti i tipi di edificio che producono risorse col nome della risorsa prodotta
SELECT bt.name as buildingName, resource.name as resourceName
FROM
	BuildingType bt
inner join resource on resource.id = bt.output_resource_id