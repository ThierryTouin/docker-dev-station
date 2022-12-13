#!/bin/bash
./ecmd.sh admin >/dev/null 2>&1 &
./ecmd.sh logs >/dev/null 2>&1 &
./ecmd.sh ui >/dev/null 2>&1 &
