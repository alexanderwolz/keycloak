# Keycloak - Customized Docker container

![GitHub release (latest by date)](https://img.shields.io/github/v/release/alexanderwolz/keycloak)
![GitHub](https://img.shields.io/badge/keycloak-26.5.2-orange)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/alexanderwolz/keycloak)
![GitHub all releases](https://img.shields.io/github/downloads/alexanderwolz/keycloak/total?color=informational)

## 🧑‍💻 About

This repository provides a customized Docker container of Keycloak integrating metrics spi and docker groups role mapper. See also [Keycloak Registry Mapper](https://github.com/alexanderwolz/keycloak-registry-mapper) and [Keycloak Metrics SPI](https://github.com/aerogear/keycloak-metrics-spi) 


## 🛠️ Build
1. ```cd build```
2. ```docker build -t alexanderwolz/keycloak .```

## ⚙️ Execute local deployment
1. ```docker compose down -v && docker compose up -d```

## 🐳 Dockerhub
1. ```docker pull alexanderwolz/keycloak:26.5.2```



- - -

Made with ❤️ in Bavaria
<br>
© 2025, <a href="https://www.alexanderwolz.de"> Alexander Wolz
