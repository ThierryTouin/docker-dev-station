#!/bin/bash

 

if [ $# -ne 1 ]; then

        echo -e "\nUsage : ${0} <PID>"

        echo -e "\tExample : ${0} 5564 \n"

        exit 1

fi

 

PID="${1}"

 

LOCK_FILE="/tmp/dump_thread_jstat.lock"


THREAD_DUMP_DIR="/tmp/$(hostname -s | tr 'a-z' 'A-Z')"

JAVA_DIR="/opt/jdk/jdk1.8.0_221/bin/"

if [ ! -d "${THREAD_DUMP_DIR}" ]; then

        echo "The dump directory ${THREAD_DUMP_DIR} does not exist"

        exit 1

fi

 

if [ ! -d "${JAVA_DIR}" ]; then

        echo "The JDK bin directory ${JAVA_DIR} does not exist"

        exit 1

fi

 

##TOMCAT_PID=$(ps aux | grep tomcat  | grep "catalina.base" | grep "${TOMCAT_HOME}" | awk '{print $2}')

if [ -z "${PID}" ]; then

        echo "Failed to get liferay PID"

        exit 1

fi

 

#DATE_T=-$(date '+%Y%m%d%H%M%S')
DATE_T=""
 

if [ -f "${LOCK_FILE}" ]; then

        echo "The lock file ${LOCK_FILE} is present"

        #exit 1

fi

 

touch ${LOCK_FILE}

${JAVA_DIR}/jstat -gcutil ${PID} >> ${THREAD_DUMP_DIR}/heap_jstat_dump${DATE_T}.dump

echo "${JAVA_DIR}/jstat -gcutil ${PID} | tail -n 1 >> ${THREAD_DUMP_DIR}/heap_jstat_dump${DATE_T}.dump" > myCmd.sh
chmod +x myCmd.sh

##su - liferay -c "${JAVA_DIR}/jstat -gcutil ${PID} > ${THREAD_DUMP_DIR}/heap_histo_dump-${DATE_T}.dump"
more ./myCmd.sh

./myCmd.sh

while sleep 30; do (./myCmd.sh); done
 

rm -f ${LOCK_FILE}
