#!/bin/bash

# Script de lancement d'une application Spring Boot avec DNS dnsmasq
# Injecte le résolveur DNS custom (dns-resolver.jar) dans le classpath
# de l'application SANS modifier son code.
#
# Pré-requis :
#   - dnsmasq démarré (docker compose -f dnsmasq-compose.yml up -d)
#   - dns-resolver.jar buildé (cd dns-resolver && ./build.sh)
#
# Usage: ./start-app-with-dns.sh [options]
#
# Exemples:
#   ./start-app-with-dns.sh                                    # mvn spring-boot:run
#   ./start-app-with-dns.sh -jar target/myapp.jar              # java -jar (fat-jar)
#   ./start-app-with-dns.sh -Dspring.profiles.active=dev       # mvn avec profil

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DNS_SERVER="127.0.0.2"
DNS_PORT="53"
RESOLVER_JAR="$SCRIPT_DIR/dns-resolver/target/dns-resolver-1.0.0.jar"

COLOR_OK="\e[0;32m"
COLOR_KO="\e[0;31m"
COLOR_INFO="\e[0;36m"
COLOR_DEFAULT="\e[39m"

# --- Vérification du JAR resolver ---
echo -e "${COLOR_INFO}[1/4] Vérification du dns-resolver.jar...${COLOR_DEFAULT}"

if [ ! -f "$RESOLVER_JAR" ]; then
    echo -e "${COLOR_INFO}  JAR non trouvé, build en cours...${COLOR_DEFAULT}"
    (cd "$SCRIPT_DIR/dns-resolver" && mvn -q clean package -DskipTests)
fi

if [ ! -f "$RESOLVER_JAR" ]; then
    echo -e "${COLOR_KO}  [KO] Impossible de builder dns-resolver.jar${COLOR_DEFAULT}"
    exit 1
fi
echo -e "${COLOR_OK}  [OK] $RESOLVER_JAR${COLOR_DEFAULT}"
echo ""

# --- Vérification que dnsmasq est joignable ---
echo -e "${COLOR_INFO}[2/4] Vérification du serveur dnsmasq (${DNS_SERVER}:${DNS_PORT})...${COLOR_DEFAULT}"

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
echo -e "${COLOR_OK}  [OK] dnsmasq opérationnel (myoidc.local -> ${TEST_RESULT})${COLOR_DEFAULT}"
echo ""

# --- Configuration JVM DNS ---
echo -e "${COLOR_INFO}[3/4] Configuration du DNS pour la JVM (Java 18+)...${COLOR_DEFAULT}"

export JAVA_TOOL_OPTIONS="-Ddns.server=${DNS_SERVER} -Ddns.port=${DNS_PORT}"

echo "  JAVA_TOOL_OPTIONS=${JAVA_TOOL_OPTIONS}"
echo "  Resolver JAR: ${RESOLVER_JAR}"
echo ""

# --- Lancement de l'application ---
echo -e "${COLOR_INFO}[4/4] Lancement de l'application Spring Boot...${COLOR_DEFAULT}"
echo ""

if [ $# -eq 0 ]; then
    # Par défaut : mvn spring-boot:run avec le resolver dans le classpath
    echo "  Mode: mvn spring-boot:run (avec dns-resolver injecté)"
    echo ""
    exec mvn spring-boot:run \
        -Dspring-boot.run.additionalClasspathElements="$RESOLVER_JAR"
elif [[ "$1" == "-jar" ]]; then
    # Mode fat-jar : utilise loader.path pour injecter le resolver
    shift
    JAR_FILE="$1"
    shift
    echo "  Mode: java -jar ${JAR_FILE} (avec dns-resolver injecté via loader.path)"
    echo ""
    exec java -Ddns.server=${DNS_SERVER} -Ddns.port=${DNS_PORT} \
        -Dloader.path="$RESOLVER_JAR" \
        -jar "$JAR_FILE" "$@"
else
    # Mode personnalisé : passer les args à mvn spring-boot:run
    echo "  Mode: mvn spring-boot:run $@ (avec dns-resolver injecté)"
    echo ""
    exec mvn spring-boot:run \
        -Dspring-boot.run.additionalClasspathElements="$RESOLVER_JAR" \
        "$@"
fi
