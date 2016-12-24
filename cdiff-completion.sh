#! /bin/bash
# cdiff parameter-completion

__cdiff()
{
    local cur prev words cword
    _init_completion || return

    # COMPREPLY=()   # Array variable storing the possible completions.
    # cur=${COMP_WORDS[COMP_CWORD]}
    # prev=${COMP_WORDS[COMP_CWORD-1]}

    case "$prev" in
        --color=)
            compgen -o nospace
            COMPREPLY=( $( compgen -W 'auto always' -- $cur ) )
            return 0
            ;;
    esac
    case "$cur" in
        -*)
            COMPREPLY=( $( compgen -W '-h -s -w -l -c --version --help --side-by-side \
                --width= --log --color=' -- $cur ) );;
        --) COMPREPLY=( $( compgen -W '--version --help --side-by-side \
                --width= --log --color=' -- $cur ) );;
        # yy)
        # zz)
        esac

    return 0
}

complete -F __cdiff cdiff
