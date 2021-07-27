#!/bin/bash

# In order to exit if any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT

elasticsearch_home="./elasticsearch"
sonar_home="./sonar/server"
dbadmin_home="./db-management"
sharing_files_home="./sharing"
postgresql_home="./db/postgresql"

COLOR_TITLE="\e[0;31m"
COLOR_DEFAULT="\e[39m"
COLOR_PARAM="\e[0;32m"


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

function startKibana() {
cd $elasticsearch_home
./startKibana.sh
}

function startPostgreSQL() {
cd $postgresql_home
./startPostgresql.sh
}

function startEnvJava() {
./startENV_Java.sh
}

function stopEnvJava() {
./scripts/stopENV_Java.sh
}

function startEnvWP() {
./startENV_WordPress.sh
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

function sonar() {
cd $sonar_home
./sonarServer.sh
}

function stopall() {
./scripts/stopAll.sh
}

function startSharingFiles() {
cd $sharing_files_home
./startSharing.sh
}



function manual() {

echo " "
echo " "
echo " "
echo -e ${COLOR_TITLE}
echo -e "################################################################"
echo -e "# Usage: ecmd.sh  <param>                                      #"
echo -e "################################################################"
echo -e ${COLOR_PARAM}
echo " -------------------------------------------------------------- "
echo " -- PARAMS (env)                                             -- "
echo " -------------------------------------------------------------- "
echo -e ${COLOR_DEFAULT}
echo "  startjc              : Start Java Environment"
echo "  stopjc               : Stop Java Environment"
echo "  injc                 : Enter in Java Container"
#echo "  setEnvIonic         : Set environnement variable for Ionic"
echo "  startwp              : Start WordPress Environment"
echo -e ${COLOR_PARAM}
echo " -------------------------------------------------------------- "
echo " -- PARAMS (dependencies)                                    -- "
echo " -------------------------------------------------------------- "
echo -e ${COLOR_DEFAULT}
echo "  elastic              : Start Elasticsearch server"
echo "  kibana               : Start Kibana server"
echo "  postgresql           : Start Postgresql server"
echo -e ${COLOR_PARAM}
echo " -------------------------------------------------------------- "
echo " -- PARAMS (admin)                                           -- "
echo " -------------------------------------------------------------- "
echo -e ${COLOR_DEFAULT}
echo "  admin                : Start Docker Admin UI (portainer)"
echo "  dbadmin              : Start Database Admin UI (omnidb)"
echo "  sonar                : Start Sonar Server"

echo -e ${COLOR_PARAM}
echo " -------------------------------------------------------------- "
echo " -- PARAMS (tool)                                            -- "
echo " -------------------------------------------------------------- "
echo -e ${COLOR_DEFAULT}
echo "  share                : start sharing files tool"
echo -e ${COLOR_PARAM}
echo " -------------------------------------------------------------- "
echo " -- PARAMS (script)                                          -- "
echo " -------------------------------------------------------------- "
echo -e ${COLOR_DEFAULT}
echo "  dtop                 : Command top pour docker"
echo "  status               : Display container / image status"
echo "  stopall              : Stop all container"
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
"startwp")
startEnvWP
;;
"elastic")
startElasticsearch
;;
"kibana")
startKibana
;;
"postgresql")
startPostgreSQL
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
"sonar")
sonar
;;
"stopall")
stopall
;;
"share")
startSharingFiles
;;
*)
    manual
    ;;
esac