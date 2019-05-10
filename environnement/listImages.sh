#!/bin/sh 
for i in `eval "sudo docker images"`
do
    echo "Images $i"
done



