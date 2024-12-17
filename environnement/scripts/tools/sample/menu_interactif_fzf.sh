#!/bin/bash

echo "=== Sélectionnez une option avec fzf ==="

choice=$(printf "Démarrer le service\nArrêter le service\nVérifier le statut\nQuitter" | fzf)

case "$choice" in
    "Démarrer le service")
        echo "Vous avez choisi de démarrer le service."
        ;;
    "Arrêter le service")
        echo "Vous avez choisi d'arrêter le service."
        ;;
    "Vérifier le statut")
        echo "Voici le statut du service :"
        ;;
    "Quitter")
        echo "Au revoir !"
        ;;
    *)
        echo "Option invalide."
        ;;
esac
