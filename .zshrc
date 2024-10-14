#------------------------------------------------------------------#
# File:     .zshrc   ZSH resource file                             #
# Author:   manu2x@qq.com                                          #
#------------------------------------------------------------------#

#------------------------------
# auto start tmux
#------------------------------

#if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#    tmux attach-session -t default || tmux new-session -s default
#fi

if which pyenv > /dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

#-----------------
# zplug
#-----------------

if [[ -f ~/.zplug/init.zsh ]]; then
  source ~/.zplug/init.zsh
else
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh 
  source ~/.zplug/init.zsh
fi

# Load theme file
zplug 'dracula/zsh', as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

#-----------------------------
# Source some stuff
#-----------------------------

if [[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  . ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
else
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
  . ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -f ~/.autojump/etc/profile.d/autojump.sh ]]; then
  . ~/.autojump/etc/profile.d/autojump.sh
else
  git clone https://github.com/wting/autojump.git ~/.zsh/autojump
  cd ~/.zsh/autojump && ./install.py
  . ~/.autojump/etc/profile.d/autojump.sh
fi

if [[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  . ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
  . ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
else
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf &&  ~/.fzf/install
fi

#------------------------------
# fzf
#------------------------------

export FZF_DEFAULT_COMMAND='fd --type f --exclude ".git" --exclude "node_modules" . --color=always'
export FZF_DEFAULT_OPTS="--ansi --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

# fzf常见用法：
# ctrl+r 历史指令
# ctrl+t 启动fzf
# alt+c cd
# vim **<tab>
# kill -9 **<tab>
# ssh **<tab>
# export **

#------------------------------
# History stuff
#------------------------------

export HISTTIMEFORMAT="%F %T "
export HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
export HISTSIZE=10000
export SAVEHIST=10000

# 窗口之间共享历史命令？
setopt inc_append_history

#------------------------------
# Local Variables
#------------------------------

# node/npm

NPM_PACKAGES="${HOME}/.npm-global"
npm config set prefix $NPM_PACKAGES
export PATH="$PATH:$NPM_PACKAGES/bin"
export PATH="$PATH:$HOME/.local/bin"

# yarn
export PATH="$PATH:$HOME/.yarn/bin"

# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
#export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

export BROWSER="/usr/bin/google-chrome-stable"
export EDITOR="vim"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5faf87"
export hostip="localhost"

## Hadoop
# export HADOOP_HOME=/home/artibix/hadoop-3.3.5
# export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
# export JAVA_HOME=/usr/lib/jvm/java-11-openjdk

# Flume
# export PATH=$PATH:/home/artibix/apache-flume-1.11.0-bin/bin

# Go
export GOPATH=$HOME/code/go

# for coding
export SASS_BINARY_SITE=http://npm.taobao.org/mirrors/node-sass yarn

#-----------------------------
# Dircolors
#-----------------------------

LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

#------------------------------
# Keybindings
#------------------------------

bindkey "^[[1;5C" forward-word                        # ctrl-rightArrow 向前移动一个单词，以空格为标准
bindkey "^[[1;5D" backward-word                       # ctrl-leftArrow　向后移动一个单词
bindkey "^[[A" history-beginning-search-backward      # ^ 根据输入的字符向后查找历史指令
bindkey "^[[B" history-beginning-search-forward       # v 向前搜索
bindkey "^[[C" forward-char                           # >
bindkey "^[[D" backward-char                          # <
bindkey "^[[H" beginning-of-line                      # [Home] 行首
bindkey "^[[F" end-of-line                            # [End]　行末

bindkey "\E[1~" beginning-of-line
bindkey "\E[4~" end-of-line
bindkey "\E[3~" delete-char

# 自带的常用快捷键有
# [ctrl-u] 清空当前行
# [ctrl-l] 清空屏幕
# 其他快捷键
#option action
#   CTRL-c  Stop current command
#   CTRL-z  Sleep program
#   CTRL-a  Go to start of line
#   CTRL-e  Go to end of line
#   CTRL-u  Cut from start of line
#   CTRL-w  delete a word in front the Cursor
#   CTRL-k  Cut to end of line
#   CTRL-r  Search history
#   CTRL + l    Clear screen
#   CTRL + s    Stop output to screen
#   CTRL + q    Re-enable screen output
#   !!  Repeat last command
#   !abc    Run last command starting with abc
#   !abc:p  Print last command starting with abc
#   !$  Last argument of previous command
#   ALT-.   Last argument of previous command
#   !*  All arguments of previous command
#   ^abc ^123   Run previous command, replacing abc with 123


#------------------------------
# Alias stuff
#------------------------------

# git
alias gaa="git add --all"
alias gci='git commit -m'
alias ga='git add'
alias gst='git status'
alias gp='git push'

# manjaro/arch
alias ls="ls --color -F"
alias ll="ls --color -lh"
alias spm="sudo pacman"
alias rm='echo "This is not the command you are looking for."; false'
# alias cat='bat'
alias cp='cp -i'
alias sys='systemctl'
alias tp='trash-put'
# windows
alias subl='subl.exe'
alias nodepad='nodepad.exe'
alias explorer=explorer.exe

# for coding
alias sail='bash vendor/bin/sail'
alias nv='nvim'

#------------------------------
# ShellFuncs
#------------------------------
# -- coloured manuals
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man -L zh_CN "$@"
  }

#------------------------------
# Comp stuff
#------------------------------
autoload -U promptinit
promptinit
zmodload zsh/complist
autoload -Uz compinit
compinit
zstyle :compinstall filename '${HOME}/.zshrc'

#- buggy
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
#-/buggy

zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always
# 小写也能tab补全
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

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
screen|screen-256color|tmux-256color)
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
autoload -U colors zsh/terminfo
colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true

setprompt() {
 setopt prompt_subst

  # VCS
  YS_VCS_PROMPT_PREFIX1=" %{$fg[white]%}on%{$reset_color%} "
  YS_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
  YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
  YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}"
  YS_VCS_PROMPT_CLEAN="%{$fg[green]%}"

zstyle ':vcs_info:git*' formats "${YS_VCS_PROMPT_PREFIX1}git\
${YS_VCS_PROMPT_PREFIX2}%b\
${YS_VCS_PROMPT_DIRTY}%u${YS_VCS_PROMPT_CLEAN}%c"
  ssh_info () {
    if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
      p_host='%F{yellow}(remote)%M%f'
    else
      p_host='%F{green}%M%f'
    fi
  }
  ssh_info

# Prompt format:
#
# PRIVILEGES USER @ MACHINE in DIRECTORY on git:BRANCH STATE [TIME] C:LAST_EXIT_CODE
# $ COMMAND
#
# For example:
#
# % ys @ ys-mbp in ~/.oh-my-zsh on git:master x [21:47:42] C:0
# $
  PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%{$fg[cyan]%}%n) \
%{$fg[white]%}@ \
${p_host} \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}\
${venv_info}\
\${vcs_info_msg_0_}\
 \
%{$fg[white]%}[%*] $exit_code
%{$terminfo[bold]$fg[yellow]%}-> %{$reset_color%}"

  PS2=$'%_>'
}
setprompt

set-simple-prompt () {
  PROMPT="%{$fg[green]%}➜ %{$fg[blue]%}%~%  "
  PS2=$'%_>'
}


#------------------------------
# WSL2 auto start services && variable
#------------------------------
if [[ "`uname -r`" == *"WSL"* ]]; then
  bindkey "^A" beginning-of-line
  bindkey "^E" end-of-line
fi

#------------------------------
# Termux auto start services && variable
#------------------------------
if which termux-info > /dev/null; then
  echo "Detects that your system is a termux, and some services are automatically started"
  if ! pgrep crond > /dev/null; then
    echo "start crond with sudo"
    crond
  else
    echo "crond is running"
  fi
  if ! pgrep -x "sshd" > /dev/null; then
    echo "start sshd with sudo"
    sshd
  else
    echo "sshd is running"
  fi
  # https://github.com/arkane-systems/genie
fi

#------------------------------
# Proxy
#------------------------------

setproxy () {
    export https_proxy="http://${hostip}:8888"
    export http_proxy="http://${hostip}:8888"
    echo "HTTP Proxy on: ${hostip}"
}

unsetproxy () {
    unset http_proxy
    unset https_proxy
    unset all_proxy
    echo "HTTP Proxy off"
}
setproxy
