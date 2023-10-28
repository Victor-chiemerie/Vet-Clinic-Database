/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
	id INT NOT NULL,
	name varchar(100) NOT NULL,
	date_of_birth DATE NOT NULL,
	escape_attempts INT NOT NULL,
	neutered BOOLEAN NOT NULL,
	weight_kg DECIMAL(5, 2) NOT NULL
);

alter table
	animals
add
	species varchar(100);

/* Create a table named owners with the following columns */
CREATE TABLE owners (
	id SERIAL PRIMARY KEY,
	full_name VARCHAR(50) NOT NULL,
	age INT NOT NULL
);

/* Create a table named species with the following columns */
CREATE TABLE species (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL
);

/* Make sure that id is set as autoincremented PRIMARY KEY */
alter table
	animals
add
	column new_id serial primary key;

update
	animals
set
	new_id = id;

alter table
	animals drop column id;

alter table
	animals rename column new_id to id;

/* Remove column species */
alter table
	animals drop column species;

/* Add column species_id which is a foreign key referencing species table */
alter table
	animals
ADD
	COLUMN species_id int,
add
	constraint fk_specie_id foreign key(species_id) references species(id);

/* Add column owner_id which is a foreign key referencing the owners table */
alter table
	animals
ADD
	COLUMN owner_id int,
add
	constraint fk_owner_id foreign key(owner_id) references owners(id);

/* Create a table named vets with the following columns */
create table vets (
	id serial primary key,
	name varchar(50) not null,
	age int not null,
	date_of_graduation date not null
);

/* Create join table with both columns as foreign keys to handle specialization */
CREATE TABLE specializations (
	vet_id bigint,
	species_id bigint,
	CONSTRAINT fk_vet_id FOREIGN KEY (vet_id) REFERENCES vets(id),
	CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species(id)
);

/* Create join table with both columns as foreign keys to handle visits */
CREATE TABLE visits (
	animal_id bigint,
	vet_id bigint,
	date_of_visitation date not null,
	CONSTRAINT fk_animal_id FOREIGN KEY (animal_id) REFERENCES animals(id),
	CONSTRAINT fk_vet_id FOREIGN KEY (vet_id) REFERENCES vets(id)
);