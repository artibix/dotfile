#------------------------------------------------------------------#
# File:     .zshrc   ZSH resource file                             #
# Author:   manu2x@qq.com                                          #
# Updated:  March 2025                                             #
#------------------------------------------------------------------#

#------------------------------
# ZSH Core Configuration
#------------------------------

# History Configuration
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=1000000                          # Increased for better history retention
SAVEHIST=$HISTSIZE                        # Match HISTSIZE
HISTORY_IGNORE="(ls|cd|pwd|exit|date)"    # Commands to ignore in history

# History Options
setopt BANG_HIST                  # Treat the '!' character specially during expansion
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history
setopt HIST_FIND_NO_DUPS         # Do not display duplicates during searches
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate
setopt HIST_IGNORE_DUPS          # Don't record if same as previous command
setopt HIST_IGNORE_SPACE         # Don't record starting with a space
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry
setopt HIST_SAVE_NO_DUPS        # Don't write duplicate entries in the history file
setopt HIST_VERIFY              # Don't execute immediately upon history expansion
setopt INC_APPEND_HISTORY       # Write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY            # Share history between all sessions

# History search configuration
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

#------------------------------
# Plugins and Theme Management
#------------------------------

# zplug setup
if [[ -f ~/.zplug/init.zsh ]]; then
  source ~/.zplug/init.zsh
else
  echo "Installing zplug..."
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  source ~/.zplug/init.zsh
fi

# Load theme and plugins
zplug 'dracula/zsh', as:theme                     # Dracula theme
zplug 'zsh-users/zsh-autosuggestions'             # Fish-like autosuggestions
zplug 'zsh-users/zsh-syntax-highlighting', defer:2 # Syntax highlighting
zplug 'zsh-users/zsh-completions'                 # Extra completion definitions
zplug 'zsh-users/zsh-history-substring-search'    # History search with up/down arrows
zplug 'supercrabtree/k'                           # Directory listings with git features
zplug 'MichaelAquilina/zsh-you-should-use'        # Reminds you of aliases
zplug 'junegunn/fzf'                              # Fuzzy finder
zplug 'wting/autojump'

if [[ -f ~/.autojump/etc/profile.d/autojump.sh ]]; then
  . ~/.autojump/etc/profile.d/autojump.sh
else
  git clone https://github.com/wting/autojump.git ~/.zsh/autojump
  cd ~/.zsh/autojump && ./install.py
  . ~/.autojump/etc/profile.d/autojump.sh
fi

# Install plugins if needed
if ! zplug check; then
    printf "Install missing plugins? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Load plugins
zplug load

#------------------------------
# Plugin Configuration
#------------------------------

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5faf87"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# fzf configuration
if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
else
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
fi

export FZF_DEFAULT_COMMAND='fd --type f --exclude ".git" --exclude "node_modules" . --color=always'
export FZF_DEFAULT_OPTS="--ansi --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --exclude .git --exclude node_modules . --color=always"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# fzf usage reminder in comment:
# - CTRL+R: Search command history
# - CTRL+T: Search for files
# - ALT+C: CD into selected directory
# - **<TAB>: Fuzzy completion (vim **, kill -9 **, ssh **, etc.)

#------------------------------
# Environment Variables
#------------------------------

if (( $+commands[nvim] )); then
  export EDITOR='nvim'
  export VISUAL='nvim'
  export MANPAGER='nvim +Man!'
elif (( $+commands[vim] )); then
  export EDITOR='vim'
  export VISUAL='vim'
  export MANPAGER='vim -M +MANPAGER -'
else
  export EDITOR='nano'
  export VISUAL='nano'
fi

# Directory colors
export LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:'

#------------------------------
# Development Environment Setup
#------------------------------

# Node.js / npm
export NPM_PACKAGES="${HOME}/.npm-global"
npm config set prefix $NPM_PACKAGES
export PATH="$PATH:$NPM_PACKAGES/bin"

# Yarn
export PATH="$PATH:$HOME/.yarn/bin"

# Local bin directory
export PATH="$PATH:$HOME/.local/bin"

# SASS mirror for China
export SASS_BINARY_SITE=http://npm.taobao.org/mirrors/node-sass

# Java / OpenJDK
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

#------------------------------
# Keybindings
#------------------------------

# Emacs keybindings (default in zsh)
bindkey -e

# Navigation
bindkey "^[[1;5C" forward-word                      # Ctrl+Right: next word
bindkey "^[[1;5D" backward-word                     # Ctrl+Left: previous word
bindkey "^[[H" beginning-of-line                    # Home: beginning of line
bindkey "^[[F" end-of-line                          # End: end of line
bindkey "^[[3~" delete-char                         # Delete: delete char

# History navigation
bindkey "^[[A" history-beginning-search-backward    # Up: search history backwards
bindkey "^[[B" history-beginning-search-forward     # Down: search history forwards

# Extra keybindings for history substring search (if plugin is loaded)
bindkey '^P' history-substring-search-up            # Ctrl+P: search up
bindkey '^N' history-substring-search-down          # Ctrl+N: search down

# Basic cursor movement
bindkey "^[[C" forward-char                         # Right: move forward
bindkey "^[[D" backward-char                        # Left: move backward

# Terminal specific keybindings
bindkey "\E[1~" beginning-of-line                   # Alt setup for Home
bindkey "\E[4~" end-of-line                         # Alt setup for End

# WSL-specific keybindings
if [[ "`uname -r`" == *"WSL"* ]]; then
  bindkey "^A" beginning-of-line                    # Ctrl+A: beginning of line (WSL)
  bindkey "^E" end-of-line                          # Ctrl+E: end of line (WSL)
fi

# Keybinding reminder:
# Ctrl+U: Clear line up to cursor
# Ctrl+K: Clear line after cursor
# Ctrl+L: Clear screen
# Ctrl+W: Delete word before cursor
# Alt+F/B: Move forward/backward one word
# Ctrl+R: Search history
# Ctrl+G: Cancel search
# Ctrl+_: Undo
# Ctrl+X Ctrl+E: Edit command in $EDITOR

#------------------------------
# Aliases
#------------------------------

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'

# git shortcuts
alias gaa="git add --all"
alias gci='git commit -m'
alias ga='git add'
alias gst='git status'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias glog='git log --oneline --graph --decorate'
alias gdiff='git diff'

# File operations (safer defaults)
alias rm='echo "This is not the command you are looking for. Use trash-put or rm -i instead."; false'
alias tp='trash-put'
alias cp='cp -i'
alias mv='mv -i'

# Modern replacement tools
alias ls="ls --color -F"                  # Colorized ls with indicators
alias ll="ls --color -lh"                 # Long list format
alias la="ls --color -lha"                # Show all files including hidden
alias lsd="ls -d */"                      # List directories only
alias grep="grep --color=auto"            # Colorized grep output
alias diff="diff --color=auto"            # Colorized diff output

# System management
alias spm="sudo pacman"                   # Arch/Manjaro package manager shortcut
alias sys='systemctl'                     # Systemd shortcut
alias sysu='systemctl --user'             # User systemd shortcut
alias dps='docker ps'                     # Docker process list
alias dpsa='docker ps -a'                 # Docker all processes
alias dl='docker logs'                    # Docker logs

# Windows subsystem
alias subl='subl.exe'                     # Sublime Text (Windows)
alias notepad='notepad.exe'               # Fixed typo from 'nodepad'
alias explorer='explorer.exe'             # Windows Explorer

# Development
alias sail='bash vendor/bin/sail'         # Laravel Sail
alias nv='nvim'                           # Neovim

# Networking
alias ports='netstat -tulanp'             # Show open ports

# General
alias h='history'                         # History shortcut
alias c='clear'                           # Clear screen
alias path='echo -e ${PATH//:/\\n}'       # Print path in readable format
alias now='date +"%T"'                    # Current time
alias nowdate='date +"%d-%m-%Y"'          # Current date

#------------------------------
# Functions
#------------------------------

# Colorized man pages
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

# Easy extract function for various archive types
extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Make directory and change into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Simple HTTP server in current directory
serve() {
  local port="${1:-8000}"
  python -m http.server "$port"
}

# Find files by name
ff() { find . -type f -name "*$1*" -print; }

setproxy() {
    local host="${1:-localhost}"
    local port="${2:-8888}"

    if ! [[ "$port" =~ ^[0-9]+$ ]] || [ "$port" -lt 1 ] || [ "$port" -gt 65535 ]; then
        echo "Error: Invalid port number. Must be between 1-65535"
        return 1
    fi

    export http_proxy="http://${host}:${port}"
    export https_proxy="http://${host}:${port}"
    export all_proxy="http://${host}:${port}"

    echo "Proxy enabled - http://${host}:${port}"
    echo "Environment variables set:"
    echo "  http_proxy:  $http_proxy"
    echo "  https_proxy: $https_proxy"
    echo "  all_proxy:   $all_proxy"
}

unsetproxy() {
    unset http_proxy https_proxy all_proxy
    echo "All proxy settings have been disabled"
}

checkproxy() {
    echo "Current proxy settings:"
    echo "Environment variables:"
    echo "  http_proxy:  ${http_proxy:-not set}"
    echo "  https_proxy: ${https_proxy:-not set}"
    echo "  all_proxy:   ${all_proxy:-not set}"
}

unsetproxy() {
    unset http_proxy
    unset https_proxy
    unset all_proxy
    echo "HTTP Proxy disabled"
}

set-simple-prompt() {
  PROMPT="%{$fg[green]%}➜ %{$fg[blue]%}%~%  "
  PS2=$'%_>'
}

#------------------------------
# Auto-start Services (Conditionals)
#------------------------------

# Termux specific settings
if which termux-info > /dev/null; then
  echo "Termux environment detected"
  if ! pgrep crond > /dev/null; then
    echo "Starting crond..."
    crond
  else
    echo "crond is running"
  fi
  if ! pgrep -x "sshd" > /dev/null; then
    echo "Starting sshd..."
    sshd
  else
    echo "sshd is running"
  fi
fi

#------------------------------
# Completion System
#------------------------------

autoload -U promptinit
promptinit
zmodload zsh/complist
autoload -Uz compinit
compinit
zstyle :compinstall filename '${HOME}/.zshrc'

# Completion formatting
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Completion behavior
zstyle ':completion:*' menu select                         # Menu-like completion
zstyle ':completion:*' use-cache on                        # Cache completions
zstyle ':completion:*' cache-path ~/.zsh/cache             # Completion cache location
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' # Case insensitive completion
zstyle ':completion:*' rehash true                         # Rehash automatically

# Application-specific completions
zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always
zstyle ':completion:*:*:docker:*' option-stacking yes      # Docker command stacking
zstyle ':completion:*:processes' command 'ps -au$USER'     # Show user processes only
zstyle ':completion:*:*:*:*:processes' menu yes select

# Docker completions
fpath=($HOME/.docker/completions $fpath)

#------------------------------
# Window title
#------------------------------
case $TERM in
  termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
    precmd () {
      vcs_info
      print -Pn "\e]0;[%n@%M][%~]%#\a"
    }
    preexec () { print -Pn "\e]0;[%n@%M][%~]%# ($1)\a" }
    ;;
  screen|screen-256color|tmux|tmux-256color)
    precmd () {
      vcs_info
      print -Pn "\e]83;title \"$1\"\a"
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a"
    }
    preexec () {
      print -Pn "\e]83;title \"$1\"\a"
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a"
    }
    ;;
esac

#------------------------------
# Prompt
#------------------------------
# Load colors and terminfo
autoload -U colors zsh/terminfo
colors

# Setup version control info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%F{blue}(%F{red}%b%F{blue})%F{yellow}%c%u%f"
zstyle ':vcs_info:git*' actionformats "%F{blue}(%F{red}%b%F{yellow}|%F{red}%a%F{blue})%F{yellow}%c%u%f"
zstyle ':vcs_info:*' stagedstr "+"
zstyle ':vcs_info:*' unstagedstr "!"

# Cache git status output to improve performance
function git_prompt_info() {
  # Only execute in git repositories
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local dirty
    local git_status
    local -a flags
    local git_prompt

    # Cache status result to avoid repeated calls
    if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
      git_status=$(command git status --porcelain 2>/dev/null)
      
      # Check for uncommitted changes
      if [[ -n $git_status ]]; then
        dirty=1
        # Parse status to check for staged and unstaged changes
        if echo "$git_status" | grep -q '^[ACDMR]'; then
          flags+=( "%F{green}+" )
        fi
        if echo "$git_status" | grep -q '^.[DM]'; then
          flags+=( "%F{red}!" )
        fi
      fi
    fi

    # Get branch name
    local branch=$(git symbolic-ref HEAD 2>/dev/null)
    branch=${branch#refs/heads/}

    # Format the prompt
    git_prompt="%F{blue}(%F{green}${branch}%F{blue})"
    [[ -n $dirty ]] && git_prompt+="${(j::)flags}%f"

    echo -n " %F{white}on%f git:$git_prompt"
  fi
}

# Set the prompt
setprompt() {
  setopt prompt_subst

  # Check if running remotely via SSH
  if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
    p_host='%F{yellow}(remote)%M%f'
  else
    p_host='%F{green}%M%f'
  fi

  # Check if we're in a virtual environment
  function virtualenv_info {
    if [[ -n "$VIRTUAL_ENV" ]]; then
      echo " %F{blue}[%F{yellow}$(basename $VIRTUAL_ENV)%F{blue}]%f"
    fi
  }

  # Get exit code
  local exit_code="%(?..%F{red}%?%f)"

  # Set the prompt format
  PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%{$fg[cyan]%}%n) \
%{$fg[white]%}@ \
${p_host} \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}\
\$(virtualenv_info)\
\$(git_prompt_info)\
 \
$exit_code
%{$terminfo[bold]$fg[yellow]%}-> %{$reset_color%}"

  PS2=$'%_>'
}

setprompt

#------------------------------
# External Configs
#------------------------------

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# LM Studio CLI
export PATH="$PATH:$HOME/.lmstudio/bin"

# Initialize proxy by default (comment out if not needed)
setproxy

clear
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/artbix/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

