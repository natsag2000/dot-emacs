#  _  _   _   ___ ___    ___   ___ _____    ___ __  __   _   ___ ___
# | \| | /_\ / __|_ _|__|   \ / _ \_   _|__| __|  \/  | /_\ / __/ __|
# | .` |/ _ \ (_ || |___| |) | (_) || ||___| _|| |\/| |/ _ \ (__\__ \
# |_|\_/_/ \_\___|___|  |___/ \___/ |_|    |___|_|  |_/_/ \_\___|___/
#

BASEDIR = elisp
OS = $(shell uname)

REMOVE = rm -rf

ifeq ("$(OS)", "FreeBSD")
	MAKECMD = gmake
else
	MAKECMD = make
endif

all: folder copylisps
	cd ~/$(BASEDIR); $(MAKECMD) install;

folder:
	if test -d ~/$(BASEDIR)-old; then rm -rf ~/$(BASEDIR)-old 2>/dev/null; fi; \
	if test -d ~/$(BASEDIR); \
	then \
		mv ~/$(BASEDIR) ~/$(BASEDIR)-old ;\
	fi; \
	mkdir ~/$(BASEDIR);

copylisps:
	cp dot-emacs ~/.emacs && \
	cp Makefile.in ~/$(BASEDIR)/Makefile && \
	cp elisp/*.el ~/$(BASEDIR)/

clean:
	$(REMOVE) ~/$(BASEDIR)
