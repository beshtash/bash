#!/bin/bash

_mkdir(){
		local d="$1" # get dir name
    local p=${2:-0755} # get permission, set derault to 0755
    [ $# -eq 0 ] && { echo "$0: dirname"; return; }
    [ ! -d "$d" ] && mkdir -m "$p" -p "$d"
}



