# reverseme
A quick reference script that can easily display reverse shells for different languages. \
This script can also spawn a netcat listener at the same time.

# Installation
chmod reverseme.sh 

# Usage
./reverseme.sh [argument]

reverseme.sh -r [rhost] -l [lport] -s [reverse-shell-selection] (OPTIONAL) -L [spawn-nc-listener]

reverseme.sh -h Displays help menu

reverseme.sh -S Displays source information

reverseme.sh -V Displays version information

# Notice
If you use the -L flag to spawn a netcat listener, the terminal shell is set to use gnome-terminal. If you use a different terminal, you will need to edit the command in the spawn_listener function.
