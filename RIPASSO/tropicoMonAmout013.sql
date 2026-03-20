-- 13) Ipotizzando che capitalisti, militaristi e religiosi corrano assieme,
--     e i comunisti da soli, di quanti voti vincerebbero le elezioni?

SELECT
	(
		SELECT COUNT(*)
		FROM citizen
			INNER JOIN faction ON faction.id = citizen.supported_faction_id
		WHERE faction.name IN ('Capitalist', 'Militarist', 'Religious')
	)
	-
	(
		SELECT COUNT(*)
		FROM citizen
			INNER JOIN faction ON faction.id = citizen.supported_faction_id
		WHERE faction.name = 'Communist'
	)
	AS differenzaVoti;
-- valore positivo = vince la coalizione, negativo = vincono i comunisti
