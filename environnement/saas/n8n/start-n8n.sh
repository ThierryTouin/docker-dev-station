#!/bin/sh 
echo "***** n8n starting at \e[92mhttp://localhost:15678 \e[0m"
docker compose -f ./n8n-compose.yml up
echo "***** n8n started at \e[92mhttp://localhost:15678 \e[0m"
