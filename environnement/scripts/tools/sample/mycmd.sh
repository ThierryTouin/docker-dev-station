#!/bin/bash

_mycmd_completions()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    local prev=${COMP_WORDS[COMP_CWORD-1]}

    case "$prev" in
        start)
            COMPREPLY=( $(compgen -W "service1 service2 service3" -- "$cur") )
            ;;
        stop)
            COMPREPLY=( $(compgen -W "service1 service2" -- "$cur") )
            ;;
        *)
            COMPREPLY=( $(compgen -W "start stop status" -- "$cur") )
            ;;
    esac
}

complete -F _mycmd_completions mycmd
