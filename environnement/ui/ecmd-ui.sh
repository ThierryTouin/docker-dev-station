#!/bin/sh 
echo starting ecmd UI...
docker-compose -f ./ecmd-ui-compose.yml up
echo "Ecmd UI started at \e[92mhttp://localhost:7777 \e[0m"
docker logs ui

