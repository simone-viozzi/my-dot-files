#! /bin/bash

echo "poweroff script!"

wall "System will go down in 10 minutes, use 'sc-stop safe-poweroff' to stop it."

curl -X POST -d '{"tag":"general", "body":"simoserver si spegnera in 10 minuti!\nContatta l amministratore per annullare lo spegnimento"}' \
    -H "Content-Type: application/json" \
    http://localhost:8005/notify/apprise

sleep 600

debug=false

if [ "$debug" = true ]; then
	dryrun="--dry-run"
else
	dryrun=""
fi

for i in {0..5}; do
	echo "tryng to poweroff $i"
	if systemd-inhibit --list --no-pager --no-legend | grep -q "shutdown"; then
		echo "there is an inibithor!"
		sleep 600
	else
		break
	fi
done

curl -X POST -d '{"tag":"general", "body":"simoserver si sta spegnendo!"}' \
    -H "Content-Type: application/json" \
    http://localhost:8005/notify/apprise

sleep 5

systemctl poweroff --check-inhibitors=no $dryrun
echo "poweroff done correctly"

