ARG KEYCLOAK_VERSION="26.4.0"
ARG METRICS_SPI_VERSION="7.0.0"
ARG REGISTRY_MAPPER_VERSION="1.8.0"


# stage 1: downloads
FROM alpine:3.22.1 AS downloader
RUN apk add curl
WORKDIR /downloads
RUN curl -sL https://repo1.maven.org/maven2/de/alexanderwolz/keycloak-registry-mapper/${REGISTRY_MAPPER_VERSION}/keycloak-registry-mapper-${REGISTRY_MAPPER_VERSION}.jar
RUN curl -sL https://github.com/aerogear/keycloak-metrics-spi/releases/download/${METRICS_SPI_VERSION}/keycloak-metrics-spi-${METRICS_SPI_VERSION}.jar

# stage 2: keycloak build
FROM keycloak/keycloak:${KEYCLOAK_VERSION} AS builder
LABEL maintainer="mail@alexanderwolz.de"
ARG METRICS_VERSION
ARG MAPPER_VERSION
ENV KC_HEALTH_ENABLED=false
ENV KC_METRICS_ENABLED=false
ENV KC_FEATURES=docker
ENV KC_DB=mariadb
COPY --from=downloader /downloads/*.jar /opt/keycloak/providers
RUN /opt/keycloak/bin/kc.sh build

# stage 2: runtime
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
