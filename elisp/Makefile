BASEDIR = elisp
DISTS   = dist
EXTERN  = ext
MISC		= misc

figlet.el_URL						 = "http://repo.or.cz/w/ShellArchive.git?a=blob_plain;hb=HEAD;f=figlet.el"
htmlize.el_URL					 = "http://www.emacswiki.org/emacs/download/htmlize.el"
pager.el_URL						 = "http://user.it.uu.se/~mic/pager.el"
tabbar.el_URL						 = "http://github.com/davidswelt/aquamacs-emacs/raw/master/aquamacs/src/site-lisp/tabbar/tabbar.el"
woof.el_URL							 = "http://www.xsteve.at/prg/emacs/woof.el"
x-dict.el_URL						 = "http://www.xsteve.at/prg/emacs/x-dict.el"
color-theme_URL					 = "http://download.gna.org/color-theme/color-theme-6.6.0.tar.gz"
color-theme_NAME				 = "color-theme-6.6.0"
muse_URL								 = "http://repo.or.cz/w/muse-el.git?a=snapshot;h=617fa8c5d1ed92e8b2eff4d6d2b53e608440db20;sf=tgz"
muse_NAME								 = "muse-3.12"
erlang_URL							 = "http://erlware-mode.googlecode.com/files/erlware-mode-0.1.16.tar.gz"
erlang_NAME							 = "erlware-mode-0.1.16"
distel_URL							 = "http://distel.googlecode.com/svn/trunk/"
distel_NAME							 = "distel"

REMOVE	= rm -rf

$(MISC):
	test -d $@ || mkdir $@

$(EXTERN): $(DISTS)
	test -d $@ || mkdir $@

$(DISTS):
	test -d $@ || mkdir $@


%.el: $(MISC)
	if test ! -s "$(MISC)/$@"; \
	then \
		wget $($@_URL) -O $(MISC)/$@ ;\
	fi

color-theme: $(EXTERN)
	if test ! -d "$(EXTERN)/$@"; \
	then \
		wget $($@_URL) -O $(DISTS)/$($@_NAME).tar.gz && \
		tar xvfz $(DISTS)/$($@_NAME).tar.gz -C $(EXTERN) ;\
	fi

muse: $(EXTERN)
	if test ! -d "$(EXTERN)/$@"; \
	then \
		wget $($@_URL) -O $(DISTS)/$($@_NAME).tar.gz && \
		tar xvfz $(DISTS)/$($@_NAME).tar.gz -C $(EXTERN) ;\
	fi

erlang: $(EXTERN)
	if test ! -d "$(EXTERN)/$@"; \
	then \
		wget $($@_URL) -O $(DISTS)/$($@_NAME).tar.gz && \
		tar xvfz $(DISTS)/$($@_NAME).tar.gz -C $(EXTERN) ;\
	fi

distel: $(EXTERN)
	if test ! -d "$(EXTERN)/$@"; \
	then \
		svn export $($@_URL) $(EXTERN)/$($@_NAME) ;\
	fi

general: x-dict.el pager.el tabbar.el figlet.el htmlize.el woof.el
	echo "misc elisp files are downloaded."

extended: color-theme muse erlang distel
	echo "extended elisp files are downloaded."

all : general extended
	echo "DONE"

install:
	if test -d ~/$(BASEDIR)-old; then rm -rf ~/$(BASEDIR)-old 2>/dev/null; fi;
	if test -d ~/$(BASEDIR); \
	then \
		mv ~/$(BASEDIR) ~/$(BASEDIR)-old ;\
	fi; \
	mkdir ~/$(BASEDIR); \
	cp ../dot-emacs ~/.emacs && \
	cp ./* ~/$(BASEDIR)/;

clean:
	$(REMOVE) $(MISC) $(EXTERN) $(DISTS)

