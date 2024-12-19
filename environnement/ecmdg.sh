#!/bin/bash

# In order to exit if any command fails
set -e

WORKDIR=$PWD
echo WORKDIR: $WORKDIR
BASEDIR=$(dirname "$0")
echo BASEDIR: $BASEDIR
cd $BASEDIR

COLOR_TITLE="\e[0;31m"
COLOR_DEFAULT="\e[39m"
COLOR_PARAM="\e[0;32m"
COLOR_CMD="\e[1;37m"

function mail1() {
  cd mail
  docker compose -f fake-smtp-compose.yml up -d
  cd $WORKDIR
}
function mail2() {
  cd mail
  docker compose -f mockmock-compose.yml up -d
  cd $WORKDIR
}
function n8n() {
  cd saas/n8n
  docker compose -f n8n-compose.yml up -d
  cd $WORKDIR
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
  
      echo -e "  ${COLOR_CMD}mail1${COLOR_DEFAULT}			:  at port 0"
    
      echo -e "  ${COLOR_CMD}mail2${COLOR_DEFAULT}			:  at port 0"
    
      echo -e "  ${COLOR_CMD}n8n${COLOR_DEFAULT}			: saas n8n at port xxxx"
    
    echo " -------------------------------------------------------------- "
    echo " "
    echo " "
  }
    
  if [ $# -eq 0 ]; then
    manual
    exit 0
  fi
  case "$1" in

    "mail1")
      mail1
    ;;
    
    "mail2")
      mail2
    ;;
    
    "n8n")
      n8n
    ;;
    
    *)
      manual
    ;;
esac
