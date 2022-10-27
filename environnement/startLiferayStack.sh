#!/bin/bash
./ecmd.sh apm >/dev/null 2>&1 &
./ecmd.sh postgresql >/dev/null 2>&1 &
./ecmd.sh elastic >/dev/null 2>&1 &
./ecmd.sh liferay >/dev/null 2>&1 &