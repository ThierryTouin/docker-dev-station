#!/bin/sh
docker stop healthy-dds-healthy-elasticsearch-1
docker rm healthy-dds-healthy-elasticsearch-1
docker rmi check-container-healthy