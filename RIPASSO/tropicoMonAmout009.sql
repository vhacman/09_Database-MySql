-- 9) Selezionare solo i diplomati e i laureati.
--    Calcolare lo stipendio medio per genere.
--    Stampare solo genere (M, F, N) e stipendio medio relativo.

SELECT
	gender,
	avg(salary) AS stipendioMedio
FROM
	citizen
WHERE
	education_level IN ('HighSchool', 'College')
GROUP BY
	gender;
