#!/bin/sh 
for s in `docker ps -q`; do
  echo `docker inspect -f "{{.Name}}" ${s}`:
  docker inspect ${s} | jq -r 'map(.NetworkSettings.Networks) []' | grep "IPAddress";
done

