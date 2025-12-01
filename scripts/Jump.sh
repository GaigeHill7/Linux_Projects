#!/usr/bin/env bash

# A simple bash script to move up to desired directory level directly.
#
# This script defines a `jump` function intended to be sourced into your shell.
# To add it to your shell session call:
#   source /path/to/Jump.sh
# and then use:
#   jump <dir-name>
# It will move to the nearest (closest) ancestor directory matching <dir-name>.

function jump() {
    # Validate input
    if [ -z "$1" ]; then
        echo "Usage: jump <directory-name>" >&2
        return 1
    fi

    local target="$1"
    local OLDIFS pos
    local -a path_arr
    local dir dir_in_path cwd limit i target_index

    # Save and change IFS to split on '/'
    OLDIFS="$IFS"
    IFS='/'
    # split PWD into array safely
    read -ra path_arr <<< "$PWD"
    IFS="$OLDIFS"

    # Find the last (closest) occurrence of the directory name
    dir_in_path=${#path_arr[@]}
    target_index=-1
    for (( i = dir_in_path-1; i >= 0; i-- )); do
        if [ "${path_arr[i]}" = "$target" ]; then
            target_index=$i
            break
        fi
    done

    if [ "$target_index" -lt 0 ]; then
        echo "jump: directory '$target' not found in current path" >&2
        return 2
    fi

    # Number of levels to go up
    limit=$((dir_in_path - target_index - 1))

    # Build the destination path safely by going up limit times
    cwd="$PWD"
    for ((i=0; i<limit; i++)); do
        cwd="$cwd/.."
    done

    # Use cd with quoting to handle spaces
    cd "$cwd" || return 3
}

# If this file is executed instead of being sourced, give a helpful message.
if [ "${BASH_SOURCE[0]}" = "$0" ]; then
    echo "This script defines a function 'jump' that must be sourced to affect your current shell." >&2
    echo "Usage: source ${BASH_SOURCE[0]}" >&2
    exit 1
fi