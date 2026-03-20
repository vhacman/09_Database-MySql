-- felicità media divisa per livello di ricchezza
select wealth_level, count(*) as n, avg(happiness_total) as averageHappiness 
from citizen group by wealth_level