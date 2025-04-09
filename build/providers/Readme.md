# Keycloak with additional libraries

## Metrics SPI
https://github.com/aerogear/keycloak-metrics-spi/releases/download/7.0.0/keycloak-metrics-spi-7.0.0.jar

### Activating
1. Log in to keycloak and go to master realm -> realm settings -> events
2. In Event listeners add "metrics-listener"
3. Repeat for all other realms

This can also be done automatically somehow. Hints:

```
#enable keycloak-metrics-spi
/opt/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080 --realm master --user $KEYCLOAK_ADMIN --password $KEYCLOAK_ADMIN_PASSWORD
/opt/keycloak/bin/kcadm.sh update events/config -s "eventsEnabled=true" -s "adminEventsEnabled=true" -s "eventsListeners+=metrics-listener"
rm /opt/keycloak/.keycloak/kcadm.config 
```

## Keycloak Groups To Docker Registry Mapper

### Activating
The mapper gets added by default but must be chosen in the admin UI
1. Go to Clients -> registry -> Client Scopes -> *-dedicated
2. Remove 'docker-v2-allow-all-mapper'
3. Add by clicking 'Configure new mapper' -> Choose Mapper "Allow by Groups and Roles"
4. Name: Allow by Groups and Roles
5. done

https://github.com/alexanderwolz/keycloak-docker-group-role-mapper/releases/download/v1.7.0/keycloak-docker-group-role-mapper-1.7.0.jar
