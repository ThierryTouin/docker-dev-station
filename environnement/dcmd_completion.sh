#!/bin/bash
  
    # Autocomplétion pour le script dcmd.sh
    _dcmd_completions()
    {
        local cur prev opts
        COMPREPLY=()                             # Réinitialise les suggestions
        cur="${COMP_WORDS[COMP_CWORD]}"         # Mot actuel
        prev="${COMP_WORDS[COMP_CWORD-1]}"      # Mot précédent
        optsNiv1=" portainer mysql drupal liferay mail1 mail2 logs n8n dufs file-manager mermaid pdf vscode ui"                  # Les options disponibles pour autocomplétion
        optsNiv2="up logs clean shell shellr"                  # Les options disponibles pour chaque fonction
    
        # Filtrer les options correspondant au mot actuel
        case "$prev" in
           
          portainer)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          mysql)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          drupal)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          liferay)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          mail1)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          mail2)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          logs)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          n8n)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          dufs)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          file-manager)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          mermaid)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          pdf)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          vscode)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          ui)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
    
          *)
              COMPREPLY=( $(compgen -W "${optsNiv1}" -- ${cur}) )
              ;;
        esac
    
        
        return 0
    }
    
    # Associe la fonction d'autocomplétion au script dcmd.sh
    complete -F _dcmd_completions dcmd
  
  