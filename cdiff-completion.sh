#! /bin/bash
# cdiff parameter-completion

__cdiff()
{
    local cur prev words cword
    _init_completion || return

    # echo -e "\n cur: ${cur} prev: ${prev} words: ${words} cword: ${cword}"

    if [[ ${cur}=="=*" ]] ; then
        case "$prev" in
            --color)
                echo "Getting here"
                COMPREPLY=( $( compgen -W 'auto always' ) )
                return 0
                ;;
        esac
    fi
    case "$cur" in
        --c*)
            compopt -o nospace
            COMPREPLY=( '--color=' );;
        --w*)
            compopt -o nospace
            COMPREPLY=( '--width=' );;
        -*)
            COMPREPLY=( $( compgen -W '-h -s -w -l -c --version --help --side-by-side \
                --width= --log --color=' -- $cur ) );;
        --*)
            COMPREPLY=( $( compgen -W '--version --help --side-by-side \
                --width= --log --color=' -- $cur ) );;
        # *) Add git log completion
        esac

    return 0
}

complete -F __cdiff cdiff
