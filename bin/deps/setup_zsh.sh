#!/usr/bin/env bash


# ==================================
# Setup zsh
# ==================================
setup_zsh()
{
	echo_title "Setup zsh"
    echo "Install zsh standalone or setup ohmyzsh?"
    echo " (1) zsh with ohmyzsh[recommend]"
    echo " (2) zsh standalone"
    echo " (0) setup zsh manually later!"
    read -p "your choice: > " input_opts
    case $input_opts in
        1)
            install_ohmyzsh
            runzsh
            ;;
        2)
            install_zsh
            runzsh
            ;;
        0)
            echo "Skip zsh setup."
            return
            ;;
        *)
            fmr_warning "Invalid choice, you could setup zsh manually later."
            return
            ;;
    esac
	fmt_success "finish zsh setup."
}

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

install_ohmyzsh()
{
    # see https://github.com/ohmyzsh/ohmyzsh/blob/master/tools/install.sh
    # if ! sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    # then
    #     if [ -n "${REMOTE_PROXY-}" ]; then
    #         echo "use remote proxy you just set!...${REMOTE_PROXY}"
    #         sh -c "$(curl -x ${REMOTE_PROXY} -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    #     elif [ -n "${GITHUB_PROXY-}" ]; then
    #         echo "use github mirror...${GITHUB_PROXY}"
    #         sh -c "$(curl -fsSL ${GITHUB_PROXY}/https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    #     fi
    # fi
    if [ -n "${REMOTE_PROXY-}" ]; then
        echo "use remote proxy you just set!...${REMOTE_PROXY}"
        sh -c "$(curl -x ${REMOTE_PROXY} -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    elif [ -n "${GITHUB_PROXY-}" ]; then
        echo "use github mirror...${GITHUB_PROXY}"
        sh -c "$(curl -fsSL ${GITHUB_PROXY}/https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        error_exit "install ohmyzsh failed, and no available http proxy or github mirror"
    fi
}


install_zsh()
{
    if ! command_exists zsh; then
        # read -p "Do you want to install zsh now: (y|n) [y] >" input_text
        # if [ x"$input_text" == x'y' ]; then
        #     install_pkg zsh
        # else
        #     fmt_warning "Skip install zsh"
        #     return
        # fi
        install_pkg zsh
    else
        echo "zsh already installed!"
    fi
    chsh_zsh
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

    printf "${print_f_yellow}Do you want to change your default shell to zsh now? [y|n] ${print_f_reset}"

    read -r u_opts
    case $u_opts in
        y*|Y*|"") ;;
        n*|N*)
            echo "Skip this step, not change your shell to zsh"
            return ;;
        *)
            echo "Invalid choice. Shell change skiped."
            return ;;
    esac

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
        log_green "Shell successful changed to $zsh"
    fi

}

append_step "setup_zsh"

