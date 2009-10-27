#  _  _   _   ___ ___    ___   ___ _____    ___ __  __   _   ___ ___
# | \| | /_\ / __|_ _|__|   \ / _ \_   _|__| __|  \/  | /_\ / __/ __|
# | .` |/ _ \ (_ || |___| |) | (_) || ||___| _|| |\/| |/ _ \ (__\__ \
# |_|\_/_/ \_\___|___|  |___/ \___/ |_|    |___|_|  |_/_/ \_\___|___/
#

BASEDIR = elisp
TEMPDIR = templates
SNAPFILE = ext_and_misc.tar.gz
CURDIR = $(shell pwd)
OS = $(shell uname)
REMOVE	= rm -rf
ESCRIPT_PATH = $(shell which escript)

ifeq ("$(OS)", "FreeBSD")
	MAKECMD = gmake
else
	MAKECMD = make
endif

all: folder copylisps
	cd ~/$(BASEDIR); $(MAKECMD) install;

all-snapshot: folder copylisps
	tar xvfz $(TEMPDIR)/$(SNAPFILE) -C ~/$(BASEDIR) && \
	cd ~/$(BASEDIR); $(MAKECMD) autosaves backups

snapshot:
	rm -f $(TEMPDIR)/$(SNAPFILE) 2>/dev/null;
	cd ~/$(BASEDIR); tar cvfz $(CURDIR)/$(TEMPDIR)/$(SNAPFILE) misc ext ;

folder:
	test -d ~/$(BASEDIR) ||  mkdir ~/$(BASEDIR);
	test -d ~/$(BASEDIR)/bin ||  mkdir ~/$(BASEDIR)/bin;

copylisps:
	cp dot-emacs ~/.emacs && \
	cp Makefile.in ~/$(BASEDIR)/Makefile && \
	echo "#!"$(ESCRIPT_PATH)  > ~/$(BASEDIR)/bin/eflymake && \
	cat $(TEMPDIR)/eflymake_tail >> ~/$(BASEDIR)/bin/eflymake && \
	cp elisp/*.el ~/$(BASEDIR)/

clean:
	$(REMOVE) ~/$(BASEDIR)
