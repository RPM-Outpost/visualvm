![visualvm logo](visualvm-logo.png)

# VisualVM rpm

Unofficial script to create an RPM package of [VisualVM](https://visualvm.github.io/).

## How to use
Open a terminal in the repo directory and run `./create-package.sh`

## How to update
When a new version of visualvm is released:

1. Download the updated script from github.
2. Run the script to get the updated version.

## More informations

### Supported distributions
- Fedora 25
- Fedora 26

It may work on other RPM-based distributions but I haven't tested it.

### Requirements
The `rpmdevtools` package is required to build RPM packages and use the script. If it's not installed, the script will offer to install it.

### About root privileges
Building an RPM package with root privileges is dangerous, see http://serverfault.com/questions/10027/why-is-it-bad-to-build-rpms-as-root.
