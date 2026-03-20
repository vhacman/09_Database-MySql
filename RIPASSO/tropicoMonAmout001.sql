-- 1) Selezionare il prezzo attuale dell'oro. Voglio vedere SOLO il costo, niente altro

SELECT
	base_market_price
FROM
	resource
WHERE
	name = 'Oro';
