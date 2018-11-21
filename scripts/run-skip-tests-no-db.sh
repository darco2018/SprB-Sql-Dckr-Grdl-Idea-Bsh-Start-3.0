#!/bin/bash

source ./scripts/config.sh

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> We will compile the files, build the JAR, create an image from Dockerfile-for-scripts and run the app in the Docker container"
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Building the project with Gradle Wrapper... >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
# always adds compiled changes
./scripts/skip-tests.sh

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Building ${app_image_name} from  Dockefile... >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
# the whole image is always created rather than adding new changes?
docker build -f Dockerfile-for-scripts -t ${app_image_name} ./

#//------------------------------------
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Running the app WITHOUT the database container... >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
./scripts/without-db.sh
#//------------------------------------


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Removing the container ${app_container_name} ... >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
docker rm ${app_container_name}

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> You can push your image with docker push ${app_image_name}... >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Removing image ${app_image_name}... >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
docker rmi  ${app_image_name}



