#!/bin/bash
set -e

COLOR_TITLE="\e[0;31m"
COLOR_DEFAULT="\e[39m"
COLOR_PARAM="\e[0;32m"
COLOR_CMD="\e[1;37m"

echo -e ${COLOR_TITLE}
echo "********************************************"
echo "*                 Versions                 *"
echo "********************************************"
echo -e ${COLOR_TITLE}
echo "--------------------------------------------"
echo -e "${COLOR_PARAM}Linux${COLOR_DEFAULT}   : \n$(lsb_release -a)"

echo -e ${COLOR_TITLE}
echo "--------------------------------------------"
echo -e "${COLOR_PARAM}node${COLOR_DEFAULT}   : $(node --version)"

echo -e ${COLOR_TITLE}
echo "--------------------------------------------"
echo -e "${COLOR_PARAM}npm${COLOR_DEFAULT}    : $(npm --version)"

echo -e ${COLOR_TITLE}
echo "--------------------------------------------"
echo -e "${COLOR_PARAM}java${COLOR_DEFAULT}   : \n$(java --version)"

echo -e ${COLOR_TITLE}
echo "--------------------------------------------"
echo -e "${COLOR_PARAM}maven${COLOR_DEFAULT}  : \n$(mvn --v)"

echo -e ${COLOR_TITLE}
echo "--------------------------------------------"
echo -e "${COLOR_PARAM}gradle${COLOR_DEFAULT} : $(gradle --version)"

echo -e ${COLOR_TITLE}
echo "--------------------------------------------"
echo -e "${COLOR_PARAM}docker${COLOR_DEFAULT} : \n$(docker version)"

echo -e ${COLOR_TITLE}
echo "--------------------------------------------"
echo -e "${COLOR_PARAM}docker-compose${COLOR_DEFAULT} : \n$(docker-compose version)"
