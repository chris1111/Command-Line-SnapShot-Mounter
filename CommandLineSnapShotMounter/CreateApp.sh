#!/bin/sh
# CommandLineSnapShotMounter
# (c) Copyright 2021 chris1111 
# This will create a Apple Bundle
# Dependencies: osacompile
PARENTDIR=$(dirname "$0")
cd "$PARENTDIR"



# Declare some VARS
APP_NAME="Command Line SnapShot Mounter.app"
SOURCE_SCRIPT="CommandLineSnapShotMounter.applescript"

echo "= = = = = = = = = = = = = = = = = = = = = = = = =  "
echo "Command Line SnapShot Mounter"
echo "= = = = = = = = = = = = = = = = = = = = = = = = =  "

Sleep 2

# Create the dir structure
/usr/bin/osacompile -o "$APP_NAME" "AppSource/$SOURCE_SCRIPT"

# Remove app
rm -rf CommandLineSnapShotMounter/"build/$APP_NAME"

Sleep 1

# Copy Licenses to the right place
cp AppSource/License.TXT "$APP_NAME"/Contents/Resources

# Copy description to the right place
cp -rp AppSource/description.rtfd "$APP_NAME"/Contents/Resources

# Copy Installer to the right place
cp -rp AppSource/CommandLineSnapShotMounter "$APP_NAME"/Contents/Resources

# Copy Info.plist to the right place
cp -rp AppSource/Info.plist "$APP_NAME"/Contents

Sleep 2

# Copy applet to the right place
cp -rp AppSource/applet.icns "$APP_NAME"/Contents/Resources

# Zip app
Sleep 1
zip -r "$APP_NAME".zip "$APP_NAME"
Sleep 1
rm -rf "$APP_NAME"
unzip "$APP_NAME".zip
Sleep 1
rm -rf "$APP_NAME".zip
echo " "

cp -r "$APP_NAME" "build"

Sleep 1
# Remove app
rm -rf "$APP_NAME"

Open "build"

echo " = = = = = = = = = = = = = = = = = = = = = = = = = 
Command Line SnapShot Mounter.app completed
= = = = = = = = = = = = = = = = = = = = = = = = =  "


