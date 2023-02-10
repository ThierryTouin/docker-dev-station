#!/bin/bash
echo " Reset Liferay"
docker stop dds_liferay
docker rm dds_liferay
docker volume rm  liferay_liferay-data
docker volume rm  liferay_liferay-osgi-war
docker volume rm  liferay_liferay-osgi-configs
echo " Reset mysql"
docker stop dds_postgresql
docker rm dds_postgresql
docker volume rm  postgresql_database_data
echo " Reset Elasticsearch"
docker stop elasticsearch_elasticsearch_1
docker rm elasticsearch_elasticsearch_1
echo "OK"