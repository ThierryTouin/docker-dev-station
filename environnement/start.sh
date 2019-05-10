#!/bin/sh 
echo start env with $1
sudo docker-compose -f $1 up -d --force-recreate

