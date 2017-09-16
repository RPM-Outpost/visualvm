#!/bin/bash
# Author: TheElectronWill
# This script downloads the latest version of VisualVM for linux, and creates a package with rpmbuild.

source terminal-colors.sh # Adds color variables
source common-functions.sh # Adds utilities functions
source basic-checks.sh # Checks that rpmbuild is available and that the script isn't started as root

rpm_dir="$PWD/RPMs"
release_version='1.3.9'
release_url='https://github.com/visualvm/visualvm.src/releases/download/1.3.9/visualvm_139.zip'
archive_name='visualvm.zip'

desktop_file="$PWD/visualvm.desktop"
spec_file="$PWD/visualvm.spec"
icon_file="$PWD/visualvm-logo.png"

work_dir="$PWD/work"
downloaded_dir="$work_dir/visualvm_139"
archive_file="$work_dir/$archive_name"

# Download the visualvm tar.gz archive and puts its name in the global variable archive_name.
download_visualvm() {
	echo "Downloading VisualVM v$release_version for linux..."
	wget -q --show-progress "$release_url" -O "$archive_file"
}

manage_dir "$work_dir"
manage_dir "$rpm_dir"
cd "$work_dir"

# Downloads visualvm if needed.
if [[ -e "$archive_file" ]]; then
	echo "Found the archive \"$archive_name\"."
	ask_yesno 'Do you want to use this archive instead of downloading a new one?' answer
	case "$answer" in
		y|Y)
			echo 'Existing archive selected.'
			;;
		*)
			rm "$archive_name"
			download_discord
	esac
else
	download_visualvm
fi


# Extracts the files:
echo
extract "$archive_name" "$work_dir"

disp "${yellow}Creating the RPM package (this may take a while)..."
cp "$icon_file" "$downloaded_dir"
cp "$desktop_file" "$work_dir/"
rpmbuild -bb --quiet "$spec_file" --define "_topdir $work_dir" --define "_rpmdir $rpm_dir"\
	--define "downloaded_dir $downloaded_dir" --define "desktop_file $desktop_file"

disp "${bgreen}Done!${reset_font}"
disp "The RPM package is located in the \"RPMs/x86_64\" folder."
disp '----------------'

ask_remove_dir "$work_dir"
ask_installpkg
