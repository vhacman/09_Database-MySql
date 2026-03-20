--salario divisa per livello di istruzione
select education_level, count(*) as n, avg(salary) as averageSalary
from citizen group by education_level
