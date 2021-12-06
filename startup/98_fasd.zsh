if (( $#commands[fasd] )); then
  alias e="fasd -ftie ${EDITOR} -b nviminfo" # quick opening files with vim

  if (( $+commands[$(__fzfcmd)] )); then
    fasd_i_e() {
      local _fasd_all=$(fasd -lftb nviminfo "$@")
      [ -z "$_fasd_all" ] && return
      if [ "$(echo "$_fasd_all" | wc -l)" -eq 1 ]; then
        ${EDITOR} "$_fasd_all"
        return
      fi
      local _fasd_ret="$(echo "$_fasd_all" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --tac --no-sort $FZF_DEFAULT_OPTS --tiebreak=index +m" $(__fzfcmd))"
      [ -f "$_fasd_ret" ] && ${EDITOR} "$_fasd_ret" || printf %s\n "$_fasd_ret"
    }

    alias e="fasd_i_e"
  fi
fi
