#!/bin/bash
echo " Stoping Liferay server"
docker-compose -f ./liferay-compose.yml stop dds_liferay
docker-compose logs --follow dds_liferay
