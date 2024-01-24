#!/bin/bash
echo " Reset Liferay"
docker stop dds_liferay
docker rm dds_liferay
docker volume rm  liferay_liferay-data
docker volume rm  liferay_liferay-osgi-war
docker volume rm  liferay_liferay-osgi-configs
echo " Reset mysql"
docker stop dds_mysql
docker rm dds_mysql
docker volume rm  mysql_dds-mysql-data
echo " Reset Elasticsearch"
docker stop elasticsearch-elasticsearch-1
docker rm elasticsearch-elasticsearch-1
echo "OK"