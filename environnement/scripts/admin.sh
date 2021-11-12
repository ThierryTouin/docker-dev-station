#!/bin/sh 
echo starting portainer...
docker volume create portainer_data
docker run --rm -d -p 9999:9000 -v /var/run/docker.sock:/var/run/docker.sock -v /opt/portainer:/data portainer/portainer-ce
echo "Admin UI started at \e[92mhttp://localhost:9999 \e[0m"

