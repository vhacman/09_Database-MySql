-- Questo database contiene i dati economici e demografici e politici di una isola tropicale governata localmente
-- dobbiamo trarre informazioni da presentare al consiglio dirigente


-- 1) Selezionare il prezzo attuale dell'oro. Voglio vedere SOLO Il costo, niente altro

SELECT base_market_price FROM resource WHERE name='Oro';


-- 2) Selezionare il prezzo attuale di Mais e Oro. Stampare nome e costo

SELECT name, base_market_price FROM resource WHERE name IN ('Mais', 'Oro');


-- 3) Selezionare nome e prezzo ivato (+22%) di tutte le materie PRIME

SELECT name, base_market_price + (base_market_price * 22 / 100) AS prezzo_ivato FROM resource WHERE is_processed = false;


-- 4) Trovare tutti i cittadini col cognome castro. Stampare nome, cognome, età, livello di studi, salario

SELECT first_name, last_name, age, education_level, salary
FROM citizen WHERE last_name = 'Castro';


-- 5) Trovare tutti i cittadini maschi di età superiore ai 45 anni con livello di felicità compreso fra 40 e 80

SELECT *
FROM citizen
WHERE gender = 'M'
  AND age > 45
  AND happiness_total BETWEEN 40 AND 80;


-- 6) Produrre l'elenco di tutti tipi di edificio che producono risorse (solo producono, non ne richiedono)

SELECT *
FROM BuildingType
INNER JOIN resource ON resource.id = BuildingType.output_resource_id
AND BuildingType.input_resource_id IS NULL;

-- alternativa senza join:
SELECT *
FROM BuildingType
WHERE input_resource_id IS NULL
AND output_resource_id IS NOT NULL;


-- 7) Produrre l'elenco di tutti i tipi di edificio che producono risorse col nome della risorsa prodotta

SELECT bt.name AS buildingName, resource.name AS resourceName
FROM BuildingType bt
INNER JOIN resource ON resource.id = bt.output_resource_id;


-- 7.1) Stampare nome e cognome di tutti i cittadini con relativa fazione di appartenenza

SELECT
    first_name AS Nome, last_name AS Cognome, faction.name AS NomeFazione
FROM
    citizen
INNER JOIN
    faction
ON
    faction.id = citizen.supported_faction_id;


-- 7.2) Quali cittadini producono mais? Stampare nome e cognome.

SELECT
    citizen.first_name, citizen.last_name
FROM
    resource
        INNER JOIN buildingType ON resource.id = buildingType.output_resource_id
        INNER JOIN building ON buildingType.id = building.building_type_id
        INNER JOIN citizen ON citizen.job_building_id = building.id
WHERE
    resource.name = 'Mais';


-- 7.3) Quale è la percentuale di cittadini maggiorenni non impiegati?

SELECT
    COUNT(*) * 100
    /
    (
        SELECT COUNT(*) FROM citizen WHERE age >= 18
    )
    AS percentualeDisoccupati
FROM
    citizen
WHERE
    age >= 18
    AND job_building_id IS NULL;


-- 7.4) Stampare nome e cognome di tutti i cittadini impiegati nella produzione di materie prime di qualunque tipo

SELECT
    citizen.first_name, citizen.last_name
FROM
    resource
        INNER JOIN buildingType ON resource.id = buildingType.output_resource_id
        INNER JOIN building ON buildingType.id = building.building_type_id
        INNER JOIN citizen ON citizen.job_building_id = building.id
WHERE
    resource.is_processed = false; -- solo materie prime, non beni lavorati


-- 8) Produrre l'elenco di tutti i tipi di edificio che richiedono risorse e producono risorse
--    stampando il nome delle risorse prodotte e richieste

SELECT
    bt.name AS nomeEdificio,
    rIn.name AS risorsaRichiesta,
    rOut.name AS risorsaProdotta
FROM
    buildingType bt
        INNER JOIN resource rIn ON rIn.id = bt.input_resource_id
        INNER JOIN resource rOut ON rOut.id = bt.output_resource_id;
-- il doppio join su resource permette di leggere sia la risorsa in ingresso che quella in uscita


-- 9) Selezionare solo i diplomati e i laureati. Calcolare lo stipendio medio per genere.
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


-- 10) Raggruppare gli edifici per tipo: Stampare il nome del tipo dell'edificio
--     e il numero di edifici di quel tipo sull'isola

SELECT
    buildingType.name AS tipoEdificio,
    COUNT(building.id) AS numeroEdifici
FROM
    buildingType
        INNER JOIN building ON buildingType.id = building.building_type_id
GROUP BY
    buildingType.id, buildingType.name;


-- 11) Quanto tabacco è stato prodotto dal 1960 al 1965?

SELECT
    SUM(pb.amount) AS tabaccoProdotto
FROM
    Production_Batch pb
        INNER JOIN building ON building.id = pb.building_id
        INNER JOIN buildingType ON buildingType.id = building.building_type_id
        INNER JOIN resource ON resource.id = buildingType.output_resource_id
WHERE
    resource.name = 'Tabacco'
    AND pb.production_date BETWEEN '1960-01-01' AND '1965-12-31';


-- 12) Quale fazione vincerà le elezioni?

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


-- 14) Quanti soldi mi ha reso ogni edificio produttivo dal 1960 al 1965?
--     Presentare il ricavo diviso per edificio.

SELECT
    building.id AS idEdificio,
    buildingType.name AS tipoEdificio,
    resource.name AS risorsaProdotta,
    SUM(pb.market_value) AS ricavoTotale
FROM
    Production_Batch pb
        INNER JOIN building ON building.id = pb.building_id
        INNER JOIN buildingType ON buildingType.id = building.building_type_id
        INNER JOIN resource ON resource.id = buildingType.output_resource_id
WHERE
    pb.production_date BETWEEN '1960-01-01' AND '1965-12-31'
GROUP BY
    building.id, buildingType.name, resource.name
ORDER BY
    ricavoTotale DESC;


-- 15) El presidente ha deciso di imporre una tassa di 2 dollari per ogni maschio con "fi" nel nome,
--     e di 1.5 dollari per ogni donna. Quanto renderà?

SELECT
    (
        SELECT COUNT(*) * 2
        FROM citizen
        WHERE gender = 'M'
          AND first_name LIKE '%fi%'
    )
    +
    (
        SELECT COUNT(*) * 1.5
        FROM citizen
        WHERE gender = 'F'
    )
    AS gettitoTassa;
