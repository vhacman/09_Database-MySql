-- 7.3) Quale è la percentuale di cittadini maggiorenni non impiegati?

SELECT
	COUNT(*) * 100
	/
	(
		SELECT
			COUNT(*) FROM citizen WHERE age >= 18
	)
	AS percentualeDisoccupati
FROM
	citizen
WHERE
	age >= 18
	AND job_building_id IS NULL;
