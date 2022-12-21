#!/bin/bash

WORKDIR=$PWD
echo WORKDIR: $WORKDIR
BASEDIR=$(dirname "$0")
echo BASEDIR: $BASEDIR
cd $BASEDIR

./ecmd.sh apm >/dev/null 2>&1 &
./ecmd.sh mysql >/dev/null 2>&1 &
./ecmd.sh elastic >/dev/null 2>&1 &
rm -f $BASEDIR/dxp/liferay/mount/files/tomcat/conf/Catalina/localhost/ROOT.xml
cp $BASEDIR/dxp/liferay/mount/files/tomcat/conf/Catalina/localhost/ROOT.xml_mysql $BASEDIR/dxp/liferay/mount/files/tomcat/conf/Catalina/localhost/ROOT.xml
./ecmd.sh liferay >/dev/null 2>&1 &
