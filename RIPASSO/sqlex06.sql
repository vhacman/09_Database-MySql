-- il join vuol dire tenere solo le righe collegate

--select * from building inner join citizen on building.id = citizen.job_building_id
-- ci stiamo avvicinando, ma che diavolo vuol dire building type = 5???

select
      citizen.first_name, citizen.last_name, resource.name
from
      resource inner join
      buildingType on resource.id = buildingType.output_resource_id
      inner join building on buildingType.id = building.building_type_id
      inner join citizen on citizen.job_building_id = building.id
where
      resource.name = 'Mais'