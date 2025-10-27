# Stage 1: Build app bằng Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
# Copy the Maven project (flattened) so pom.xml is at /app/pom.xml
COPY initial/ /app/
RUN mvn -B -q clean package -DskipTests

# Stage 2: Run app
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
# Match Spring Boot server.port in application.properties
EXPOSE 8085
ENTRYPOINT ["java", "-jar", "app.jar"]
