#!/bin/bash
echo " Starting Healthy server"
#docker compose -f ./docker-compose-sample.yml up --force-recreate dds-healthy-elasticsearch 
docker build -t check-container-healthy .
docker compose -f ./docker-compose-sample.yml up dds-healthy-elasticsearch 
docker compose logs --follow dds-healthy-elasticsearch