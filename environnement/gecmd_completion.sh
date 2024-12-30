#!/bin/bash
  
    # Autocomplétion pour le script ecmdg.sh
    _gecmd_completions()
    {
        local cur prev opts
        COMPREPLY=()                    # Réinitialise les suggestions
        cur="${COMP_WORDS[COMP_CWORD]}" # Mot actuel
        prev="${COMP_WORDS[COMP_CWORD-1]}" # Mot précédent
        opts="ui admin backend"         # Les options disponibles pour autocomplétion
    
        # Filtrer les options correspondant au mot actuel
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    }
    
    # Associe la fonction d'autocomplétion au script ecmdg.sh
    complete -F _gecmd_completions gecmd
  
  