#!/bin/sh 
echo starting dozzle...
docker-compose -f ./dozzle-compose.yml up -d
echo "Logs UI started at \e[92mhttp://localhost:9998 \e[0m"

