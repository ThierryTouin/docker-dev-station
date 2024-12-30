function generateEcmdContent(functionTab, config) {
  const { COMMAND, COMPOSE_COMMAND } = config;

  let output = `#!/bin/bash
  
  # In order to exit if any command fails
  set -e
  
  WORKDIR=$PWD
  echo WORKDIR: $WORKDIR
  BASEDIR=$(dirname "$0")
  echo BASEDIR: $BASEDIR
  cd $BASEDIR
  
  COLOR_TITLE="\\e[0;31m"
  COLOR_DEFAULT="\\e[39m"
  COLOR_PARAM="\\e[0;32m"
  COLOR_CMD="\\e[1;37m"
  
  `;

  functionTab.forEach(({ functionName, ecmdMeta, dirname, basename }) => {
    output += `function ${functionName}() {\n`;
    output += `  cd ${dirname}\n`;

    output += `  if [ "$2" == "shell" ]; then\n`;
    output += `    ${COMMAND} container exec -it ${ecmdMeta.containerName} /bin/sh\n`;
    output += `  elif [ "$2" == "shellr" ]; then\n`;
    output += `    ${COMMAND} container exec -it --user root ${ecmdMeta.containerName} /bin/sh\n`;
    output += `  elif [ "$2" == "clean" ]; then\n`;
    output += `    ${COMPOSE_COMMAND} -f ${basename} down --volumes --rmi all\n`;
    output += `  elif [ "$2" == "up" ]; then\n`;
    output += `    ${COMPOSE_COMMAND} -f ${basename} up -d\n`;
    output += `  else\n`;
    output += `    echo "Try : ${functionName} {up | clean | shell | shellr}"\n`;
    output += `  fi\n`;
    output += `  cd $WORKDIR\n`;
    output += `}\n`;
  });

  output += `
  function manual() {
    echo " "
    echo " "
    echo " "
    echo -e \${COLOR_TITLE}
    echo -e "################################################################"
    echo -e "# Usage: ecmd.sh  <param>                                      #"
    echo -e "################################################################"
    echo -e \${COLOR_PARAM}
    echo " -------------------------------------------------------------- "
    echo " -- PARAMS (env)                                             -- "
    echo " -------------------------------------------------------------- "
    echo -e \${COLOR_DEFAULT}
  `;

  functionTab.forEach(({ functionName, ecmdMeta }) => {
    output += `
      printf "\${COLOR_CMD}%-20s : \${COLOR_DEFAULT}%-40s  : \${COLOR_DEFAULT}%-30s\\n" "> ${functionName}" "${
      ecmdMeta.description ? " Start " + ecmdMeta.description : ""
    }" "${ecmdMeta.description ? "http://localhost:" + ecmdMeta.port : ""}"
      `;
  });

  output += `
    echo " -------------------------------------------------------------- "
    echo " "
    echo " "
  }
  
  if [ $# -eq 0 ]; then
    manual
    exit 0
  fi
  `;

  output += 'case "$1" in\n';
  functionTab.forEach(({ functionName }) => {
    output += `
    "${functionName}")
      ${functionName} "$@"
    ;;
  `;
  });
  output += `
    *)
      manual
    ;;
  esac
  `;

  return output;
}

module.exports = { generateEcmdContent };
