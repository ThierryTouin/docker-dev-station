#!/bin/sh 
echo start Sonar Stack
docker compose -f ./sonarServer-compose.yml up -d --force-recreate


