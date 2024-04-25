#!/bin/sh 
echo "***** vscode starting at \e[92mhttp://localhost:13219 \e[0m"
docker compose -f ./vscode-compose.yml up
echo "***** vscode started at \e[92mhttp://localhost:13219 \e[0m"
