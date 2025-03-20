#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 -v USER_ROLE=$USER_ROLE -v USER_PASSWORD=$USER_PASSWORD -v DB_NAME=$DB_NAME -v --username "$POSTGRES_USER" <<-EOSQL
    create role :USER_ROLE with login password :'USER_PASSWORD' NOSUPERUSER CREATEDB CREATEROLE INHERIT;
    create database :DB_NAME with owner :USER_ROLE;
    GRANT ALL PRIVILEGES ON DATABASE :DB_NAME to :USER_ROLE;
EOSQL