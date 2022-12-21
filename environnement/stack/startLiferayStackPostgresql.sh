#!/bin/bash

WORKDIR=$PWD
echo WORKDIR: $WORKDIR
BASEDIR=$(dirname "$0")
echo BASEDIR: $BASEDIR
cd $BASEDIR

./ecmd.sh apm >/dev/null 2>&1 &
./ecmd.sh postgresql >/dev/null 2>&1 &
./ecmd.sh elastic >/dev/null 2>&1 &
rm -f ./dxp/liferay/mount/files/tomcat/conf/Catalina/localhost/ROOT.xml
cp ./dxp/liferay/mount/files/tomcat/conf/Catalina/localhost/ROOT.xml_postgresql ./dxp/liferay/mount/files/tomcat/conf/Catalina/localhost/ROOT.xml
./ecmd.sh liferay >/dev/null 2>&1 &
