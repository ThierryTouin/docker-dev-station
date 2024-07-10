#!/bin/sh

# Attendre que le $1 soit sain
echo "Waiting for $1 to become healthy..."
until [ "$(docker inspect --format "{{json .State.Health.Status }}" $1)" = "\"healthy\"" ]; do
    sleep 5
    echo -n "."
done
echo "$1 is healthy."