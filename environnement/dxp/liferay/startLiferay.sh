
#!/bin/bash
echo " Starting Liferay server"
#docker compose -f ./liferay-compose.yml up dds_liferay
docker compose -f ./liferay-compose.yml up
docker compose logs --follow dds_liferay
