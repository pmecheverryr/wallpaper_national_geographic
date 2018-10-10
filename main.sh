#!/bin/bash
# Copyright (c) 2018 Pedro Mauricio Echeverry Rey. All Rights Reserved
# pedromauricioecheverry@gmail.com
# Last update 2018-10-09
# Scrit bash para actualizar imagen del dia de la National Geographic

# verificar conexion a la red
STATE_CONNECTION=false
wget -q --spider http://google.com
if [ $? -eq 0 ]; then
    STATE_CONNECTION=true
else
    STATE_CONNECTION=false
fi

if STATE_CONNECTION=true; then
    WALLPAPERS="wallpapers"
    DATE=$(date +"%Y%m%d")
    ROUTE="$PWD/$WALLPAPERS"
    FILE_NAME="$DATE.jpg"
    FILE="$ROUTE/$FILE_NAME"

    if [ ! -d "${ROUTE}" ] ; then 
        mkdir "${ROUTE}" 
    fi

    FILE_TMP="$(curl https://www.nationalgeographic.com/photography/photo-of-the-day/ -s | grep  '<meta property="og:image" content="' | sed 's/<meta property="og:image" content="//' | sed 's/"\/>$//')"

    curl "$FILE_TMP" > $FILE   

    if [ -f "$FILE" ]
    then
        gsettings set org.gnome.desktop.background picture-uri "file://$FILE"
	#gsettings set org.gnome.desktop.background picture-options "stretched"
	#gsettings set org.gnome.desktop.screensaver picture-options "stretched"
	gsettings set org.gnome.desktop.screensaver picture-uri "file://$FILE"
    fi
fi
