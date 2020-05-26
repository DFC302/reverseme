#!/usr/bin/env bash

_reverseme() {
	COMREPLY=()

	cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    next="${COMP_WORDS[COMP_CWORD+1]}"
   
	info_commands="--help \
		--version \
		--langs \
		--lhost \
		--lport \
		--listener \
		--list \
		--save"

	shells="bash \
		awk \
		perl \
		python \
		php \
		ruby \
		netcat \
		telnet \
		socat \
		java"

  	perl_options="linux windows"
  	python_options="tcp udp stcp"
  	ruby_options="linux windows"
  	list_options="gnome xfce"

  	case "${prev}" in
  		--langs)
			COMPREPLY=( $(compgen -W "${shells}" ${cur}) )
			return 0
		;;
		perl)
			COMPREPLY=( $(compgen -W "${perl_options}" ${cur}) )
			return 0	
		;;
		python)
			COMPREPLY=( $(compgen -W "${python_options}" ${cur}) )
			return 0	
		;;
		ruby)
			COMPREPLY=( $(compgen -W "${ruby_options}" ${cur}) )
			return 0	
		;;
		--listener)
			COMPREPLY=( $(compgen -W "${list_options}" ${cur}) )
			return 0
		;;
    esac


    COMPREPLY=($(compgen -W "${info_commands}" -- ${cur}))
   	return 0
}

complete -F _reverseme reverseme