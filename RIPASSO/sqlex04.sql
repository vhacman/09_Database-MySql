select
      gender,
      education_level,
      avg(salary) as avgSalary,
      count(*) as n
from
      citizen
group by
      gender, education_level
order by
      education_level, gender;