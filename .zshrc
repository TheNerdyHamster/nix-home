# enable colors
autoload -U colors && colors

# History file
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.cache/zsh/history
setopt HIST_IGNORE_ALL_DUPS

export EDITOR="vim"
export VISUAL="vim"

fpath+=(~/.config/hcloud/completion/zsh)

autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ print -Pn "\e]2;%m:%2~\a" }
KUBECONFIG="$(find ~/.kube/configs/ -type f -exec printf '%s:' '{}' +)"
# Plugins
source ~/.zplug/init.zsh

zplug "plugins/git",            from:oh-my-zsh
zplug "plugins/ssh-agent",      from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zdharma/fast-syntax-highlighting", defer:2
zplug "kazhala/dotbare", defer:2

if ! zplug check; then
    zplug install
fi

zplug load

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# ALIASES

# Terminal
alias c='clear'
alias ping='ping -c 5'
alias szsh='source ~/.zshrc'

# Vim
alias vi='nvim'
alias vim='nvim'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Changing "ls" to "exa"
alias ls='exa --icons --color=always --group-directories-first' # my preferred listing
alias la='exa -a  --icons --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l  --icons --color=always --group-directories-first'  # long format
alias lla='exa -al --icons --color=always --group-directories-first'  # long format
alias lt='exa -aT --icons --color=always --group-directories-first' # tree listing

# # Git

# pacman and yay
alias pacsyu='sudo pacman -Syyu'                 # update only standard pkgs
alias parsua='paru -Sua --noconfirm'              # update only AUR pkgs
alias parsyu='paru -Syu --noconfirm'              # update standard pkgs and AUR pkgs
alias unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'  # remove orphaned packages

# Utils
alias scrot="scrot '%Y-%m-%d_$w$h.png' -e 'mv $f ~/Pictures/screenshots'"
alias myip='curl http://ipecho.net/plain; echo'
alias ports='netstat -tulanp'
alias connjabra="bluetoothctl connect 70:BF:92:D1:07:D3"
alias discjabra="bluetoothctl disconnect 70:BF:92:D1:07:D3"

# Flags
alias free='free -m'

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

# Switching between shells
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"

# Exports
GPG_TTY=`tty`
export GPG_TTY

export VISUAL=vim

export LANG=en_US.UTF-8

# DotBare
export DOTBARE_DIR="$HOME/.dotfiles"

# Golang
export PATH="$PATH:$HOME/go/bin"

# Yarn
export PATH="$PATH:$HOME/.yarn/bin"

# Dotnet tools
export PATH="$PATH:$HOME/.dotnet/tools"

# Rust tools
export PATH="$PATH:$HOME/.cargo/bin"
# Composer
export PATH="$PATH:$HOME/.config/composer/vendor/bin"

# Less & man pages
# Start blinking
export LESS_TERMCAP_mb=$(tput bold; tput setaf 4) # Blue
# Start bold
export LESS_TERMCAP_md=$(tput bold; tput setaf 4) # Blue
# Start standout
export LESS_TERMCAP_so=$(tput bold; tput rev; tput setaf 6) # Cyan
# End standout
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# Start underline
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 5) # Magenta
# End bold, blinking, standout, underline
export LESS_TERMCAP_me=$(tput sgr0)

# Functions
function re() {
   paru -Qq | fzf -q "$1" -m --preview 'paru -Qi {1}' | xargs -ro paru -Rns
}

# Completion
# Helm
source <(helm completion zsh)
# Kubectl
source <(kubectl completion zsh)
# DotNET
_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")

  reply=( "${(ps:\n:)completions}" )
}

compctl -K _dotnet_zsh_complete dotnet

# Suggestion of alias for command.
# source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh 2>/dev/null
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

eval "$(starship init zsh)"

alias luamake=/home/leo/.cache/nvim/nlua/sumneko_lua/lua-language-server/3rd/luamake/luamake


eval 
            fuck () {
                TF_PYTHONIOENCODING=$PYTHONIOENCODING;
                export TF_SHELL=zsh;
                export TF_ALIAS=fuck;
                TF_SHELL_ALIASES=$(alias);
                export TF_SHELL_ALIASES;
                TF_HISTORY="$(fc -ln -10)";
                export TF_HISTORY;
                export PYTHONIOENCODING=utf-8;
                TF_CMD=$(
                    thefuck THEFUCK_ARGUMENT_PLACEHOLDER $@
                ) && eval $TF_CMD;
                unset TF_HISTORY;
                export PYTHONIOENCODING=$TF_PYTHONIOENCODING;
                test -n "$TF_CMD" && print -s $TF_CMD
            }
        
