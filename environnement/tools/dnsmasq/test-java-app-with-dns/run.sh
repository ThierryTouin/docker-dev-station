#!/bin/bash

# Script principal : build le dns-resolver et lance l'application demo Spring Boot
# avec le DNS dnsmasq injecté (sans modification du code applicatif).
#
# Usage: ./run.sh
#
# Pré-requis :
#   - dnsmasq démarré (cd .. && docker compose -f dnsmasq-compose.yml up -d)
#   - Java 21+ et Maven installés

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DNS_SERVER="127.0.0.2"
DNS_PORT="53"
RESOLVER_JAR="$SCRIPT_DIR/dns-resolver/target/dns-resolver-1.0.0.jar"
DEMO_APP_DIR="$SCRIPT_DIR/demo-springboot"

COLOR_OK="\e[0;32m"
COLOR_KO="\e[0;31m"
COLOR_INFO="\e[0;36m"
COLOR_DEFAULT="\e[39m"

echo ""
echo -e "${COLOR_INFO}╔═══════════════════════════════════════════════════╗${COLOR_DEFAULT}"
echo -e "${COLOR_INFO}║  Test Java App with DNS (dnsmasq)                 ║${COLOR_DEFAULT}"
echo -e "${COLOR_INFO}╚═══════════════════════════════════════════════════╝${COLOR_DEFAULT}"
echo ""

# --- 1. Vérification dnsmasq ---
echo -e "${COLOR_INFO}[1/4] Vérification dnsmasq (${DNS_SERVER}:${DNS_PORT})...${COLOR_DEFAULT}"

if command -v dig &>/dev/null; then
    TEST_RESULT=$(dig @${DNS_SERVER} -p ${DNS_PORT} +short +time=2 "myoidc.local" 2>/dev/null)
elif command -v nslookup &>/dev/null; then
    TEST_RESULT=$(nslookup -port=${DNS_PORT} "myoidc.local" ${DNS_SERVER} 2>/dev/null | awk '/^Address: / {print $2}' | tail -1)
else
    echo -e "${COLOR_KO}  [KO] Ni 'dig' ni 'nslookup' disponibles.${COLOR_DEFAULT}"
    exit 1
fi

if [ -z "$TEST_RESULT" ]; then
    echo -e "${COLOR_KO}  [KO] dnsmasq ne répond pas.${COLOR_DEFAULT}"
    echo ""
    echo "  Démarrer dnsmasq :"
    echo "    cd $SCRIPT_DIR/.."
    echo "    docker compose -f dnsmasq-compose.yml up -d"
    echo ""
    exit 1
fi
echo -e "${COLOR_OK}  [OK] dnsmasq opérationnel (myoidc.local -> ${TEST_RESULT})${COLOR_DEFAULT}"
echo ""

# --- 2. Build du dns-resolver.jar ---
echo -e "${COLOR_INFO}[2/4] Build du dns-resolver.jar...${COLOR_DEFAULT}"

if [ ! -f "$RESOLVER_JAR" ]; then
    (cd "$SCRIPT_DIR/dns-resolver" && mvn -q clean package -DskipTests)
fi

if [ ! -f "$RESOLVER_JAR" ]; then
    echo -e "${COLOR_KO}  [KO] Echec du build de dns-resolver.jar${COLOR_DEFAULT}"
    exit 1
fi
echo -e "${COLOR_OK}  [OK] ${RESOLVER_JAR}${COLOR_DEFAULT}"
echo ""

# --- 3. Configuration JVM ---
echo -e "${COLOR_INFO}[3/4] Configuration DNS pour la JVM (Java 18+ SPI via agent)...${COLOR_DEFAULT}"

# -javaagent: ajoute le JAR au system classpath → ServiceLoader trouve le SPI
export JAVA_TOOL_OPTIONS="-javaagent:${RESOLVER_JAR} -Ddns.server=${DNS_SERVER} -Ddns.port=${DNS_PORT}"

echo "  JAVA_TOOL_OPTIONS=${JAVA_TOOL_OPTIONS}"
echo ""

# --- 4. Lancement de l'application demo ---
echo -e "${COLOR_INFO}[4/4] Lancement de l'application Spring Boot demo...${COLOR_DEFAULT}"
echo ""

cd "$DEMO_APP_DIR"
mvn -q spring-boot:run

echo ""
echo -e "${COLOR_INFO}Terminé.${COLOR_DEFAULT}"
