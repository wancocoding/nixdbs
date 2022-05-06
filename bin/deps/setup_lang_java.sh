#!/usr/bin/env bash

install_sdkman()
{
	if [ ! -f "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
		curl_wrapper -s "https://get.sdkman.io" | bash
		# local http_proxy=$(get_http_proxy)
		# if [ ! -z "${http_proxy:-}" ]; then
		#     curl --proxy $http_proxy -s "https://get.sdkman.io" | bash
		# else
		#     curl -s "https://get.sdkman.io" | bash
		# fi
	fi
	# sdkman script not set -eu, it's sucks
	set +eu
	source "$HOME/.sdkman/bin/sdkman-init.sh"
	# show sdkman version
	sdk version
	set -eu
}

install_jdk()
{
	set +eu
	# set http proxy
	use_http_proxy_by_setting "install_jdk_use_proxy"

	sdk install java "$JDK_DEFAULT_VERSION"
	sdk default java "$JDK_DEFAULT_VERSION"
	sdk install gradle "$GRADLE_DEFAULT_VERSION"
	sdk default gradle "$GRADLE_DEFAULT_VERSION"
	sdk current

	unset_http_proxy
	set -eu
}

setup_java_kits()
{
	echo_title "Setup JDK and Gradle"
	install_sdkman
	install_jdk
	fmt_success "Setup JDK and Gradle finish!"
}

append_step "setup_java_kits"
