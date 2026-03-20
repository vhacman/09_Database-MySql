-- quali edifici producono materie prime? 
select * from building inner join buildingType on building_type_id = buildingType.id