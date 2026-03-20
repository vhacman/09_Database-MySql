-- 3) Selezionare nome e prezzo ivato (+22%) di tutte le materie PRIME

SELECT name, base_market_price + (base_market_price * 22 / 100) AS prezzo_ivato
FROM resource
WHERE is_processed = false;