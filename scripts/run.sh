#!/usr/bin/env bash
# Runs the server itself. Configure any server specific settings here.
# Also updates the server whenever the server shuts down cleanly.
while :
do
	echo "Updating SDK."
	until steamcmd +runscript ./sdk-update.txt
	do
		echo "Failed to update SDK. Trying again in a five seconds."
		sleep 5
	done
	echo "SDK update finished."
	
	echo "Updating Pre-Fortress 2."
	until ./pf-update.sh
	do
		echo "Failed to update Pre-Fortress 2. Trying again in a five seconds."
		sleep 5
	done

	echo "Removing redundant C++ binary"
	rm ./sdk/bin/libstdc++.so.6

	echo "Pre-Fortress 2 update finished."

	echo "Starting Server."
	./sdk/srcds_run -console -game pf2 \
		-secure -timeout 0 -nobreakpad -exec autoexec
	EXITCODE=$?
	if [$EXITCODE -eq 1] || [$EXITCODE -eq 130]; then
		echo "Something went wrong, the server may have crashed."
		echo "Please check the logs before starting back up."
		exit 1
	fi
	echo "Server exited."
done
