#!/bin/bash

# In order to exit if any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT

elasticsearch_home="./elasticsearch"


function setEnv() {

echo "# - set environnement ..."
echo " "
source setEnv.sh "$@"
echo " "
echo "#"
echo "# Done."

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
echo "###################"
echo "# Usage: _env.sh  #"
echo "###################"
echo " "
echo " -- FUNCTIONS -- "
#echo "  setEnvJava           : Set environnement variable for Java"
#echo "  setEnvIonic          : Set environnement variable for Ionic"
echo "  startEnvJava         : Start Java Environment"
echo "  stopEnvJava          : Stop Java Environment"
echo "  startElasticsearch   : Start Elasticsearch server"
echo "  startAdmin           : Start Docker Admin UI (portainer)"
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
"setEnvJava")
setEnv java
;;
"setEnvIonic")
setEnv ionic
;;
"startEnvJava")
startEnvJava
;;
"stopEnvJava")
stopEnvJava
;;
"startElasticsearch")
startElasticsearch
;;
"startAdmin")
startAdmin
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