#!/bin/sh 
docker compose -f ./omnidb-compose.yml up

echo "OmniDB started at \e[92mhttp://localhost:8000 \e[0m"