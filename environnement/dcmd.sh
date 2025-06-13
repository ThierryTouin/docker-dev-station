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
  elif [ "$2" == "logs" ]; then
    docker compose -f portainer-compose.yml logs --follow
  else
    docker compose -f portainer-compose.yml up -d
    echo "==> Started on http://localhost:9999"
  fi
  cd $WORKDIR
}
function glowroot() {
  cd apm/glowroot
  if [ "$2" == "shell" ]; then
    docker container exec -it dds-glowroot /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds-glowroot /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f glowroot-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f glowroot-compose.yml logs --follow
  else
    docker compose -f glowroot-compose.yml up -d
    echo "==> Started on http://localhost:4000"
  fi
  cd $WORKDIR
}
function mongo-db() {
  cd db/mongo
  if [ "$2" == "shell" ]; then
    docker container exec -it mongo-db /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root mongo-db /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f docker-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f docker-compose.yml logs --follow
  else
    docker compose -f docker-compose.yml up -d
    echo "==> Started on http://localhost:27017"
  fi
  cd $WORKDIR
}
function mysql() {
  cd db/mysql
  if [ "$2" == "shell" ]; then
    docker container exec -it dds-mysql /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds-mysql /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f mysql-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f mysql-compose.yml logs --follow
  else
    docker compose -f mysql-compose.yml up -d
    echo "==> Started on http://localhost:3306"
  fi
  cd $WORKDIR
}
function postgresql() {
  cd db/postgresql
  if [ "$2" == "shell" ]; then
    docker container exec -it dds-postgresql /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds-postgresql /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f postgresql-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f postgresql-compose.yml logs --follow
  else
    docker compose -f postgresql-compose.yml up -d
    echo "==> Started on http://localhost:NA"
  fi
  cd $WORKDIR
}
function liquibase() {
  cd db-management/liquibase
  if [ "$2" == "shell" ]; then
    docker container exec -it dds-liquibase /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds-liquibase /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f liquibase-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f liquibase-compose.yml logs --follow
  else
    docker compose -f liquibase-compose.yml up -d
    echo "==> Started on http://localhost:NA"
  fi
  cd $WORKDIR
}
function omnidb() {
  cd db-management/omnidb
  if [ "$2" == "shell" ]; then
    docker container exec -it omnidb /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root omnidb /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f omnidb-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f omnidb-compose.yml logs --follow
  else
    docker compose -f omnidb-compose.yml up -d
    echo "==> Started on http://localhost:8000"
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
  elif [ "$2" == "logs" ]; then
    docker compose -f docker-compose.yml logs --follow
  else
    docker compose -f docker-compose.yml up -d
    echo "==> Started on http://localhost:9980"
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
  elif [ "$2" == "logs" ]; then
    docker compose -f liferay-compose.yml logs --follow
  else
    docker compose -f liferay-compose.yml up -d
    echo "==> Started on http://localhost:18080"
  fi
  cd $WORKDIR
}
function dds-strapi() {
  cd dxp/strapi
  if [ "$2" == "shell" ]; then
    docker container exec -it dds-strapi /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds-strapi /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f docker-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f docker-compose.yml logs --follow
  else
    docker compose -f docker-compose.yml up -d
    echo "==> Started on http://localhost:1337"
  fi
  cd $WORKDIR
}
function elastic1() {
  cd elasticsearch
  if [ "$2" == "shell" ]; then
    docker container exec -it dds-elasticsearch /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds-elasticsearch /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f elasticsearch-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f elasticsearch-compose.yml logs --follow
  else
    docker compose -f elasticsearch-compose.yml up -d
    echo "==> Started on http://localhost:9200"
  fi
  cd $WORKDIR
}
function elastic2() {
  cd elasticsearch
  if [ "$2" == "shell" ]; then
    docker container exec -it dds-elasticsearch /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds-elasticsearch /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f kibana-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f kibana-compose.yml logs --follow
  else
    docker compose -f kibana-compose.yml up -d
    echo "==> Started on http://localhost:9200"
  fi
  cd $WORKDIR
}
function keycloak() {
  cd iam/keycloak
  if [ "$2" == "shell" ]; then
    docker container exec -it keycloak /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root keycloak /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f keycloak-postgres.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f keycloak-postgres.yml logs --follow
  else
    docker compose -f keycloak-postgres.yml up -d
    echo "==> Started on http://localhost:9080"
  fi
  cd $WORKDIR
}
function ldap() {
  cd iam/ldap
  if [ "$2" == "shell" ]; then
    docker container exec -it openldap /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root openldap /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f ldap-compose.yml.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f ldap-compose.yml.yml logs --follow
  else
    docker compose -f ldap-compose.yml.yml up -d
    echo "==> Started on http://localhost:389"
  fi
  cd $WORKDIR
}
function ldap-admin() {
  cd iam/ldap-admin
  if [ "$2" == "shell" ]; then
    docker container exec -it phpldapadmin /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root phpldapadmin /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f ldap-admin-compose.yml.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f ldap-admin-compose.yml.yml logs --follow
  else
    docker compose -f ldap-admin-compose.yml.yml up -d
    echo "==> Started on http://localhost:8081"
  fi
  cd $WORKDIR
}
function java() {
  cd language/java
  if [ "$2" == "shell" ]; then
    docker container exec -it dds-java /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds-java /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f java-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f java-compose.yml logs --follow
  else
    docker compose -f java-compose.yml up -d
    echo "==> Started on http://localhost:8080"
  fi
  cd $WORKDIR
}
function fake-smtp() {
  cd mail/fake-smtp
  if [ "$2" == "shell" ]; then
    docker container exec -it fake-email /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root fake-email /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f fake-smtp-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f fake-smtp-compose.yml logs --follow
  else
    docker compose -f fake-smtp-compose.yml up -d
    echo "==> Started on http://localhost:1080"
  fi
  cd $WORKDIR
}
function dds_mockmock() {
  cd mail/mockmock
  if [ "$2" == "shell" ]; then
    docker container exec -it dds_mockmock /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds_mockmock /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f mockmock-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f mockmock-compose.yml logs --follow
  else
    docker compose -f mockmock-compose.yml up -d
    echo "==> Started on http://localhost:8282"
  fi
  cd $WORKDIR
}
function glances() {
  cd monitoring/glances
  if [ "$2" == "shell" ]; then
    docker container exec -it dds-glances /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds-glances /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f glances-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f glances-compose.yml logs --follow
  else
    docker compose -f glances-compose.yml up -d
    echo "==> Started on http://localhost:61208"
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
  elif [ "$2" == "logs" ]; then
    docker compose -f dozzle-compose.yml logs --follow
  else
    docker compose -f dozzle-compose.yml up -d
    echo "==> Started on http://localhost:9998"
  fi
  cd $WORKDIR
}
function apache() {
  cd reverse-proxy/apache
  if [ "$2" == "shell" ]; then
    docker container exec -it apache /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root apache /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f apache-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f apache-compose.yml logs --follow
  else
    docker compose -f apache-compose.yml up -d
    echo "==> Started on http://localhost:80"
  fi
  cd $WORKDIR
}
function kong() {
  cd reverse-proxy/kong
  if [ "$2" == "shell" ]; then
    docker container exec -it dds-kong /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds-kong /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f kong-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f kong-compose.yml logs --follow
  else
    docker compose -f kong-compose.yml up -d
    echo "==> Started on http://localhost:8000"
  fi
  cd $WORKDIR
}
function traefik1() {
  cd reverse-proxy/traefik
  if [ "$2" == "shell" ]; then
    docker container exec -it dds-traefik /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds-traefik /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f docker-compose-traefik-test-https.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f docker-compose-traefik-test-https.yml logs --follow
  else
    docker compose -f docker-compose-traefik-test-https.yml up -d
    echo "==> Started on http://localhost:80"
  fi
  cd $WORKDIR
}
function traefik2() {
  cd reverse-proxy/traefik
  if [ "$2" == "shell" ]; then
    docker container exec -it dds-traefik /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds-traefik /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f docker-compose-traefik.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f docker-compose-traefik.yml logs --follow
  else
    docker compose -f docker-compose-traefik.yml up -d
    echo "==> Started on http://localhost:80"
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
  elif [ "$2" == "logs" ]; then
    docker compose -f n8n-compose.yml logs --follow
  else
    docker compose -f n8n-compose.yml up -d
    echo "==> Started on http://localhost:15678"
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
  elif [ "$2" == "logs" ]; then
    docker compose -f dufs-compose.yml logs --follow
  else
    docker compose -f dufs-compose.yml up -d
    echo "==> Started on http://localhost:9980"
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
  elif [ "$2" == "logs" ]; then
    docker compose -f sharing-compose.yml logs --follow
  else
    docker compose -f sharing-compose.yml up -d
    echo "==> Started on http://localhost:9980"
  fi
  cd $WORKDIR
}
function sonar-cli() {
  cd sonar/client
  if [ "$2" == "shell" ]; then
    docker container exec -it sonar-cli /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root sonar-cli /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f sonarClient-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f sonarClient-compose.yml logs --follow
  else
    docker compose -f sonarClient-compose.yml up -d
    echo "==> Started on http://localhost:NA"
  fi
  cd $WORKDIR
}
function sonar() {
  cd sonar/server
  if [ "$2" == "shell" ]; then
    docker container exec -it sonarqube /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root sonarqube /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f sonarServer-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f sonarServer-compose.yml logs --follow
  else
    docker compose -f sonarServer-compose.yml up -d
    echo "==> Started on http://localhost:19000"
  fi
  cd $WORKDIR
}
function S3() {
  cd storage/s3
  if [ "$2" == "shell" ]; then
    docker container exec -it dds-minio /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root dds-minio /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f minio-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f minio-compose.yml logs --follow
  else
    docker compose -f minio-compose.yml up -d
    echo "==> Started on http://localhost:80"
  fi
  cd $WORKDIR
}
function it-tools() {
  cd tools/it-tools
  if [ "$2" == "shell" ]; then
    docker container exec -it it-tools /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root it-tools /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f it-tools-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f it-tools-compose.yml logs --follow
  else
    docker compose -f it-tools-compose.yml up -d
    echo "==> Started on http://localhost:7474"
  fi
  cd $WORKDIR
}
function mermaid() {
  cd tools/mermaid/online
  if [ "$2" == "shell" ]; then
    docker container exec -it mermaid-mermaid-live-editor-1 /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root mermaid-mermaid-live-editor-1 /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f docker-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f docker-compose.yml logs --follow
  else
    docker compose -f docker-compose.yml up -d
    echo "==> Started on http://localhost:18000"
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
  elif [ "$2" == "logs" ]; then
    docker compose -f stirling-pdf-compose.yml logs --follow
  else
    docker compose -f stirling-pdf-compose.yml up -d
    echo "==> Started on http://localhost:18181"
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
  elif [ "$2" == "logs" ]; then
    docker compose -f vscode-compose.yml logs --follow
  else
    docker compose -f vscode-compose.yml up -d
    echo "==> Started on http://localhost:13219"
  fi
  cd $WORKDIR
}
function web-terminal() {
  cd tools/web-terminal
  if [ "$2" == "shell" ]; then
    docker container exec -it web-terminal /bin/sh
  elif [ "$2" == "shellr" ]; then
    docker container exec -it --user root web-terminal /bin/sh
  elif [ "$2" == "clean" ]; then
    docker compose -f wt-compose.yml down --volumes --rmi all
  elif [ "$2" == "logs" ]; then
    docker compose -f wt-compose.yml logs --follow
  else
    docker compose -f wt-compose.yml up -d
    echo "==> Started on http://localhost:13002"
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
  elif [ "$2" == "logs" ]; then
    docker compose -f ecmd-ui-compose.yml logs --follow
  else
    docker compose -f ecmd-ui-compose.yml up -d
    echo "==> Started on http://localhost:7777"
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
  
      echo -e ${COLOR_TITLE}
      echo "Group: Admin"
      echo -e ${COLOR_DEFAULT}
    
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > portainer" " Start portainer" "http://localhost:9999"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > glances" " Start glances" "http://localhost:61208"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > logs" " Start logs with dozzle" "http://localhost:9998"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > ui" " Start ui for dds" "http://localhost:7777"
      
      echo -e ${COLOR_TITLE}
      echo "Group: APM"
      echo -e ${COLOR_DEFAULT}
    
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > glowroot" " Start apm with glowroot" "http://localhost:4000"
      
      echo -e ${COLOR_TITLE}
      echo "Group: SGDB"
      echo -e ${COLOR_DEFAULT}
    
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > mongo-db" " Start base de données mongodb" "http://localhost:27017"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > mysql" " Start base de données mysql" "http://localhost:3306"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > postgresql" " Start base de données postgresql" "http://localhost:NA"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > liquibase" " Start manager of database" "http://localhost:NA"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > omnidb" " Start base de données mangamement with omnidb" "http://localhost:8000"
      
      echo -e ${COLOR_TITLE}
      echo "Group: DXP"
      echo -e ${COLOR_DEFAULT}
    
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > drupal" " Start Drupal" "http://localhost:9980"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > liferay" " Start Liferay" "http://localhost:18080"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > dds-strapi" " Start cms with strapi" "http://localhost:1337"
      
      echo -e ${COLOR_TITLE}
      echo "Group: Search"
      echo -e ${COLOR_DEFAULT}
    
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > elastic1" " Start elasticsearch" "http://localhost:9200"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > elastic2" " Start elasticsearch" "http://localhost:9200"
      
      echo -e ${COLOR_TITLE}
      echo "Group: IAM"
      echo -e ${COLOR_DEFAULT}
    
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > keycloak" " Start keycloak" "http://localhost:9080"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > ldap" " Start ldap with openladap" "http://localhost:389"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > ldap-admin" " Start ldap administration" "http://localhost:8081"
      
      echo -e ${COLOR_TITLE}
      echo "Group: Language"
      echo -e ${COLOR_DEFAULT}
    
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > java" " Start Dev Java Environment" "http://localhost:8080"
      
      echo -e ${COLOR_TITLE}
      echo "Group: Mail"
      echo -e ${COLOR_DEFAULT}
    
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > fake-smtp" " Start smtp with fake-smtp" "http://localhost:1080"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > dds_mockmock" " Start smtp with mockmock" "http://localhost:8282"
      
      echo -e ${COLOR_TITLE}
      echo "Group: Proxy"
      echo -e ${COLOR_DEFAULT}
    
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > apache" " Start apache" "http://localhost:80"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > kong" " Start kong" "http://localhost:8000"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > traefik1" " Start traefik" "http://localhost:80"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > traefik2" " Start traefik" "http://localhost:80"
      
      echo -e ${COLOR_TITLE}
      echo "Group: saas"
      echo -e ${COLOR_DEFAULT}
    
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > n8n" " Start saas n8n" "http://localhost:15678"
      
      echo -e ${COLOR_TITLE}
      echo "Group: undefined"
      echo -e ${COLOR_DEFAULT}
    
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > dufs" " Start file sharing with dufs" "http://localhost:9980"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > file-manager" " Start file sharing with file-manager" "http://localhost:9980"
      
      echo -e ${COLOR_TITLE}
      echo "Group: Quality"
      echo -e ${COLOR_DEFAULT}
    
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > sonar-cli" " Start sonar-cli" "http://localhost:NA"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > sonar" " Start sonarqube" "http://localhost:19000"
      
      echo -e ${COLOR_TITLE}
      echo "Group: Storage"
      echo -e ${COLOR_DEFAULT}
    
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > S3" " Start S3 with minio" "http://localhost:80"
      
      echo -e ${COLOR_TITLE}
      echo "Group: Tools"
      echo -e ${COLOR_DEFAULT}
    
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > it-tools" " Start it-tools" "http://localhost:7474"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > mermaid" " Start mermaid online" "http://localhost:18000"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > pdf" " Start stirling-pdf" "http://localhost:18181"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > vscode" " Start vscode" "http://localhost:13219"
      
        printf "${COLOR_CMD}%-20s : ${COLOR_DEFAULT}%-40s  : ${COLOR_DEFAULT}%-30s\n" "     > web-terminal" " Start web-terminal" "http://localhost:13002"
      
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
  
    "glowroot")
      glowroot "$@"
    ;;
  
    "mongo-db")
      mongo-db "$@"
    ;;
  
    "mysql")
      mysql "$@"
    ;;
  
    "postgresql")
      postgresql "$@"
    ;;
  
    "liquibase")
      liquibase "$@"
    ;;
  
    "omnidb")
      omnidb "$@"
    ;;
  
    "drupal")
      drupal "$@"
    ;;
  
    "liferay")
      liferay "$@"
    ;;
  
    "dds-strapi")
      dds-strapi "$@"
    ;;
  
    "elastic1")
      elastic1 "$@"
    ;;
  
    "elastic2")
      elastic2 "$@"
    ;;
  
    "keycloak")
      keycloak "$@"
    ;;
  
    "ldap")
      ldap "$@"
    ;;
  
    "ldap-admin")
      ldap-admin "$@"
    ;;
  
    "java")
      java "$@"
    ;;
  
    "fake-smtp")
      fake-smtp "$@"
    ;;
  
    "dds_mockmock")
      dds_mockmock "$@"
    ;;
  
    "glances")
      glances "$@"
    ;;
  
    "logs")
      logs "$@"
    ;;
  
    "apache")
      apache "$@"
    ;;
  
    "kong")
      kong "$@"
    ;;
  
    "traefik1")
      traefik1 "$@"
    ;;
  
    "traefik2")
      traefik2 "$@"
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
  
    "sonar-cli")
      sonar-cli "$@"
    ;;
  
    "sonar")
      sonar "$@"
    ;;
  
    "S3")
      S3 "$@"
    ;;
  
    "it-tools")
      it-tools "$@"
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
  
    "web-terminal")
      web-terminal "$@"
    ;;
  
    "ui")
      ui "$@"
    ;;
  
    *)
      manual
    ;;
  esac
  