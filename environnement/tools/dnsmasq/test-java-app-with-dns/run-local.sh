#!/bin/bash

# Script de lancement en mode LOCAL (DNS embarqué, sans serveur externe)
# Résout les noms depuis le fichier dns-hosts.properties.
#
# Usage: ./run-local.sh
#
# Pré-requis :
#   - Java 21+ et Maven installés
#   - PAS besoin de dnsmasq / Docker

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
RESOLVER_JAR="$SCRIPT_DIR/dns-resolver/target/dns-resolver-1.0.0.jar"
DEMO_APP_DIR="$SCRIPT_DIR/demo-springboot"
HOSTS_FILE="$SCRIPT_DIR/dns-hosts.properties"

COLOR_OK="\e[0;32m"
COLOR_KO="\e[0;31m"
COLOR_INFO="\e[0;36m"
COLOR_DEFAULT="\e[39m"

echo ""
echo -e "${COLOR_INFO}╔═══════════════════════════════════════════════════╗${COLOR_DEFAULT}"
echo -e "${COLOR_INFO}║  Test Java App with DNS (mode LOCAL embarqué)     ║${COLOR_DEFAULT}"
echo -e "${COLOR_INFO}╚═══════════════════════════════════════════════════╝${COLOR_DEFAULT}"
echo ""

# --- 1. Vérification fichier hosts ---
echo -e "${COLOR_INFO}[1/3] Vérification dns-hosts.properties...${COLOR_DEFAULT}"

if [ ! -f "$HOSTS_FILE" ]; then
    echo -e "${COLOR_KO}  [KO] Fichier non trouvé: ${HOSTS_FILE}${COLOR_DEFAULT}"
    exit 1
fi

ENTRY_COUNT=$(grep -c "^[^#]" "$HOSTS_FILE" 2>/dev/null | grep -v "^0$" || echo "0")
echo -e "${COLOR_OK}  [OK] ${HOSTS_FILE} (${ENTRY_COUNT} entrées)${COLOR_DEFAULT}"
echo ""

# --- 2. Build du dns-resolver.jar ---
echo -e "${COLOR_INFO}[2/3] Build du dns-resolver.jar...${COLOR_DEFAULT}"

(cd "$SCRIPT_DIR/dns-resolver" && mvn -q clean package -DskipTests)

if [ ! -f "$RESOLVER_JAR" ]; then
    echo -e "${COLOR_KO}  [KO] Echec du build de dns-resolver.jar${COLOR_DEFAULT}"
    exit 1
fi
echo -e "${COLOR_OK}  [OK] ${RESOLVER_JAR}${COLOR_DEFAULT}"
echo ""

# --- 3. Lancement de l'application demo ---
echo -e "${COLOR_INFO}[3/3] Lancement de l'application Spring Boot (mode local)...${COLOR_DEFAULT}"
echo ""

export JAVA_TOOL_OPTIONS="-javaagent:${RESOLVER_JAR} -Ddns.mode=local -Ddns.hosts.file=${HOSTS_FILE} -Ddns.fallback=true"
echo "  JAVA_TOOL_OPTIONS=${JAVA_TOOL_OPTIONS}"
echo ""

cd "$DEMO_APP_DIR"
mvn -q spring-boot:run

echo ""
echo -e "${COLOR_INFO}Terminé.${COLOR_DEFAULT}"
