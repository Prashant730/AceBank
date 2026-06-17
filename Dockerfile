# ── Stage 1: Build ──────────────────────────────────────────────────────────
FROM eclipse-temurin:21-jdk-alpine AS builder

WORKDIR /app

# Copy Maven wrapper and pom first (better layer caching)
COPY .mvn/ .mvn/
COPY mvnw pom.xml ./

# Download dependencies (cached unless pom.xml changes)
RUN ./mvnw dependency:go-offline -q

# Copy source and build
COPY src/ src/
RUN ./mvnw clean package -DskipTests -q

# ── Stage 2: Run ─────────────────────────────────────────────────────────────
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

COPY --from=builder /app/target/ace-bank-lite-1.0-SNAPSHOT.jar app.jar

# Render injects PORT at runtime
EXPOSE 8081

ENTRYPOINT ["java", "-jar", "app.jar"]
