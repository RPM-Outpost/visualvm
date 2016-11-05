# RPM Package for bleeding-edge VisualVM
All you need to simply build an RPM package of [VisualVM](https://visualvm.github.io/).

## How to use
### Build the rpm package yourself
Run the [create-package.sh](https://github.com/RPM-Outpost/discord/blob/master/create-package.sh) script (from the command line).
It will download the latest version of VisualVM and build an RPM package.
Then, install the package with `sudo dnf install <rpm file>`.

**Note:** You need to install the `rpmdevtools` package to use the script.
Don't worry: the script detects if it isn't installed, and can install it for you.

### Use the rpm package I've already built
I've already built a package with my script.
You can download this package [here](https://github.com/RPM-Outpost/visualvm/blob/master/RPMs/x86_64/visualvm-1.3.9-github.0.fc24.x86_64.rpm).

### How to update
When a new version of discord is released, you can run the `create-package.sh` script again to create an updated package.
Or you can download an updated package from my github repository.
Then, simply install the updated package with `sudo dnf install <rpm file>`.

### Note
Unlike the scripts for [discord](https://github.com/RPM-Outpost/discord) and [libimobiledevice](https://github.com/RPM-Outpost/libimobiledevice), 
the script for visualvm doesn't automatically choose the latest available version:
for now, the version is hardcoded. So the script has to be updated everytime a new version of VisualVM is released.
