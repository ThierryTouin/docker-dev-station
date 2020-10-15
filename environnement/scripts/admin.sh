#!/bin/sh 
echo starting portainer...
sudo docker run -d -p 9999:9000 -v /var/run/docker.sock:/var/run/docker.sock -v /opt/portainer:/data portainer/portainer-ce

echo "Admin UI started at \e[92mhttp://localhost:9999 \e[0m"
