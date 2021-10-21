#!/bin/bash

# filename: anaconda_script_application.sh
# author: @leodrivera


echo "Script for creating an application in Ubuntu for Anaconda"


sudo tee "/usr/share/applications/anaconda.desktop" << EOF > /dev/null
Name=anaconda
Version=3.0
Type=Application
Exec=/home/$USER/anaconda3/bin/anaconda-navigator
Icon=/home/$USER/anaconda3/lib/python3.8/site-packages/anaconda_navigator/static/images/anaconda-icon-256x256.png
Comment=Open Anaconda Navigator
Terminal=false 
EOF