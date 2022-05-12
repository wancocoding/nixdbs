#!/usr/bin/env bash


# ==================================
# Setup zsh
# ==================================

runzsh()
{
    fmt_warning "Important!!! You may run this script again if you run zsh right now!!!"
    read -p "Do you want to run zsh now? [y|n]: > " user_opts
    case $user_opts in
        y*|Y*) ;;
        n*|N*)
            echo "Not run zsh now..."
            fmt_warning "You can run zsh after this script!!"
            return ;;
        *)
            echo "Invalid choice."
            return ;;
    esac
    exec zsh -l
}

exec_install_ohmyzsh()
{
    # see https://github.com/ohmyzsh/ohmyzsh/blob/master/tools/install.sh
	dependent_tasks "zsh"
	if [ ! -d $HOME/.oh-my-zsh ]; then
		curl_wrapper "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh" | bash
	else
		echo "oh-my-zsh already installed"
	fi
}


exec_install_zsh()
{
	echo_title "Setup zsh"
    if ! command_exists zsh; then
        # read -p "Do you want to install zsh now: (y|n) [y] >" input_text
        # if [ x"$input_text" == x'y' ]; then
        #     install_pkg zsh
        # else
        #     fmt_warning "Skip install zsh"
        #     return
        # fi
		pkg_install_wrapper zsh
    else
        echo "zsh already installed!"
    fi
    chsh_zsh
	fmt_success "finish zsh setup."
}

chsh_zsh()
{
    # If this user's login shell is already "zsh", do not attempt to switch.
    if [ "$(basename -- "$SHELL")" = "zsh" ]; then
        echo "your already in zsh shell."
        return
    fi
    if ! command_exists chsh; then
        cat <<EOF
I can't change your shell automatically because this system does not have chsh.
${print_f_green}Please manually change your default shell to zsh${print_f_reset}
EOF
        return
    fi

    # fmt_msg_yellow "Do you want to change your default shell to zsh now? [y|n]"
    #
    # read -r u_opts
    # case $u_opts in
    #     y*|Y*|"") ;;
    #     n*|N*)
    #         echo "Skip this step, not change your shell to zsh"
    #         return ;;
    #     *)
    #         echo "Invalid choice. Shell change skiped."
    #         return ;;
    # esac

    if [ -f /etc/shells ]; then
        shells_file=/etc/shells
    else
        error_exit "could not find /etc/shells. Change your shell manually"
    fi

    # check zsh command exist again
    # if zsh command exist, but not in /etc/shells
    if ! zsh=$(command -v zsh) || ! zsh=$(grep '^/.*/zsh' "$shells_file" | tail -n 1); then
        fmt_warning "could not find zsh binary file"
        fmt_warning "Please change your shell manually."
        return
    fi

    echo "Changing your shell to $zsh..."
    sudo -k chsh -s "$zsh" "$USER"
    # Check if the shell change was successful
    if [ $? -ne 0 ]; then
        fmt_warning "chsh zsh unsuccessful. Change your default shell manually."
    else
        export SHELL="$zsh"
        fmt_msg_green "Shell successful changed to $zsh"
    fi

}


exec_update_zsh()
{
	echo_title "update zsh"
    if ! command_exists zsh; then
		error_exit "you must install zsh first."
	else
		pkg_update_wrapper zsh
		fmt_success "update zsh finish"
	fi
}

exec_update_ohmyzsh()
{
	echo_title "update oh-my-zsh"
	fmt_warning "Please update oh-my-zsh manually"
	fmt_info "1. make sure you are in zsh"
	fmt_info "2. run 'omz update'"
}

append_task_to_init "zsh"
append_task_to_init "ohmyzsh"
