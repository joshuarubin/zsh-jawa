# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath path

# Set the list of directories that Zsh searches for programs.
path=(
  ${HOME}/.local/bin
  ${HOME}/go/bin
  ${HOME}/.cabal/bin
  ${HOME}/.cargo/bin
  ${HOME}/.luarocks/bin
  ${HOME}/.yarn/bin
  /snap/bin
  $path
)

# remove non-existent directories
path=($^path(N))
