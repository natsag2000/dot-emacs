BASEDIR = elisp
DISTS   = dist
ERLANG	= erlang
EXTERN  = ext
JAVA		= java
MISC		= misc

figlet.el_URL		 = "http://repo.or.cz/w/ShellArchive.git?a=blob_plain;hb=HEAD;f=figlet.el"
htmlize.el_URL	 = "http://www.emacswiki.org/emacs/download/htmlize.el"
pager.el_URL		 = "http://user.it.uu.se/~mic/pager.el"
tabbar.el_URL    = "http://github.com/davidswelt/aquamacs-emacs/raw/master/aquamacs/src/site-lisp/tabbar/tabbar.el"
woof.el_URL			 = "http://www.xsteve.at/prg/emacs/woof.el"
x-dict.el_URL		 = "http://www.xsteve.at/prg/emacs/x-dict.el"

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
		wget http://download.gna.org/color-theme/color-theme-6.6.0.tar.gz && \
		tar xvfz color-theme-6.6.0.tar.gz && \
		mv color-theme-6.6.0 $(EXTERN)/$@ && \
		rm color-theme-6.6.0.tar.gz ;\
	fi

general: x-dict.el pager.el tabbar.el figlet.el htmlize.el woof.el
	echo "misc elisp files are downloaded."

all : general color-theme
	echo "DONE"

install:
	rm -rf ~/$(BASEDIR)-old 2>/dev/null;
	cp ../dot-emacs ~/.emacs && \
	mv ~/$(BASEDIR) ~/$(BASEDIR)-old && mkdir ~/$(BASEDIR) && \
	cp -r * ~/$(BASEDIR)

clean:
	$(REMOVE) $(MISC) $(EXTERN) $(DISTS)
