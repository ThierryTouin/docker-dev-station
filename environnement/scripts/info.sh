#!/bin/sh 
clear
echo "#######################################################"
echo TARGET_CONTAINER is $TARGET_CONTAINER
#sudo docker inspect docker_dev-app | grep IPAddress
#sudo docker inspect wordpress:5.2.4 | grep IPAddress

echo "#######################################################"
echo docker_dev-app_1
sudo docker inspect docker_dev-app_1 | grep IPAddress
