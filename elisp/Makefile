MISC		= misc
EXTERN  = ext
DISTS   = dist
ERLANG	= erlang
JAVA		= java
BASEDIR = elisp

REMOVE	= rm -rf

$(MISC):
	test -d $@ || mkdir $@

$(EXTERN): $(DISTS)
	test -d $@ || mkdir $@

$(DISTS):
	test -d $@ || mkdir $@

x-dict.el: $(MISC)
	if test ! -s "$(MISC)/$@"; \
	then \
		wget "http://www.xsteve.at/prg/emacs/x-dict.el" -O $(MISC)/$@ ;\
	fi

pager.el: $(MISC)
	if test ! -s "$(MISC)/$@"; \
	then \
		wget "http://user.it.uu.se/~mic/pager.el" -O $(MISC)/$@ ;\
	fi

tabbar.el: $(MISC)
	if test ! -s "$(MISC)/$@"; \
	then \
		wget "http://github.com/davidswelt/aquamacs-emacs/raw/master/aquamacs/src/site-lisp/tabbar/tabbar.el" -O $(MISC)/$@ ;\
	fi

figlet.el: $(MISC)
	if test ! -s "$(MISC)/$@"; \
	then \
		wget "http://repo.or.cz/w/ShellArchive.git?a=blob_plain;hb=HEAD;f=figlet.el" -O $(MISC)/$@ ;\
	fi

color-theme: $(EXTERN)
	if test ! -d "$(EXTERN)/$@"; \
	then \
		wget http://download.gna.org/color-theme/color-theme-6.6.0.tar.gz && \
		tar xvfz color-theme-6.6.0.tar.gz && \
		mv color-theme-6.6.0 $(EXTERN)/$@ && \
		rm color-theme-6.6.0.tar.gz ;\
	fi

general: x-dict.el pager.el tabbar.el figlet.el
	echo "general elisp files are downloaded."

all : general color-theme
	echo "DONE"

install:
	rm -rf ~/$(BASEDIR)-old 2>/dev/null;
	cp ../dot-emacs ~/.emacs && \
	mv ~/$(BASEDIR) ~/$(BASEDIR)-old && mkdir ~/$(BASEDIR) && \
	cp -r * ~/$(BASEDIR)

clean:
	$(REMOVE) $(MISC) $(EXTERN) $(DISTS)
