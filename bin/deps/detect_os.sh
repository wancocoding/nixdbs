#!/bin/bash

# ==================================
# Detect OS Information
# ==================================

OS=`uname -s`
OS_MACH=`uname -m`
OS_KERNEL=`uname -r`


OS_PSEUDONAME=""
OS_REV=""

detect_os(){
    echo_title "Detect you OS infomation"

    if [ "${OS}" = "Linux" ] ; then
        OS_KERNEL=$(uname -r)
        if [ -f /etc/gentoo-release ] ; then
	    OS_DIST='Gentoo'
            OS_REV=`awk '{print $5}' /etc/gentoo-release`
        elif [ -f /etc/redhat-release ] ; then
            OS_DIST='RedHat'
            OS_PSEUDONAME=$(sed s/.*\(// < /etc/redhat-release | sed s/\)//)
            OS_REV=$(sed s/.*release\ // < /etc/redhat-release | sed s/\ .*//)
        elif [ -f /etc/SuSE-release ] ; then
            OS_DIST='SuSe'
            # OS_DIST=$(tr "\n" ' ' < /etc/SuSE-release | sed s/VERSION.*//)
            OS_PSEUDONAME=`cat /etc/SuSE-release | tr "\n" ' '| sed s/VERSION.*//`
            OS_REV=`cat /etc/SuSE-release | tr "\n" ' ' | sed s/.*=\ //`
        # elif [ -f /etc/mandrake-release ] ; then
        #     OS_DIST='Mandrake'
        #     OS_PSEUDONAME=`cat /etc/mandrake-release | sed s/.*\(// | sed s/\)//`
        #     OS_REV=`cat /etc/mandrake-release | sed s/.*release\ // | sed s/\ .*//`
        #     PACKAGE_INSTALL_CMD='dnf -y install'
        #     # OS_PSEUDONAME=$(sed s/.*\(// < /etc/mandrake-release | sed s/\)//)
        #     # OS_REV=$(sed s/.*release\ // < /etc/mandrake-release | sed s/\ .*//)
        elif [ -f /etc/debian_version ] ; then	
            # if [ "$(awk -F= '/DISTRIB_ID/ {print $2}' /etc/lsb-release)" = "Ubuntu" ]; then
            if [ -f /etc/lsb-release ] ; then
                OS_DIST=`cat /etc/lsb-release | grep '^DISTRIB_ID' | awk -F=  '{ print $2 }'`
                OS_PSEUDONAME=`cat /etc/lsb-release | grep '^DISTRIB_CODENAME' | awk -F=  '{ print $2 }'`
                OS_REV=`cat /etc/lsb-release | grep '^DISTRIB_RELEASE' | awk -F=  '{ print $2 }'`
            else
                fmt_warning "Can not recognize your debain distribute"
                error_exit
            fi
        elif [ -f /etc/arch-release ] ; then
            OS_DIST="Arch"
        elif [ -f /etc/manjaro-release ] ; then
            OS_DIST="Manjaro"
        elif [ -f /etc/alpine-release ] ; then
            OS_DIST="Alpine"
            OS_REV=`cat /etc/alpine-release`
        fi
        if [ -f /etc/UnitedLinux-release ] ; then
            # OS_DIST="${DIST}[$(tr "\n" ' ' < /etc/UnitedLinux-release | sed s/VERSION.*//)]"
            fmt_warning "Not sure your system is supported!"
            error_exit
        fi
        OS_INFO="${OS} ${OS_DIST} ${OS_REV}(${OS_PSEUDONAME} ${OS_KERNEL} ${OS_MACH})"
    elif [ "${OS}" == "Darwin" ]; then
        OS_DIST="OSX"
        type -p sw_vers &>/dev/null
        [ $? -eq 0 ] && {
            OS=`sw_vers | grep 'ProductName' | cut -f 2`
            OS_REV=`sw_vers | grep 'ProductVersion' | cut -f 2`
            OS_BUILD=`sw_vers | grep 'BuildVersion' | cut -f 2`
            OS_INFO="${OS} ${OS_DIST} ${OS_REV} ${OS_BUILD}"
        } || {
            OS_INFO="MacOSX"
        }
    else
        echo "Your Operation System not supported!!"
        error_exit
    fi
    # lowcase_os_dist="${OS_DIST,,}"
    OSNAME_LOWERCASE=$(echo $OS_DIST | awk '{print tolower($0)}')
    echo "Your system information:"
    echo -e "  Marchine:            ${OS}"
    echo -e "  Dist:                ${OS_DIST}"
    echo -e "  Version:             ${OS_REV}"
    echo -e "  Architecture:        ${OS_MACH}"
    echo -e "  Kernel:              ${OS_KERNEL}"
    echo ${OS_INFO}
    fmt_success "Detect OS success"
}

detect_os

