#!/bin/sh 
echo "Elasticsearch starting at \e[92mhttp://localhost:9200 \e[0m"
docker-compose -f ./elasticsearch-compose.yml up
