/* Populate database with sample data. */
INSERT INTO
    animals
VALUES
    (1, 'Agumon', '2020-02-03', 0, TRUE, 10.23);

INSERT INTO
    animals
VALUES
    (2, 'Gabumon', '2018-11-15', 2, TRUE, 8.0);

INSERT INTO
    animals
VALUES
    (3, 'Pikachu', '2021-01-07', 1, FALSE, 15.04);

INSERT INTO
    animals
VALUES
    (4, 'Devimon', '2017-05-12', 5, TRUE, 11.0);

INSERT INTO
    animals (
        id,
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES
    (5, 'Charmander', '2020-02-08', 0, false, 11.0),
    (6, 'Plantmon', '2021-11-15', 2, true, -5.7),
    (7, 'Squirtle', '1993-04-02', 3, false, -12.13),
    (8, 'Angemon', '2005-06-12', 1, true, -45),
    (9, 'Boarmon', '2005-06-07', 7, true, 20.4),
    (10, 'Blossom', '1998-10-13', 3, true, 17),
    (11, 'Ditto', '2022-05-14', 4, true, 22);

/* Insert the following data into the owners table */
INSERT INTO
    owners (full_name, age)
VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

/* Insert the following data into the species table */
INSERT INTO
    species (name)
VALUES
    ('Pokemon'),
    ('Digimon');

/* Modify your inserted animals so it includes the species_id value */
update
    animals
set
    species_id = case
        when name like '%mon' then (
            select
                id
            from
                species
            where
                name = 'Digimon'
        )
        else (
            select
                id
            from
                species
            where
                name = 'Pokemon'
        )
    end;

/* Modify your inserted animals to include owner information (owner_id) */
UPDATE
    animals
SET
    owner_id = (
        SELECT
            id
        FROM
            owners
        WHERE
            full_name = 'Sam Smith'
    )
WHERE
    name = 'Agumon';

UPDATE
    animals
SET
    owner_id = (
        SELECT
            id
        FROM
            owners
        WHERE
            full_name = 'Jennifer Orwell'
    )
WHERE
    name IN ('Gabumon', 'Pikachu');

UPDATE
    animals
SET
    owner_id = (
        SELECT
            id
        FROM
            owners
        WHERE
            full_name = 'Bob'
    )
WHERE
    name IN ('Devimon', 'Plantmon');

UPDATE
    animals
SET
    owner_id = (
        SELECT
            id
        FROM
            owners
        WHERE
            full_name = 'Melody Pond'
    )
WHERE
    name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE
    animals
SET
    owner_id = (
        SELECT
            id
        FROM
            owners
        WHERE
            full_name = 'Dean Winchester'
    )
WHERE
    name IN ('Angemon', 'Boarmon');

/* Insert data into the vets table */
INSERT INTO
    vets (name, age, date_of_graduation)
VALUES
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');

/* Insert data into the specializations table */
INSERT INTO
    specializations (vet_id, species_id)
VALUES
    (
        (
            select
                id
            from
                vets
            where
                name = 'William Tatcher'
        ),
        (
            select
                id
            from
                species
            where
                name = 'Pokemon'
        )
    ),
    (
        (
            select
                id
            from
                vets
            where
                name = 'Stephanie Mendez'
        ),
        (
            select
                id
            from
                species
            where
                name = 'Pokemon'
        )
    ),
    (
        (
            select
                id
            from
                vets
            where
                name = 'Stephanie Mendez'
        ),
        (
            select
                id
            from
                species
            where
                name = 'Digimon'
        )
    ),
    (
        (
            select
                id
            from
                vets
            where
                name = 'Jack Harkness'
        ),
        (
            select
                id
            from
                species
            where
                name = 'Digimon'
        )
    );

/* Insert data into the visits table */
INSERT INTO
    visits (animal_id, vet_id, date_of_visitation)
VALUES
    (
        (
            select
                id
            from
                animals
            where
                name = 'Agumon'
        ),
        (
            select
                id
            from
                vets
            where
                name = 'William Tatcher'
        ),
        ('2020-05-24')
    ),
    (
        (
            select
                id
            from
                animals
            where
                name = 'Agumon'
        ),
        (
            select
                id
            from
                vets
            where
                name = 'Stephanie Mendez'
        ),
        ('2020-07-22')
    ),
    (
        (
            select
                id
            from
                animals
            where
                name = 'Gabumon'
        ),
        (
            select
                id
            from
                vets
            where
                name = 'Jack Harkness'
        ),
        ('2021-02-02')
    ),
    (
        (
            select
                id
            from
                animals
            where
                name = 'Pikachu'
        ),
        (
            select
                id
            from
                vets
            where
                name = 'Maisy Smith'
        ),
        ('2020-01-05')
    ),
    (
        (
            select
                id
            from
                animals
            where
                name = 'Pikachu'
        ),
        (
            select
                id
            from
                vets
            where
                name = 'Maisy Smith'
        ),
        ('2020-03-08')
    ),
    (
        (
            select
                id
            from
                animals
            where
                name = 'Pikachu'
        ),
        (
            select
                id
            from
                vets
            where
                name = 'Maisy Smith'
        ),
        ('2020-05-14')
    ),
    (
        (
            select
                id
            from
                animals
            where
                name = 'Devimon'
        ),
        (
            select
                id
            from
                vets
            where
                name = 'Stephanie Mendez'
        ),
        ('2021-05-04')
    ),
    (
        (
            select
                id
            from
                animals
            where
                name = 'Charmander'
        ),
        (
            select
                id
            from
                vets
            where
                name = 'Jack Harkness'
        ),
        ('2021-02-24')
    ),
    (
        (
            select
                id
            from
                animals
            where
                name = 'Plantmon'
        ),
        (
            select
                id
            from
                vets
            where
                name = 'Maisy Smith'
        ),
        ('2019-12-21')
    ),
    (
        (
            select
                id
            from
                animals
            where
                name = 'Plantmon'
        ),
        (
            select
                id
            from
                vets
            where
                name = 'William Tatcher'
        ),
        ('2020-08-10')
    ),
    (
        (
            select
                id
            from
                animals
            where
                name = 'Plantmon'
        ),
        (
            select
                id
            from
                vets
            where
                name = 'Maisy Smith'
        ),
        ('2021-04-07')
    ),
    (
        (
            select
                id
            from
                animals
            where
                name = 'Squirtle'
        ),
        (
            select
                id
            from
                vets
            where
                name = 'Stephanie Mendez'
        ),
        ('2019-09-29')
    ),
    (
        (
            select
                id
            from
                animals
            where
                name = 'Angemon'
        ),
        (
            select
                id
            from
                vets
            where
                name = 'Jack Harkness'
        ),
        ('2020-10-03')
    ),
(
        (
            select
                id
            from
                animals
            where
                name = 'Angemon'
        ),
        (
            select
                id
            from
                vets
            where
                name = 'Jack Harkness'
        ),
        ('2020-11-04')
    ),
    (
        (
            select
                id
            from
                animals
            where
                name = 'Boarmon'
        ),
        (
            select
                id
            from
                vets
            where
                name = 'Maisy Smith'
        ),
        ('2019-01-24')
    ),
    (
        (
            select
                id
            from
                animals
            where
                name = 'Boarmon'
        ),
        (
            select
                id
            from
                vets
            where
                name = 'Maisy Smith'
        ),
        ('2019-05-15')
    ),
    (
        (
            select
                id
            from
                animals
            where
                name = 'Boarmon'
        ),
        (
            select
                id
            from
                vets
            where
                name = 'Maisy Smith'
        ),
        ('2020-02-27')
    ),
    (
        (
            select
                id
            from
                animals
            where
                name = 'Boarmon'
        ),
        (
            select
                id
            from
                vets
            where
                name = 'Maisy Smith'
        ),
        ('2020-08-03')
    ),
    (
        (
            select
                id
            from
                animals
            where
                name = 'Blossom'
        ),
        (
            select
                id
            from
                vets
            where
                name = 'Stephanie Mendez'
        ),
        ('2020-05-24')
    ),
    (
        (
            select
                id
            from
                animals
            where
                name = 'Blossom'
        ),
        (
            select
                id
            from
                vets
            where
                name = 'William Tatcher'
        ),
        ('2021-01-11')
    );