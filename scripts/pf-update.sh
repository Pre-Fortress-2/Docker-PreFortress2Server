#!/usr/bin/env bash
# Updates Pre-Fortress 2.

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
	echo $FILE
	if [[ $FILE == *"full"* ]]
	then
  		PF2=$FILE
	else
		if [[ $FILE == *".7z"* ]]
		then
			rm -f $FILE
		fi
	fi
done

7za x -y $PF2
cd ..

echo "Removing redundant C++ binary"
rm ./sdk/bin/libstdc++.so.6

echo "Install complete, exiting."
exit 0
