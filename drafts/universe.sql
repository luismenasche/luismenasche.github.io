CREATE DATABASE universe;

\c universe

CREATE TABLE galaxy(
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    description TEXT,
    has_life BOOLEAN DEFAULT false,
    age_in_million_of_years INT
);

CREATE TABLE constellation(
    constellation_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    description TEXT,
    has_life BOOLEAN DEFAULT false,
    galaxy_id INT REFERENCES galaxy(galaxy_id)  
);

CREATE TABLE star(
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    description TEXT,
    has_life BOOLEAN DEFAULT false,
    age_in_million_of_years INT,
    distance_to_earth NUMERIC,
    galaxy_id INT REFERENCES galaxy(galaxy_id),
    constellation_id INT REFERENCES constellation(constellation_id)
);

CREATE TABLE planet(
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    description TEXT,
    has_life BOOLEAN DEFAULT false,
    age_in_million_of_years INT,
    distance_to_earth NUMERIC,
    star_id INT REFERENCES star(star_id)
);

CREATE TABLE moon(
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    description TEXT,
    has_life BOOLEAN DEFAULT false,
    age_in_million_of_years INT,
    distance_to_earth NUMERIC,
    planet_id INT REFERENCES planet(planet_id)
);

INSERT INTO galaxy (name, has_life) VALUES ('Milky Way', true), ('Andromeda', false), ('Cigar', false), ('Large Magellanic Cloud', false), ('Black Eye', false), ('Comet', false);

INSERT INTO constellation (name, has_life, galaxy_id) VALUES ('Sun', true, 1), ('Aquarius', false, 1), ('Aries', false, 1);

INSERT INTO star (name, has_life, galaxy_id, constellation_id) VALUES ('Sun', true, 1, 1), ('Hamal', false, 3, 1), ('Lambda Arietis', false, 3, 1), ('Beta Aquarii', false, 2, 1), ('Delta Aquarii', false, 2, 1), ('Theta Aquarii', false, 2, 1);

INSERT INTO planet (name, has_life, star_id) VALUES ('Mercury', false, 1), ('Venus', false, 1), ('Earth', true, 1), ('Mars', false, 1), ('Jupiter', false, 1), ('Sapturn', false, 1), ('Uranus', false, 1), ('Neptune', false, 1), ('Hamal Planet 1', false, 2), ('Hamal Planet 2', false, 2), ('Hamal Planet 3', false, 2), ('Hamal Planet 4', false, 2);

INSERT INTO moon (name, planet_id) VALUES ('Moon', 3), ('Phobos', 4), ('Deimos', 4), ('Ganymede', 5), ('Callisto', 5), ('Io', 5), ('Europa', 5), ('Titan', 6), ('Enceladus', 6), ('Hyperion', 6), ('Prometheus', 6), ('Pandora', 6), ('Janus', 6), ('Epimetheus', 6), ('Mimas', 6), ('Iapetus', 6), ('Phoebe', 6), ('Tethys', 6), ('Telesto', 6), ('Miranda', 7);
