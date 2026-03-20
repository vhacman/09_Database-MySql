SELECT 
	COUNT(*) * 100 
	/ 
	(
		SELECT 
			COUNT(*) FROM citizen WHERE age >= 18
	) 
	AS rebelPercentage
FROM citizen
WHERE is_rebel = true
  AND age >= 18;