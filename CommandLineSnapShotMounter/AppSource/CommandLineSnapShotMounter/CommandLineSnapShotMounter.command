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
echo "                                Welcome $nameh "
echo " "
echo "                 Type A to Mount Snapshot "
echo "                 Type B to Install kext, Frameworks, PrivateFrameworks "
echo "                 Type X to quit  "
echo "                                                 "
echo "                 A - MOUNT SNAPSHOT - "
echo "                 B - INSTALL KEXT, FRAMEWORKS, PRIVATEFRAMEWORKS - "
echo "                 X - QUIT PROGRAM - "
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
echo "`tput setaf 7``tput sgr0``tput bold``tput setaf 26`Root access! Type your pasword: `tput sgr0` `tput setaf 7``tput sgr0`"
echo " "
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
echo "Command Line Install binary"
# Vars
SLEDir="/System/Volumes/Update/mnt1/System/Library/Extensions/"
TempDir="/Private/tmp/Install"
FDir="/System/Volumes/Update/mnt1/System/Library/Frameworks/"
FTempDir="/Private/tmp/InstallF"
PFDir="/System/Volumes/Update/mnt1/System/Library/PrivateFrameworks/"
PFTempDir="/Private/tmp/InstallPF"
BUSLEDir="$HOME/Desktop/BackupKext_SLE"
BUSLFDir="$HOME/Desktop/BackupKext_SLF"
BUSLPFDir="$HOME/Desktop/BackupKext_SLPF"
echo " "
if [ "/Private/tmp/Install" ]; then
    rm -rf "/Private/tmp/Install"
fi

if [ "/Private/tmp/InstallF" ]; then
    rm -rf "/Private/tmp/InstallF"
fi

if [ "/Private/tmp/InstallPF" ]; then
    rm -rf "/Private/tmp/InstallPF"
fi
echo "
******************************************************
Command Line Install Binary ➤ Start
******************************************************"

read -p "Would you like to install Frameworks? (Y or N)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
mkdir -p "${FTempDir}"
echo  "  "
echo "`tput setaf 7``tput sgr0``tput bold``tput setaf 10`Please select your Frameworks files`tput sgr0` `tput setaf 7``tput sgr0`"
# Set Droping directory and file
osascript <<EOD
set ThePath to POSIX file "/Private/tmp/InstallF"
display dialog "Please choose Frameworks files" buttons {"Select"} with icon note default button 1
set theFiles to choose folder with prompt "Choose files" default location (path to desktop folder) with multiple selections allowed
tell application "Finder"
    
    duplicate theFiles to ThePath with replacing
end tell
EOD
echo "Prepare Installation for:"
for file in "${FTempDir}"/*;
do
echo "${file##*/}"
done
Sleep 1
echo "Verifying Frameworks for /System/Library/Frameworks/:"
if [ -e "${3}/System/Volumes/Update/mnt1/System/Library/Frameworks/${file##*/}"  ]; then
echo "Find ${file##*/} ➣ Save Frameworks for (SLF)"
mkdir -p ~/Desktop/BackupKext_SLF
for file in "${FTempDir}"/*;
do
Sleep 3
rsync -ab "${FTempDir}"/${file##*/} "$BUSLFDir";
Sleep 3
done
fi
echo "OK for Frameworks "
mv ~/Desktop/BackupKext_SLF ~/Desktop/BackupKext_SLF`date "+%Y%m%d_%H%M%S"`
Sleep 1
sudo cp -R /Private/tmp/InstallF/*.framework "${FDir}"
fi
Sleep 1
read -p "Would you like to install PrivateFrameworks? (Y or N)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
mkdir -p "${PFTempDir}"
echo  "  "
echo "`tput setaf 7``tput sgr0``tput bold``tput setaf 10`Please select your PrivateFrameworks files`tput sgr0` `tput setaf 7``tput sgr0`"
# Set Droping directory and file
osascript <<EOD
set ThePath to POSIX file "/Private/tmp/InstallPF"
display dialog "Please choose PrivateFrameworks files" buttons {"Select"} with icon note default button 1
set theFiles to choose folder with prompt "Choose files" default location (path to desktop folder) with multiple selections allowed
tell application "Finder"
    
    duplicate theFiles to ThePath with replacing
end tell
EOD
echo "Prepare Installation for:"
for file in "${PFTempDir}"/*;
do
echo "${file##*/}"
done
Sleep 1
echo "Verifying Frameworks for /System/Library/PrivateFrameworks/:"
if [ -e "${3}/System/Volumes/Update/mnt1/System/Library/PrivateFrameworks/${file##*/}"  ]; then
echo "Find ${file##*/} ➣ Save PrivateFrameworks for (SLPF)"
mkdir -p ~/Desktop/BackupKext_SLPF
for file in "${PFTempDir}"/*;
do
Sleep 3
rsync -ab "${PFTempDir}"/${file##*/} "$BUSLPFDir";
Sleep 3
mv ~/Desktop/BackupKext_SLPF ~/Desktop/BackupKext_SLPF`date "+%Y%m%d_%H%M%S"`
Sleep 1
sudo cp -R /Private/tmp/InstallPF/*.framework "${PFDir}"
done
fi
echo "OK for PrivateFrameworks "
fi
Sleep 1
read -p "Would you like to install Kext? (Y or N)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
mkdir -p "${TempDir}"
echo  "  "
echo "`tput setaf 7``tput sgr0``tput bold``tput setaf 10`Please select your kexts files`tput sgr0` `tput setaf 7``tput sgr0`"
# Set Droping directory and file
osascript <<EOD
set ThePath to POSIX file "/Private/tmp/Install"
display dialog "Please choose kexts files" buttons {"Select"} with icon note default button 1
set theFiles to choose file with prompt "Choose files" default location (path to desktop folder) with multiple selections allowed
tell application "Finder"
    
    duplicate theFiles to ThePath with replacing
end tell
EOD
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
Sleep 3
done
fi
echo "OK for Kext"
mv ~/Desktop/BackupKext_SLE ~/Desktop/BackupKext_SLE`date "+%Y%m%d_%H%M%S"`
Sleep 1
sudo cp -R /Private/tmp/Install/* "${SLEDir}"
fi

Sleep 1
echo "`tput setaf 7``tput sgr0``tput bold``tput setaf 26`Kext Cache repair! Please wait. .`tput sgr0` `tput setaf 7``tput sgr0`"
sudo chown -R root:wheel /System/Volumes/Update/mnt1/System/Library/Extensions
sudo chmod -R 755 /System/Volumes/Update/mnt1/System/Library/Extensions
sudo kmutil install --volume-root /System/Volumes/Update/mnt1/ --update-all
sudo bless --folder /System/Volumes/Update/mnt1/System/Library/CoreServices --bootefi --create-snapshot
Sleep 1
diskutil unmount /System/Volumes/Update/mnt1
echo "`tput setaf 7``tput sgr0``tput bold``tput setaf 10`Done! Reboot your Mac`tput sgr0` `tput setaf 7``tput sgr0`"
Sleep 1
sudo rm -rf /Private/tmp/Install
sudo rm -rf /Private/tmp/InstallF
sudo rm -rf /Private/tmp/InstallPF
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
