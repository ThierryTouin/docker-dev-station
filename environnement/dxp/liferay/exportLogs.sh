#!/bin/sh 
clear
echo "#######################################################"
echo "###             export logs in tmp                  ###"
echo "#######################################################"
docker cp dds_liferay:/opt/liferay/logs ./tmp
