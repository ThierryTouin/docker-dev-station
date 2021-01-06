#!/bin/sh 
clear
echo "#######################################################"
echo "###             in docker                           ###"
echo "#######################################################"
TARGET_CONTAINER=postgresql_postgresql_1
echo TARGET_CONTAINER is $TARGET_CONTAINER
docker container exec -it $TARGET_CONTAINER bash -c "echo \"export PS1='\e[0;31m[\u@\h \W]\$ \e[m '\" >> ~/.bashrc && bash"


