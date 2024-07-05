#!/bin/sh 
echo "#######################################################"
echo " Waiting for elasticsearch !"

until $(curl --output /dev/null --silent --head --fail http://elasticsearch:9200); do
    printf '.'
    sleep 5
done
echo "DONE."
curl -XPUT -H "Content-Type: application/json" http://elasticsearch:9200/_cluster/settings -d '{ "transient": { "cluster.routing.allocation.disk.threshold_enabled": false } }'
curl -XPUT -H "Content-Type: application/json" http://elasticsearch:9200/_all/_settings -d '{"index.blocks.read_only_allow_delete": null}'
