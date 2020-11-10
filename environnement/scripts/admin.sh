#!/bin/sh 
echo starting portainer...
#docker run --rm -d -p 9999:9000 -v /var/run/docker.sock:/var/run/docker.sock -v /opt/portainer:/data portainer/portainer:1.22.1
docker run --rm -d -p 9999:9000 -v /var/run/docker.sock:/var/run/docker.sock -v /opt/portainer:/data portainer/portainer-ce:2.0.0
echo "Admin UI started at \e[92mhttp://localhost:9999 \e[0m"
