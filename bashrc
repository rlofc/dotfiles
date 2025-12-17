#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History settings
export HISTSIZE=100000
export HISTCONTROL=erasedups:ignorespace
shopt -s histappend

# Base prompt and colors
PS1='[\u@\h \W]\$xx '
export LS_COLORS="$(vivid -m 8-bit generate snazzy)"
export TERM="xterm-256color"
export COLORTERM=truecolor

# Hacks
ulimit -n 4096
xset r rate 300 120

# Fzf
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
source ~/bin/fzf.sh

# Aliases
alias pq=pueue
alias pqa="pueue add"
alias ls='ls --color=auto'
alias lsa='EZA_ICON_SPACING=2 eza -lah --git --git-repos --icons'

# Bash-it
source ~/.bashit
