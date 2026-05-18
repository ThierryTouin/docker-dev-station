#!/bin/bash

# Script de test des entrées DNS via le serveur dnsmasq local
# Usage: ./test-dns.sh

set -e

DNS_SERVER="127.0.0.1"
DNS_PORT="5353"

COLOR_OK="\e[0;32m"
COLOR_KO="\e[0;31m"
COLOR_INFO="\e[0;36m"
COLOR_DEFAULT="\e[39m"

DOMAINS=("myoidc.local" "dev1.local")

echo -e "${COLOR_INFO}========================================${COLOR_DEFAULT}"
echo -e "${COLOR_INFO} Test DNS via dnsmasq (port ${DNS_PORT})${COLOR_DEFAULT}"
echo -e "${COLOR_INFO}========================================${COLOR_DEFAULT}"
echo ""

# Vérifier que dig est installé
if ! command -v dig &> /dev/null; then
    echo -e "${COLOR_KO}[ERREUR] 'dig' n'est pas installé.${COLOR_DEFAULT}"
    echo "  Installer avec : sudo apt install dnsutils"
    exit 1
fi

for domain in "${DOMAINS[@]}"; do
    echo -n "  Résolution de ${domain} ... "
    result=$(dig @${DNS_SERVER} -p ${DNS_PORT} +short "${domain}" 2>/dev/null)

    if [ -n "$result" ]; then
        echo -e "${COLOR_OK}OK${COLOR_DEFAULT} -> ${result}"
    else
        echo -e "${COLOR_KO}ECHEC${COLOR_DEFAULT} (pas de réponse)"
    fi
done

echo ""
echo -e "${COLOR_INFO}----------------------------------------${COLOR_DEFAULT}"
echo -e "${COLOR_INFO} Test d'un domaine externe (google.com)${COLOR_DEFAULT}"
echo -e "${COLOR_INFO}----------------------------------------${COLOR_DEFAULT}"
echo -n "  Résolution de google.com ... "
result=$(dig @${DNS_SERVER} -p ${DNS_PORT} +short "google.com" 2>/dev/null | head -1)

if [ -n "$result" ]; then
    echo -e "${COLOR_OK}OK${COLOR_DEFAULT} -> ${result}"
else
    echo -e "${COLOR_KO}ECHEC${COLOR_DEFAULT} (pas de réponse)"
fi

echo ""
echo -e "${COLOR_INFO}========================================${COLOR_DEFAULT}"
echo -e "${COLOR_INFO} Utilisation depuis vos applications :${COLOR_DEFAULT}"
echo -e "${COLOR_INFO}========================================${COLOR_DEFAULT}"
echo ""
echo "  Pour utiliser ce DNS depuis votre host sans modifier /etc/hosts,"
echo "  configurez vos applications pour utiliser le DNS :"
echo "    DNS Server: ${DNS_SERVER}:${DNS_PORT}"
echo ""
echo "  Ou utilisez nslookup/dig manuellement :"
echo "    dig @${DNS_SERVER} -p ${DNS_PORT} myoidc.local"
echo "    nslookup -port=${DNS_PORT} myoidc.local ${DNS_SERVER}"
echo ""
