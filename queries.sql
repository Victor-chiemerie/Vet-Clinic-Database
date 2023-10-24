/*Queries that provide answers to the questions from all projects.*/
/*Find all animals whose name ends in "mon"*/
SELECT
    *
From
    animals
WHERE
    name LIKE '%mon';

/*List the name of all animals born between 2016 and 2019*/
SELECT
    name
From
    animals
WHERE
    EXTRACT(
        YEAR
        FROM
            date_of_birth
    ) BETWEEN 2016
    AND 2019;

/*List the name of all animals that are neutered and have less than 3 escape attempts*/
SELECT
    name
from
    animals
where
    neutered = true
    and escape_attempts > 3;

/*List the date of birth of all animals named either "Agumon" or "Pikachu"*/
select
    date_of_birth
from
    animals
where
    name in ('Agumon', 'Pikachu');

/*List name and escape attempts of animals that weigh more than 10.5kg*/
select
    name,
    escape_attempts
from
    animals
where
    weight_kg > 10.5;

/*Find all animals that are neutered*/
select
    *
from
    animals
where
    neutered = true;

/*Find all animals not named Gabumon*/
select
    *
from
    animals
where
    name != 'Gabumon';

/*Find all animals with a weight between 10.4kg and 17.3kg*/
select
    *
from
    animals
where
    weight_kg between 10.4
    and 17.3;

begin;

delete from
    animals
where
    date_of_birth > '2022-01-01';

select
    *
from
    animals;

savepoint my_savepoint;

update
    animals
set
    weight_kg = weight_kg * -1;

select
    *
from
    animals;

rollback to my_savepoint;

select
    *
from
    animals;

update
    animals
set
    weight_kg = weight_kg * -1
where
    weight_kg < 0;

commit;

select
    *
from
    animals;

SELECT
    COUNT(*)
FROM
    animals;

SELECT
    COUNT(*)
FROM
    animals
where
    escape_attempts = 0;

select
    avg(weight_kg)
from
    animals;

select
    neutered,
    max(escape_attempts)
from
    animals
group by
    neutered;

select
    species,
    max(weight_kg),
    min(weight_kg)
from
    animals
group by
    species;

select
    species,
    avg(escape_attempts) as average_escape_attempts
from
    animals
where
    date_of_birth BETWEEN '1990-01-01'
    AND '2000-12-31'
group by
    species;