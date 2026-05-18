#!/bin/bash

# Script de test DNS via dnsmasq - SANS sudo
# Teste la résolution DNS, puis simule des connexions réseau
# en utilisant les IPs résolues par dnsmasq.
#
# Usage: ./test-dns-namespace.sh

set -e

DNS_SERVER="127.0.0.1"
DNS_PORT="5353"

DOMAINS=("myoidc.local" "dev1.local")

COLOR_OK="\e[0;32m"
COLOR_KO="\e[0;31m"
COLOR_INFO="\e[0;36m"
COLOR_DEFAULT="\e[39m"

echo -e "${COLOR_INFO}============================================${COLOR_DEFAULT}"
echo -e "${COLOR_INFO} Test DNS via dnsmasq (${DNS_SERVER}:${DNS_PORT})${COLOR_DEFAULT}"
echo -e "${COLOR_INFO} (sans sudo)${COLOR_DEFAULT}"
echo -e "${COLOR_INFO}============================================${COLOR_DEFAULT}"
echo ""

# Vérifier les outils disponibles
HAS_DIG=false
HAS_NSLOOKUP=false
HAS_CURL=false

command -v dig &>/dev/null && HAS_DIG=true
command -v nslookup &>/dev/null && HAS_NSLOOKUP=true
command -v curl &>/dev/null && HAS_CURL=true

if [ "$HAS_DIG" = false ] && [ "$HAS_NSLOOKUP" = false ]; then
    echo -e "${COLOR_KO}[ERREUR] Ni 'dig' ni 'nslookup' ne sont installés.${COLOR_DEFAULT}"
    echo "  Installer avec : apt install dnsutils (ou bind-utils sur RHEL)"
    exit 1
fi

# --- 1. Résolution DNS ---
echo -e "${COLOR_INFO}[1/3] Résolution DNS${COLOR_DEFAULT}"
echo ""

declare -A RESOLVED_IPS

for domain in "${DOMAINS[@]}"; do
    echo -n "  ${domain} -> "

    if [ "$HAS_DIG" = true ]; then
        IP=$(dig @${DNS_SERVER} -p ${DNS_PORT} +short "${domain}" 2>/dev/null)
    else
        IP=$(nslookup -port=${DNS_PORT} "${domain}" ${DNS_SERVER} 2>/dev/null | awk '/^Address: / {print $2}' | tail -1)
    fi

    if [ -n "$IP" ]; then
        echo -e "${COLOR_OK}${IP}${COLOR_DEFAULT}"
        RESOLVED_IPS["$domain"]="$IP"
    else
        echo -e "${COLOR_KO}ECHEC (pas de réponse)${COLOR_DEFAULT}"
    fi
done

echo ""

# --- 2. Ping sur les IPs résolues ---
echo -e "${COLOR_INFO}[2/3] Ping sur les IPs résolues${COLOR_DEFAULT}"
echo ""

for domain in "${DOMAINS[@]}"; do
    IP="${RESOLVED_IPS[$domain]}"
    if [ -n "$IP" ]; then
        echo -n "  ping ${domain} (${IP}) ... "
        if ping -c 1 -W 2 "$IP" > /dev/null 2>&1; then
            echo -e "${COLOR_OK}OK${COLOR_DEFAULT}"
        else
            echo -e "${COLOR_KO}ECHEC${COLOR_DEFAULT}"
        fi
    else
        echo -e "  ping ${domain} ... ${COLOR_KO}SKIP (non résolu)${COLOR_DEFAULT}"
    fi
done

echo ""

# --- 3. Test curl avec --resolve (simule le DNS sans modifier le système) ---
echo -e "${COLOR_INFO}[3/3] Test HTTP avec curl --resolve${COLOR_DEFAULT}"
echo ""

if [ "$HAS_CURL" = true ]; then
    for domain in "${DOMAINS[@]}"; do
        IP="${RESOLVED_IPS[$domain]}"
        if [ -n "$IP" ]; then
            echo -n "  curl http://${domain} (via ${IP}) ... "
            HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
                --resolve "${domain}:80:${IP}" \
                --resolve "${domain}:443:${IP}" \
                --connect-timeout 3 \
                "http://${domain}" 2>/dev/null || echo "000")
            if [ "$HTTP_CODE" != "000" ]; then
                echo -e "${COLOR_OK}HTTP ${HTTP_CODE}${COLOR_DEFAULT}"
            else
                echo -e "${COLOR_KO}ECHEC (connexion refusée ou timeout)${COLOR_DEFAULT}"
            fi
        fi
    done
else
    echo -e "  ${COLOR_KO}curl non disponible, test HTTP ignoré.${COLOR_DEFAULT}"
fi

echo ""
echo -e "${COLOR_INFO}============================================${COLOR_DEFAULT}"
echo -e "${COLOR_INFO} Résumé${COLOR_DEFAULT}"
echo -e "${COLOR_INFO}============================================${COLOR_DEFAULT}"
echo ""
echo "  Pour utiliser ce DNS dans vos applications :"
echo ""
echo "  - curl :    curl --resolve myoidc.local:80:127.0.0.1 http://myoidc.local"
echo "  - wget :    non supporté (pas de --resolve)"
echo "  - Java :    -Dhttps.proxyHost=... ou configurer un DNS custom"
echo "  - Node.js : dns.setServers(['${DNS_SERVER}:${DNS_PORT}']) dans le code"
echo ""
