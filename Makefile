PREFIX = /usr
PKG = gpro

all:
	@echo Run \'make install\' to install GPRO.
	@echo Run \'make uninstall\' to uninstall GPRO.

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@cp -p $(PKG).sh $(DESTDIR)$(PREFIX)/bin/$(PKG)
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/$(PKG)

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/$(PKG)
