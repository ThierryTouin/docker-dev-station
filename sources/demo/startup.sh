#!/bin/sh
echo "*** Compile Project ($1)***"

mvn clean install $1

if [ "$?" -ne "0" ]; then
  echo "Sorry, compile problem !!! Please check ! "
  exit 1
fi

echo "*** Starting Project ($1)***"
mvn $1

