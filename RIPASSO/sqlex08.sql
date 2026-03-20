select
      *
from
      citizen left join building
      on citizen.home_building_id = building.id;