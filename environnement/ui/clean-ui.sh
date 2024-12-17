#!/bin/sh 
echo cleaning portainer...
docker compose -f ./ecmd-ui-compose.yml down --volumes --rmi all

