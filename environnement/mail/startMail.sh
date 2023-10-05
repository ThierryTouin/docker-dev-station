
#!/bin/bash
echo " Starting Mail server"
docker compose -f ./mockmock-compose.yml up dds_mockmock
docker compose logs --follow dds_mockmock
