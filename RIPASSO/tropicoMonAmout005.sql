
-- 5) Trovare tutti i cittadini maschi di età superiore ai 45 anni con livello di felicità compreso fra 40 e 80

SELECT *

FROM
		citizen
WHERE 
		gender = 'M'
  AND 
  		age > 45
  AND 
  		happiness_total BETWEEN 40 AND 80;