#!/bin/bash
echo " Reset Glowroot container"
#docker stop lbi_elasticsearch
#docker rm lbi_elasticsearch
docker volume rm glowroot_cassandra-volume