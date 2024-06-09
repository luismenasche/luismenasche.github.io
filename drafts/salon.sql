DROP DATABASE IF EXISTS salon;

CREATE DATABASE salon;

\c salon

CREATE TABLE customers(
  customer_id SERIAL PRIMARY KEY,
  phone VARCHAR(15) UNIQUE,
  name VARCHAR(30)
);

CREATE TABLE services(
  service_id SERIAL PRIMARY KEY,
  name VARCHAR(30)
);

CREATE TABLE appointments(
  appointment_id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(customer_id),
  service_id INT REFERENCES services(service_id),
  time VARCHAR(30)
);

INSERT INTO services(name) VALUES ('haircut'), ('handnails'), ('toenails');
