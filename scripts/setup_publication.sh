#!/usr/bin/env bash
set -e

DB_NAME=${1:-"db"}
DB_USER=${2:-"admin"}

# Create the Local publication
psql -v ON_ERROR_STOP=1 -U "$DB_USER" -d $DB_NAME <<-EOSQL
    CREATE PUBLICATION publication FOR ALL TABLES;
EOSQL
echo "Publication publication created."