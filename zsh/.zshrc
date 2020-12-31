
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
zstyle ':vcs_info:*' formats "%{$fg[white]%}[%{$fg[blue]%}%b%{$fg[white]%}] %{$fg[red]%}%u%{$fg[yellow]%}%c%{$fg[blue]%}%m%{$reset_color%}"
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-st
#zstyle ':vcs_info:*+*:*' debug true

+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='?'
    fi
}

### Compare local changes to remote changes

function +vi-git-st() {
    local ahead behind
    local -a gitstatus

    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l | tr -d ' ')
    (( $ahead )) && gitstatus+=( "↑$ahead" )

    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l | tr -d ' ')
    (( $behind )) && gitstatus+=( "↓$behind" )

    hook_com[misc]+=${gitstatus}
}

precmd() {

    vcs_info
    if [[ -n ${vcs_info_msg_0_} ]]; then
        RPROMPT="${vcs_info_msg_0_} %(?.%F{green}√.%F{red}%?)%f"
    else
        RPROMPT="%(?.%F{green}√.%F{red}%?)%f"
    fi
}


PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%m %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
