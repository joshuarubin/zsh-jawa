# WEZTERM_SHELL_SKIP_ALL - disables all
# WEZTERM_SHELL_SKIP_SEMANTIC_ZONES - disables zones
# WEZTERM_SHELL_SKIP_CWD - disables OSC 7 cwd setting

if [[ "${TERM_PROGRAM}" != "WezTerm" ]]; then
	return 0
fi

if [ "${WEZTERM_SHELL_SKIP_ALL}" = "1" ]; then
	return 0
fi

if [[ $- != *i* ]]; then
	# Shell integration is only useful in interactive sessions
	return 0
fi

case "$TERM" in
linux | dumb)
	# Avoid terminals that don't like OSC sequences
	return 0
	;;
esac

# This function emits an OSC 7 sequence to inform the terminal
# of the current working directory.  It prefers to use a helper
# command provided by wezterm if wezterm is installed, but falls
# back to a simple printf command otherwise.
__wezterm_osc7() {
	if hash wezterm 2>/dev/null; then
		wezterm set-working-directory 2>/dev/null && return 0
		# If the command failed (perhaps the installed wezterm
		# is too old?) then fall back to the simple version below.
	fi
	printf "\033]7;file://%s%s\033\\" "${HOSTNAME}" "${PWD}"
}

# The semantic precmd and prexec functions generate semantic
# zones, marking up the prompt, the user input and the command
# output so that the terminal can better reason about the display.
__wezterm_semantic_precmd_executing=""
__wezterm_semantic_precmd() {
	local ret="$?"
	if [[ "$__wezterm_semantic_precmd_executing" != "0" ]]; then
		__wezterm_save_ps1="$PS1"
		__wezterm_save_ps2="$PS2"
		# Markup the left and right prompts so that the terminal
		# knows that they are semantically prompt output.
		PS1=$'%{\e]133;P;k=i\a%}'$PS1$'%{\e]133;B\a%}'
		PS2=$'%{\e]133;P;k=s\a%}'$PS2$'%{\e]133;B\a%}'
	fi
	if [[ "$__wezterm_semantic_precmd_executing" != "" ]]; then
		# Report last command status
		printf "\033]133;D;%s;aid=%s\007" "$ret" "$$"
	fi
	# Fresh line and start the prompt
	printf "\033]133;A;cl=m;aid=%s\007" "$$"
	__wezterm_semantic_precmd_executing=0
}

function __wezterm_semantic_preexec() {
	# Restore the original PS1/PS2
	PS1="$__wezterm_save_ps1"
	PS2="$__wezterm_save_ps2"
	# Indicate that the command output begins here
	printf "\033]133;C;\007"
	__wezterm_semantic_precmd_executing=1
}

# Register the various functions; take care to perform osc7 after
# the semantic zones as we don't want to perturb the last command
# status before we've had a chance to report it to the terminal
if [[ -z "${WEZTERM_SHELL_SKIP_SEMANTIC_ZONES}" ]]; then
	precmd_functions+=(__wezterm_semantic_precmd)
	preexec_functions+=(__wezterm_semantic_preexec)
fi

if [[ -z "${WEZTERM_SHELL_SKIP_CWD}" ]]; then
	precmd_functions+=(__wezterm_osc7)
fi

true
