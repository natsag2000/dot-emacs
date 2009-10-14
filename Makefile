#  _  _   _   ___ ___    ___   ___ _____    ___ __  __   _   ___ ___
# | \| | /_\ / __|_ _|__|   \ / _ \_   _|__| __|  \/  | /_\ / __/ __|
# | .` |/ _ \ (_ || |___| |) | (_) || ||___| _|| |\/| |/ _ \ (__\__ \
# |_|\_/_/ \_\___|___|  |___/ \___/ |_|    |___|_|  |_/_/ \_\___|___/
#

BASEDIR = elisp
SNAPDIR = templates
SNAPFILE = ext_and_misc.tar.gz
CURDIR = $(shell pwd)


REMOVE	= rm -rf

all: folder copylisps
	cd ~/$(BASEDIR); make install;

all-snapshot: folder copylisps
	tar xvfz $(SNAPDIR)/$(SNAPFILE) -C ~/$(BASEDIR) && \
	cd ~/$(BASEDIR); make autosaves backups

snapshot:
	rm -f $(SNAPDIR)/$(SNAPFILE) 2>/dev/null;
	cd ~/$(BASEDIR); tar cvfz $(CURDIR)/$(SNAPDIR)/$(SNAPFILE) misc ext ;

folder:
	if test -d ~/$(BASEDIR)-old; then rm -rf ~/$(BASEDIR)-old 2>/dev/null; fi;
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