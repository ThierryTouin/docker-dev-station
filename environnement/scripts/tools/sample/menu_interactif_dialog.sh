#!/bin/bash

cmd=(dialog --clear --menu "Choisissez une option :" 15 50 4)
options=(
    1 "Démarrer le service"
    2 "Arrêter le service"
    3 "Vérifier le statut"
    4 "Quitter"
)
choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

clear
case $choice in
    1)
        echo "Vous avez choisi de démarrer le service."
        ;;
    2)
        echo "Vous avez choisi d'arrêter le service."
        ;;
    3)
        echo "Voici le statut du service."
        ;;
    4)
        echo "Au revoir !"
        ;;
    *)
        echo "Option invalide."
        ;;
esac
