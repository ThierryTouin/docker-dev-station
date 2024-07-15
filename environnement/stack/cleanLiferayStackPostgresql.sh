#!/bin/bash
echo " Reset Liferay"
docker stop dds-liferay
docker rm dds-liferay
docker stop dds-healthy-elasticsearch
docker rm dds-healthy-elasticsearch
docker volume rm  dds_liferay-data
docker volume rm  dds_liferay-osgi-war
docker volume rm  dds_liferay-osgi-configs
echo " Reset postgresql"
docker stop dds-postgresql
docker rm dds-postgresql
docker volume rm  dds_postgresql_data
echo " Reset Elasticsearch"
docker stop dds-elasticsearch
docker rm dds-elasticsearch
echo "OK"