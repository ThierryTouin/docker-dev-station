      printf "%-15s | %-15s" "\${COLOR_CMD}${functionName}\${COLOR_DEFAULT}" "${ecmdMeta.description ? ' Start ' + ecmdMeta.description : ''} ${ecmdMeta.description ? ' at http://localhost:' + ecmdMeta.port : ''}/n"

      echo -e "  \${COLOR_CMD}${functionName}\${COLOR_DEFAULT}\t\t\t: ${ecmdMeta.description ? ' Start ' + ecmdMeta.description : ''} ${ecmdMeta.description ? ' at http://localhost:' + ecmdMeta.port : ''}"

