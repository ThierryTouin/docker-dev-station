#!/bin/bash

 

if [ $# -ne 1 ]; then

        echo -e "\nUsage : ${0} <PID>"

        echo -e "\tExample : ${0} 5564 \n"

        exit 1

fi

 

PID="${1}"

 

LOCK_FILE="/tmp/dump_thread_cpu.lock"


THREAD_DUMP_DIR="/tmp/$(hostname -s | tr 'a-z' 'A-Z')"


if [ ! -d "${THREAD_DUMP_DIR}" ]; then

        echo "The dump directory ${THREAD_DUMP_DIR} does not exist"

        exit 1

fi

 
 


if [ -z "${PID}" ]; then

        echo "Failed to get PID"

        exit 1

fi

 
DATE_T=""
 

if [ -f "${LOCK_FILE}" ]; then

        echo "The lock file ${LOCK_FILE} is present"

        #exit 1

fi

 

touch ${LOCK_FILE}

top -b -n 1 -p ${PID} | grep ${PID} >> ${THREAD_DUMP_DIR}/heap_cpustat_dump${DATE_T}.dump

echo "top -b -n 1 -p ${PID} | grep ${PID} >> ${THREAD_DUMP_DIR}/heap_cpustat_dump${DATE_T}.dump" > cpuStatCmd.sh
chmod +x cpuStatCmd.sh


more ./cpuStatCmd.sh

./cpuStatCmd.sh

while sleep 30; do (./cpuStatCmd.sh); done
 

rm -f ${LOCK_FILE}
