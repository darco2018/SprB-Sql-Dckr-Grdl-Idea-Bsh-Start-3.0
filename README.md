# Reference app with

- IntelliJ
- Gradle (Wrapper)
- SpringBoot
- MySql
- Docker
- bash scripts
- plugin **com.palantir.docker** to build/push image
(alternative plugin is here https://github.com/Transmode/gradle-docker)
- **docker-compose.yml**

You can use BOTH **bash scripts** in script folder and/or **Docker plugin** to build an image and run in a container
and you can run **docker-compose up/down** to start 2 separate containers: webapp and db.

---------------------------
#### Compared with SprB-Sql-Dckr-Grdl-Idea-Bsh-Start-1.0:

1. Added plugin '**com.palantir.docker**' which can
- build image with 
    /gradlew clean build **docker** --info
- build image and push to DockerHub with
    ./gradlew clean build **dockerPush** --info 
. - to build image
Other tasks of the plugin are defined here:
https://github.com/palantir/gradle-docker

The plugin creates _docker_ folder in the project with _dependency_ folder

2. Added a new directory structure in Dockerfile:
DEPENDENCY=target/dependency
That's where JAr gets unpacked now.
build.gradle defines task '_unpack_'

3. The functionality of version 1 of this project remains untouched, encapsulated in folder _scripts_.
But it uses a different Dockerfile, so if you want to use the older version you'd better remove Dockerfile from 
the root folder of the project.

4. Added docker-compose.yml

------------------------------------

What I still miss:

**app**
- can't connect from Java file to the database 
- no Hibernate integration

The app  **doesn't** use **docker-compose**.

### NOTES:
- when referring to other files/folders we have to write the full path even if it's in the same folder, eg
./scripts/config.sh  or  ./gradlew clean   (where ./ means the root folder, gradlew is in the root folder)

- docker run nie kompiluje zmienionych plików - konieczny jest gradle build
- docker exec -it distracted_murdock /bin/sh (for alpine - which doesnt have bash or curl)
- docker exec -it distracted_murdock bash  (openjdk has bash and curl)

#### This app uses bash scripts to build Docker containers for 
- the app 
- the database.
Run them like this **./ xxx.sh**
----------------------------
It's necessary to FIRST spin up the database with **db-up** if you want to use it in a container.
**db-up** - spins up the database in a Docker container
**db-down** - stops and destroys the container 

**run-all.sh**  
- builds the project with Gradle Wrapper
- builds the image
- connect to the db (it must be previously span up with **db-up** )
- runs the image WITHOUT the database in a Docker container
- removes the image and container when the server is stopped

**run-no-db.sh**  
As above but also
- doens connect to the db 

**run-skip-tests-no-db.sh**  
As **run.sh** but 
- doens connect to the db 
- skips tests
------------------

- **./gradlew bootRun** - can be used to start the app outside Docker containers without tests
- **./gradlew clean build --info** - just build the JAR
- **./gradlew clean test --scan** - just run unit tests

-----------------

#### Debugging the application in a Docker container

To debug the application JPDA Transport can be used. So we’ll treat the container like a remote server. To enable this feature pass a java agent settings in JAVA_OPTS variable and map agent’s port to localhost during a container run. With the Docker for Mac there is limitation due to that we can’t access container by IP without black magic usage.

```sh
$ docker run -e "JAVA_OPTS=-agentlib:jdwp=transport=dt_socket,address=5005,server=y,suspend=n" \ 
-p 8080:8080 -p 5005:5005 -t springio/gs-spring-boot-docker\
```


--------------------
        
        
#####See **build.gradle-dirty** for comments about build.gradle
