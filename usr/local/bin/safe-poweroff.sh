#! /bin/bash

echo "poweroff script!"

wall "System will go down in 5 minutes, use 'sc-stop safe-poweroff' to stop it."

sleep 300

debug=false

if [ "$debug" = true ]; then
	dryrun="--dry-run"
else
	dryrun=""
fi

for i in {0..5}; do
	echo "tryng to poweroff $i"
	# useful for debug
	if systemd-inhibit --list --no-pager --no-legend | grep -q "shutdown"; then
		echo "there is an inibithor!"
		sleep 600
	else
		systemctl poweroff --check-inhibitors=no $dryrun
		echo "poweroff done correctly"
		exit 0
	fi
done

echo "i'm done waiting, die."
systemctl poweroff --check-inhibitors=no $dryrun
