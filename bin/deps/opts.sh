#!/usr/bin/env bash

declare -a TASK_NAME_ARRAY=(osmir sys base git tools brew zsh ohmyzsh vim java python \
	clang ruby node go)

print_help()
{
    cat <<-EndOptionsHelp
Usage: nixdbs [-chv] info|update [task name]|run [task name]
Options:
    -c, --config [file]             Define a cofiguration file
    -h, --help                      Display this help
    -v, --version                   Display Nixdbs version

Actions:
    info                Show nixdbs information on this machine
    init                Init system and install packages defined in configuration files
    install [tasks]      Run the specified task
    update [tasks]       Update all(when task is empty), or update specified task 
    remove [tasks]       Remove specified task 

Tasks;
    osmir               setup system package manager mirror
    sys                 upgrade system
    base                install necessary packages
    git
    tools
    zsh
    ohmyzsh
    vim
    ruby
    java
    node
    clang
    python
    go



Example Usage:
    nixdbs init
    - This command will install run all tasks defined in the configuration file
    nixdbs -c mini init
    - This command will run init task by a mini configuration file
    nixdbs -c ~/.nixdbs.my.conf init
    - This command will run init task by a user-defined configuration file
    nixdbs ins vim
    - Install vim and some vim plugins
    nixdbs ins vim git brew
    - Install vim git and homebrew
    nixdbs update brew
    - Update homebrew
    nixdbs info
    - Show nixdbs information on this machine
    nixdbs remove node
    - Remove nvm and nodejs installed by nvm

EndOptionsHelp
}

declare -a specified_steps=()

# USER_CONFIG_FILE="$NIXDBS_HOME/configs/nixdbs.default.conf"

define_main_job()
{
	if [ -z ${JOB_NAME:-} ];then
		echo "define job $1"
		JOB_NAME="$1"
	else
		echo "Error: You can only run one job at a time!"
		exit 1
	fi
}

add_task()
{
	if [[ " ${TASK_NAME_ARRAY[*]} " =~ " ${1} " ]]; then
		specified_steps+=("$1")
		return 0
	else
		echo "Error: Task or argument [${1}] not found!"
		return 1
	fi
}

while [[ $# -gt 0 ]]
do
	run_arg="$1"
	case $run_arg in
		init)
			define_main_job "init"
			shift
			;;
		up|update)
			define_main_job "update"
			shift
			# JOB_NAME="update"
			# if [ ! -z "$2"]; then
			#     TASK_NAME="$2"
			#     shift 2
			# else
			#     TASK_NAME="all"
			#     shift
			# fi
			;;
		ins|install)
			define_main_job "install"
			shift
			# JOB_NAME="install"
			# [ -z ${2:-} ] && \
			#     echo "Abort. Your must add a task name argument." && \
			#     exit 1
			# shift
			;;
		rm|remove)
			define_main_job "remove"
			shift
			# JOB_NAME="remove"
			# [ -z ${2:-} ] && \
			#     echo "Abort. Your must add a task name argument." && \
			#     exit 1
			# TASK_NAME="$2"
			# shift 2
			;;
		info|information)
			print_info
			exit 0
			;;
		-c|--config)
			[ -z ${2:-} ] && \
				echo "Abort. Your must add a task name argument." && \
				exit 1
			USER_CONFIG_FILE="$2"
			shift 2
			;;
		-h|--help)
			print_help
			exit 0
			;;
		-v|--version)
			print_version
			exit 0
			;;
		*)
			if add_task "$1" ; then
				shift
			else
				print_help
				exit 1
			fi
			;;
	esac
done


# 
if [ ! -z ${USER_CONFIG_FILE:-} ]; then
	case $USER_CONFIG_FILE in
		mini)
			JOB_CONFIG_FILE="$NIXDBS_HOME/configs/nixdbs.minimal.conf"
			;;
		full)
			JOB_CONFIG_FILE="$NIXDBS_HOME/configs/nixdbs.full.conf"
			;;
		default)
			JOB_CONFIG_FILE="$NIXDBS_HOME/configs/nixdbs.default.conf"
			;;
		*)
			if [[ "$USER_CONFIG_FILE" = /* ]]; then
				# absolute path
				if [ ! -f $USER_CONFIG_FILE ];then
					echo "File: ${USER_CONFIG_FILE} does not exist."
					exit 1
				else
					JOB_CONFIG_FILE=$USER_CONFIG_FILE
				fi
			else
				USER_CONFIG_FILE=${USER_CONFIG_FILE#\./}
				USER_CONFIG_FILE="$CURRENT_WORK_PATH/${USER_CONFIG_FILE}"
				if [ ! -f $USER_CONFIG_FILE ]; then
					echo "File: ${USER_CONFIG_FILE} does not exist."
					exit 1
				else
					JOB_CONFIG_FILE=$USER_CONFIG_FILE
				fi
			fi
			;;
	esac
else
	JOB_CONFIG_FILE="$NIXDBS_HOME/configs/nixdbs.default.conf"
fi

echo "================================================================================="
echo "Task Information                "
echo "job name:           $JOB_NAME"
echo "tasks:              ${specified_steps[@]}"
echo "config file:        ${JOB_CONFIG_FILE}"
echo "================================================================================="


# # ============ options
# while getopts "hs:c:" cmd_opts
# do
#     case $cmd_opts in
#         h)
#             # print help
#             print_help
#             exit 0
#             ;;
#         c)
#             USER_CONFIG_FILE=$OPTARG
#             echo "====== Run with user config file: $OPTARG ======"
#             ;;
#         s)
#             arg_step_name=$OPTARG
#             echo "====== Run task [$arg_step_name] ======"
#             specified_steps+=("$arg_step_name")
#             ;;
#     esac
# done
#
# # reset option index that '$1' will be the main argument
# shift $((OPTIND - 1))
#
# for i in "$@"
# do
# case $i in
#     init|initialize|in*)
#         echo "------ init ------"
#         ;;
#     update|up*)
#         echo "----- update ------"
#         ;;
#     *)
#         echo "unknow argument"
# esac
# done
