#!/bin/sh 
clear
echo "#######################################################"
echo "###             in tomcat                           ###"
echo "#######################################################"
docker container exec -it dds_liferay bash -c "echo \"export PS1='\e[0;31m[\u@\h \W]\$ \e[m '\" >> ~/.bashrc && bash"
