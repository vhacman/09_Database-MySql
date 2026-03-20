-- 15) El presidente ha deciso di imporre una tassa:
--       - 2 dollari per ogni maschio con "fi" nel nome
--       - 1.5 dollari per ogni donna
--     Quanto renderà?

SELECT
	(
		SELECT COUNT(*) * 2
		FROM citizen
		WHERE gender = 'M'
		  AND first_name LIKE '%fi%' -- case sensitive in SQLite; usare LIKE per semplicità
	)
	+
	(
		SELECT COUNT(*) * 1.5
		FROM citizen
		WHERE gender = 'F'
	)
	AS gettitoTassa;
