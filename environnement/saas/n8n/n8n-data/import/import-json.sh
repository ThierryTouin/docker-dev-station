#!/bin/sh
echo "# Starting import ..."

# Durée maximale d'attente en secondes
MAX_WAIT_TIME=120
START_TIME=$(date +%s)

# Test pour vérifier l'état du serveur
while true; do
    if /usr/bin/wget --server-response --proxy off --no-verbose --tries=1 --timeout=3 127.0.0.1:5678/healthz -O /dev/null 2>&1 | grep -q 'HTTP/1.1 200 OK'; then
        echo "# Server is READY."
        break
    fi
    
    CURRENT_TIME=$(date +%s)
    ELAPSED_TIME=$((CURRENT_TIME - START_TIME))
    
    if [ $ELAPSED_TIME -ge $MAX_WAIT_TIME ]; then
        echo "# Timeout reached. Server is not ready."
        exit 1
    fi

    echo "# Waiting for server to be ready (Elapsed time : $ELAPSED_TIME) ..."
    sleep 5
done

# Exécution de l'importation une fois le test réussi
echo "########--111--########" 
whoami
echo "#######--111--#########" 

n8n import:workflow --separate --input=/home/node/import/workflows/
echo "Import DONE #"