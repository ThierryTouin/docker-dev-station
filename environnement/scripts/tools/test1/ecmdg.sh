#!/bin/bash

# Script principal pour lancer des commandes spécifiques en fonction des arguments

case "$1" in
    ui)
        echo "Lancement du docker-compose pour l'interface utilisateur (UI)..."
        cd /chemin/vers/votre/dossier/ui || exit 1
        docker-compose -f docker-compose.yml up
        ;;
    admin)
        echo "Lancement du docker-compose pour l'administration..."
        cd /chemin/vers/votre/dossier/admin || exit 1
        docker-compose -f docker-compose.yml up
        ;;
    backend)
        echo "Lancement du docker-compose pour le backend..."
        cd /chemin/vers/votre/dossier/backend || exit 1
        docker-compose -f docker-compose.yml up
        ;;
    *)
        echo "Usage: $0 {ui|admin|backend}"
        exit 1
        ;;
esac
