#!/bin/bash
echo " Reset Strapi"
docker stop dds_strapi_postgres
docker stop dds_strapi
docker rm dds_strapi_postgres
docker rm dds_strapi
sudo rm -Rf ./app
sudo rm -Rf ./db
docker rmi strapi-dds_strapi
echo "OK"