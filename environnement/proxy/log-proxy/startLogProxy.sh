
#!/bin/bash
echo " Starting Log Proxy server"
#docker rm dds_proxy
#docker rmi simple_dds_proxy
docker compose -f ./proxy-compose.yml up dds_proxy
docker compose logs --follow dds_proxy
