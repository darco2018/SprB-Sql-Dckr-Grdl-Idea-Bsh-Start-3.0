#!/usr/bin/env bash

source ./scripts/config.sh

docker run  -it -p 8080:8080 \
    --name ${app_container_name} \
    --link ${db_container_name} \
     ${app_image_name}

docker inspect -f "{{ .HostConfig.Links }}" ${app_container_name}