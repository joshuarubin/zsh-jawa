if [ -d "/nix" -a -d "${HOME}/.nix-defexpr" -a -L "${HOME}/.nix-profile" ]; then
  typeset -xU nix_path
  typeset -xT NIX_PATH nix_path :
  nix_path=(
    nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs
    $HOME/.nix-defexpr/channels
    /nix/var/nix/profiles/per-user/root/channels
    $nix_path
  )

  if [ -f "${HOME}/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
    . "${HOME}/.nix-profile/etc/profile.d/hm-session-vars.sh"
  fi

  export PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"
fi
