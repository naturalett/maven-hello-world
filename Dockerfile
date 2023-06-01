# FROM maven:3.9.2 AS build
# # COPY /src /src
# COPY ./src pom.xml ./
# # WORKDIR src
# RUN mvn clean install

FROM maven:3.8.3-openjdk-17-slim AS build
# COPY /src /src

COPY . /app
WORKDIR /app
RUN mvn clean install
# EXPOSE 8080
# COPY my-app /home/app/
# COPY pom.xml /home/app
# RUN mvn -f /home/app/my-app/pom.xml clean package

# FROM openjdk:8
FROM openjdk:17.0.1-jdk-slim-buster
COPY --from=build /app/target/my-app.jar /my-app.jar
ENTRYPOINT ["java", "-jar","/my-app.jar"]
EXPOSE 8080
# RUN mvn install
# ADD target/my-app.jar my-app.jar