#!/bin/bash

# filename: create_application.sh
# author: @leodrivera


echo "Script for transforming a script into an application in Ubuntu"

read -p "Insert appliation's name: "  name
read -p "Insert appliation's version: " version
read -p "Insert the application's path: " app_path
read -p "Insert application icon's path: " icon_path
read -p "Insert appliation's comment: " comment

#Get the name in lowercase
name_lower=$(echo "$name" | tr '[:upper:]' '[:lower:]')


sudo tee "/usr/share/applications/$name_lower.desktop" << EOF > /dev/null
[Desktop Entry]
Name=$name_lower
Version=$version
Type=Application
Exec=$app_path
Icon=$icon_path
Comment=$comment
Terminal=false
EOF