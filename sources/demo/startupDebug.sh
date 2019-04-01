#!/bin/sh
echo "*** Starting Project in Debug Mode ***"
mvn clean install -DskipTests=true
mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005"

