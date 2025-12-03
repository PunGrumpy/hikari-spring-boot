FROM maven:3.9.11-eclipse-temurin-21 AS build

WORKDIR /app

# Copy pom first and download dependencies (better Docker cache usage)
COPY pom.xml .
RUN mvn -B -ntp dependency:go-offline

# Copy the rest of the source and build
COPY src ./src
RUN mvn -B -ntp package -DskipTests

FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

# Copy the Spring Boot fat jar from the build stage
COPY --from=build /app/target/spring-boot-jdbc-1.0.jar app.jar

# Allow passing arguments, e.g.:
#   docker run --rm --network=host hikari-spring-boot insert Alice alice@example.com
#   docker run --rm --network=host hikari-spring-boot display
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

# docker build -t hikari-spring-boot .
# docker run -p 3000:3000 hikari-spring-boot