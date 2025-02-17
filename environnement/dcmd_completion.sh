#!/bin/bash
  
    # Autocomplétion pour le script dcmd.sh
    _dcmd_completions()
    {
        local cur prev opts
        COMPREPLY=()                             # Réinitialise les suggestions
        cur="${COMP_WORDS[COMP_CWORD]}"         # Mot actuel
        prev="${COMP_WORDS[COMP_CWORD-1]}"      # Mot précédent
        optsNiv1=" portainer glowroot mongo-db mysql postgresql omnidb drupal liferay dds-strapi elastic1 elastic2 keycloak ldap ldap-admin fake-smtp dds_mockmock glances logs apache kong traefik1 traefik2 n8n dufs file-manager sonar-cli sonar S3 mermaid pdf vscode ui"                  # Les options disponibles pour autocomplétion
        optsNiv2="up logs clean shell shellr"                  # Les options disponibles pour chaque fonction
    
        # Filtrer les options correspondant au mot actuel
        case "$prev" in
           
          portainer)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          glowroot)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          mongo-db)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          mysql)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          postgresql)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          omnidb)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          drupal)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          liferay)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          dds-strapi)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          elastic1)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          elastic2)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          keycloak)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          ldap)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          ldap-admin)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          fake-smtp)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          dds_mockmock)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          glances)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          logs)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          apache)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          kong)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          traefik1)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          traefik2)
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
     
          sonar-cli)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          sonar)
              COMPREPLY=( $(compgen -W "${optsNiv2}" -- ${cur}) )
              ;;
     
          S3)
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
  
  