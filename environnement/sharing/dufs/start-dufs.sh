#!/bin/sh 
docker compose -f ./dufs-compose.yml up &

echo "Sharing Files UI started at \e[92mhttp://localhost:9980 \e[0m"

