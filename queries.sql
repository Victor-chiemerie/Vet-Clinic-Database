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

/* What animals belong to Melody Pond? */
select
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
from
    animals
    join owners on animals.owner_id = owners.id
where
    owners.full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon) */
select
    animals.name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
from
    animals
    join species on animals.species_id = species.id
where
    species.name = 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal */
select
    owners.full_name,
    animals.name
from
    animals
    right join owners on animals.owner_id = owners.id;

/* How many animals are there per species? */
SELECT
    species.name,
    COUNT(animals.id) AS animal_count
FROM
    animals
    JOIN species ON animals.species_id = species.id
GROUP BY
    species.name;

/* List all Digimon owned by Jennifer Orwell */
select
    animals.name,
    species.name
from
    animals
    join species on animals.species_id = species.id
    join owners on animals.owner_id = owners.id
where
    owners.full_name = 'Jennifer Orwell'
    and species.name = 'Digimon';

/*List all animals owned by Dean Winchester that haven't tried to escape */
select
    a.name,
    a.escape_attempts,
    o.full_name
from
    animals a
    join owners o on a.owner_id = o.id
where
    a.escape_attempts = 0
    and o.full_name = 'Dean Winchester';

/*Who owns the most animals */
SELECT
    o.full_name,
    COUNT(a.id) as animals_owned
FROM
    owners o
    LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY
    o.full_name
ORDER BY
    animals_owned DESC
LIMIT
    1;

/* Who was the last animal seen by William Tatcher? */
SELECT
    a.name as animal_name,
    vi.date_of_visitation
FROM
    visits vi
    JOIN animals a ON vi.animal_id = a.id
    JOIN vets v ON vi.vet_id = v.id
WHERE
    v.name = 'William Tatcher'
order BY
    vi.date_of_visitation desc
limit
    1;

/* How many different animals did Stephanie Mendez see? */
SELECT
    count(distinct vi.animal_id) as number_of_animals
FROM
    visits vi
    JOIN vets v ON vi.vet_id = v.id
WHERE
    v.name = 'Stephanie Mendez';

/* List all vets and their specialties, including vets with no specialties */
select
    v.name as vet_name,
    s.name as speciaity
from
    vets v
    left join specializations sp on v.id = sp.vet_id
    left join species s on sp.species_id = s.id
    /* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020 */
select
    a.name,
    vi.date_of_visitation
from
    animals a
    join visits vi on vi.animal_id = a.id
    join vets v on v.id = vi.vet_id
where
    v.name = 'Stephanie Mendez'
    and vi.date_of_visitation BETWEEN '2020-04-01'
    AND '2020-08-30';

/* What animal has the most visits to vets? */
select
    a.name as animal_name,
    count(vi.animal_id) as visitations
from
    visits vi
    join animals a on vi.animal_id = a.id
group by
    a.id
order by
    visitations desc
limit
    1;

/* Who was Maisy Smith's first visit? */
select
    a.name as animal_name,
    vi.date_of_visitation
from
    visits vi
    join animals a on vi.animal_id = a.id
    join vets v on vi.vet_id = v.id
where
    v.name = 'Maisy Smith'
order by
    vi.date_of_visitation asc
limit
    1;

/* Details for most recent visit: animal information, vet information, and date of visit */
select
    a.name as animal_name,
    a.date_of_birth,
    a.escape_attempts,
    neutered,
    weight_kg,
    s.name as species,
    o.full_name as owner,
    vi.date_of_visitation,
    v.name as vet_doctor
from
    visits vi
    join animals a on vi.animal_id = a.id
    join vets v on vi.vet_id = v.id
    join owners o on a.owner_id = o.id
    join species s on a.species_id = s.id
order by
    vi.date_of_visitation desc
limit
    1;

/* How many visits were with a vet that did not specialize in that animal's species? */
SELECT
    COUNT(*) AS num_visits_without_specialization
FROM
    visits v
    JOIN animals a ON v.animal_id = a.id
    JOIN vets vt ON v.vet_id = vt.id
    LEFT JOIN specializations s ON vt.id = s.vet_id
    AND a.species_id = s.species_id
WHERE
    s.vet_id IS NULL;

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */
SELECT
    name,
    COUNT(*) AS total
FROM
    (
        SELECT
            a.species_id
        FROM
            (
                SELECT
                    id
                FROM
                    vets
                WHERE
                    name = 'Maisy Smith'
            ) as vet
            JOIN visits ON visits.vet_id = vet.id
            JOIN animals a ON a.id = visits.animal_id
    ) as all_visits
    JOIN species ON all_visits.species_id = species.id
GROUP BY
    name
ORDER BY
    total DESC
LIMIT
    1;