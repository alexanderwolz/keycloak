ARG KEYCLOAK_VERSION="26.1.4"
ARG METRICS_VERSION="7.0.0"
ARG MAPPER_VERSION="1.7.0"

# stage 1: keycloak build
FROM keycloak/keycloak:${KEYCLOAK_VERSION} AS builder
LABEL maintainer="mail@alexanderwolz.de"
ARG METRICS_VERSION
ARG MAPPER_VERSION
ENV KC_HEALTH_ENABLED=false
ENV KC_METRICS_ENABLED=false
ENV KC_FEATURES=docker
ENV KC_DB=mariadb
COPY providers/keycloak-docker-group-role-mapper-${MAPPER_VERSION}.jar /opt/keycloak/providers/
COPY providers/keycloak-metrics-spi-${METRICS_VERSION}.jar /opt/keycloak/providers/
RUN /opt/keycloak/bin/kc.sh build

## stage 2: runtime
FROM keycloak/keycloak:${KEYCLOAK_VERSION} AS runtime
LABEL maintainer="mail@alexanderwolz.de"
ARG METRICS_VERSION
ENV KC_LOG_CONSOLE_OUTPUT=json
ENV KC_DB_URL=jdbc:mariadb://database:3306/database
COPY --from=builder /opt/keycloak/lib/quarkus/ /opt/keycloak/lib/quarkus/
COPY --from=builder /opt/keycloak/providers/ /opt/keycloak/providers/
WORKDIR /opt/keycloak
COPY themes /opt/keycloak/themes/

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start", "--optimized"]
