#!/bin/sh
# Author: TheElectronWill
# This script downloads the latest version of VisualVM for linux, and creates a package with rpmbuild.

rpm_dir="$PWD/RPMs"

desktop_file="$PWD/visualvm.desktop"
spec_file="$PWD/visualvm.spec"
icon_file="$PWD/visualvm-logo.png"

work_dir="$PWD/work"
downloaded_dir="$work_dir/visualvm_139"

release_version='1.3.9'
release_url='https://github.com/visualvm/visualvm.src/releases/download/1.3.9/visualvm_139.zip'

# It's a bad idea to run rpmbuild as root!
if [ "$(id -u)" = "0" ]; then
	echo '------------------------ WARNING ------------------------'
	echo 'This script should NOT be executed with root privileges!'
	echo 'Building rpm packages as root is dangerous and may harm the system!'
	echo 'Actually, badly written RPM spec files may execute dangerous command in the system directories.'
	echo 'So it is REALLY safer not to run this script as root.'
	echo 'If you still want to run this script as root, type "do it!" within 5 seconds (type anything else to exit):'
	read -t 5 -p 'Do you really want to do it (not recommended)? ' answer
	if [ "$answer" != "do it!" ]; then
		exit
	fi
	echo '------------------------ WARNING ------------------------'
fi

# Checks that rpmbuild is installed.
if ! type 'rpmbuild' > /dev/null; then
	echo 'You need the rpm development tools to create rpm packages.'
	read -n 1 -p 'Do you want to install the rpmdevtools package now? [y/N]' answer
	echo
	case "$answer" in
		y|Y)
			sudo -p 'Enter your password to install rpmdevtools: ' dnf install rpmdevtools
			;;
		*) 
			echo "Ok, I won't install rpmdevtools."
			exit
	esac
else
	echo "rpmbuild detected!"
fi

# Download the visualvm tar.gz archive and puts its name in the global variable archive_name.
download_visualvm() {
	echo 'Downloading VisualVM for linux...'
	wget -q --show-progress "$release_url"
	archive_name='visualvm_139.zip'
}

# Asks the user if they want to remove the specified directory, and removes it if they want to.
ask_remove_dir() {
	read -n 1 -p "Do you want to remove the \"$1\" directory? [y/N]" answer
	echo
	case "$answer" in
		y|Y)
			rm -r "$1"
			echo "\"$1\" directory removed."		
			;;
		*)
			echo "Ok, I won't remove it."
	esac
	echo
}

# If the specified directory exists, asks the user if they want to remove it.
# If it doesn't exist, creates it.
manage_dir() {
	if [ -d "$1" ]; then
		echo "The $2 directory already exist. It may contain outdated data."
		ask_remove_dir "$1"
	fi
	mkdir -p "$1"
}

manage_dir "$work_dir"
manage_dir "$rpm_dir"
cd "$work_dir"

# Downloads visualvm if needed.
archive_name="$(ls *.zip 2>/dev/null)"
if [ $? -eq 0 ]; then
	echo "Found $archive_name"
	read -n 1 -p 'Do you want to use this archive instead of downloading a new one? [y/N]' answer
	echo
	case "$answer" in
		y|Y)
			echo 'Ok, I will use this archive.'
			;;
		*)
			rm "$archive_name"
			download_discord
	esac
else
	download_visualvm
fi


echo
echo 'Extracting the files...'
unzip -q "$archive_name" -d "$work_dir"


echo 'Creating the RPM package (this may take a while)...'
cp "$icon_file" "$downloaded_dir"
cp "$desktop_file" "$work_dir/"
rpmbuild -bb --quiet "$spec_file" --define "_topdir $work_dir" --define "_rpmdir $rpm_dir"\
	--define "downloaded_dir $downloaded_dir" --define "desktop_file $desktop_file"

echo
echo '------------------------- Done! -------------------------'
echo "The RPM package is located in the \"RPMs/x86_64\" folder."
ask_remove_dir "$work_dir"
