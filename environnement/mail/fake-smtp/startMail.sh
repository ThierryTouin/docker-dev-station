
#!/bin/bash
echo " Starting Mail server"
#docker compose -f ./mockmock-compose.yml up dds_mockmock
docker compose -f ./fake-smtp-compose.yml up dds_fake-email
docker compose logs --follow dds_fake-email
