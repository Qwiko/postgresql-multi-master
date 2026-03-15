#!/usr/bin/env bash
set -e

PEER_HOST=${1:-"pg_node_2"}
DB_NAME=${2:-"db"}
DB_USER=${3:-"admin"}
DB_PASSWORD=${4:-"postgres"}

SUB_NAME="subscription_$PEER_HOST"

echo "Setting up subscription to $PEER_HOST, db: $DB_NAME"

psql -U "$DB_USER" -d $DB_NAME <<-EOSQL
    CREATE SUBSCRIPTION $SUB_NAME 
    CONNECTION 'host=$PEER_HOST dbname=$DB_NAME user=$DB_USER password=$DB_PASSWORD' 
    PUBLICATION publication 
    WITH (origin = none);
EOSQL
