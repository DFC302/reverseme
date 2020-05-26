#!/bin/bash

# Place username here
USER=

# Where will reverseme be located at?
# Please use absolute path
# By default, reverseme is installed in the home directory of the specificed user
# It is better to use absolute path because this script will be run by root instead of the local user
DIRECTORY=/home/${USER}/reverseme

# This variable holds the file location for your .bash_aliases
# Use absolute path because this script will be run by root instead of the local user
ALIAS_FILE=/home/${USER}/.bash_aliases

# Default file that bash uses before starting the interactive shell
# By default it is .bashrc
# However, you can change it to any one you like.
# Some newer Ubuntu systems use .profile. If you wish, I have built one for .profile below. Just edit this one out.
SOURCE_FILE=/home/${USER}/.bashrc
#Source_FILE=/home/${USER}/.profile

# Check if user is root
if [[ $EUID -ne 0 ]] ; then
	echo "Please run me as root!"
	exit 1
fi

# Check if user variable is blank
if [ -z ${USER} ] ; then
	echo "User varialbe was left blank. Please add a user!"
	exit 1

fi

# Check if directory variable is blank
if [ -z ${DIRECTORY} ] ; then
	echo "Directory variable was left blank. Please add an absolute path on where reverseme will be installed!."
	exit 1
fi

# Make sure directory variable has /reverseme on the end, with no leading "/"
if [[ ${DIRECTORY} =~ /reverseme/$ ]] ; then
    DIRECTORY=$(echo ${DIRECTORY} | sed 's/\/*$//g')
fi

# Make sure directory exists
if [ ! -d ${DIR} ] ; then
	echo "This directory was not found!"
	echo "Are you sure the correct directory is being used?"
	exit 1

# if directory exists proceed
elif [ -d ${DIR} ] ; then
	if [ ! -f ${ALIAS_FILE} ] ; then
		echo "Alias file: ${ALIAS_FILE} not found. Creating now..."
		touch ${ALIAS_FILE}
		echo "File created!"
	fi

	echo -e "\n# reverseme" >> ${ALIAS_FILE}
	echo -e "alias reverseme='/usr/bin/bash ${DIRECTORY}/main.sh'" >> ${ALIAS_FILE}
	echo -e "\nsource ${DIRECTORY}/reverseme_completion.bash" >> ${SOURCE_FILE}
fi

# source shells.sh script into main.sh for user
sed -i "4i\\. ${DIRECTORY}/shells.sh" main.sh

# If user is using apt package manager, check if xclip is installed.
# If not attempt to install.
echo "Checking if xclip is installed..."
xclip -h > /dev/null 2>&1 \
|| apt install xclip -y ; exit 0

# Let user know install script has finished.
echo "Done. reverseme should be installed on your system now."
echo "Do not forget to source your .bashrc file: source ~/.bashrc"
exit 0
