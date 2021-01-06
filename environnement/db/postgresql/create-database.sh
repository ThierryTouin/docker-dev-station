#!/bin/sh 
clear
echo "#######################################################"
echo "###             in docker                           ###"
echo "#######################################################"
TARGET_CONTAINER=postgresql_postgresql_1
echo TARGET_CONTAINER is $TARGET_CONTAINER
docker exec -it $TARGET_CONTAINER psql -U postgres -c "CREATE DATABASE $1 WITH ENCODING 'UTF8';"


