#!/usr/bin/env bash


# ==================================
# Setup Proxy
# ==================================

# setup_proxy()
# {
#     echo "Setup a local proxy or just add a proxy server?"
#     echo " (1) local proxy server"
#     echo " (2) remote proxy socket or http server"
#     echo " (0) ignore, setup proxy server later!"
#     read -p "your choice: > " input_text
#     if [ ! -z $input_text ] && [ $input_text != " " ]; then
#         if [ $input_text -eq 0 ]; then
#             echo "you decide setup proxy server later!"
#         elif [ $input_text -eq 1 ]; then
#             echo "setup a local proxy!"
#         elif [ $input_text -eq 2 ]; then
#             echo "setup a remote proxy"
#             echo "Please enter your remote proxy url"
#             echo "eg: http://192.168.0.114:9081"
#             read -p "> " input_text
#             if [ ! -z $input_text ] && [ $input_text != "" ]; then
#                 REMOTE_PROXY=$input_text
#                 log_green "your proxy is: $REMOTE_PROXY"
#             fi
#         else
#             :;
#         fi
#     else
#         log_red "your proxy setting failed!"
#     fi
# 		read -p "Do you want to setup a remote proxy? [y|n]" user_input
# 		case $user_input in
# 			y*|Y*)
# 					echo "Please enter your remote proxy url"
# 					echo "eg: http://192.168.0.114:9081"
# 					read -p "> " input_text
# 					if [ ! -z $input_text ] && [ $input_text != "" ]; then
# 							REMOTE_PROXY=$input_text
# 							fmt_info "your proxy is: $REMOTE_PROXY"
# 					fi
# 		esac
# }

setup_remote_proxy()
{
	  echo_title "Setup a remote proxy"
		read -p "Do you want to setup a remote proxy? [y|n]" user_input
		case $user_input in
			y*|Y*)
					echo "Please enter your remote proxy url"
					echo "eg: http://192.168.0.114:9081"
					read -p "> " input_text
					if [ ! -z $input_text ] && [ $input_text != "" ]; then
							REMOTE_PROXY=$input_text
							fmt_info "your proxy is: $REMOTE_PROXY"
							fmt_success "setup remote proxy!"
					fi
					;;
			*)
				echo "Ignore..."
				;;
		esac

}

setup_remote_proxy

