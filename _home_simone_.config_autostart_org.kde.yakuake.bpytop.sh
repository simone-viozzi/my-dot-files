 
#!/bin/sh

exec yakuake &
sleep 1

# qdbus org.kde.yakuake /yakuake/sessions addSession 
qdbus org.kde.yakuake /yakuake/sessions runCommand bpytop
