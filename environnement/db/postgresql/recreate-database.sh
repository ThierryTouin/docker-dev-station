#!/bin/sh 
clear
echo "#######################################################"
echo "###             in docker                           ###"
echo "#######################################################"
TARGET_CONTAINER=dds_postgresql
echo TARGET_CONTAINER is $TARGET_CONTAINER
docker exec -it $TARGET_CONTAINER psql -U dbuser -c "DROP DATABASE $1;"
docker exec -it $TARGET_CONTAINER psql -U dbuser -c "CREATE DATABASE $1 WITH ENCODING 'UTF8';"


