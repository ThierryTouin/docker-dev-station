#!/bin/bash
echo " Reset ecmd-ui"
docker stop ecmd-ui
docker rm ecmd-ui
docker rmi ui_ecmd-ui
#docker volume rm liferay-build-image_elasticsearch-plugins
