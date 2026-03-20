-- 8) Produrre l'elenco di tutti i tipi di edificio che richiedono risorse e producono risorse,
--    stampando il nome delle risorse prodotte e richieste

SELECT
	bt.name AS nomeEdificio,
	rIn.name AS risorsaRichiesta,
	rOut.name AS risorsaProdotta
FROM
	buildingType bt
		INNER JOIN resource rIn ON rIn.id = bt.input_resource_id
		INNER JOIN resource rOut ON rOut.id = bt.output_resource_id;
-- il doppio join su resource permette di ottenere sia la risorsa in ingresso che quella in uscita
