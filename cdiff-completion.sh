#! /bin/bash
# cdiff parameter-completion

. /usr/share/bash-completion/completions/git

containsElement () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

__cdiff()
{
    local cur prev words cword
    _init_completion || return

    _get_comp_words_by_ref -n "=" cur prev

    # echo -e "\n cur: ${cur} prev: ${prev} words: ${words[@]} cword: ${cword[@]}"
    # echo "${COMP_WORDS[@]}"

    if containsElement "-l" "${COMP_WORDS[@]}" || containsElement "--log" "${COMP_WORDS[@]}"; then
        _git_log
        return 0
    fi

    case "$cur" in
        --color=*)
            COMPREPLY=( $(compgen -W 'auto always' -- ${cur#*=} ));;
        --width=*)
            return 0;;
        -*)
            COMPREPLY=( $( compgen -W '-h -s -w -l -c --version \
                --help --side-by-side \
                --width= --log --color=' -- $cur ) )
            [[ $COMPREPLY = *= ]] && compopt -o nospace;;
        *) _git_diff
        esac

    return 0
}

complete -F __cdiff cdiff
