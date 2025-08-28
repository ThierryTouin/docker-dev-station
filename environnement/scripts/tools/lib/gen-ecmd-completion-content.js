function generateEcmdCompletionContent(functionTab) {

  let opts1List = '';
  functionTab.forEach(({ functionName, ecmdMeta }) => {
    opts1List += ` ${functionName}`;
  });
  let opts2List = 'up down logs clean shell shellr';
  let opts2CmdList = '';
  functionTab.forEach(({ functionName, ecmdMeta }) => {
    opts2CmdList += ` 
          ${functionName})
              COMPREPLY=( $(compgen -W "\${optsNiv2}" -- \${cur}) )
              ;;
    `;
  });
  

    let output = `#!/bin/bash
  
    # Autocomplétion pour le script dcmd.sh
    _dcmd_completions()
    {
        local cur prev opts
        COMPREPLY=()                             # Réinitialise les suggestions
        cur="\${COMP_WORDS[COMP_CWORD]}"         # Mot actuel
        prev="\${COMP_WORDS[COMP_CWORD-1]}"      # Mot précédent
        optsNiv1="${opts1List}"                  # Les options disponibles pour autocomplétion
        optsNiv2="${opts2List}"                  # Les options disponibles pour chaque fonction
    
        # Filtrer les options correspondant au mot actuel
        case "$prev" in
          ${opts2CmdList}
          *)
              COMPREPLY=( $(compgen -W "\${optsNiv1}" -- \${cur}) )
              ;;
        esac
    
        
        return 0
    }
    
    # Associe la fonction d'autocomplétion au script dcmd.sh
    complete -F _dcmd_completions dcmd
  
  `;
  return output;
}

module.exports = { generateEcmdCompletionContent };