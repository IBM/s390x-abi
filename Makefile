# s390x/s390 ABI specification -- Makefile
#
# Create various output formats from the source files.  PDF is the
# default, others are experimental.  While the s390x ABI (64 bit) is the
# main target, the s390 ABI (32 bit, preliminary) can be built as well.

MAIN = lzsabi
OTHERS = fdl-1.1 ibm-notices
INPUTS = $(MAIN) $(OTHERS)

TEX2PDF = latexmk -lualatex
TEX2HTML = make4ht --lua

# Conversion to plain text
HTML2TXT = elinks \
	-dump -dump-charset ascii -dump-width 81 \
	-no-references -no-numbering
# Sample command line with alternate tool
#  HTML2TXT = w3m -dump -no-graph

LATEXDIFF = latexdiff --exclude-textcmd="section,subsection,subsubsection"

SUBDIRS = s390x-pdf s390-pdf s390x-html s390-html

PHONY := all tex pdf html txt

# Default target

all: $(MAIN)_s390x.pdf

# Prepare TeX source in separate subdirectories

$(SUBDIRS:=/$(MAIN).tex): $(INPUTS:=.tex)
	mkdir -p $(dir $@) && cd $(dir $@) && \
	ln -sf $(INPUTS:%=../%.tex) .

tex: $(SUBDIRS:=/index.tex)

s390x-%/index.tex: s390x-%/$(MAIN).tex $(OTHERS:=.tex)
	printf '%s\n' '\newif\ifzseries\zseriestrue\input{lzsabi.tex}' > $@

s390-%/index.tex: s390-%/$(MAIN).tex $(OTHERS:=.tex)
	printf '%s\n' '\newif\ifzseries\zseriesfalse\input{lzsabi.tex}' > $@

# PDF output
# Targets 'lzsabi_s390x.pdf', 'lzsabi_s390.pdf'

pdf: $(MAIN)_s390x.pdf $(MAIN)_s390.pdf

$(MAIN)_%.pdf: %-pdf/index.tex
	cd $*-pdf && $(TEX2PDF) index.tex
	mv $*-pdf/index.pdf $@

# HTML output
# Targets 's390x-html/index.html', 's390-html/index.html'

html: s390x-html/index.html s390-html/index.html

%-html/index.html: %-html/index.tex
	cd $*-html && $(TEX2HTML) index.tex

# Plain text output
# Targets 'lzsabi_s390x.txt', 'lzsabi_s390.txt'

txt: $(MAIN)_s390x.txt $(MAIN)_s390.txt

$(MAIN)_%.txt: %-html/index.html
	$(HTML2TXT) $< \
	| sed 's/━/-/g; s/  *$$//' | cat - local-vars.txt > $@ \
	|| rm -f $@

# Different revisions of the main document
# Source must be in "revs/", such as "revs/lzsabi-1.5.tex".

s390x-%-html/$(MAIN).tex s390-%-html/$(MAIN).tex \
s390x-%-pdf/$(MAIN).tex s390-%-pdf/$(MAIN).tex: \
  revs/$(MAIN)-%.tex $(INPUTS:=.tex)
	mkdir -p $(dir $@) && cd $(dir $@) && \
	ln -sf $(OTHERS:%=../%.tex) . && \
	ln -sf ../revs/$(MAIN)-$*.tex $(MAIN).tex

# Diff output
# These rules enable targets like 'lzsabi_s390x-vs-1.5.pdf'.

s390x-vs-%-html/$(MAIN).tex s390-vs-%-html/$(MAIN).tex \
s390x-vs-%-pdf/$(MAIN).tex s390-vs-%-pdf/$(MAIN).tex: \
  revs/$(MAIN)-%.tex $(INPUTS:=.tex)
	mkdir -p $(dir $@) && cd $(dir $@) && \
	ln -sf $(OTHERS:%=../%.tex) .
	$(LATEXDIFF) revs/$(MAIN)-$*.tex $(MAIN).tex > $@

$(MAIN)_s390x-%.patch: $(MAIN)_s390x-%.txt $(MAIN)_s390x.txt
	diff -ud $(MAIN)_s390x-$*.txt $(MAIN)_s390x.txt > $@ || true

# Other targets

$(MAIN).tar.gz : $(MAIN).tex $(INPUTS:=.tex)  $(MAIN).mk4 \
		Makefile README.md LICENSE
	tar -czf $@ $^

clean:
	rm -rf $(SUBDIRS) s390x-*-html s390-*-html s390x-*-pdf s390-*-pdf
	rm -rf *.patch $(MAIN)_*.pdf $(MAIN)_*.txt $(MAIN).tar.gz
