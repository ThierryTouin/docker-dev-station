#!/bin/bash
  
    # Autocomplétion pour le script dcmd.sh
    _dcmd_completions()
    {
        local cur prev opts
        COMPREPLY=()                    # Réinitialise les suggestions
        cur="${COMP_WORDS[COMP_CWORD]}" # Mot actuel
        prev="${COMP_WORDS[COMP_CWORD-1]}" # Mot précédent
        opts=" portainer drupal liferay mail1 mail2 logs n8n dufs file-manager mermaid pdf vscode ui"         # Les options disponibles pour autocomplétion
    
        # Filtrer les options correspondant au mot actuel
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    }
    
    # Associe la fonction d'autocomplétion au script dcmd.sh
    complete -F _dcmd_completions dcmd
  
  