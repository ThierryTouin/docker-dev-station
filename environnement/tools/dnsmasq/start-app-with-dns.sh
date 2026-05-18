#!/bin/bash

# Script de lancement d'une application Spring Boot avec DNS dnsmasq
# Résout les domaines locaux via dnsmasq sans modifier /etc/hosts ni sudo.
#
# Usage: ./start-app-with-dns.sh [options maven ou jar]
#
# Exemples:
#   ./start-app-with-dns.sh                          # mvn spring-boot:run
#   ./start-app-with-dns.sh -jar myapp.jar           # java -jar
#   ./start-app-with-dns.sh -Dspring.profiles.active=dev

set -e

DNS_SERVER="127.0.0.1"
DNS_PORT="5353"

COLOR_OK="\e[0;32m"
COLOR_KO="\e[0;31m"
COLOR_INFO="\e[0;36m"
COLOR_DEFAULT="\e[39m"

# --- Vérification que dnsmasq est joignable ---
echo -e "${COLOR_INFO}[1/3] Vérification du serveur dnsmasq (${DNS_SERVER}:${DNS_PORT})...${COLOR_DEFAULT}"

if command -v dig &>/dev/null; then
    TEST_RESULT=$(dig @${DNS_SERVER} -p ${DNS_PORT} +short +time=2 "myoidc.local" 2>/dev/null)
elif command -v nslookup &>/dev/null; then
    TEST_RESULT=$(nslookup -port=${DNS_PORT} "myoidc.local" ${DNS_SERVER} 2>/dev/null | awk '/^Address: / {print $2}' | tail -1)
else
    echo -e "${COLOR_KO}[ERREUR] Ni 'dig' ni 'nslookup' disponibles.${COLOR_DEFAULT}"
    exit 1
fi

if [ -z "$TEST_RESULT" ]; then
    echo -e "${COLOR_KO}[ERREUR] dnsmasq ne répond pas. Est-il démarré ?${COLOR_DEFAULT}"
    echo "  Lancer : docker compose -f dnsmasq-compose.yml up -d"
    exit 1
fi
echo -e "${COLOR_OK}  OK - dnsmasq opérationnel${COLOR_DEFAULT}"
echo ""

# --- Configuration DNS pour la JVM ---
echo -e "${COLOR_INFO}[2/3] Configuration DNS pour la JVM...${COLOR_DEFAULT}"

# networkaddress.cache.ttl : durée du cache DNS JVM (en secondes)
# Pour Java < 18, sun.net.spi.nameservice fonctionne
# Pour Java >= 18, on utilise les propriétés réseau standard

JAVA_DNS_OPTS="-Dnetworkaddress.cache.ttl=30"
JAVA_DNS_OPTS="$JAVA_DNS_OPTS -Dnetworkaddress.cache.negative.ttl=5"

# Forcer le DNS via les propriétés système (Java < 18)
JAVA_DNS_OPTS="$JAVA_DNS_OPTS -Dsun.net.spi.nameservice.nameservers=${DNS_SERVER}"
JAVA_DNS_OPTS="$JAVA_DNS_OPTS -Dsun.net.spi.nameservice.provider.1=dns,sun"

export JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS} ${JAVA_DNS_OPTS}"

echo "  JAVA_TOOL_OPTIONS=${JAVA_TOOL_OPTIONS}"
echo ""

# --- Lancement de l'application ---
echo -e "${COLOR_INFO}[3/3] Lancement de l'application Spring Boot...${COLOR_DEFAULT}"
echo ""

if [ $# -eq 0 ]; then
    # Par défaut : mvn spring-boot:run
    echo "  Mode: mvn spring-boot:run"
    echo ""
    exec mvn spring-boot:run
elif [[ "$1" == "-jar" ]]; then
    # Mode jar : java -jar
    shift
    echo "  Mode: java -jar $@"
    echo ""
    exec java ${JAVA_DNS_OPTS} -jar "$@"
else
    # Mode personnalisé : passer tous les args à mvn spring-boot:run
    echo "  Mode: mvn spring-boot:run $@"
    echo ""
    exec mvn spring-boot:run "$@"
fi
