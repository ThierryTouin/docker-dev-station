#!/bin/sh 
for s in `docker ps -q`; do
  echo `docker inspect -f "{{.Name}}" ${s}`:
  echo `docker inspect -f "{{ .Config.Hostname }}" ${s}`;
done

