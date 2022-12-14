#!/bin/bash
echo " Reset mysql"
docker stop dds_mysql
docker rm dds_mysql
docker volume rm dds_mysql_dds-mysql-data
