# reverseme
A quick reference script that can easily display reverse shells for different languages. \
This script can also spawn a netcat listener at the same time.

# Installation
chmod reverseme.sh 

# Usage
./reverseme.sh [argument]

reverseme.sh -H [host] -L [lport] -S [reverse-shell-selection] (OPTIONAL) -l [spawn-nc-listener]

reverseme.sh -h Displays help menu

reverseme.sh -d Displays list of available shells

reverseme.sh -s Displays source information

reverseme.sh -V Displays version information

# Notice
If you use the -l flag to spawn a netcat listener, the terminal shell is set to use gnome-terminal. If you use a different terminal, you will need to edit the command in the spawn_listener function.
