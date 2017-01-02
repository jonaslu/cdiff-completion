#! /bin/bash
# cdiff parameter-completion

__init() {
    _completion_loader git
}

__containsElement () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

__cdiff() {
    local cur prev words cword
    _init_completion || return

    _get_comp_words_by_ref -n "=" cur prev

    if __containsElement "-l" "${COMP_WORDS[@]}" || __containsElement "--log" "${COMP_WORDS[@]}"; then
        _git_log
        return 0
    fi

    case "$cur" in
        --color=*)
            COMPREPLY=( $(compgen -W 'auto always' -- ${cur#*=} ));;
        --width=*)
            return 0;;
        -*)
            LOCAL_COMPLREPLY=( $( compgen -W '-h -s -w -l -c --version \
                --help --side-by-side \
                --width= --log --color=' -- $cur ) )
            _git_diff
            COMPREPLY=("${LOCAL_COMPLREPLY[@]}" "${COMPREPLY[@]}")
            [[ $COMPREPLY = *= ]] && compopt -o nospace;;
        *) _git_diff
        esac

    return 0
}

__init

complete -F __cdiff cdiff
