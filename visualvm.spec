# Defined by the caller (ie the script):
# downloaded_dir
# desktop_file

%define install_dir /opt/visualvm
%define apps_dir /usr/share/applications

# Disable brp-java-repack-jars which is really slow, and not useful for VisualVM.
%define __jar_repack 0
%define _build_id_links none

Name:		visualvm
Version:	2.0.1
Release:	github.0%{?dist}
Summary:	All-in-One Java Troubleshooting Tool

Group:		Development/Tools
License:	GPLv2
URL:		https://visualvm.github.io/index.html
BuildArch:	x86_64
Requires:   java

%description
VisualVM is a visual tool integrating commandline JDK tools and lightweight profiling capabilities.
Designed for both development and production time use.

%prep

%build

%install
export QA_RPATHS=255
# ignore rpaths errors (or else this step fails)

mkdir -p "%{buildroot}%{install_dir}"
mkdir -p "%{buildroot}%{apps_dir}"
mv "%{downloaded_dir}"/* "%{buildroot}%{install_dir}"
cp "%{desktop_file}" "%{buildroot}%{apps_dir}"
chmod +x "%{buildroot}%{install_dir}/bin/visualvm"

%files
/*


