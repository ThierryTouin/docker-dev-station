#!/bin/bash

WORKDIR=$PWD
echo WORKDIR: $WORKDIR
BASEDIR=$(dirname "$0")
echo BASEDIR: $BASEDIR
cd $BASEDIR
ECMDDIR=$ECMDDIR
echo ECMDDIR: $ECMDDIR

$ECMDDIR/ecmd.sh apm >/dev/null 2>&1 &
$ECMDDIR/ecmd.sh mysql >/dev/null 2>&1 &
$ECMDDIR/ecmd.sh elastic >/dev/null 2>&1 &
rm -f $ECMDDIR/dxp/liferay/mount/files/tomcat/conf/Catalina/localhost/ROOT.xml
cp $ECMDDIR/dxp/liferay/mount/files/tomcat/conf/Catalina/localhost/ROOT.xml_mysql $ECMDDIR/dxp/liferay/mount/files/tomcat/conf/Catalina/localhost/ROOT.xml
$ECMDDIR/ecmd.sh liferay >/dev/null 2>&1 &
echo "OK"