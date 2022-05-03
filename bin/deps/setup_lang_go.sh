#!/usr/bin/env bash

install_gvm()
{
	if [ ! -d $HOME/.gvm ] && [ ! -f $HOME/.gvm/scripts/gvm ]; then
		local gvm_install_script="https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer"
		curl_wrapper -fsSL $gvm_install_script | bash
	fi
	[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
}

install_default_go()
{
	# gvm install $GOLANG_DEFAULT_VERSION
	# gvm list
    local os_type=$(uname | awk '{print tolower($0)}')
	if [ $os_type = 'darwin' ] || [ $os_type = 'linux' ]; then
		local os_arch_text=`uname -m`
		local os_arch="amd64"
		case "$(uname -m)" in
			'i386' | 'i686')
				os_arch='386'
				;;
			'amd64' | 'x86_64')
				os_arch='amd64'
				;;
			# 'armv5tel')
			#     os_type='arm32-v5'
			#     ;;
			'armv6l')
				os_arch='arm6l'
				# grep Features /proc/cpuinfo | grep -qw 'vfp' || os_type='arm32-v5'
				;;
			# 'armv7' | 'armv7l')
			#     os_type='arm32-v7a'
			#     grep Features /proc/cpuinfo | grep -qw 'vfp' || os_type='arm32-v5'
			#     ;;
			'armv8' | 'aarch64')
				os_arch='arm64'
				;;
			*)
				error_exit "Sorry! your cpu architecture is not supported!"
				;;
		esac
		local dl_filename="${GOLANG_DEFAULT_VERSION}.${os_type}-${os_arch}.tar.gz"
		local go_download_url="https://go.dev/dl/${dl_filename}"
		local dl_file_full_path="$HOME/.cache/nixdbs/download/${dl_filename}" 
		local install_full_path="$HOME/.local/lib/go/versions/${GOLANG_DEFAULT_VERSION}"
		local link_source_path="${install_full_path}/go"
		local link_dest_path="$HOME/.local/lib/go/current"
		fmt_info "the download url is ${go_download_url}"
		mkdir -p $HOME/.cache/nixdbs/download
		if [ ! -f $dl_file_full_path ]; then
			curl_wrapper -o "${dl_file_full_path}" -L $go_download_url 
		fi
		# install go
		if [ ! -d $install_full_path ]; then
			fmt_info "install golang to $HOME/.local/lib/go"
			mkdir -p $install_full_path
			tar -C $install_full_path -xzf "${dl_file_full_path}"
		else
			fmt_info "golang version ${GOLANG_DEFAULT_VERSION} already installed"
		fi
		rm -rf "$link_dest_path" >/dev/null 2>&1
		ln -s "$link_source_path" "$link_dest_path"
	else
		error_exit "Your machine not support now!"
	fi

}

setup_go_proxy()
{
	mkdir -p $HOME/.config/go
	echo "GO111MODULE=on" > $HOME/.config/go/env
	echo "GOPROXY=https://mirrors.aliyun.com/goproxy/,https://goproxy.cn,direct" >> $HOME/.config/go/env
}

setup_go_path()
{
	mkdir -p $HOME/.local/go > /dev/null 2>&1
	if [ -f $HOME/.zshrc ]; then
		if ! grep -q "GOPATH" $HOME/.zshrc ;then
			echo "" >> $HOME/.zshrc
			echo "# ====== Golang ======" >> $HOME/.zshrc
			echo 'export PATH=$HOME/.local/lib/go/current/bin:$PATH' >> $HOME/.zshrc
			echo '# global gopath' >> $HOME/.zshrc
			echo 'export GOPATH=$HOME/.local/go' >> $HOME/.zshrc
		fi
	fi

	if [ -f $HOME/.bashrc ]; then
		if ! grep -q "GOPATH" $HOME/.bashrc ;then
			echo "" >> $HOME/.bashrc
			echo "# ====== Golang ======" >> $HOME/.bashrc
			echo 'export PATH=$HOME/.local/lib/go/current/bin:$PATH' >> $HOME/.bashrc
			echo '# global gopath' >> $HOME/.bashrc
			echo 'export GOPATH=$HOME/.local/go' >> $HOME/.bashrc
		fi
	fi
}

setup_go_kits()
{
	echo_title "Setup Golang"

	local script_http_proxy=$(get_http_proxy)
	if [ ! -z "${script_http_proxy:-}" ]; then
		export http_proxy="$script_http_proxy"
	fi

	# Deprecated
	# install_gvm

	install_default_go

	setup_go_proxy

	setup_go_path

	unset http_proxy

	fmt_success "Setup Golang finish!"
}


append_step "setup_go_kits"
