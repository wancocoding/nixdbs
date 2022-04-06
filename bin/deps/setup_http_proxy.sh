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

save_http_proxy()
{
    # for zsh
    if [ -a $HOME/.zshrc ]; then
        if ! grep -q 'export NIXDBS_HTTP_PROXY' $HOME/.zshrc ; then
            echo '' >> $HOME/.zshrc
            echo '# ====== http proxy ====== ' >> $HOME/.zshrc
	    echo "export NIXDBS_HTTP_PROXY=$NIXDBS_HTTP_PROXY" >> ~/.zshrc
        fi
    fi
    # for bash
    if [ -a $HOME/.bashrc ]; then
        if ! grep -q 'export NIXDBS_HTTP_PROXY' $HOME/.bashrc ; then
            echo '' >> $HOME/.bashrc
            echo '# ====== http proxy ====== ' >> $HOME/.bashrc
	    echo "export NIXDBS_HTTP_PROXY=$NIXDBS_HTTP_PROXY" >> ~/.bashrc
        fi
    fi
    export HTTP_PROXY="$NIXDBS_HTTP_PROXY"
}

setup_http_proxy()
{
	echo_title "Setup a http proxy"
	fmt_info "this http proxy will used to setup git http.proxy or download something"
	# read -p "Do you want to setup a http proxy? [y|n]" user_input
	# case $user_input in
	# 	y*|Y*)
	# 			echo "Please enter your remote proxy url"
	# 			echo "eg: http://192.168.0.114:9081, http://user:pass@192.168.0.114:9081"
	# 			read -p "> " input_text
	# 			if [ ! -z $input_text ] && [ $input_text != "" ]; then
	# 					REMOTE_PROXY=$input_text
	# 					fmt_info "your proxy is: $REMOTE_PROXY"
	# 					save_http_proxy
	# 					fmt_success "setup remote proxy!"
	# 			fi
	# 			;;
	# 	*)
	# 		echo "Ignore..."
	# 		;;
	# esac
	local http_proxy=$(get_config_str set_http_proxy)
	if [ ! -z "$http_proxy" ] ;then
		NIXDBS_HTTP_PROXY="$http_proxy"
		fmt_info "your http proxy is: $NIXDBS_HTTP_PROXY"
		save_http_proxy
		fmt_success "setup remote proxy!"
	fi

}

append_step "setup_http_proxy"

