#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

#2019-10-21 - Script adapted for use with MiSTer FPGA project (http://misterfpga.org) by MiSterAddons (https://misteraddons.com)

## @fn printMsgs()
## @param type style of display to use - dialog, console or heading
## @param message string or array of messages to display
## @brief Prints messages in a variety of ways.
function printMsgs() {
	local type="$1"
	shift
	if [[ "$__nodialog" == "1" && "$type" == "dialog" ]]; then
		type="console"
	fi
	for msg in "$@"; do
		[[ "$type" == "dialog" ]] && dialog --backtitle "$__backtitle" --cr-wrap --no-collapse --msgbox "$msg" 20 60 1>&2
		[[ "$type" == "console" ]] && echo -e "$msg"
		[[ "$type" == "heading" ]] && echo -e "\n= = = = = = = = = = = = = = = = = = = = =\n$msg\n= = = = = = = = = = = = = = = = = = = = =\n"
	done
	return 0
}

function _set_interface_wifi() {
	local state="$1"

	if [[ "$state" == "up" ]]; then
		if ! ifup wlan0; then
			ip link set wlan0 up
		fi
	elif [[ "$state" == "down" ]]; then
		if ! ifdown wlan0; then
			ip link set wlan0 down
		fi
	fi
}

function remove_wifi() {
	sed -i '/network={/,/}/d' "/media/fat/linux/wpa_supplicant.conf"
}

function list_wifi() {
	local line
	local essid
	local type
	while read line; do
		[[ "$line" =~ ^Cell && -n "$essid" ]] && echo -e "$essid\n$type"
		[[ "$line" =~ ^ESSID ]] && essid=$(echo "$line" | cut -d\" -f2)
		[[ "$line" == "Encryption key:off" ]] && type="open"
		[[ "$line" == "Encryption key:on" ]] && type="wep"
		[[ "$line" =~ ^IE:.*WPA ]] && type="wpa"
	done < <(iwlist wlan0 scan | grep -o "Cell .*\|ESSID:\".*\"\|IE: .*WPA\|Encryption key:.*")
	echo -e "$essid\n$type"
}

function connect_wifi() {
	if [[ ! -d "/sys/class/net/wlan0/" ]]; then
		printMsgs "dialog" "No wlan0 interface detected"
		return 1
	fi
	dialog --backtitle "$__backtitle" --infobox "\nSearching for WiFi networks......" 5 40 1>&2
	local essids=()
	local essid
	local types=()
	local type
	local options=()
	i=0
	_set_interface_wifi up 2>/dev/null
	sleep 1
	while IFS= read -r essid; read type; do
		essids+=("${essid}")
		types+=("$type")
		options+=("$i" "${essid}")
		((i++))
	done < <(list_wifi)
	options+=("H" "Hidden ESSID")

	local cmd=(dialog --backtitle "$__backtitle" --menu "Please choose the network you would like to connect to" 22 76 16)
	choice=$("${cmd[@]}" "${options[@]}" 3>&1 1>&2 2>&3)
	[[ -z "$choice" ]] && return

	local hidden=0
	if [[ "$choice" == "H" ]]; then
		cmd=(dialog --backtitle "$__backtitle" --inputbox "Please enter the ESSID" 10 60)
		essid=$("${cmd[@]}" 3>&1 1>&2 2>&3)
		[[ -z "$essid" ]] && return
		cmd=(dialog --backtitle "$__backtitle" --nocancel --menu "Please choose the WiFi type" 12 40 6)
		options=(
			wpa "WPA/WPA2"
			wep "WEP"
			open "Open"
		)
		type=$("${cmd[@]}" "${options[@]}" 3>&1 1>&2 2>&3)
		hidden=1
	else
		essid=${essids[choice]}
		type=${types[choice]}
	fi

	if [[ "$type" == "wpa" || "$type" == "wep" ]]; then
		local key=""
		cmd=(dialog --backtitle "$__backtitle" --insecure --passwordbox "Please enter the WiFi key/password for $essid" 10 63)
		local key_ok=0
		while [[ $key_ok -eq 0 ]]; do
			key=$("${cmd[@]}" 3>&1 1>&2 2>&3) || return
			key_ok=1
			if [[ ${#key} -lt 8 || ${#key} -gt 63 ]] && [[ "$type" == "wpa" ]]; then
				printMsgs "dialog" "Password must be between 8 and 63 characters"
				key_ok=0
			fi
			if [[ -z "$key" && $type == "wep" ]]; then
				printMsgs "dialog" "Password cannot be empty"
				key_ok=0
			fi
		done
	fi

	remove_wifi
	create_config_wifi "$type" "$essid" "$key"
	gui_connect_wifi
}

function create_config_wifi() {
	local type="$1"
	local essid="$2"
	local key="$3"

	local wpa_config
	wpa_config+="\tssid=\"$essid\"\n"
	case $type in
		wpa)
			wpa_config+="\tpsk=\"$key\"\n"
			;;
		wep)
			wpa_config+="\tkey_mgmt=NONE\n"
			wpa_config+="\twep_tx_keyidx=0\n"
			wpa_config+="\twep_key0=$key\n"
			;;
		open)
			wpa_config+="\tkey_mgmt=NONE\n"
			;;
	esac

	[[ $hidden -eq 1 ]] &&  wpa_config+="\tscan_ssid=1\n"

	wpa_config=$(echo -e "$wpa_config")
	cat >> "/media/fat/linux/wpa_supplicant.conf" <<_EOF_
network={
$wpa_config
}
_EOF_
}

function gui_connect_wifi() {
	_set_interface_wifi down 2>/dev/null
	_set_interface_wifi up 2>/dev/null
	dialog --backtitle "$__backtitle" --infobox "\nConnecting ..." 5 40 1>&2
	local id=""
	i=0
	while [[ -z "$id" && $i -lt 30 ]]; do
		sleep 1
		id=$(iwgetid -r)
		((i++))
	done
	if [[ -z "$id" ]]; then
		printMsgs "dialog" "Unable to connect to network $essid"
		_set_interface_wifi down 2>/dev/null
	else
		printMsgs "dialog" "Successfully connected to network $essid"
	fi
}

connect_wifi
clear
