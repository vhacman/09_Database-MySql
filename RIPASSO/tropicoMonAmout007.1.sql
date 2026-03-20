SELECT 
	first_name as Nome, last_name as Cognome, faction.name as NomeFazione
FROM
	citizen
inner join 
	faction
on
	faction.id = citizen.supported_faction_id
