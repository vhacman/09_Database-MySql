-- provo ad aggiungere i building
-- select * from citizen, building; -- ERRATO. Non è un inner join, è un prodotto cartesiano
-- combina tutte le righe con tutti gli edifici. Secondo questa query il presidente lavora
-- sto combinando tutti i cittadini con tutti gli edifici. ORRORE. Applico il join
-- il join vuol dire tenere solo le righe collegate

--select * from building inner join citizen on building.id = citizen.job_building_id
-- ci stiamo avvicinando, ma che diavolo vuol dire building type = 5???

select
      avg(salary) as average
from
      resource inner join
      buildingType on resource.id = buildingType.output_resource_id
      inner join building on buildingType.id = building.building_type_id
      inner join citizen on citizen.job_building_id = building.id
where
      resource.name = 'Mais'
-- 4 tabelle, un filtro, una proiezione di 2 campi