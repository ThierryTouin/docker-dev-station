#!/bin/sh 
echo starting glances...
docker compose -f ./glances-compose.yml up -d
echo "Logs UI started at \e[92mhttp://localhost:61208 \e[0m"

