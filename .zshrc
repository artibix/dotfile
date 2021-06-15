#------------------------------------------------------------------#
# File:     .zshrc   ZSH resource file                             #
# Version:  1.１                                                   #
# Author:   manu2x@qq.com                                          #
#------------------------------------------------------------------#

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
  git clone git://github.com/wting/autojump.git ~/.zsh/autojump
  cd ~/.zsh/autojump && ./install.py
  . ~/.autojump/etc/profile.d/autojump.sh
fi

if [[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  . ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
  . ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

#------------------------------
# History stuff
#------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# 历史指令直接使用-i,-E,-D参数就可以读取每条指令的时间了

#------------------------------
# Variables
#------------------------------
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
export BROWSER="/usr/bin/google-chrome-stable"
export EDITOR="vim"
export PATH="${PATH}:"
#export http_proxy='http://localhost:8888'
#export https_proxy='http://localhost:8888'
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5faf87"

#-----------------------------
# Dircolors
#-----------------------------
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

#------------------------------
# Keybindings
#------------------------------
# bindkey -e

bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
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
bindkey "\e[3~" delete-char
# 自带的常用快捷键有
# [ctrl-u] 清空当前行
# [ctrl-l] 清空屏幕
# 其他快捷键
#option	action
#	CTRL-c	Stop current command
#	CTRL-z	Sleep program
#	CTRL-a	Go to start of line
#	CTRL-e	Go to end of line
#	CTRL-u	Cut from start of line
#	CTRL-w	delete a word in front the Cursor
#	CTRL-k	Cut to end of line
#	CTRL-r	Search history
#	CTRL + l	Clear screen
#	CTRL + s	Stop output to screen
#	CTRL + q	Re-enable screen output
#	!!	Repeat last command
#	!abc	Run last command starting with abc
#	!abc:p	Print last command starting with abc
#	!$	Last argument of previous command
#	ALT-.	Last argument of previous command
#	!*	All arguments of previous command
#	^abc ^123	Run previous command, replacing abc with 123


#------------------------------
# Alias stuff
#------------------------------
alias ls="ls --color -F"
alias ll="ls --color -lh"
alias spm="sudo pacman"
alias gaa="git add --all"
alias gcmsg='git commit -m'
alias ga='git add'
alias gst='git status'
alias gp='git push'
alias rm='trash'
alias cat='bat'
alias cp='cp -i'

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
    man "$@"
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
  screen|screen-256color)
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
    p_host='%F{yellow}%M%f'
  else
    p_host='%F{green}%M%f'
  fi
  }
  ssh_info


# Virtualenv
local venv_info='$(virtenv_prompt)'
YS_THEME_VIRTUALENV_PROMPT_PREFIX=" %{$fg[green]%}"
YS_THEME_VIRTUALENV_PROMPT_SUFFIX=" %{$reset_color%}%"
virtenv_prompt() {
	[[ -n ${VIRTUAL_ENV} ]] || return
	echo "${YS_THEME_VIRTUALENV_PROMPT_PREFIX}${VIRTUAL_ENV:t}${YS_THEME_VIRTUALENV_PROMPT_SUFFIX}"
}

local exit_code="%(?,,C:%{$fg[red]%}%?%{$reset_color%})"

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

