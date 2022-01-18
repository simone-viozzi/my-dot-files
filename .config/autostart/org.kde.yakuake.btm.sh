#!/bin/sh

exec yakuake &

sleep 1

#INITIAL_ID=`qdbus org.kde.yakuake /yakuake/sessions org.kde.yakuake.activeSessionId`
#function addSession {
#    SESSION_ID=`qdbus org.kde.yakuake /yakuake/sessions org.kde.yakuake.addSession`
#    qdbus org.kde.yakuake /yakuake/tabs setTabTitle $SESSION_ID "$1"
#    if [ ! -z "$2" ]; then
#        qdbus org.kde.yakuake /yakuake/sessions runCommandInTerminal $SESSION_ID "$2"
#    fi
#}

#addSession "Top" "btm"

#qdbus org.kde.yakuake /yakuake/sessions org.kde.yakuake.removeSession $INITIAL_ID

qdbus org.kde.yakuake /yakuake/sessions runCommand btm
