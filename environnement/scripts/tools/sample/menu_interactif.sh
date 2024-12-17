#!/bin/bash

echo "=== Menu interactif ==="

PS3="Choisissez une option : "  # Texte affiché pour l'invite

options=("Démarrer le service" "Arrêter le service" "Vérifier le statut" "Quitter")

select opt in "${options[@]}"; do
    case $opt in
        "Démarrer le service")
            echo "Vous avez choisi de démarrer le service."
            # Placez ici la commande pour démarrer le service
            ;;
        "Arrêter le service")
            echo "Vous avez choisi d'arrêter le service."
            # Placez ici la commande pour arrêter le service
            ;;
        "Vérifier le statut")
            echo "Voici le statut du service :"
            # Placez ici la commande pour afficher le statut
            ;;
        "Quitter")
            echo "Au revoir !"
            break
            ;;
        *)
            echo "Option invalide, veuillez choisir un numéro valide."
            ;;
    esac
done
