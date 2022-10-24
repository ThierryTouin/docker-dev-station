#!/bin/sh 
echo "Minio starting at \e[92mhttp://localhost:19000 \e[0m"
echo "Minio console at \e[92mhttp://localhost:19001 \e[0m"
docker-compose -f ./minio-compose.yml up
