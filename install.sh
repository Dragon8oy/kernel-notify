#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $DIR

if ls /usr/bin/git; then
  echo "Git found"
else
  echo "Git not installed, exiting"
  exit
fi
if ls /usr/bin/wget; then
  echo "Wget found"
else
  echo "Wget not installed, exiting"
  exit
fi
if ls /usr/bin/notify-send; then
  echo "Notify-send found"
else
  echo "Notify-send not installed, we strongly recommend installing it for GUI systems"
fi

#Move kernel-notify to /usr/bin/kernel-notify
sudo cp kernel-notify /usr/bin/kernel-notify

#Make /usr/share/kernel-notify and move icon.png to /usr/share/kernel-notify/icon.png
if [ -d "/usr/share/kernel-notify" ]; then
  echo "/usr/share/kernel-notify was found, not creating it"
else
  echo "/usr/share/kernel-notify not found, creating it"
  sudo mkdir /usr/share/kernel-notify
  echo "Created directory"
fi

sudo cp icon.png /usr/share/kernel-notify/icon.png
echo "Added icon"

#Add startup app
if [ -d "/etc/xdg/autostart" ]; then
  echo "/etc/xdg/autostart found"
  sudo cp kernel-notify.desktop /etc/xdg/autostart/kernel-notify.desktop
  sudo cp kernel-notify.desktop /usr/share/kernel-notify/kernel-notify.desktop
else
  echo "/etc/xdg/autostart not found"
  echo "Adding commands for autostart on user login to /etc/profile or /etc/profile.d/"
  if [ -d "/etc/profile.d" ]; then
    sudo cp autostart.sh /etc/profile.d/autostart.sh
  else
    sudo echo "kernel-notify" >> /etc/profile
fi
echo "Added autostart file"

sudo cp updater /usr/share/kernel-notify/updater
echo "Added updater"

sudo rm -rf $DIR
