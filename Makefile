PKGNAME=networkmountsfix

all:
	chmod 755 package/DEBIAN/postinst
	dpkg-deb --build package .

test:
	test -e package/DEBIAN/control
	test -e package/DEBIAN/postinst
	test -e package/DEBIAN/triggers
	if which aspell >/dev/null; \
	then \
		 <package/DEBIAN/control sed -n '/^Description: /,$$p' | aspell --lang=en --encoding=utf-8 list; \
	fi
	if which shellcheck >/dev/null; \
	then \
		shellcheck -s sh package/DEBIAN/postinst; \
	fi

check:
	test -e $(PKGNAME)*.deb
	dpkg-deb -I $(PKGNAME)*.deb

install:
	if [ $$(id -u) -ne 0 ]; then echo WARNING: You are not root.; fi
	dpkg -i $(PKGNAME)*.deb
	dpkg-trigger --by-package=gvfs-backends /usr/share/gvfs/mounts/network.mount
	dpkg --triggers-only $(PKGNAME)

checkinstall:
	dpkg --verify $(PKGNAME)
	cmp package/DEBIAN/postinst /var/lib/dpkg/info/$(PKGNAME).postinst
	grep "^/usr/share/gvfs/mounts/network.mount $(PKGNAME)$$" /var/lib/dpkg/triggers/File
	grep '^AutoMount=false$$' /usr/share/gvfs/mounts/network.mount

clean:
	rm -f $(PKGNAME)*.deb
	

