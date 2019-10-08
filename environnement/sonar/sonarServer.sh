#!/bin/sh 
echo start Sonar Stack
sudo docker-compose -f ./sonarServer.yml up -d --force-recreate


