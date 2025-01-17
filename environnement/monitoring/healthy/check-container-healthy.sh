#!/bin/sh

echo param1=$1

if [ -z "$1" ]; then
    echo "No container name provided"
    exit 1
fi

CONTAINER_NAME=$1

if docker inspect --format '{{.State.Health.Status}}' "$CONTAINER_NAME" | grep -q 'unhealthy'; then
    echo "Container $CONTAINER_NAME is unhealthy"
    exit 1
else
    echo "Container $CONTAINER_NAME is healthy"
    exit 0
fi