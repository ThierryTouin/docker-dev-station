#!/bin/sh 
echo start Sonar Stack
sudo docker-compose -f ./sonar/sonarClient.yml up -d --force-recreate


