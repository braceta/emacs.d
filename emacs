#!/bin/bash


EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs
EMACSCLIENT="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -c -n"
OSXEMACSOPEN="open -a Emacs"
#EMACSPID=$(ps aux | grep Emacs.app | awk '{print $2}')
EMACSPID=$(ps aux | grep Emacs.app | grep -v grep | awk '{print $2}')

if [ $# -gt 0 ] # has args?
	then
		if [ -e $1 ]; then  # File exists?
			$EMACSCLIENT $* 2>/dev/null 
			if [ $? -ne 0 ]; then
				$OSXEMACSOPEN $*
			fi
		else # File does not exists
			if [ -n "$EMACSPID" ] ; then
				#echo "Emacs is running: $EMACSPID"
				$EMACSCLIENT $* &	
				# Bring window to front
				osascript -e 'tell application "Emacs" to activate'
			else
				#echo "Emacs not running, starting a new one"
				$EMACS $* &
			fi
		fi
else # no args
	$OSXEMACSOPEN
fi

# Bring window to front
#osascript -e 'tell application "Emacs" to activate'


#EMACSCLIENT="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -c -n -a /Applications/Emacs.app/Contents/MacOS/Emacs"

# Run emacs client
#$EMACSCLIENT $* 2>/dev/null & 

# Bring window to front
#osascript -e 'tell application "Emacs" to activate'

