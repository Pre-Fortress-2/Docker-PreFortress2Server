#!/usr/bin/env bash
# Updates Pre-Fortress 2.

FILE=/sdk/pf2
if test -f "$FILE"; then
    echo "$FILE exists."
	cd sdk/pf2
	echo "Updating game."
	git pull
	if [ $? -ne 0 ]; then
		echo "Failed to pull repo"
		exit 1
	fi
else 
	echo "Downloading game."
	cd sdk
	# Repo cannot be cloned, do not try.
	git clone https://github.com/Pre-Fortress-2/pf2.git
	if [ $? -ne 0 ]; then
		echo "Failed to clone repo"
		exit 1
	fi
	
	echo "Removing redundant C++ binary"
	rm ./sdk/bin/libstdc++.so.6

fi

echo "Install complete, exiting."
exit 0
