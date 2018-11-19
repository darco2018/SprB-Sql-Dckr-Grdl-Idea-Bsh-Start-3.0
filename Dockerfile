FROM openjdk:8
#   /tmp is where a Spring Boot app creates working directories for Tomcat by default.
VOLUME /tmp

ARG DEPENDENCY=target/dependency
COPY ${DEPENDENCY}/BOOT-INF/lib       /app/lib
COPY ${DEPENDENCY}/META-INF           /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes   /app
ENTRYPOINT ["java","-cp","app:app/lib/*","pl.ust.app.Main"]
