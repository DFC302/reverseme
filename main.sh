#!/bin/bash

# source absolute path

function helpMenu() {
	ORG='\033[0;33m'
	RED='\033[0;31m'
	GREEN='\033[0;32m'
	NC='\033[0m'

	echo "reverseme - A quick reference script that can easily display reverse shells for different languages."
    echo "Version: 2.0.0"
    echo ""
    echo "Usage: reverseme --[options]"
    echo "Example usage: reverseme --lhost 10.0.0.2 --lport 4444 --langs perl linux"
    echo -e "${ORG}Warning: lport and lhost both needed FIRST to display reverse shells correctly!${NC}"
    echo -e "${RED}\tWRONG: reverseme --langs bash --lhost 10.0.0.2 --lport 4444${NC}"
    echo -e "${GREEN}\tCORRECT: reverseme --lhost 10.0.0.2 || lport 4444 --langs bash${NC}"
    echo ""
    echo -e "--help\t\t\tDisplays this help menu and exits."
    echo -e "--version\t\tDisplays version and title information."
    echo -e "--list\t\t\tList avaialble languages supported."
    echo -e "--save\t\t\tSave reverse shell to clipboard."
    echo -e "--lport=[port]\t\tProvide a listening port."
    echo -e "--lhost=[IP]\t\tProvide a listening host."
    echo ""
    echo -e "--listener=[ENV]\tSpawn a listener on a specfic lport."
    echo -e "\t\t\t\tgnome"
    echo -e "\t\t\t\txfce"
    echo -e "\t\t\t\t${GREEN}Example: --lport 4444 --listener gnome${NC}"
    echo ""
    echo -e "--langs=[lang]\tLanguage reverse shell is written in."
    echo -e "\t\t\tbash"
    echo -e "\t\t\tawk"
    echo -e "\t\t\tperl [OPTIONAL] linux || windows"
    echo -e "\t\t\tpython [PROTOCOL] tcp || udp || stcp"
    echo -e "\t\t\tphp"
    echo -e "\t\t\truby [OPTIONAL] linux || windows"
    echo -e "\t\t\tnetcat"
    echo -e "\t\t\ttelnet"
    echo -e "\t\t\tsocat"
    echo -e "\t\t\tjava"
    echo ""
}

function display_avail_languages() {
	echo ""
	echo "Supported languages:"
	echo -e "\tbash"
	echo -e "\tawk"
	echo -e "\tperl"
	echo -e "\tpython"
	echo -e "\tphp"
	echo -e "\truby"
	echo -e "\tnetcat"
	echo -e "\ttelnet"
	echo -e "\tsocat"
	echo -e "\tjava"
	echo ""

}

function version() {
	RED='\033[0;31m'
	NC='\033[0m'

	echo -e """\n${RED}
	________                                    ______  ___
	___  __ \_______   ____________________________   |/  /____
	__  /_/ /  _ \_ | / /  _ \_  ___/_  ___/  _ \_  /|_/ /_  _ \\
	_  _, _//  __/_ |/ //  __/  /   _(__  )/  __/  /  / / /  __/
	/_/ |_| \___/_____/ \___//_/    /____/ \___//_/  /_/  \___/

	${NC}"""

	echo -e "${RED}\t\tWritten by:${NC} Matthew Greer"
	echo -e "${RED}\t\tGithub:${NC} https://github.com/DFC302"
	echo -e "${RED}\t\tHTB Profile:${NC} https://www.hackthebox.eu/profile/17842"
	echo -e "${RED}\t\tEmail:${NC} pydev302@gmail.com"
	echo -e "${RED}\t\tVersion:${NC} 2.0.0"
	echo ""
}

function exampleUsage() {
	echo -e "\nExample usage: reverseme --lhost 10.0.0.2 || lport 4444 --bash${NC}"
	echo -e "|| = either or first\n"
}

if [ $# -eq 0 ] ; then
	helpMenu
	exit 0

else

	while [ ! $# -eq 0 ] ; do
		case "$1" in
			--help)
				helpMenu
				exit 0
				;;
			--version)
				version
				exit 0
				;;
			--list)
				display_avail_languages
				exit 0
				;;
			--lhost)
				LHOST=$2
				if [[ ! ${LHOST} =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]] ; then
    				echo "Not a valid IP!"
    				exit 1
    			fi
				;;
			--lport)
				LPORT=$2
				if [[ ! ${LPORT} =~ ^[0-9]{1,5}$ ]] ; then
    				echo "Not a valid port!"
    				exit 1
				fi
				;;
			--langs)
				SEL=${2,,}
				LANGS=(
					"bash"
					"awk"
					"perl"

				)
				if [ -z ${LPORT} ] ; then
					echo "Listening port needed before revese shell language selection"
					exampleUsage
					exit 1
				elif [ -z ${LHOST} ] ; then
					echo "Listening host needed before revese shell language selection"
					exampleUsage
					exit 1
				else
					for lang in "${LANGS[@]}" ; do

						if [[ ${SEL} == "bash" ]] ; then
							bash
							break

						elif [[ ${SEL} == "awk" ]] ; then
							awk
							break

						elif [[ ${SEL} == "perl" ]] ; then
							OS=${3,,}
			 				perl
			 				break

			 			elif [[ ${SEL} == "python" ]] ; then
			 				PROTOCOL=${3,,}
							python
							break

						elif [[ ${SEL} == "php" ]] ; then
							php
							break

						elif [[ ${SEL} == "ruby" ]] ; then
							OS=${3,,}
							ruby
							break

						elif [[ ${SEL} == "netcat" ]] ; then
							netcat
							break

						elif [[ ${SEL} == "telnet" ]] ; then
							telnet
							break

						elif [[ ${SEL} == "socat" ]] ; then
							socat
							break 

						elif [[ ${SEL} == "java" ]] ; then
							java
							break
						fi
					done
				fi
			;;
			
			--listener)
				if [ -z ${LPORT} ] ; then
					echo "Listening port needed for listener!"
					echo -e "Example usage: --lport 4444 --listener xfce || gnome"
					echo -e "|| = either or first"
					exit 1
				fi
				ENV=${2,,}
				listener
				;;
			--save)
				SAVE=True
				;;
		esac
		shift
	done
fi
