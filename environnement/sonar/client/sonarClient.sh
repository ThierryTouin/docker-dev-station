#!/bin/sh 
echo start Sonar Stack
#sudo docker-compose -f ./sonarClient.yml up -d --force-recreate
sudo docker-compose -f ./sonarClient.yml logs -t --follow


