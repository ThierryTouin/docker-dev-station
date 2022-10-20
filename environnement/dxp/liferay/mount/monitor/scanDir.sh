#!/bin/bash
# start with 
# nohup ./scanDir.sh >> /opt/liferay/osgi/state/logScanDir.log &
#
echo "#######################################################"
echo " Scan directories : "

function scanDir() {
    nbFicDir=`find $1 -type f | wc -l`
    sizeDir=`du -sh $1`
    logDate=`date`
    echo -e "$logDate\t$nbFicDir\t$sizeDir"
}

until false
do
    echo -e "-------------------------"
    scanDir /opt/liferay/tomcat/temp
    scanDir /opt/liferay/data
    scanDir /opt/liferay/logs
    scanDir /opt/liferay/tomcat/logs
    scanDir /opt/liferay/work
    scanDir /opt/liferay/tomcat/work
    scanDir /opt/liferay/osgi/modules
    scanDir /opt/liferay/osgi/war
    scanDir /opt/liferay/osgi/configs
    scanDir /tmp
    scanDir /opt/liferay/deploy
    sleep 300
done
echo "DONE."

