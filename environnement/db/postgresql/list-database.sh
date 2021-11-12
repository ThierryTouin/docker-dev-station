#!/bin/sh 
clear
echo "#######################################################"
echo "###             in docker                           ###"
echo "#######################################################"
TARGET_CONTAINER=dds_postgresql
echo TARGET_CONTAINER is $TARGET_CONTAINER
docker exec -it $TARGET_CONTAINER psql -U dbuser -c "\l"


