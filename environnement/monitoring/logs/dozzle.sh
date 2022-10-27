#!/bin/sh 
echo starting dozzle...
docker-compose -f ./dozzle-compose.yml up
echo "Logs UI started at \e[92mhttp://localhost:9998 \e[0m"

