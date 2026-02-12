ARG KEYCLOAK_VERSION="26.5.3"
ARG METRICS_SPI_VERSION="7.0.0"
ARG REGISTRY_MAPPER_VERSION="1.9.2"


# stage 1: downloads
FROM alpine:3.22.1 AS downloader
ARG METRICS_SPI_VERSION
ARG REGISTRY_MAPPER_VERSION

RUN apk add --no-cache curl

WORKDIR /downloads

RUN curl -LO https://repo1.maven.org/maven2/de/alexanderwolz/keycloak-registry-mapper/${REGISTRY_MAPPER_VERSION}/keycloak-registry-mapper-${REGISTRY_MAPPER_VERSION}.jar || exit 1
RUN curl -LO https://github.com/aerogear/keycloak-metrics-spi/releases/download/${METRICS_SPI_VERSION}/keycloak-metrics-spi-${METRICS_SPI_VERSION}.jar || exit 1

# stage 2: keycloak build
FROM keycloak/keycloak:${KEYCLOAK_VERSION} AS builder
LABEL maintainer="mail@alexanderwolz.de"

ENV KC_FEATURES=docker,token-exchange
ENV KC_HEALTH_ENABLED=true
ENV KC_DB=postgres

COPY --from=downloader /downloads/ /opt/keycloak/providers/

RUN /opt/keycloak/bin/kc.sh build

# stage 3: runtime
FROM keycloak/keycloak:${KEYCLOAK_VERSION} AS runtime
LABEL maintainer="mail@alexanderwolz.de"

ENV KC_LOG_CONSOLE_OUTPUT=json
ENV KC_DB_URL=jdbc:postgresql://database:5432/keycloak

COPY --from=builder /opt/keycloak/ /opt/keycloak/
COPY themes /opt/keycloak/themes/

WORKDIR /opt/keycloak

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start", "--optimized"]
