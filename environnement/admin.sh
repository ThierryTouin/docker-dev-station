#!/bin/sh 
echo start portainer
sudo docker run -d -p 9999:9000 -v /var/run/docker.sock:/var/run/docker.sock -v /opt/portainer:/data portainer/portainer

