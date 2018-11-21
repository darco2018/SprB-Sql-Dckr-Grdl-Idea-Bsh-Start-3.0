#!/usr/bin/env bash

source ./scripts/config.sh

echo println "&&&&&&&&&&&&&&&&&& About to run "docker run  -it -p 8080:8080 --name ${app_container_name} --link ${db_container_name} ${app_image_name}" %%%%%%%%%%%%%%%%%55555555555"

docker run  -it -p 8080:8080 \
    --name ${app_container_name} \
    --link ${db_container_name} \
     ${app_image_name}

echo println "&&&&&&&&&&&&&&&&&& Run started %%%%%%%%%%%%%%%%%55555555555"

docker inspect -f "{{ .HostConfig.Links }}" ${app_container_name}

echo println "&&&&&&&&&&&&&&&&&& Inspection finished %%%%%%%%%%%%%%%%%55555555555"