# reverseme
A quick reference script that can easily display reverse shells for different languages. \
This script can also spawn a netcat listener at the same time.

# Installation
chmod reverseme.sh 

Edit script with favorite editor and change IP variable to attack-IP and PORT variable to attack-port. \
Script was tested in gnome enviornment on a Debian system. Desired terminal can be set in script as well.

# Usage
./reverseme.sh [argument]

reverseme.sh -r [rhost] -l [lport] -s [reverse-shell-selection] (OPTIONAL) -L [spawn-nc-listener]

reverseme.sh -h Displays help menu

reverseme.sh -S Displays source information

reverseme.sh -V Displays version information
