#!/usr/bin/env bash


# install some dev tools like gcc make ninja cmake clangd llvm

exec_install_clang()
{
	echo_title "Setup C and Cpp language development kits"
	fmt_info "checking clang..."
	if ! command_exists clang; then
		fmt_info "install clang"
		pkg_install_wrapper clang
	fi
	fmt_info "checking cmake..."
	if ! command_exists cmake; then
		fmt_info "install cmake"
		pkg_install_wrapper cmake
	fi
	fmt_info "checking ninja..."
	if ! command_exists ninja; then
		fmt_info "install ninja"
		pkg_install_wrapper ninja
	fi
	fmt_info "checking gcc..."
	if ! command_exists gcc; then
		fmt_info "install gcc"
		pkg_install_wrapper gcc
	fi
	fmt_info "checking make..."
	if ! command_exists make; then
		fmt_info "install make"
		pkg_install_wrapper make
	fi
	fmt_info "checking gdb..."
	if ! command_exists gdb; then
		fmt_info "install gdb"
		pkg_install_wrapper gdb
	fi

	fmt_success "Setup C and Cpp language development kits finish!"
}


append_task_to_init "clang"
