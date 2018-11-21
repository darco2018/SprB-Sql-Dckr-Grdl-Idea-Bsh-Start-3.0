# Reference app with

- IntelliJ
- Gradle (Wrapper)
- SpringBoot
- MySql
- bash scripts
- docker
- docker-compose
- plugin **com.palantir.docker** to build/push image
(alternative plugin is here https://github.com/Transmode/gradle-docker)


You can use BOTH **bash scripts** in _script_ folder AND **Docker plugin** to build an image and run the app in a container
You can also **docker-compose up/down** to start  2 linked containers: webapp and db.

---------------------------
#### Compared with SprB-Sql-Dckr-Grdl-Idea-Bsh-Start-1.0:

1. Added plugin '**com.palantir.docker**' which can
- build image with 
    /gradlew clean build --info **docker** 
- build image and push to DockerHub with
    ./gradlew clean build --info **dockerPush**

Other tasks of the plugin are defined here:
https://github.com/palantir/gradle-docker

The plugin creates _docker_ folder in the project with _dependency_ folder

2. Added a new directory structure in Dockerfile:
DEPENDENCY=target/dependency -> That's where JAR gets unpacked now.
build.gradle defines this custom task '_unpack_'

3. The functionality of version 1 of this project remains untouched, encapsulated in folder _scripts_.
But it uses a different Dockerfile: Dockerfile-for-scripts. TODO: they could be replaced with a single Dockerfile.

4. Added docker-compose.yml

------------------------------------

What I still miss:

**app**
- can't connect from Java file to the database 
- no Hibernate integration

### NOTES:
- when referring to other files/folders we have to write the full path even if it's in the same folder, eg
./scripts/config.sh  or  ./gradlew clean   (where ./ means the root folder, gradlew is in the root folder)

- docker run doesnt compile changed files - for this do gradle build
- docker exec -it distracted_murdock /bin/sh (for alpine - which doesnt have bash or curl)
- docker exec -it distracted_murdock bash  (openjdk has bash and curl)

#### This app uses bash scripts to build Docker containers for 
- the app 
- the database.
Run them like this **./scripts/xxx.sh**
----------------------------
Using my scripts it's necessary to FIRST spin up the database with **db-up** if you want to use it in a container.
**db-up** - spins up the database in a Docker container
**db-down** - stops and **destroys** the container 

**run-all.sh**  
- builds the project with Gradle Wrapper
- builds the image
- connect to the db (it must be previously span up with **db-up** )
- runs the app WITHOUT the dockerized database in a Docker container on the embedded SpringBoot's tomcat
- removes the image and container when the server is stopped

**run-no-db.sh**  
as above but
- runs the image WITHOUT the dockerized database 

**run-skip-tests-no-db.sh**  
as above but also
- skips tests

------------------

- **./gradlew bootRun** - can be used to start the app outside Docker containers without tests
- **./gradlew clean build --info** - just build the JAR
- **./gradlew clean test --scan** - just run unit tests

**--scan** will generate a report to be seen at the link provided at the end of the run (note: during the run
you'll have to approve licence agreement)

-----------------

**docker-compose up/down** - use docker-compose.ymp to create a STACK. It starts both the app in the container as well as the database
It downloads the image if its missing locally.
It doesnt remove the constainers or the image when tomcat is stopped. It reuses them.
It doesnt re-compile, so you dont see changes.

#### Debugging the application in a Docker container

To debug the application JPDA Transport can be used. So we’ll treat the container like a remote server. To enable this feature pass a java agent settings in JAVA_OPTS variable and map agent’s port to localhost during a container run. With the Docker for Mac there is limitation due to that we can’t access container by IP without black magic usage.

```sh
$ docker run -e "JAVA_OPTS=-agentlib:jdwp=transport=dt_socket,address=5005,server=y,suspend=n" \ 
-p 8080:8080 -p 5005:5005 -t springio/gs-spring-boot-docker\
```


--------------------
        
        
#####See **build.gradle-dirty** for comments about build.gradle
