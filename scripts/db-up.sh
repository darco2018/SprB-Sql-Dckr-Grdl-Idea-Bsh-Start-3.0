#!/usr/bin/env bash

source ./scripts/config.sh

echo "Starting the database container..."
docker run -d  --name  ${db_container_name} \
    --env="MYSQL_ROOT_PASSWORD=${pass}" \
    --env="MYSQL_PASSWORD=${pass}" \
    --env="MYSQL_DATABASE=${db_name}" \
    mysql

echo "Fetching logs from the database container..."
docker logs ${db_container_name}

echo "Inspecting the database container..."
docker inspect ${db_container_name}

#docker exec -it db bash
#mysql -u root -h localhost -proot
#show databases;