#
# ~/.bashrc
#
#Decorations

bind 'TAB:menu-complete'
bind 'set show-all-if-ambiguous on'
force_color_prompt=yes

#Alias General
alias v="nvim"
alias vimconfig="nvim ~/.config/nvim/init.lua" 
alias bashrc='sudo nvim ~/.bashrc'
alias uni="cd $HOME/UNI"

#ROS AI phyton
#File explorer
alias N="sudo nnn"
alias n="nnn"
alias home="cd $HOME"
alias devel="cd $HOME/Devel"
alias ls="lsd"
alias ll="lsd -l"
alias la="lsd -a"
alias c="clear"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

#NNN config
#https://github.com/jarun/nnn/wiki/Usage#configuration

BLK="01" CHR="08" DIR="dc" EXE="1b" REG="00" HARDLINK="06" SYMLINK="45" MISSING="00" ORPHAN="09" FIFO="09" SOCK="0B" OTHER="05"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
export NNN_COLORS="3f"
export VISUAL="nvim"
export NNN_OPENER="nuke"
export NNN_EDITOR="neovim"
#. "$HOME/.cargo/env"
