#!/usr/bin/env bash

function detect_os {

	UNAME=$( command -v uname)

	case $( "${UNAME}" | tr '[:upper:]' '[:lower:]') in
	  linux*)
	    echo 'linux'
	    ;;
	  darwin*)
	    echo 'darwin'
	    ;;
	  msys*|cygwin*|mingw*)
	    # or possible 'bash on windows'
	    echo 'windows'
	    ;;
	  nt|win*)
	    echo 'windows'
	    ;;
	  *)
	    echo 'unknown'
	    ;;
	esac
	    return
}

function detect_cmd {
	if hash $1 2>/dev/null; then
		echo 1
    else
		echo 0
    fi
}

# vim:set ft=sh noet sts=4 ts=4 sw=4 tw=78:
