#!/bin/bash
echo " Starting Healthy server"
docker run -it --entrypoint /bin/sh check-container-healthy
