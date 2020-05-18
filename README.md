# reverseme
A quick reference script that can easily display reverse shells for different languages. \
This script can also spawn a netcat listener at the same time.

# Installation
chmod 755 reverseme.sh 

# Usage
./reverseme.sh [argument]

reverseme.sh -H [host] -L [lport] -S [reverse-shell-selection] (OPTIONAL) -l [spawn-nc-listener]

reverseme.sh -h Displays help menu

reverseme.sh -d Displays list of available shells

reverseme.sh -s Displays source information

reverseme.sh -V Displays version information

# Notice
If you use the -l flag to spawn a netcat listener, the terminal shell is set to use gnome-terminal. If you use a different terminal, you will need to edit the command in the spawn_listener function.

# Screenshots
![Help Menu](https://github.com/DFC302/reverseme/blob/master/images/help_menu.png)

![Example](https://github.com/DFC302/reverseme/blob/master/images/example.png)

### Useful? Like the project and wanna show support?
<a href="https://www.buymeacoffee.com/dfc302" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>
