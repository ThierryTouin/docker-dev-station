#!/bin/bash
echo "#######################################################"
echo " Scan directories : "

function scanDir() {
    nbFicDir=`find $1 -type f | wc -l`
    sizeDir=`du -sh $1`
    logDate=`date`
    echo -e "$1: \t$logDate\t$nbFicDir\t$sizeDir"
}

until false
do
    scanDir /opt/liferay/tomcat/temp
    scanDir /opt/liferay/data
    #scanDir /opt/liferay/osgi/state
    sleep 30
done
echo "DONE."


