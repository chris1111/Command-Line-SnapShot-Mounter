#!/bin/sh
# Copyright (c) 2021, chris1111. All Right Reserved
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
# Vars
defaults write com.apple.terminal "Default Window Settings" "Pro"
defaults write com.apple.terminal "Startup Window Settings" "Pro"
printf '\e[8;30;80t'

nameh=`users`
function echob() {
  echo "`tput bold`$1`tput sgr0`"
}

function head
{
clear
echo "          ***************************************************************
                           CommandLine SnapShotMounter"
}
echo " "

function menu
{
echo " "
echo "                                   Welcome $nameh "
echo " "
echo "                                Type A to Mount Snapshot "
echo "                                Type B to Install kext files "
echo "                                Type X to quit  "
echo "                                                 "
echo "                                A - MOUNT SNAPSHOT - "
echo "                                B - INSTALL KEXT - "
echo "                                X - QUIT PROGRAM - "
echo "
          ***************************************************************
                 © Copyright 2021 chris1111, All Right Reserved.
          *************************************************************** "

read -n 1 option
}
function COMMAND_LINE_MOUNTER
{
head
echo " "
echo "Command Line SnapShot Mounter"
# Vars
BOLD="\033[1m"
RED="\033[1;31m"
GREEN="\033[1;32m"
BLUE="\033[1;34m"
OFF="\033[m"
echo "Verification SIP"
Sleep 2
function vertifySIP {
    echo -n "Verification SIP..."
    if [[ "$(csrutil status | grep "System Integrity Protection status: disabled." | wc -l)" == "       0" && "$(csrutil status | grep "Filesystem Protections: disabled" | wc -l)" == "       0" ]]; then
        echo ""
osascript -e 'tell app "System Events" to display dialog "SIP is enabled on this system. Please disable the SIP from the bootloader or boot to Recovery HD or an install USB drive, open a new terminal window and enter (csrutil disable), and (csrutil authenticated-root disable) without parentheses.
Once done, reboot into your standard installation of macOS and run this program again." with icon file "System:Library:CoreServices:CoreTypes.bundle:Contents:Resources:FileVaultIcon.icns" buttons {"OK"} default button 1 with title "SnapShot Mounter (Error SIP Enable)"'

osascript -e 'display notification "Program close" sound name "default" with title "'"$apptitle"'" subtitle "SIP Enable"'
echo "Disable the SIP then restart the program!"
exit
        return 1
    fi
    return 0
        
}

vertifySIP

echo "Verification SIP"
Sleep 2
function vertifySIP {
    echo -n "Verification SIP..."
    if [[ "$(csrutil authenticated-root status | grep "System Integrity Protection status: disabled." | wc -l)" == "       0" && "$(csrutil authenticated-root status | grep "Authenticated Root status: disabled" | wc -l)" == "       0" ]]; then
        echo ""
osascript -e 'tell app "System Events" to display dialog "SIP authenticated-root is enabled on this system. Please disable the SIP from the bootloader or boot to Recovery HD or an install USB drive, open a new terminal window and enter (csrutil disable), and (csrutil authenticated-root disable) without parentheses.
Once done, reboot into your standard installation of macOS and run this program again." with icon file "System:Library:CoreServices:CoreTypes.bundle:Contents:Resources:FileVaultIcon.icns" buttons {"OK"} default button 1 with title "SnapShot Mounter (Error SIP authenticated-root Enable)"'

osascript -e 'display notification "Program close" sound name "default" with title "'"$apptitle"'" subtitle "SIP Enable"'
echo "Disable the SIP then restart the program!"
exit
        return 1
    fi
    return 0
        
}

vertifySIP

Sleep 1

echo "———————————————————————————————————————————————————————————————————————"

sudo diskutil list

echo "————————————————————————————————————————————————————————————————————————"
printf "Enter the Number of the partition follow by [ENTER]. (Exemple) ${GREEN}disk4s5${OFF}"

echo "  "

echo "   ===== The choose Partition Will be Mounted as SnapShot disk! =====
————————————————————————————————————————————————————————————————————————"

read -p ": " target
Sleep 1
sudo mount -o nobrowse -t apfs /dev/$target /System/Volumes/Update/mnt1


echo "—————————————————————————————————————————————————————————————————————————"
echo "`tput setaf 7``tput sgr0``tput bold``tput setaf 26`Mounted SnapShot disk. `tput sgr0` `tput setaf 7``tput sgr0`"
Sleep 2
echo "—————————————————————————————————————————————————————————————————————————"
echo "`tput setaf 7``tput sgr0``tput bold``tput setaf 26`Open SnapShot disk. `tput sgr0` `tput setaf 7``tput sgr0`"
echo "—————————————————————————————————————————————————————————————————————————"
echo "`tput setaf 7``tput sgr0``tput bold``tput setaf 26`Successfully Mounted and Open!`tput sgr0` `tput setaf 7``tput sgr0`"
open /System/Volumes/Update/mnt1/
echo " "
}
function COMMAND_KEXT
{
head
echo " "
echo "Command Line Install Kext"
# Vars
SLEDir="/System/Volumes/Update/mnt1/System/Library/Extensions/"
TempDir="/Private/tmp/Install"
BUSLEDir="$HOME/Desktop/BackupKext_SLE"
echo " "
if [ "/Private/tmp/Install" ]; then
    rm -rf "/Private/tmp/Install"
fi
echo "
******************************************************
Command Line Install Kext ➤ Start
******************************************************"
# Set Droping directory and file
mkdir -p "${TempDir}"
echo  "`tput setaf 7``tput sgr0``tput bold``tput setaf 10`Please move your kexts to the window \ Followed by Enter`tput sgr0` `tput setaf 7``tput sgr0`  "
read -p ": " target
cp -R ${target} "${TempDir}"
echo "Prepare Installation for:"
for file in "${TempDir}"/*;
do
echo "${file##*/}"
done
Sleep 1
echo "Verifying Kexts for /System/Library/Extensions/:"
if [ -e "${3}/System/Volumes/Update/mnt1/System/Library/Extensions/${file##*/}"  ]; then
echo "Find ${file##*/} ➣ Save Kext for (SLE)"
mkdir -p ~/Desktop/BackupKext_SLE
for file in "${TempDir}"/*;
do
Sleep 3
rsync -ab "${TempDir}"/${file##*/} "$BUSLEDir";
Sleep 1
done
fi
sudo cp -r /Private/tmp/Install/* "${SLEDir}"
Sleep 1
echo "Kext Cache repair! Please wait. ."
sudo chown -R root:wheel /System/Volumes/Update/mnt1/System/Library/Extensions
sudo chmod -R 755 /System/Volumes/Update/mnt1/System/Library/Extensions
sudo kmutil install --volume-root /System/Volumes/Update/mnt1/ --update-all
sudo bless --folder /System/Volumes/Update/mnt1/System/Library/CoreServices --bootefi --create-snapshot
Sleep 1
diskutil unmount /System/Volumes/Update/mnt1
echo "Done! Reboot your mac"
Sleep 1
mv ~/Desktop/BackupKext_SLE ~/Desktop/BackupKext_SLE`date "+%Y%m%d_%H%M%S"`
sudo rm -rf /Private/tmp/Install
echo " "
echo "`tput setaf 7``tput sgr0``tput bold``tput setaf 26`Succeed kexts installed!`tput sgr0` `tput setaf 7``tput sgr0`"
echo " "
}
function Quit
{
clear
echo " "
echo "
Quit Command Line SnapShot Mounter."

osascript -e 'tell app "terminal" to display dialog "Good By" with icon file "System:Library:CoreServices:loginwindow.app:Contents:Resources:ShutDown.tiff" buttons {"Logout"} default button 1 with title "Command Line SnapShot Mounter"'
echo " "
echob "Good By $hours `tput setaf 7``tput sgr0``tput bold``tput setaf 10`$nameh`tput sgr0` `tput setaf 7``tput sgr0`"
echo " "
exit 0
}
while [ 1 ]
do
head
menu
case $option in

a|A)
echo
COMMAND_LINE_MOUNTER ;;
b|B)
echo
COMMAND_KEXT ;;
x|X)
echo
Quit ;;


*)
echo ""
esac
echo
echob "`tput setaf 7``tput sgr0``tput bold``tput setaf 10`Type any key to return.`tput sgr0` `tput setaf 7``tput sgr0`"
echo
read -n 1 line
clear
done

exit
