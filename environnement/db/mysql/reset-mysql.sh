#!/bin/bash
echo " Reset mysql"
docker stop dds-mysql
docker rm dds-mysql
docker volume rm  dds_mysql-data
