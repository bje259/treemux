#!/bin/zsh

source /Users/bradleyeuell/dotfiles/tmux/.config/tmux/plugins/tmux-sidebar/scripts/funcs.sh

inputDepth=${1:=2}

set_sidebar_tree_depth "$inputDepth"

tmux run-shell "tmux source-file /Users/bradleyeuell/.config/tmux/tmux.conf > /dev/null"
