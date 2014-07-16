# Constructs like {} are not compatible with the original /bin/sh,
# the default does not work on debian systems using /bin/dash as /bin/sh.
SHELL = /bin/bash

OPT_SGML = -d -c latin -p a4 --language=it
OPT_HTML = -s 0 -T 2
OPT_TXT = --filter -b 2 -P '\-T latin1'
OPT_TEX = --output=tex 
OPT_PS = -z 

define SED_EXPRESSION
/<\/HEAD>/{
  r ANALYTICS
  a </HEAD>
  d
}
endef
export SED_EXPRESSION

  # Get the first sgml file in the directory
source_ext = $(word 1,$(wildcard *.sgml)) 

  # Get rid of the extension and of any 
  # repeated whitespace
source = $(strip $(source_ext:.sgml=))

  # Those are targets that should be 
  # ignored
.PHONY: default all clean tidy

  # Get rid of implicit rules
.SUFFIXES: 

default: all tidy

sign: 

tidy: 
	@echo "Cleaning up..."
	@rm -f ./log.* 
	@rm -f ./*.ps
	@rm -f ./*.tex

all: log.check $(source).txt $(source)/$(source).html $(source).html.tar.gz \
	$(source).ps.gz $(source).pdf

log.check: $(source).sgml Makefile
	@sgmlcheck $(source).sgml 2>$(source).err
	@if test "x`cat $(source).err`" != "x"; then \
           echo "SGML contains errors!!!" 1>&2; \
	   cat ./$(source).err 1>&2; \
	   rm -f ./$(source).err; \
	   exit 1; \
	 fi; \
	 rm -f ./$(source).err
	@touch ./log.check

$(source).txt: $(source).sgml Makefile
	@echo Generating $(@)...;\
	 sgml2txt $(OPT_SGML) $(OPT_TXT) ./$(source).sgml &> log.sgml-txt

$(source)/$(source).html: $(source).sgml Makefile
	@echo "Generating html version...";\
         echo "  Creating directory...";\
	 mkdir -p ./$(source);
	@echo "  Parsing sgml file...";\
	 cd $(source);\
	 sgml2html $(OPT_SGML) $(OPT_HTML) ../$(source).sgml &> ../log.sgml-html; \
	 ln -fs ./$(source).html ./index.html;\
	 cd ..
	@echo "  Adding analytics code...";\
	 sed -i -e "$$SED_EXPRESSION" ./$(source)/$(source).html


$(source).html.tar.gz: $(source).sgml $(source)/$(source).html Makefile
	@echo Generating tar.gz of the html version...; \
	 tar -czf ./$(source).html.tar.gz ./$(source)

$(source).ps.gz: $(source).ps Makefile
	@echo Generating .ps.gz version...;\
	 gzip -9c < $(source).ps > $(source).ps.gz

$(source).ps: $(source).dvi Makefile
	@echo Generating .ps version...;\
	 dvips $(OPT_PS) $(source).dvi &> log.sgml-ps

$(source).dvi: $(source).tex Makefile
	@echo Generating .dvi version...;\
	 latex '\nonstopmode\input{$(source).tex}' &> ./log.sgml-dvi;\
	 cat ./$(source).log >> ./log.sgml-dvi
	@echo "  Generating index...";\
	 latex '\nonstopmode\input{$(source).tex}' 2>&1 >> ./log.sgml-dvi;\
	 cat ./$(source).log >> ./log.sgml-dvi
	@echo "  Removing temporary files...";\
	 rm -f ./$(source).{log,toc,aux} 

$(source).tex: $(source).sgml Makefile
	@echo "Generating latex (.tex) version...";\
	 sgml2latex $(OPT_SGML) $(OPT_TEX) ./$(source).sgml &> log.sgml-tex;
	@echo "  Adjusting language and fonts...";\
	 perl -pi -e "s/english\]\{babel\}/italian]{babel}\n\\\\usepackage{times}/" \
	 	$(source).tex;

$(source).pdf: $(source).ps Makefile
	@echo Generating .pdf version...;\
	 ps2pdf13 $(source).ps
	@echo "  Removing temporary files...";\
	 rm -f ./body.tmp ./head.tmp;

html:
	@for a in $(source){.sgml,.pdf,.ps.gz,.txt,.html.tar.gz}; do \
	 b=$${a%%.*};\
         echo "<a href=\"$(DIR)/$$a\">$${a##$$b.}</a>&nbsp;&nbsp;";\
	 done;
	@echo "<a href=\"$(DIR)/$(source)/\">Online Version</a>"



clean:
	rm -rf ./$(source){,.dvi,.html.tar.gz,.pdf,.ps,.ps.gz,.tex,.txt}
	rm -f ./log.* ./*.log ./*.out ./*.toc ./*.aux
	rm -f ./{body,head}.tmp

