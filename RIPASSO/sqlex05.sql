SELECT first_name, last_name, happiness_total FROM citizen 
where first_name<>'El Presidente' --escludo il presidente
ORDER BY happiness_total DESC limit 10; -- voglio dal più felice al meno felice