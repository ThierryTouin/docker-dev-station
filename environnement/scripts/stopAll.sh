#!/bin/sh

#IFS="|"
#array=("/dozzle${IFS}/portainer")
arr=['/dozzle','/portainer']

for i in `eval "docker ps -a -q"`
do
    name=`eval "docker inspect --format='{{.Name}}' $i"`;

    #if [[ " ${arr[*]} " == *" ${name} "* ]]; then
    #    echo "is in array"
    #else
    #    echo "is not in array"
    #fi




    #if [[ "${IFS}${array[*]}${IFS}" =~ "${IFS}${name}${IFS}" ]]; then
    #    echo "Protected container : " $name
    #else
        echo "Stopping container :" $name
        docker stop $i  
    #fi

done

#unset IFS # or set back to original IFS if previously set


