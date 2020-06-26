#!/bin/sh 
echo "#######################################################"
echo "###             set env  $1                         ###"
echo "#######################################################"
if [ -z "$1" ]; then
    echo -e "\nPlease call '$0 <argument>' to run this command!\n"
    /#xit 1
fi

if [ $1 = "java" ]
then
    export TARGET_CONTAINER="docker_dev-app_1"
fi

if [ $1 = "ionic" ]
then
    export TARGET_CONTAINER="docker_dev-ionic_1"
fi

if [ $TARGET_CONTAINER = "" ]
then
    echo -e "\nPlease call '$0 with good <argument>' to run this command!\n"
    #exit 1
fi


echo $TARGET_CONTAINER
