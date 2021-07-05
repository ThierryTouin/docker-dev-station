#!/bin/sh 
echo "***** Kibana starting at \e[92mhttp://localhost:5601 \e[0m"
docker-compose -f ./kibana-compose.yml up
echo "***** Kibana started at \e[92mhttp://localhost:5601 \e[0m"
