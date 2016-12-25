#! /bin/bash
# cdiff parameter-completion

__cdiff()
{
    local cur prev words cword
    _init_completion || return

    _get_comp_words_by_ref -n "=" cur prev

    # echo -e "\n cur: ${cur} prev: ${prev} words: ${words} cword: ${cword}"

    # case "$prev" in
    #     --color=*)
    #         echo "Getting here"
    #         COMPREPLY=( $( compgen -W 'auto always' ) )
    #         return 0
    #         ;;
    # esac

    case "$cur" in
        --color=*)
            COMPREPLY=( $(compgen -W 'auto always' -- ${cur#*=} ));;
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
