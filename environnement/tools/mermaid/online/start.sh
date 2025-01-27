#!/bin/bash

# Vérifie que Docker Compose est installé
if ! command -v docker-compose &> /dev/null
then
    echo "docker compose n'est pas installé. Veuillez l'installer avant de continuer."
    exit 1
fi

# Démarre le service avec Docker Compose
echo "Démarrage du service Mermaid Live Editor..."
docker compose up 
echo "Le service est maintenant accessible sur http://localhost:8000"
