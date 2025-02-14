#!/bin/bash
WORKDIR=$PWD
echo WORKDIR: $WORKDIR
cd ./scripts/tools
./cmd.sh $@
cd $WORKDIR