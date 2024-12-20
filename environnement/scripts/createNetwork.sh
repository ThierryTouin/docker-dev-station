#!/bin/sh
# Nom du réseau
network_name="devnet"

# Vérifier si le réseau existe déjà
if [ ! "$(docker network ls --filter name=^${network_name}$ --format="{{ .Name }}")" ]; then
  docker network create ${network_name}
else
  echo "Le réseau '${network_name}' existe déjà. Aucune action n'a été entreprise."
fi


