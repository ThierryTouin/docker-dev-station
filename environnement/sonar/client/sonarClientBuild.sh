#!/bin/sh 
echo start Sonar Stack
docker compose -f ./sonarClient-compose.yml up -d --force-recreate


