
# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' stagedstr '+'
#zstyle ':vcs_info:*' formats " %{$fg[yellow]%}[%{$fg[yellow]%}%b%{$fg[yellow]%}] %{$fg[yellow]%}%u%{$fg[yellow]%}%c%{$fg[yellow]%}%m%{$reset_color%}%%"
#%F{yellow}%?%f
zstyle ':vcs_info:*' formats "%{$fg[white]%}[%{$fg[blue]%}%b%{$fg[white]%}] %{$fg[red]%}%u%{$fg[yellow]%}%c%{$fg[blue]%}%m%{$reset_color%}"
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[misc]+='?'
    fi
}

precmd() {

    vcs_info
    if [[ -n ${vcs_info_msg_0_} ]]; then
        # Oh hey, nothing from vcs_info, so we got more space.
        # Let's print a longer part of $PWD...
        RPROMPT="${vcs_info_msg_0_} %(?.%F{green}√.%F{red}%?)%f"
    else
        # vcs_info found something, that needs space. So a shorter $PWD
        # makes sense.
        RPROMPT="%(?.%F{green}√.%F{red}%?)%f"
    fi
}

# You can now use `%1v' to drop the $vcs_info_msg_0_ contents in your prompt;
# like this:

#PS1="%m%(1v.%F{red}%1v%f.)%# "
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%m %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
#RPROMPT="%(1v.%F{red}%1v%f.)% %?|%T"
