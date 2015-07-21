DIR=qt
MYFOP="fop"
DOC=qt
FOP=$(shell whereis fop | awk '{if($$2 == "" )print $(MYFOP);else print $$2}')
DOCS:= $(shell ls *.xml)
XSLTPROC=/usr/bin/xsltproc
STYLE=print.xsl
XSL=print.xsl

all: saxon
saxon: $(DOC).xml
	rm -rf $(DIR)
	mkdir $(DIR)
	java -cp /usr/share/java/saxon.jar:/usr/share/java/xalan2.jar:/usr/share/java/xercesImpl.jar:/usr/share/java/xslthl.jar:/usr/share/java/docbook-xsl-saxon.jar -Dxslthl.config="file://///usr/share/xml/docbook/stylesheet/docbook-xsl/highlighting/xslthl-config.xml" com.icl.saxon.StyleSheet $(DOC).xml html.xsl
	cp -r figuras images $(DIR)
	cp estilo.css $(DIR)
pub:
	cp -r $(DOC) ~/Dropbox/www
pdf:
	dblatex -d --texstyle=mystyle -t pdf $(DOC).xml
pdf1: $(DOC).fo
	fop -fo $(DOC).fo -pdf $(DOC).pdf
$(DOC).fo: $(DOC).xml
	java -cp /usr/share/java/saxon.jar:/usr/share/java/xercesImpl.jar:/usr/share/java/xslthl.jar:/usr/share/java/docbook-xsl-saxon.jar com.icl.saxon.StyleSheet \
	-o $(DOC).fo \
        $(DOC).xml \
        $(XSL) \
	use.extensions=1 \
	callouts.extension=1 \
	textinsert.extension=1
.PHONY: all clean commit test $(DOC).tar.gz published help
