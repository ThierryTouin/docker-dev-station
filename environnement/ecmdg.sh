#!/bin/bash

# In order to exit if any command fails
set -e

WORKDIR=$PWD
echo WORKDIR: $WORKDIR
BASEDIR=$(dirname "$0")
echo BASEDIR: $BASEDIR
cd $BASEDIR
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
    echo " -------------------------------------------------------------- "
  
      echo -e "  mail1                 : mail1"
    
      echo -e "  mail2                 : mail2"
    
      echo -e "  n8n                 : n8n"
    
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
