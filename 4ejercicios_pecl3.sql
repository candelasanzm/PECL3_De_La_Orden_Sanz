-- Ejercicio 1
delete
from pecl3.final.final_vehiculos as v
where v.vehicle_id is NULL or v.vehicle_id = '' or length(v.vehicle_id) < 10;

delete
from pecl3.final.final_colisionVehiculos as cv
where cv.vehicle_id is NULL or cv.vehicle_id = '' or length(cv.vehicle_id) < 10;

-- Ejercicio 2
delete
from pecl3.final.final_persona as p
where p.person_id is NULL or p.person_id = '' or length(p.person_id) < 10;

delete
from pecl3.final.final_colisionpersona as cp
where cp.person_id is NULL or cp.person_id = '' or length(cp.person_id) < 10;

-- Ejercicio 3
update pecl3.final.final_vehiculos as v
set state_registration = cv.state_registration
from pecl3.final.final_colisionvehiculos as cv
where v.vehicle_id = cv.vehicle_id;

alter table pecl3.final.final_colisionvehiculos drop column state_registration;

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
update pecl3.final.final_persona p
set person_sex = cp.person_sex
from pecl3.final.final_colisionpersona as cp
where p.person_id = cp.person_id;

alter table pecl3.final.final_colisionpersona drop column person_sex;

update pecl3.final.final_persona
set person_sex = 'U'
where person_sex is NULL;

-- Ejercicio 6
alter table pecl3.final.final_persona add column person_age integer;

create or replace function calcular_edad()
returns trigger as $$
begin
    new.person_age := DATE_PART('year', age(new.person_dob));
    return new;
end;
$$ language plpgsql;

create trigger calcular_edad
    before insert on pecl3.final.final_persona
    for each row
    execute function calcular_edad();

-- Ejercicio 7
alter table pecl3.final.final_vehiculos add column vehicle_accidents integer default 0;

create or replace function calcular_accidentes()
returns trigger as $$
begin
    update pecl3.final.final_vehiculos
    set vehicle_accidents = ( select COUNT(*)
                              from pecl3.final.final_colisionvehiculos
                              where pecl3.final.final_colisionvehiculos.vehicle_id = new.vehicle_id )
    where pecl3.final.final_vehiculos.vehicle_id = new.vehicle_id;
    return new;
end;
$$ language plpgsql;

create trigger calcular_accidentes
    after insert or update on pecl3.final.final_colisionvehiculos
    for each row
    execute function calcular_accidentes();




-- Ejercicio 8
alter table pecl3.final.final_accidentes add constraint accidentes_pk primary key(collision_id);

alter table pecl3.final.final_persona add constraint persona_pk primary key (person_id);

alter table pecl3.final.final_vehiculos add constraint vehiculos_pk primary key (vehicle_id);

alter table pecl3.final.final_colisionpersona add constraint colision_persona_pk primary key (person_id, collision_id);
alter table pecl3.final.final_colisionpersona add constraint personId_fk foreign key  (person_id) references pecl3.final.final_persona(person_id) match full on delete set default on update set default;
alter table pecl3.final.final_colisionpersona add constraint vehicleId_fk foreign key (vehicle_id) references pecl3.final.final_vehiculos(vehicle_id) match full on delete set default on update set default;
alter table pecl3.final.final_colisionpersona add constraint contributing1_fk foreign key (contributing_factor_1) references pecl3.final.final_accidentes(contributing_factor_vehicle_1) match full on delete set default on update set default;
alter table pecl3.final.final_colisionpersona add constraint contributing2_fk foreign key (contributing_factor_2) references pecl3.final.final_accidentes(contributing_factor_vehicle_2) match full on delete set default on update set default;
alter table pecl3.final.final_colisionpersona add constraint personSex_fk foreign key (person_sex) references pecl3.final.final_persona(person_sex) match full on delete set default on update set default;
alter table pecl3.final.final_colisionpersona add constraint collisionId_fk foreign key (collision_id) references pecl3.final.final_accidentes(collision_id) match full on delete set default on update set default;

alter table pecl3.final.final_colisionvehiculos add constraint vehicleId_fk foreign key(vehicle_id) references pecl3.final.final_vehiculos(vehicle_id) match full on delete set default on update set default;
alter table pecl3.final.final_colisionvehiculos add constraint collisionId_fk foreign key(collision_id) references pecl3.final.final_accidentes(collision_id) match full on delete set default on update set default;
alter table pecl3.final.final_colisionvehiculos add constraint contributing_factor_1_fk foreign key(contributing_factor_1) references pecl3.final.final_accidentes(contributing_factor_vehicle_1) match full on delete set default on update set default;
alter table pecl3.final.final_colisionvehiculos add constraint contributing_factor_2_fk foreign key(contributing_factor_2) references pecl3.final.final_accidentes(contributing_factor_vehicle_2) match full on delete set default on update set default;
alter table pecl3.final.final_colisionvehiculos add constraint colision_vehiculos_pk primary key(vehicle_id,collision_id);