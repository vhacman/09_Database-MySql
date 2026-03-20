-- 12) Quale fazione vincerà le elezioni?
--     Stampa fazione e numero di voti, ordinati dal più votato al meno votato

SELECT
	faction.name AS fazione,
	COUNT(citizen.id) AS voti
FROM
	faction
		INNER JOIN citizen ON citizen.supported_faction_id = faction.id
GROUP BY
	faction.id, faction.name
ORDER BY
	voti DESC;
