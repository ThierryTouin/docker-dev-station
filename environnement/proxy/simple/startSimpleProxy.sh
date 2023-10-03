
#!/bin/bash
echo " Starting Simple Proxy server"
docker rm dds_proxy
docker rmi simple_dds_proxy
docker compose -f ./simple-proxy-compose.yml up dds_proxy
docker compose logs --follow dds_proxy
