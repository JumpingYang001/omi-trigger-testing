# triggered-edit-deb-package
Debian package that changes a line in a file after each time it has been modified by an upgrade.

In its given form, the package automatically sets `AutoMount=false` in `/usr/share/gvfs/mounts/network.mount`. It can be modified to do similar tasks.

## Build
The package is built with a makefile.

* `make test` performs checks the source files.
* `make all` creates the deb package.
* `make check` test whether the deb package is valid
* `make install` installs the package. Needs to be run with root privileges.
* `make checkinstall` checks whether the package was successfully installed.

## (Un-)Installation
If not using the makefile as described above, the deb package can be built and installed with (run from the project root directory):

	    chmod 755 package/DEBIAN/postinst
	    dpkg-deb --build package .
        dpkg -i <PACKAGENAME>.deb

`PACKAGENAME` is `networkmountsfix` or the package name you choose, if done so. To trigger the script without using the makefile and without having to wait for the next modification of the trigger file run:

	    dpkg-trigger --by-package=gvfs-backends /usr/share/gvfs/mounts/network.mount
	    dpkg --triggers-only <PACKAGENAME>

Giving the trigger file and the package it originated from (found using `dpkg -S /usr/share/gvfs/mounts/network.mount`) and the package name of our package.

The package is removed with

        dpkg -r <PACKAGENAME>

The `dpkg` commands need to be run with root privileges.

## Customization
`package/DEBIAN/triggers` declares the file(s) on the change of which the script is triggered. `package/DEBIAN/control` states the package name and description. The package name has to be set correspondingly in the `Makefile`.

`package/DEBIAN/postinst` is the shell script that gets executed. It will be  called by dpkg with the first argument "`triggered`" and the trigger file as second argument.
