#!/bin/bash

# entorno
sudo podman network create lbd-net

sudo podman run -d --name nodo1 --network lbd-net -p 5441:5432 \
  -e POSTGRES_PASSWORD="$PGPASS" \
  -v nodo1-datos:/var/lib/postgresql/data \
  docker.io/library/postgres:16 -c wal_level=replica -c max_prepared_transactions=10

sudo podman run -d --name nodo3 --network lbd-net -p 5443:5432 \
  -e POSTGRES_PASSWORD="$PGPASS" \
  -v nodo3-datos:/var/lib/postgresql/data \
  docker.io/library/postgres:16 -c max_prepared_transactions=10

sleep 10
sudo podman exec nodo1 psql -U postgres -c 'CREATE DATABASE "db-nodo1";'
sudo podman exec nodo3 psql -U postgres -c 'CREATE DATABASE "db-nodo3";'

# replicacion
sudo podman exec nodo1 psql -U postgres -c "CREATE ROLE replicador WITH REPLICATION LOGIN PASSWORD '$PGPASS_REPL';"
sudo podman exec nodo1 sh -c 'echo "host replication replicador 10.89.0.0/24 scram-sha-256" >> /var/lib/postgresql/data/pg_hba.conf'
sudo podman exec nodo1 psql -U postgres -c "SELECT pg_reload_conf();"

sudo podman run --rm --network lbd-net --user postgres \
  -e PGPASSWORD="$PGPASS_REPL" \
  -v nodo2-datos:/var/lib/postgresql/data \
  docker.io/library/postgres:16 \
  sh -c "pg_basebackup -h nodo1 -U replicador -D /var/lib/postgresql/data -R -X stream -P && chmod 700 /var/lib/postgresql/data"

sudo podman run -d --name nodo2 --network lbd-net -p 5442:5432 \
  -v nodo2-datos:/var/lib/postgresql/data \
  docker.io/library/postgres:16 -c max_prepared_transactions=10

# detener nodo2
sudo podman stop nodo2

# iniciar nodo2
sudo podman start nodo2
