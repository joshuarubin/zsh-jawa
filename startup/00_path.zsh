# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath path

# Set the list of directories that Zsh searches for programs.
path=(
  ${HOME}/bin
  ${HOME}/go/bin
  ${HOME}/.yarn/bin
  ${HOME}/.rbenv/bin
  ${HOME}/.rbenv/shims
  ${HOME}/.cargo/bin
  ${HOME}/.cabal/bin
  ${HOME}/.nodenv/bin
  ${HOME}/.nodenv/shims
  ${HOME}/.node-build/bin
  ${HOME}/.luarocks/bin
  ${HOME}/.local/bin
  /snap/bin
  /usr/local/{bin,sbin}
  $path
)
