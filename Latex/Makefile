files = lutherbook

FILES_TEX = $(addsuffix .tex, $(files))
TEX_OUTPUTS_TARGS = $(patsubst %,./%,$(FILES_TEX))

FILES_PDF = $(addsuffix .pdf, $(files))
PDF_OUTPUTS_TARGS = $(patsubst %,./%,$(FILES_PDF))

OUTPUT_TARGS = $(TEX_OUTPUTS_TARGS) $(PDF_OUTPUTS_TARGS)

.PHONY: all clean images latex

.PRECIOUS: *.tex *.pdf *.info
.SECONDARY:

all: latex

latex: $(PDF_OUTPUTS_TARGS)

%.pdf: %.tex %.xsl 
	latexmk -xelatex $* 

%.xsl:

%.tex: %.xsl
	xml=../$(addsuffix .xml, $*)
	xsl=$(addsuffix .xsl, $*)
	java  -jar ../SaxonHE12-8J/saxon-he-12.8.jar -s:../lutherbook.xml -xsl:lutherbook.xsl -xi:on -o:$@

clean:
	latexmk -C $(TEX_OUTPUTS_TARGS)
	rm -f $(PDF_OUTPUTS_TARGS) $(TEX_OUTPUTS_TARGS)

