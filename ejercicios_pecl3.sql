-- Ejercicio 1
delete
from pecl3.final.final_vehiculos as v
where v.vehicle_id is NULL or length(v.vehicle_id) < 10;

delete
from pecl3.final.final_colisionVehiculos as cv
where cv.vehicle_id is NULL or length(cv.vehicle_id) < 10;

delete
from pecl3.final.final_colisionpersona as cp
where cp.vehicle_id is NULL or length(cp.vehicle_id) < 10;

-- Ejercicio 2
delete
from pecl3.final.final_persona as p
where p.person_id is NULL or length(p.person_id) < 10;

delete
from pecl3.final.final_colisionpersona as cp
where cp.person_id is NULL or length(cp.person_id) < 10;

-- Ejercicio 3

-- Ejercicio 4
update pecl3.final.final_vehiculos
set vehicle_type = 'unknown'
where vehicle_type is NULL;

update pecl3.final.final_vehiculos
set vehicle_make = 'unknown'
where vehicle_make is NULL;

update pecl3.final.final_vehiculos
set vehicle_model = 'unknown'
where vehicle_model is NULL;

update pecl3.final.final_vehiculos
set vehicle_year = 9999
where vehicle_year is NULL;

update pecl3.final.final_vehiculos
set state_registration = 'unknown'
where state_registration is NULL;

-- Ejercicio 5
-- Ejercicio 6
-- Ejercicio 7
-- Ejercicio 8