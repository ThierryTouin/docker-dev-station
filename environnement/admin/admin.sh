#!/bin/sh 
echo starting portainer...
docker-compose -f ./portainer-compose.yml up -d
echo "Admin UI started at \e[92mhttp://localhost:9999 \e[0m"
docker logs portainer


#docker volume create portainer_data
#docker run --rm -d --name portainer -p 9999:9000 -v /var/run/docker.sock:/var/run/docker.sock -v /opt/portainer:/data portainer/portainer-ce --admin-password '$$2y$$05$$ZBq/6oanDzs3iwkhQCxF2uKoJsGXA0SI4jdu1PkFrnsKfpCH5Ae4G'
