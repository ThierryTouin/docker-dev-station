#!/bin/bash

# Lancement du code-server une première fois pour qu'il initialise ses fichiers si nécessaire
code-server --auth=none --disable-telemetry &

# Attente que le fichier de settings par défaut existe
while [ ! -d "/home/coder/.local/share/code-server/User" ]; do
    echo "En attente de l'initialisation du dossier User..."
    sleep 1
done

# Copie personnalisée du fichier settings.json
echo "Copie personnalisée du fichier settings.json"
cp -f /home/coder/custom-local/share/code-server/User/settings.json /home/coder/.local/share/code-server/User/settings.json

