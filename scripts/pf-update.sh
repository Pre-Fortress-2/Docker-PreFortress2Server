#!/usr/bin/env bash
# Updates Pre-Fortress 2.

download_game() {
	echo "Downloading game."

	cd sdk
	curl https://archive.prefortress.com/latest/version.txt > ./version.txt
	
	echo "Removing any leftover game files."
	rm -f latest.tar.gz

	# Downloads latest tarball from the latest archive.
	curl -L https://archive.prefortress.com/latest/latest.tar.gz -o ./latest.tar.gz

	tar -xzf latest.tar.gz
	cd ..
}

if [ -d "./sdk/pf2/" ]; then
	if [ -f "./sdk/version.txt" ]; then
		content=$(curl https://archive.prefortress.com/latest/version.txt)
		if grep -Fxq "$content" ./sdk/version.txt; then
			echo "Matching version, no need to update."
		else
			echo "Update Detected."
			download_game
		fi
	else
		echo "No verbose version text detected."
		download_game
    fi
else
	echo "No PF2 Installation exists."
	download_game
fi

echo "Install complete, exiting."