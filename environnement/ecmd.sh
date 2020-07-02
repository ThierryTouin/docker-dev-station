#!/bin/bash

# In order to exit if any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT

elasticsearch_home="./elasticsearch"
dbadmin_home="./db-management"

function ICJ() {

echo "# - set environnement ..."
echo " "
source ./scripts/setEnv.sh java
echo " "
echo "#"
./scripts/shell.sh

}

function startDBAdmin() {
cd $dbadmin_home
./startOmnidb.sh
}

function startElasticsearch() {
cd $elasticsearch_home
./startElasticsearch.sh
}

function startEnvJava() {
./startENV_Liferay.sh
}

function stopEnvJava() {
./scripts/stopENV_Java.sh
}

function startAdmin() {
./scripts/admin.sh
}

function dtop() {
./scripts/dtop.sh
}

function status() {
./scripts/status.sh
}

function manual() {

echo " "
echo " "
echo " "
echo "###########################"
echo "# Usage: ecmd.sh  <param> #"
echo "###########################"
echo " "
echo " -- PARAMS -- "
echo "  startjc              : Start Java Environment"
echo "  stopjc               : Stop Java Environment"
echo "  injc                 : Enter in Java Container"
#echo "  setEnvIonic         : Set environnement variable for Ionic"
echo "  elastic              : Start Elasticsearch server"
echo "  admin                : Start Docker Admin UI (portainer)"
echo "  dbadmin              : Start Database Admin UI (omnidb)"
echo "  dtop                 : Command top pour docker"
echo "  status               : Display container / image status"
echo " "
echo " "

}

if [ $# -eq 0 ]; then
    manual
    exit 0
fi

case "$1" in
"injc")
ICJ
;;
"setEnvIonic")
setEnv ionic
;;
"startjc")
startEnvJava
;;
"stopjc")
stopEnvJava
;;
"elastic")
startElasticsearch
;;
"admin")
startAdmin
;;
"dbadmin")
startDBAdmin
;;
"dtop")
dtop
;;
"status")
status
;;
*)
    manual
    ;;
esac