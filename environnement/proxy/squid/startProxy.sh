
#!/bin/bash
echo " Starting Proxy server"
docker-compose -f ./squid-compose.yml up dds_proxy
docker-compose logs --follow dds_proxy
