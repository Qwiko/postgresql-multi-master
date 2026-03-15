## Restart sequences

```bash
# Example: Running on pg_node_1
cat ./scripts/restart_sequences.sh | docker exec -i pg_node_1 bash -s -- 1 2 db admin

# Example: Running on pg_node_2
cat ./scripts/restart_sequences.sh | docker exec -i pg_node_2 bash -s -- 2 2 db admin
```

## Create local publication

```bash
# Example: Running on pg_node_1
cat ./scripts/setup_publication.sh | docker exec -i pg_node_1 bash -s -- db admin

# Example: Running on pg_node_2
cat ./scripts/setup_publication.sh | docker exec -i pg_node_2 bash -s -- db admin
```

## Setup subscription

```bash
# Example: Running on pg_node_1
cat ./scripts/setup_subscription.sh | docker exec -i pg_node_1 bash -s -- pg_node_2 db admin postgres

# Example: Running on pg_node_2
cat ./scripts/setup_subscription.sh | docker exec -i pg_node_2 bash -s -- pg_node_1 db admin postgres
```

## Refresh subscription

Must be done after new tables have been added

```bash
docker exec pg_node_1 psql -U admin -d db -c "
  ALTER SUBSCRIPTION subscription_pg_node_2 REFRESH PUBLICATION WITH (copy_data = false);"

docker exec pg_node_2 psql -U admin -d db -c "
  ALTER SUBSCRIPTION subscription_pg_node_1 REFRESH PUBLICATION WITH (copy_data = false);"
```
