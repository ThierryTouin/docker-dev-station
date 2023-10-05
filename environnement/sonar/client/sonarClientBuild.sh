#!/bin/sh 
echo start Sonar Stack
docker compose -f ./sonarClient.yml up -d --force-recreate


