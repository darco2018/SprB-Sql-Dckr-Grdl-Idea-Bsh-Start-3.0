#!/usr/bin/env bash

source ./scripts/config.sh

docker run  -it -p 8080:8080  --name ${app_container_name}  ${app_image_name}
# --rm  -d
