# -*- mode: sh; sh-indentation: 4; indent-tabs-mode: nil; sh-basic-offset: 4; -*-

# Copyright (c) 2021 Joshua Rubin

# According to the Zsh Plugin Standard:
# https://zdharma.github.io/zinit/wiki/zsh-plugin-standard/

0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# Then ${0:h} to get plugin's directory

autoload -Uz bashcompinit && bashcompinit

fpath[1,0]="${0:h}/functions"
for func in ${0:h}/functions/*(-.N:t); do
    autoload -Uz ${func}
done
unset func

setopt extended_glob
for file in ${0:h}/startup/^(*.zwc|*.zwc.old)(-.N); do
    source "${file}"
done
unset file

# vim:ft=zsh:tw=80:sw=4:sts=4:et:foldmarker=[[[,]]]
