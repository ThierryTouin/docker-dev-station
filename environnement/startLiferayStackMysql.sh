#!/bin/bash
./ecmd.sh apm >/dev/null 2>&1 &
./ecmd.sh mysql >/dev/null 2>&1 &
./ecmd.sh elastic >/dev/null 2>&1 &
rm -f ./dxp/liferay/mount/files/tomcat/conf/Catalina/localhost/ROOT.xml
cp ./dxp/liferay/mount/files/tomcat/conf/Catalina/localhost/ROOT.xml_mysql ./dxp/liferay/mount/files/tomcat/conf/Catalina/localhost/ROOT.xml
./ecmd.sh liferay >/dev/null 2>&1 &