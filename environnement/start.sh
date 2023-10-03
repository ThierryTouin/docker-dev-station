#!/bin/sh 
echo start env with $1
docker compose -f $1 up -d --force-recreate

