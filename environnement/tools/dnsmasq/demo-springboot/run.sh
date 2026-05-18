#!/bin/bash

# Lance l'application Spring Boot dns-check avec le DNS dnsmasq configuré.
# Usage: ./run.sh
#
# Pré-requis :
#   - dnsmasq démarré (docker compose -f ../dnsmasq-compose.yml up -d)
#   - Java 17+ et Maven installés

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DNS_SERVER="127.0.0.2"

COLOR_OK="\e[0;32m"
COLOR_KO="\e[0;31m"
COLOR_INFO="\e[0;36m"
COLOR_DEFAULT="\e[39m"

echo ""
echo -e "${COLOR_INFO}╔═══════════════════════════════════════════════╗${COLOR_DEFAULT}"
echo -e "${COLOR_INFO}║   DNS Check - Spring Boot + dnsmasq           ║${COLOR_DEFAULT}"
echo -e "${COLOR_INFO}╚═══════════════════════════════════════════════╝${COLOR_DEFAULT}"
echo ""

# --- Vérification dnsmasq ---
echo -e "${COLOR_INFO}[1/3] Vérification que dnsmasq est actif...${COLOR_DEFAULT}"

if command -v dig &>/dev/null; then
    TEST=$(dig @${DNS_SERVER} -p 53 +short +time=2 "myoidc.local" 2>/dev/null)
elif command -v nslookup &>/dev/null; then
    TEST=$(nslookup "myoidc.local" ${DNS_SERVER} 2>/dev/null | grep -i "address" | tail -1 | awk '{print $2}')
else
    TEST=""
fi

if [ -z "$TEST" ]; then
    echo -e "${COLOR_KO}  [KO] dnsmasq ne répond pas sur ${DNS_SERVER}:53${COLOR_DEFAULT}"
    echo ""
    echo "  Démarrer dnsmasq :"
    echo "    cd ${SCRIPT_DIR}/.."
    echo "    docker compose -f dnsmasq-compose.yml up -d"
    echo ""
    exit 1
fi
echo -e "${COLOR_OK}  [OK] dnsmasq répond (myoidc.local -> ${TEST})${COLOR_DEFAULT}"
echo ""

# --- Configuration JVM DNS ---
echo -e "${COLOR_INFO}[2/3] Configuration du DNS pour la JVM...${COLOR_DEFAULT}"

# Java 18+ : sun.net.spi.nameservice est supprimé.
# On utilise un custom InetAddressResolverProvider (SPI) + dnsjava.
# Les propriétés dns.server et dns.port sont lues par notre DnsmasqResolverProvider.
export JAVA_TOOL_OPTIONS="-Ddns.server=${DNS_SERVER} -Ddns.port=53"

echo "  JAVA_TOOL_OPTIONS=${JAVA_TOOL_OPTIONS}"
echo ""

# --- Lancement de l'application ---
echo -e "${COLOR_INFO}[3/3] Lancement de l'application Spring Boot...${COLOR_DEFAULT}"
echo ""

cd "$SCRIPT_DIR"
mvn -q spring-boot:run 2>&1 | grep -v "Picked up JAVA_TOOL_OPTIONS"

echo ""
echo -e "${COLOR_INFO}Terminé.${COLOR_DEFAULT}"
