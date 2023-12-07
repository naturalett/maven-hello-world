FROM maven:3.8.3-openjdk-17-slim AS build
WORKDIR /build
COPY . /build
RUN mvn clean install

FROM openjdk:17.0.1-jdk-slim-buster
WORKDIR /data
# see .dockerignore
COPY --from=build /build/target/*.jar .
ENTRYPOINT ["java", "-jar","app.jar"]
EXPOSE 8080
