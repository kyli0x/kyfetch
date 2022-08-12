#!/bin/sh

## created by kyli0x
## https://kyli0x.pw

## colors
	white='[37m'
	bwhite='[1;37m'
	cyan='[1;36m'
	reset='[0m'

## hostname
HOST=$USER@$HOSTNAME${reset}

## os
. /etc/os-release

## kernel
read -r _ _ version _ < /proc/version
kernel=${version%%-*}

## uptime
uptime=$(uptime -p |cut -d' ' -f2-)

## packages 
pkg_total=$(pacman -Q |wc -l)

## wm detection > hardcoded dwm because wmname dwm inside .xinitrc isnt working
id=$(xprop -root -notype _NET_SUPPORTING_WM_CHECK)
id=${id##* }
wm=$(xprop -id "$id" -notype -len 100 -f _NET_WM_NAME 8t |grep '^_NET_WM_NAME' |cut -d\" -f 2)

## output
clear

	printf '%s\n' "
 ${cyan}  kyli0x's system info tool
 ${white}         [kyli0x.pw]

 ${bwhite} host${reset}   :: ${HOST}
 ${bwhite} os${reset}     :: ${PRETTY_NAME}
 ${bwhite} ver${reset}    :: ${kernel}
 ${bwhite} uptime${reset} :: ${uptime}
 ${bwhite} pkgs${reset}   :: ${pkg_total}
 ${bwhite} wm${reset}     :: dwm
"

exit 0
