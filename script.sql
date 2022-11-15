CREATE DATABASE mirea;

CREATE TYPE contact_enum AS ENUM ('email', 'телефон', 'адрес');
CREATE TYPE priority_enum AS ENUM ('низкий', 'средний', 'высокий');

CREATE TABLE IF NOT EXISTS user_login
(
    id SERIAL PRIMARY KEY NOT NULL,
    username VARCHAR(20) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS person
(
    id SERIAL PRIMARY KEY NOT NULL UNIQUE,
    user_id INTEGER REFERENCES user_login(id) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS contact_info
(
    id SERIAL PRIMARY KEY NOT NULL UNIQUE,
    person_id INTEGER REFERENCES person(id) NOT NULL,
    contact VARCHAR(50) NOT NULL UNIQUE,
    type contact_enum NOT NULL
);

CREATE TABLE IF NOT EXISTS roles
(
    id SERIAL PRIMARY KEY NOT NULL UNIQUE,
    title VARCHAR(15) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS person_role
(
    id SERIAL PRIMARY KEY NOT NULL UNIQUE,
    person_id INTEGER REFERENCES person(id) NOT NULL UNIQUE,
    role_id INTEGER REFERENCES roles(id) NOT NULL
);

CREATE TABLE IF NOT EXISTS organization
(
    id SERIAL PRIMARY KEY NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL UNIQUE,
    person_id INTEGER REFERENCES person(id) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS task_type
(
    id SERIAL PRIMARY KEY NOT NULL UNIQUE,
    title VARCHAR(25) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS contract
(
    id SERIAL PRIMARY KEY NOT NULL UNIQUE,
    extra_data json NOT NULL
);

CREATE TABLE IF NOT EXISTS tasks
(
    id SERIAL PRIMARY KEY NOT NULL UNIQUE,
    contact_id INTEGER REFERENCES person(id) NOT NULL,
    author_id INTEGER REFERENCES person(id) NOT NULL,
    executor_id INTEGER REFERENCES person(id) NOT NULL,
    contract_id INTEGER REFERENCES contract(id) NULL,
    task_type_id INTEGER REFERENCES task_type(id) NULL,
    priority_id priority_enum NOT NULL,
    data VARCHAR(256) NULL,
    dt_created TIMESTAMP NOT NULL,
    dt_finished TIMESTAMP NULL,
    dt_deadline TIMESTAMP NULL
);
