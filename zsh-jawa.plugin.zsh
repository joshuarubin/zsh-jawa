# -*- mode: sh; sh-indentation: 4; indent-tabs-mode: nil; sh-basic-offset: 4; -*-

# Copyright (c) 2021 Joshua Rubin

# According to the Zsh Plugin Standard:
# https://z.digitalclouds.dev/community/zsh_plugin_standard

0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# Then ${0:h} to get plugin's directory

if [[ ${zsh_loaded_plugins[-1]} != */kalc && -z ${fpath[(r)${0:h}/functions]} ]] {
    path=( "${0:h}/bin" $path )

    fpath=( "${0:h}/functions" $fpath )
    autoload -Uz "${0:h}/functions"/*(.:t)

    setopt extended_glob
    for file in ${0:h}/startup/^(*.zwc|*.zwc.old)(-.N); do
        source "${file}"
    done
    unset file
}

# vim:ft=zsh:tw=80:sw=4:sts=4:et:foldmarker=[[[,]]]
