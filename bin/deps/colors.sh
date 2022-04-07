#!/bin/bash

show_truecolor()
{
    awk 'BEGIN{
	s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
	for (colnum = 0; colnum<77; colnum++) {
	    r = 255-(colnum*255/76);
	    g = (colnum*510/76);
	    b = (colnum*255/76);
	    if (g>255) g = 510-g;
	    printf "\033[48;2;%d;%d;%dm", r,g,b;
	    printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
	    printf "%s\033[0m", substr(s,colnum+1,1);
	}
	printf "\n";
    }' 
}


show_256color()
{
    for color in {0..255} ; do
        printf "\033[38;5;%sm %3s \33[0m" $color $color
        if [ $((($color + 1) % 6)) == 4 ]; then
            echo
        fi
    done
    echo # new line
}

detect_term_color()
{
    # default color is ANSI 16
    #     0 - ANSI 16
    #     1 - 256
    #     2 - turecolor
    echo "checking term color..."
    TERM_COLOR_TYPE=0
    echo # new line
    show_truecolor
    read -p "Can you see the continuous gradient of colors? [y(yes)|n(no)]" user_answ;
    case $user_answ in
        y*|Y*)
	        TERM_COLOR_TYPE=2
            return
            ;;
        *)
            ;;
    esac

    echo
    show_256color
    read -p "Can you see all 256 colors? [y(yes)|n(no)]" user_answ;
    case $user_answ in
        y*|Y*)
	        TERM_COLOR_TYPE=1
            return
	        ;;
        *)
            ;;
    esac
}


detect_term_color_noninteractive()
{
    echo "checking term color..."
    TERM_COLOR_TYPE=1
	case "${COLORTERM:-nt}" in
		truecolor|24bit)
	        TERM_COLOR_TYPE=2
			return 0 ;;
	esac
	case "$TERM" in
		iterm           |\
		tmux-truecolor  |\
		linux-truecolor |\
		xterm-truecolor |\
		screen-truecolor) 
	        TERM_COLOR_TYPE=2
			return 0 ;;
	esac
	return 0

}

print_color_type()
{
    case $TERM_COLOR_TYPE in
        0)
            echo "Your term color type is ANSI 16 color"
            ;;
        1)
            echo "Your term color type is 256 color"
            ;;
        2)
            echo "Your term color type is true color"
            ;;
        *)
            echo "Your term color type is Plain ASCII"
            ;;
    esac
}

setup_color()
{
    # detect_term_color
	detect_term_color_noninteractive
    print_color_type
    FMT_RESET=$(printf '\033[0m')
    FMT_BOLD=$(printf '\033[1m')
    FMT_UNDERLINE=$(printf '\033[4m')
    if [ ! -t 1 ]; then
    	# not tty, no color set
    	  FMT_RED=""
        FMT_BLUE=""
        FMT_GREEN=""
        FMT_YELLOW=""
        FMT_BOLD=""
        FMT_RESET=""
        FMT_UNDERLINE=""
    elif [ $TERM_COLOR_TYPE == 1 ]; then
    	# ture color
    	  FMT_RED=$(printf '\033[38;2;229;28;35m')
        FMT_BLUE=$(printf '\033[38;2;77;208;225m')
        FMT_GREEN=$(printf '\033[38;2;66;189;65m')
        FMT_YELLOW=$(printf '\033[38;2;255;193;7m')
    elif [ $TERM_COLOR_TYPE == 2 ]; then
   	# 256 color 
    	  FMT_RED=$(printf '\033[38;5;198m')
        FMT_BLUE=$(printf '\033[38;5;69m')
        FMT_GREEN=$(printf '\033[38;5;82m')
        FMT_YELLOW=$(printf '\033[38;5;191m')
    else
    	# default
    	  FMT_RED=$(printf '\033[31m')
        FMT_BLUE=$(printf '\033[34m')
        FMT_GREEN=$(printf '\033[32m')
        FMT_YELLOW=$(printf '\033[33m')
    fi
}

setup_color

