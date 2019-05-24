#!/bin/sh 
echo start Sonar Stack
sudo docker-compose -f ./sonar/sonarServer.yml up -d --force-recreate


