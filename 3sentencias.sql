-- Sentencia 1
select pecl3.final.final_colisionVehiculos.vehicle_id, count(pecl3.final.final_colisionVehiculos.collision_id) as NumeroAccidentes
from pecl3.final.final_colisionVehiculos
group by vehicle_id
having count(final.final_colisionVehiculos.collision_id) > 1
order by NumeroAccidentes desc ;

-- Sentencia 2
select *
from pecl3.final.final_vehiculos
where vehicle_year <= 1989
order by vehicle_year desc;

-- Sentencia 3
select vehicle_make, count(vehicle_make) as CantidadPorMarca
from pecl3.final.final_vehiculos
group by vehicle_make
order by CantidadPorMarca desc
limit 5;

-- Sentencia 4
select count(pecl3.final.final_colisionPersona.collision_id) as NumeroAccidentes, pecl3.final.final_colisionPersona.person_id
from pecl3.final.final_colisionPersona
group by person_id
having count(pecl3.final.final_colisionPersona.collision_id) > 1
order by NumeroAccidentes desc;

-- Sentencia 5
select position_in_vehicle, person_id, person_age
from pecl3.final.final_colisionPersona
where position_in_vehicle in ('Driver') and (person_age > 65 or person_age < 26)
order by person_age asc;

-- Sentencia 6
select distinct pecl3.final.final_persona.*, pecl3.final.final_vehiculos.vehicle_type
from pecl3.final.final_persona, pecl3.final.final_vehiculos
where final_vehiculos.vehicle_type = 'Pick-up';

-- Sentencia 7
select count(cv.unique_id) as NumeroAccidentes, v.vehicle_make
from pecl3.final.final_colisionVehiculos as cv left join pecl3.final.final_vehiculos as v on cv.vehicle_id = v.vehicle_id
group by v.vehicle_make
order by NumeroAccidentes asc
limit 3;

select count(cv.unique_id) as NumeroAccidentes, v.vehicle_type
from pecl3.final.final_colisionVehiculos as cv left join pecl3.final.final_vehiculos as v on cv.vehicle_id = v.vehicle_id
group by v.vehicle_type
order by NumeroAccidentes asc
limit 3;

-- Sentencia 8
select count(cv.unique_id) as NumeroAccidentes, v.vehicle_make
from pecl3.final.final_colisionVehiculos as cv left join pecl3.final.final_vehiculos as v on cv.vehicle_id = v.vehicle_id
group by v.vehicle_make
order by vehicle_make asc;

-- Sentencia 9
select pecl3.final.final_persona.person_address, pecl3.final.final_persona.person_city, pecl3.final.final_persona.person_state
from pecl3.final.final_persona, pecl3.final.final_accidentes, pecl3.final.final_colisionPersona
where pecl3.final.final_persona.person_id = pecl3.final.final_colisionPersona.person_id
    and pecl3.final.final_accidentes.collision_id = pecl3.final.final_colisionPersona.collision_id
    and pecl3.final.final_colisionPersona.position_in_vehicle in ('Driver');

-- Sentencia 10
select state_registration, count(pecl3.final.final_colisionVehiculos.collision_id) as NumeroAccidentes
from pecl3.final.final_colisionVehiculos
group by state_registration
order by state_registration desc;
