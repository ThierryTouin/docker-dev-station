#!/bin/sh 
for i in `eval "sudo docker ps -a -q"`
do
    echo "Containers $i"
done




