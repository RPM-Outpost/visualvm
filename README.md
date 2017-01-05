# RPM Package for VisualVM
A script to create an RPM package of [VisualVM](https://visualvm.github.io/).

## How to use
Run the [create-package.sh](https://github.com/RPM-Outpost/visualvm/blob/master/create-package.sh) script from the command line.
It will download the latest version of VisualVM and build an RPM package.
Then, install the package with `sudo dnf install <rpm file>`.

### Requirements
You need to install the `rpmdevtools` package to build RPM packages and use the script.
Don't worry: the script detects if it isn't installed, and can install it for you.

### About root privileges
Building an RPM package with root privileges is dangerous, because a mistake in SPEC file could result in running nasty commands.
See http://serverfault.com/questions/10027/why-is-it-bad-to-build-rpms-as-root.

## Update visualvm
When a new version of visualvm is released, you can run the `create-package.sh` script again to create an updated package.
Then, simply install the updated package with `sudo dnf install <rpm file>`.  

Note that, unlike my other RPM-Outpost scripts, this one doesn't automatically choose the latest available version.
It has to be updated everytime a new version of VisualVM is released.

## Supported distributions
- Fedora 24
- Fedora 25

It probably work on other RPM-based distros but I haven't tested it. Let me know if it works for you!
