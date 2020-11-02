#!/bin/sh 
for i in `eval "docker images"`
do
    echo "Images $i"
done



