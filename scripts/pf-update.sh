#!/usr/bin/env bash
# Updates Pre-Fortress 2.

INSTALL=./sdk/pf2/
if test -f "$INSTALL"; then
    echo "No PF2 Installation exists."
    download_game
    if test -f "currentVersion.txt"; then
    	content=$(curl -L https://raw.githubusercontent.com/Pre-Fortress-2/pf2/main/currentVersion.txt)
    	if grep -Fxq "$content" currentVersion.txt; then
    	    echo "Matching version, no need to update."
	else:
	    echo "Downloading update."
	    curl -L https://raw.githubusercontent.com/Pre-Fortress-2/pf2/main/currentVersion.txt > ./sdk/currentVersion.txt
	    download_game
	fi
    else:
    	echo "No verbose version text detected."
	curl -L https://raw.githubusercontent.com/Pre-Fortress-2/pf2/main/currentVersion.txt -o ./sdk/currentVersion.txt
	download_game
    fi
    	
fi

download_game() {
	echo "Downloading game."
	cd sdk

	# Downloads all .7z files from the latest release.
	curl -s https://api.github.com/repos/Pre-Fortress-2/pf2/releases/latest \
	| grep "browser_download_url.*7z" \
	| cut -d : -f 2,3 \
	| tr -d \" \
	| wget -qi -

	# Removes all .7z files that isn't the full game.
	for FILE in *
	do
		if [[ $FILE == *"full"* ]]
		then
			PF2=$FILE
		else
			if [[ $FILE == *".7z"* ]]
			then
				rm -f $FILE
			f [[ $FILE == *".7z."* ]]
			then
				rm -f $FILE
			fi
		fi
	done

	7za x -y $PF2
	cd ..

}

echo "Removing redundant C++ binary"
rm ./sdk/bin/libstdc++.so.6

echo "Install complete, exiting."
exit 0
