-- -- 2) Selezionare il prezzo attuale di Mais e Oro. Stampare nome e costo
SELECT 
		name, base_market_price
FROM 
		resource
WHERE 
		name 
			IN ('Mais', 'Oro');