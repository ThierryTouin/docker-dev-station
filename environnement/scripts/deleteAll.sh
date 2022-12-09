#!/bin/sh 
for i in `eval "docker ps -a -q"`
do
    echo "Containers $i"
    docker stop $i  
done

docker rmi $(docker images -q)

