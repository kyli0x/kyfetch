#!/bin/sh

## system infomration tool
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

## memory
mem=$(free -m |awk 'FNR==2 {print $6"MiB / "$2"MiB"}')

## cpu
cpu=$(grep -Po 'model name.*: \K.*' /proc/cpuinfo | uniq | sed -E 's/\([^)]+\)//g')

## gpu
gpu=$(lspci |grep -i vga |cut -d' ' -f5-9)

## output
clear

	printf '%s\n' "
 ${cyan}           kyfetch
 ${white}         [kyli0x.pw]

 ${bwhite} host${reset}   :: ${HOST}
 ${bwhite} os${reset}     :: ${PRETTY_NAME}
 ${bwhite} ver${reset}    :: ${kernel}
 ${bwhite} uptime${reset} :: ${uptime}
 ${bwhite} pkgs${reset}   :: ${pkg_total}
 ${bwhite} wm${reset}     :: dwm
 ${bwhite} cpu${reset}    :: ${cpu}
 ${bwhite} gpu${reset}    :: ${gpu}
 ${bwhite} mem${reset}    :: ${mem}
"

exit 0
