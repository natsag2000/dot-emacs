MISC		= misc
EXTERN  = ext
DISTS   = dist
ERLANG	= erlang
JAVA		= java

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
		wget http://www.xsteve.at/prg/emacs/x-dict.el && \
		mv $@ $(MISC); \
	fi

pager.el: $(MISC)
	if test ! -s "$(MISC)/$@"; \
	then \
		wget http://user.it.uu.se/~mic/pager.el && \
		mv $@ $(MISC); \
	fi

tabbar.el: $(MISC)
	if test ! -s "$(MISC)/$@"; \
	then \
		wget http://github.com/davidswelt/aquamacs-emacs/raw/master/aquamacs/src/site-lisp/tabbar/tabbar.el && \
		mv $@ $(MISC); \
	fi

color-theme: $(EXTERN)
	if test ! -d "$(EXTERN)/$@"; \
	then \
		wget http://download.gna.org/color-theme/color-theme-6.6.0.tar.gz && \
		tar xvfz color-theme-6.6.0.tar.gz && \
		mv color-theme-6.6.0 $(EXTERN)/$@ && \
		rm color-theme-6.6.0.tar.gz ;\
	fi

general: x-dict.el pager.el tabbar.el
	echo "general elisp files are downloaded."

all : general color-theme
	echo "DONE"

clean:
	$(REMOVE) $(MISC) $(EXTERN) $(DISTS)


