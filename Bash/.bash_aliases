#!/bin/bash
# Generally useful ones

alias q='exit'
alias c='clear'
alias h='history'
alias cs='clear;ls'
alias p='cat'
alias pd='pwd'
alias t='time'
alias k='kill'
alias null='/dev/null'
alias e='emacsclient -c'
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias ....='cd ..; cd ..; cd ..'
alias python='python3'
alias pip='pip3'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# System-specific ls shenanigans
if command -v exa &> /dev/null; then
    alias l='exa -al --color=always --group-directories-first'
    alias lt='exa -aT --color=always --group-directories-first'
fi

if [[ "$OSTYPE" == "darwin"* ]] &&  command -v gls &> /dev/null; then
    alias ls='gls --color=always'
fi
    

# Shortcuts to .emacs.d and .bashrc
alias emacsd='emacsclient -c ~/.emacs.d/'
alias bashrc='emacsclient -c ~/.bashrc'
alias loadbash='source ~/.bashrc'

# Common directories
alias home='cd ~'
alias root='cd /'
alias dtop='cd ~/Desktop'
alias down='cd ~/Downloads'

# Various project directories

alias mclass='cd ~/Classes/Math\ Classes'
alias eclass='cd ~/Classes/English\ Classes'
alias mhw='cd ~/Classes/Math\ Classes/Homework'
alias ewh='cd ~/Classes/English\ Classes/Homework'
alias writing='cd ~/Writing\ Projects/'
alias dfiles='cd ~/.dotfiles/'

# Git commands

alias g='git'
alias st='git status'
alias com='git commit -m'
alias clone='git clone'
alias sth='git stash'
alias lg='git log'
alias u='git add -u'
alias all='git add .'

