#!/bin/zsh

# Source the necessary plugin files
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CURRENT_DIR="${0%/*}"
source "$CURRENT_DIR/helpers.sh"
source "$CURRENT_DIR/variables.sh"
source "$CURRENT_DIR/tree_helpers.sh"
debug=$(get_tmux_option "@sidebar-debug" "false")

PANE_ID="$TMUX_PANE"
PANE_CURRENT_PATH="$(get_pane_info "$PANE_ID" "#{pane_current_path}")"

get_sidebar_current_depth() {
	get_tmux_option "@sidebar-tree-command" "tree -Cal --gitignore --dirsfirst -L1" | sed -n 's/.*-L\([0-9]*\).*/\1/p'
}

set_sidebar_tree_depth() {
	local depth="$1"
	local current_depth=$(get_tmux_option "@sidebar-tree-command" "tree -Cal --gitignore --dirsfirst -L1" | sed -n 's/.*-L\([0-9]*\).*/\1/p')
	if $debug; then
		echo "Setting sidebar tree depth to $depth"
		echo "Current tree depth is $current_depth"
	fi
	currentCmd=$(tree_user_command)
	if [[ -z "$currentCmd" ]]; then
		currentCmd="tree -Cla -L2"
	fi
	newCmd=$(echo "$currentCmd" | sed -n 's/\(.*-L\s*\)\([0-9]*\).*/\1/p' | xargs -I {} printf "%s%s\n" {} "$depth")
	echo "$currentCmd $newCmd"
	set_tmux_option "@sidebar-tree-command" "$newCmd"
}

sidebar_pane_id() {
	sidebar_registration |
		cut -d',' -f1
}

sidebar_registration() {
	get_tmux_option "${REGISTERED_PANE_PREFIX}-${PANE_ID}" ""
}

sidebar_exists() {
	local pane_id="$(sidebar_pane_id)"
	tmux list-panes -F "#{pane_id}" 2>/dev/null |
		\grep -q "^${pane_id}$"
}

has_sidebar() {
	if [ -n "$(sidebar_registration)" ] && sidebar_exists; then
		return 0
	else
		return 1
	fi
}

updSB() {
	if [[ -z "$debug" ]]; then
		debug=false
	fi
	regSidePane=$(get_tmux_option "${REGISTERED_PANE_PREFIX}-${TMUX_PANE}" "")

	if [ -z "$regSidePane" ]; then
		if $debug; then echo "No registered sidebar pane found for this pane."; fi
		return
	fi

	tarPane=$(echo "$regSidePane" | cut -d',' -f1)
	cmd=$(echo "$regSidePane" | cut -d',' -f2)

	if [ -n "$tarPane" ] && [ -n "$cmd" ]; then
		tmux clear-history -t "$tarPane"
		tmux run-shell -t "$tarPane" "$cmd"
	else
		if $debug; then echo "Failed to retrieve the target pane ID or command."; fi
	fi
}

cdsb() {
	if [ -d "$1" ]; then
		cd "$1" || return
		has_sidebar && updSB
	else
		if $debug; then echo "Directory '$1' does not exist."; fi
	fi
}
