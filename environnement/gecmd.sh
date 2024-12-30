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
  
  function portainer() {
  cd admin
  if [ "$2" == "shell" ]; then
    docker container exec -it dds-portainer /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds-portainer /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f portainer-compose.yml down --volumes --rmi all
  elif [ "$2" == "up" ]; then
    docker compose -f portainer-compose.yml up -d
  else
    echo "Try : portainer {up | clean | shell | shellr}"
  fi
  cd $WORKDIR
}
function drupal() {
  cd dxp/drupal
  if [ "$2" == "shell" ]; then
    docker container exec -it dds-drupal /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds-drupal /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f docker-compose.yml down --volumes --rmi all
  elif [ "$2" == "up" ]; then
    docker compose -f docker-compose.yml up -d
  else
    echo "Try : drupal {up | clean | shell | shellr}"
  fi
  cd $WORKDIR
}
function liferay() {
  cd dxp/liferay
  if [ "$2" == "shell" ]; then
    docker container exec -it dds-liferay /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds-liferay /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f liferay-compose.yml down --volumes --rmi all
  elif [ "$2" == "up" ]; then
    docker compose -f liferay-compose.yml up -d
  else
    echo "Try : liferay {up | clean | shell | shellr}"
  fi
  cd $WORKDIR
}
function mail1() {
  cd mail
  if [ "$2" == "shell" ]; then
    docker container exec -it undefined /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root undefined /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f fake-smtp-compose.yml down --volumes --rmi all
  elif [ "$2" == "up" ]; then
    docker compose -f fake-smtp-compose.yml up -d
  else
    echo "Try : mail1 {up | clean | shell | shellr}"
  fi
  cd $WORKDIR
}
function mail2() {
  cd mail
  if [ "$2" == "shell" ]; then
    docker container exec -it undefined /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root undefined /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f mockmock-compose.yml down --volumes --rmi all
  elif [ "$2" == "up" ]; then
    docker compose -f mockmock-compose.yml up -d
  else
    echo "Try : mail2 {up | clean | shell | shellr}"
  fi
  cd $WORKDIR
}
function logs() {
  cd monitoring/logs
  if [ "$2" == "shell" ]; then
    docker container exec -it dds-dozzle /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds-dozzle /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f dozzle-compose.yml down --volumes --rmi all
  elif [ "$2" == "up" ]; then
    docker compose -f dozzle-compose.yml up -d
  else
    echo "Try : logs {up | clean | shell | shellr}"
  fi
  cd $WORKDIR
}
function n8n() {
  cd saas/n8n
  if [ "$2" == "shell" ]; then
    docker container exec -it undefined /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root undefined /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f n8n-compose.yml down --volumes --rmi all
  elif [ "$2" == "up" ]; then
    docker compose -f n8n-compose.yml up -d
  else
    echo "Try : n8n {up | clean | shell | shellr}"
  fi
  cd $WORKDIR
}
function dufs() {
  cd sharing/dufs
  if [ "$2" == "shell" ]; then
    docker container exec -it dds_dufs /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds_dufs /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f dufs-compose.yml down --volumes --rmi all
  elif [ "$2" == "up" ]; then
    docker compose -f dufs-compose.yml up -d
  else
    echo "Try : dufs {up | clean | shell | shellr}"
  fi
  cd $WORKDIR
}
function file-manager() {
  cd sharing/file-manager
  if [ "$2" == "shell" ]; then
    docker container exec -it dds_fm /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds_fm /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f sharing-compose.yml down --volumes --rmi all
  elif [ "$2" == "up" ]; then
    docker compose -f sharing-compose.yml up -d
  else
    echo "Try : file-manager {up | clean | shell | shellr}"
  fi
  cd $WORKDIR
}
function mermaid() {
  cd tools/mermaid
  if [ "$2" == "shell" ]; then
    docker container exec -it mermaid-mermaid-live-editor-1 /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root mermaid-mermaid-live-editor-1 /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f docker-compose.yml down --volumes --rmi all
  elif [ "$2" == "up" ]; then
    docker compose -f docker-compose.yml up -d
  else
    echo "Try : mermaid {up | clean | shell | shellr}"
  fi
  cd $WORKDIR
}
function pdf() {
  cd tools/stirling-pdf
  if [ "$2" == "shell" ]; then
    docker container exec -it stirling_pdf /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root stirling_pdf /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f stirling-pdf-compose.yml down --volumes --rmi all
  elif [ "$2" == "up" ]; then
    docker compose -f stirling-pdf-compose.yml up -d
  else
    echo "Try : pdf {up | clean | shell | shellr}"
  fi
  cd $WORKDIR
}
function vscode() {
  cd tools/vscode
  if [ "$2" == "shell" ]; then
    docker container exec -it dds_vscode /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds_vscode /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f vscode-compose.yml down --volumes --rmi all
  elif [ "$2" == "up" ]; then
    docker compose -f vscode-compose.yml up -d
  else
    echo "Try : vscode {up | clean | shell | shellr}"
  fi
  cd $WORKDIR
}
function ui() {
  cd ui
  if [ "$2" == "shell" ]; then
    docker container exec -it dds-ecmd-ui /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds-ecmd-ui /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f ecmd-ui-compose.yml down --volumes --rmi all
  elif [ "$2" == "up" ]; then
    docker compose -f ecmd-ui-compose.yml up -d
  else
    echo "Try : ui {up | clean | shell | shellr}"
  fi
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
  
      printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "> portainer" " Start portainer" "http://localhost:9999"
      
      printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "> drupal" " Start Drupal" "http://localhost:9980"
      
      printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "> liferay" " Start Liferay" "http://localhost:18080"
      
      printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "> mail1" "" ""
      
      printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "> mail2" "" ""
      
      printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "> logs" " Start logs with dozzle" "http://localhost:9998"
      
      printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "> n8n" " Start saas n8n" "http://localhost:15678"
      
      printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "> dufs" " Start file sharing with dufs" "http://localhost:9980"
      
      printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "> file-manager" " Start file sharing with file-manager" "http://localhost:9980"
      
      printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "> mermaid" " Start mermaid online" "http://localhost:18000"
      
      printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "> pdf" " Start stirling-pdf" "http://localhost:18181"
      
      printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "> vscode" " Start vscode" "http://localhost:13219"
      
      printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "> ui" " Start ui for dds" "http://localhost:7777"
      
    echo " -------------------------------------------------------------- "
    echo " "
    echo " "
  }
  
  if [ $# -eq 0 ]; then
    manual
    exit 0
  fi
  case "$1" in

    "portainer")
      portainer "$@"
    ;;
  
    "drupal")
      drupal "$@"
    ;;
  
    "liferay")
      liferay "$@"
    ;;
  
    "mail1")
      mail1 "$@"
    ;;
  
    "mail2")
      mail2 "$@"
    ;;
  
    "logs")
      logs "$@"
    ;;
  
    "n8n")
      n8n "$@"
    ;;
  
    "dufs")
      dufs "$@"
    ;;
  
    "file-manager")
      file-manager "$@"
    ;;
  
    "mermaid")
      mermaid "$@"
    ;;
  
    "pdf")
      pdf "$@"
    ;;
  
    "vscode")
      vscode "$@"
    ;;
  
    "ui")
      ui "$@"
    ;;
  
    *)
      manual
    ;;
  esac
  