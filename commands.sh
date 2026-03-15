

# Publications
docker exec pg_node_1 psql -U admin -d db -c "CREATE PUBLICATION pub_node_1 FOR ALL TABLES;"
docker exec pg_node_2 psql -U admin -d db -c "CREATE PUBLICATION pub_node_2 FOR ALL TABLES;"

# Subscription
docker exec pg_node_1 psql -U admin -d db -c "
  CREATE SUBSCRIPTION sub_node_2 
  CONNECTION 'host=pg_node_2 dbname=db user=admin password=postgres' 
  PUBLICATION pub_node_2 
  WITH (origin = none);"

docker exec pg_node_2 psql -U admin -d db -c "
  CREATE SUBSCRIPTION sub_node_1 
  CONNECTION 'host=pg_node_1 dbname=db user=admin password=postgres' 
  PUBLICATION pub_node_1 
  WITH (origin = none);"

# Test table
docker exec pg_node_1 psql -U admin -d db -c "
  CREATE TABLE users (id serial PRIMARY KEY, username VARCHAR(50));"

docker exec pg_node_2 psql -U admin -d db -c "
  CREATE TABLE users (id serial PRIMARY KEY, username VARCHAR(50));"



# Insert on A
docker exec pg_node_1 psql -U admin -d db -c "INSERT INTO users (username) VALUES ('Alice_from_A');"

# Read on B
docker exec pg_node_2 psql -U admin -d db -c "SELECT * FROM users;"

# Insert on B
docker exec pg_node_2 psql -U admin -d db -c "INSERT INTO users (username) VALUES ('Bob_from_B');"

# Read on A
docker exec pg_node_1 psql -U admin -d db -c "SELECT * FROM users;"