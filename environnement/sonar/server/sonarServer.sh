#!/bin/sh 
echo start Sonar Stack
docker-compose -f ./sonarServer.yml up -d --force-recreate


