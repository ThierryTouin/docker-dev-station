#!/bin/sh

sudo apt-get update
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
sudo apt-get update

sudo DEBIAN_FRONTEND=noninteractive sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose docker-compose-plugin

echo "    Type number \"1\" and press Enter to select \"iptables-legacy\""
sudo update-alternatives --config iptables
sudo service docker start

sudo service docker status


### Executing the Docker Command Without Sudo
sudo usermod -aG docker ${USER}
sudo chown ${USER} /var/run/docker.sock
sudo service docker restart


docker run hello-world