if (( $#commands[vim] )); then
  export EDITOR="vim"
  export VISUAL="vim"
fi

if (( $#commands[nvim] )); then
  export EDITOR="nvim"
  export VISUAL="nvim"

  local args="$(nvim_args)"

  if [ -n "${args}" ]; then
    alias nvim="nvim ${args}"
  fi
fi

