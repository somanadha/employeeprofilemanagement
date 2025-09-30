# Stage 1: Build the application and resolve dependencies Using Maven 3.9.4 running on JDK 21
FROM maven:3.9.4-eclipse-temurin-21-alpine AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src

# Download dependencies only to cache them for later build stages
# Download dependencies to the target/dependency directory for later build stages
RUN mvn dependency:copy-dependencies

# Package the application as a fat jar or a standard jar
RUN mvn -X package -DskipTests

# Stage 2: Create the final image using JRE 21 only
FROM eclipse-temurin:21-alpine
WORKDIR /app

# Copy the application JAR (LEAN/THIN) & its dependencies from the build stage to make a FAT/UBER JAR
COPY --from=build /app/target/*.jar employeeprofilemanagement.jar

# Application is running in port 8200
EXPOSE 8200

# Command to run the application with all dependencies on the classpath
ENTRYPOINT ["java", "-jar", "employeeprofilemanagement.jar"]