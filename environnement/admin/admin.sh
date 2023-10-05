#!/bin/sh 
echo starting portainer...
docker compose -f ./portainer-compose.yml up -d
echo "Admin UI started at \e[92mhttp://localhost:9999 \e[0m"
#docker logs portainer

