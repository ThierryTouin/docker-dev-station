#!/bin/sh 
echo start Sonar Stack
#sudo docker compose -f ./sonarClient.yml up -d --force-recreate
docker compose --verbose -f ./sonarClient-compose.yml logs -t --follow


