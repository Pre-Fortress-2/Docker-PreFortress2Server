#!/usr/bin/env bash
# Updates Pre-Fortress 2.

download_game() {
	echo "Downloading game."
	cd sdk

	echo "Removing any leftover game files."
	rm -f *.7z

	# Downloads all .7z files from the latest release.
	curl -s https://api.github.com/repos/Pre-Fortress-2/pf2/releases/latest \
	| grep "browser_download_url.*7z" \
	| cut -d : -f 2,3 \
	| tr -d \" \
	| wget -qi -

	# Removes all .7z files that isn't the full game.
	for FILE in *
	do
		if [[ $FILE == *"full"* ]]; then
			PF2=$FILE
		else
			if [[ $FILE == *".7z"* ]]; then
				rm -f $FILE
			fi
		fi
	done

	7za x -y $PF2
	cd ..
}


# this needs to be updated, its reliant on the old currentVersion.txt system.
# needs to just check the tag from the latest release
# curl https://api.github.com/repos/Pre-Fortress-2/pf2/releases/latest -s | jq .tag_name -r

INSTALL=./sdk/pf2/
if [ -d "$INSTALL" ]; then
	if test -f "./sdk/currentVersion.txt"; then
		content=$(curl https://api.github.com/repos/Pre-Fortress-2/pf2/releases/latest -s | jq .tag_name -r)
		if grep -Fxq "$content" ./sdk/currentVersion.txt; then
			echo "Matching version, no need to update."
		else
			echo "Downloading update."
			curl https://api.github.com/repos/Pre-Fortress-2/pf2/releases/latest -s | jq .tag_name -r > ./sdk/currentVersion.txt
			download_game
		fi
	else
		echo "No verbose version text detected."
		curl https://api.github.com/repos/Pre-Fortress-2/pf2/releases/latest -s | jq .tag_name -r > ./sdk/currentVersion.txt
		download_game
    fi
else
	echo "No PF2 Installation exists."
	curl https://api.github.com/repos/Pre-Fortress-2/pf2/releases/latest -s | jq .tag_name -r > ./sdk/currentVersion.txt
	download_game
fi

echo "Removing redundant C++ binary"
rm ./sdk/bin/libstdc++.so.6

echo "Install complete, exiting."
exit 0
