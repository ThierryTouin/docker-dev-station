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
admin_home="./admin"
sharing_files_home="./sharing"
postgresql_home="./db/postgresql"
liferay_home="./dxp/liferay"
glowroot_home="./apm/glowroot"

COLOR_TITLE="\e[0;31m"
COLOR_DEFAULT="\e[39m"
COLOR_PARAM="\e[0;32m"
COLOR_CMD="\e[1;37m"

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

function startAPM() {
cd $glowroot_home
./start-glowroot.sh
}

function startLiferay() {
cd $liferay_home
./startLiferay.sh
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
cd $admin_home    
./admin.sh
}

function dtop() {
./scripts/dtop.sh
}

function dips() {
./scripts/dips.sh
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
echo -e "  ${COLOR_CMD}startjc${COLOR_DEFAULT}              : Start Java Environment"
echo -e "  ${COLOR_CMD}stopjc${COLOR_DEFAULT}               : Stop Java Environment"
echo -e "  ${COLOR_CMD}injc${COLOR_DEFAULT}                 : Enter in Java Container"
#echo "  setEnvIonic         : Set environnement variable for Ionic"
echo -e "  ${COLOR_CMD}liferay${COLOR_DEFAULT}              : Start Liferay server"
echo -e "  ${COLOR_CMD}startwp${COLOR_DEFAULT}              : Start WordPress Environment"
echo -e ${COLOR_PARAM}
echo " -------------------------------------------------------------- "
echo " -- PARAMS (dependencies)                                    -- "
echo " -------------------------------------------------------------- "
echo -e ${COLOR_DEFAULT}
echo -e "  ${COLOR_CMD}elastic${COLOR_DEFAULT}              : Start Elasticsearch server"
echo -e "  ${COLOR_CMD}kibana${COLOR_DEFAULT}               : Start Kibana server"
echo -e "  ${COLOR_CMD}postgresql${COLOR_DEFAULT}           : Start Postgresql server"
echo -e "  ${COLOR_CMD}apm${COLOR_DEFAULT}                  : Start Glowroot APM Server"
echo -e ${COLOR_PARAM}
echo " -------------------------------------------------------------- "
echo " -- PARAMS (admin)                                           -- "
echo " -------------------------------------------------------------- "
echo -e ${COLOR_DEFAULT}
echo -e "  ${COLOR_CMD}admin${COLOR_DEFAULT}                : Start Docker Admin UI (portainer)"
echo -e "  ${COLOR_CMD}dbadmin${COLOR_DEFAULT}              : Start Database Admin UI (omnidb)"
echo -e "  ${COLOR_CMD}sonar${COLOR_DEFAULT}                : Start Sonar Server"

echo -e ${COLOR_PARAM}
echo " -------------------------------------------------------------- "
echo " -- PARAMS (tool)                                            -- "
echo " -------------------------------------------------------------- "
echo -e ${COLOR_DEFAULT}
echo -e "  ${COLOR_CMD}share${COLOR_DEFAULT}                : start sharing files tool"
echo -e ${COLOR_PARAM}
echo " -------------------------------------------------------------- "
echo " -- PARAMS (script)                                          -- "
echo " -------------------------------------------------------------- "
echo -e ${COLOR_DEFAULT}
echo -e "  ${COLOR_CMD}dtop${COLOR_DEFAULT}                 : Command top pour docker"
echo -e "  ${COLOR_CMD}dips${COLOR_DEFAULT}                 : Display IP container"
echo -e "  ${COLOR_CMD}status${COLOR_DEFAULT}               : Display container / image status"
echo -e "  ${COLOR_CMD}stopall${COLOR_DEFAULT}              : Stop all container"
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
"apm")
startAPM
;;
"liferay")
startLiferay
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
"dips")
dips
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