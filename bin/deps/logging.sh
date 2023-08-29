#!/bin/bash

# print message with color
fmt_msg_red() {
    printf "%s%s%s\n" "${FMT_BOLD}${FMT_RED}" "$*" "${FMT_RESET}"
}
fmt_msg_green() {
    printf "%s%s%s\n" "${FMT_BOLD}${FMT_GREEN}" "$*" "${FMT_RESET}"
}
fmt_msg_yellow() {
    printf "%s%s%s\n" "${FMT_BOLD}${FMT_YELLOW}" "$*" "${FMT_RESET}"
}
fmt_msg_blue() {
    printf "%s%s%s\n" "${FMT_BOLD}${FMT_BLUE}" "$*" "${FMT_RESET}"
}
fmt_msg_underline() {
    printf "%s%s%s\n" "${FMT_UNDERLINE}" "$*" "${FMT_RESET}"
}

# logger functions
fmt_info() {
    printf "%s[INFO]:%s %s\n" "${FMT_BOLD}${FMT_BLUE}" "${FMT_RESET}" "$*"
}
fmt_error() {
    printf "%s[ERROR]:%s %s\n" "${FMT_BOLD}${FMT_RED}" "${FMT_RESET}" "$*" >&2
}

fmt_warning() {
    printf "%s[WARNING]:%s %s\n" "${FMT_BOLD}${FMT_YELLOW}" "${FMT_RESET}" "$*"
}

fmt_success() {
    printf "%s[SUCCESS]%s %s\n" "${FMT_BOLD}${FMT_GREEN}" "$FMT_RESET" "$*"
}

fmt_cmd() {
    printf "%s[CMD]:%s %s\n" "${FMT_BOLD}${FMT_YELLOW}" "${FMT_RESET}" "$*"
}

echo_title() {
    printf "%s===============================================%s\n" \
        "${FMT_BOLD}${FMT_BLUE}" "$FMT_RESET"
    printf "%s%s%s\n" "${FMT_BOLD}${FMT_BLUE}" "$*" "$FMT_RESET"
    printf "%s===============================================%s\n" \
        "${FMT_BOLD}${FMT_BLUE}" "$FMT_RESET"
}

# exit functions
abort_exit() {
    printf "%s\n" "$@"
    exit 1
}

error_exit() {
    fmt_msg_red "$*"
    # remove temp file
    rm -rf $TMP_FILE &>/dev/null
    exit 1
}

finish_exit() {
    rm -rf $TMP_FILE &>/dev/null
    exit 0
}

printf "=== Output color palette %s%s[Blue] %s[Yellow] %s[Red] %s[Green] %s ===\n" \
    "$FMT_BOLD" "$FMT_BLUE" "$FMT_YELLOW" "$FMT_RED" "$FMT_GREEN" "$FMT_RESET"
