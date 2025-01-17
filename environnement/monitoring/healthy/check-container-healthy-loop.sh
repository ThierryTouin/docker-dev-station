#!/bin/sh

echo param1=$1

if [ -z "$1" ]; then
    echo "No container name provided"
    exit 1
fi

CONTAINER_NAME=$1

# Attendre que le $CONTAINER_NAME soit sain
echo "Waiting for $CONTAINER_NAME to become healthy..."
until [ "$(docker inspect --format "{{json .State.Health.Status }}" $CONTAINER_NAME)" = "\"healthy\"" ]; do
    sleep 5
    echo -n "."
done
echo "$CONTAINER_NAME is healthy."

exit 0