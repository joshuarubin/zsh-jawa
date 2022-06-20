HOMEBREW_PREFIX="/opt/homebrew";
if [ -d "$HOMEBREW_PREFIX" ]; then
  export HOMEBREW_PREFIX
  export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar";
  export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}";
  export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin${PATH+:$PATH}";
  export MANPATH="${HOMEBREW_PREFIX}/share/man${MANPATH+:$MANPATH}:";
  export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}";

  fpath=("${HOMEBREW_PREFIX}/share/zsh/site-functions" $fpath)

  export HOMEBREW_NO_ENV_HINTS=1
  export HOMEBREW_BAT=1
fi
