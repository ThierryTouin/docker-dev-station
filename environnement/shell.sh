#!/bin/sh 
clear
echo "#######################################################"
echo "###             in docker                           ###"
echo "#######################################################"
sudo docker container exec -it docker_dev-app_1 bash -c "echo \"export PS1='\e[0;31m[\u@\h \W]\$ \e[m '\" >> ~/.bashrc && bash"


