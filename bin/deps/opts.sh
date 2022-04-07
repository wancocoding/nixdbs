#!/usr/bin/env bash

print_help()
{
    cat <<-EndOptionsHelp
    Usage: nixdbs.sh [-h] [-s step name] [-c config file path]
    Options:
    -c Config file
		Run script with a custome configuration file
    -s Step name
    	Run the specified steps:
        brew   - setup homebrew
    	vim    - setup vim
    -h
	Show this help messages
	EndOptionsHelp
}

declare -a specified_steps=()

# ============ options
while getopts "hs:c:" cmd_opts
do
    case $cmd_opts in
        h)
            # print help
            print_help
            exit 0
            ;;
        c)
            echo "$OPTARG"
            ;;
        s)
			arg_step_name=$OPTARG
			specified_steps+=("$arg_step_name")
            ;;
    esac
done

# reset option index that '$1' will be the main argument
shift $((OPTIND - 1))

