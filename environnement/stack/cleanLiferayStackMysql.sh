#!/bin/bash
echo " Reset Liferay"
docker stop dds-liferay
docker rm dds-liferay
docker stop dds-healthy-elasticsearch
docker rm dds-healthy-elasticsearch
docker stop dds-glowroot
docker rm dds-glowroot
docker stop dds-cassandra
docker rm dds-cassandra
docker volume rm  dds_liferay-data
docker volume rm  dds_liferay-osgi-war
docker volume rm  dds_liferay-osgi-configs
echo " Reset mysql"
docker stop dds-mysql
docker rm dds-mysql
docker volume rm dds_mysql-data
echo " Reset Elasticsearch"
docker stop dds-elasticsearch
docker rm dds-elasticsearch
echo "OK"