#!/bin/sh 
echo cleaning portainer...
docker compose -f ./portainer-compose.yml down --volumes --rmi all

