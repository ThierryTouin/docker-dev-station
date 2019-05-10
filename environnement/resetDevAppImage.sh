#!/bin/sh 
for i in `eval "sudo docker ps -a -q"`
do
    echo "Containers $i"
    sudo docker stop $i
    sudo docker rm $i
done

for i in `eval "sudo docker images"`
do
    echo "Images $i"
done

sudo docker rmi docker_dev-app

