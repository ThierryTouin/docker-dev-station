
#!/bin/bash
echo " Starting Squid server (Proxy)"
docker-compose -f ./squid-compose.yml up dds_proxy
docker-compose logs --follow dds_proxy
