<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://wtm.cornell.edu"
    xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:m="http://www.w3.org/1998/Math/MathML" xmlns:opf="http://www.idpf.org/2007/opf"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mods="http://www.loc.gov/mods/v3"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:wtm="http://wtm.cornell.edu"
    xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:bibtex="http://bibtexml.sf.net/"
    exclude-result-prefixes="xs wtm" version="2.0">

    <xsl:strip-space elements="*"/>

    <xsl:character-map name="latex-escape">
        <!--xsl:output-character character="&amp;" string="\&amp;"/-->
        <xsl:output-character character="$" string="\$"/>
        <!--xsl:output-character character="#" string="\#"/-->
        <xsl:output-character character="_" string="\_"/>
    </xsl:character-map>

    <xsl:output method="text" encoding="UTF-8" use-character-maps="latex-escape" indent="no"
        omit-xml-declaration="yes"/>

    <xsl:param name="plantprofile" select="'https://plants.usda.gov/plant-profile'"/>

    <!-- IdentityTransform -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="/" xml:space="preserve">
\documentclass{book}
\usepackage[utf8]{inputenc}
\setcounter{tocdepth}{5}
\usepackage[
backend=biber,
style=alphabetic,
%sorting=ynt
]{biblatex}
\addbibresource{lutherbook.bib}
\bibliography{lutherbook.bib}
\usepackage{amsmath}
\usepackage{xltxtra}    
\usepackage{graphicx} 
\usepackage{imakeidx}
        \usepackage{datetime} 
\usepackage{fontspec}

\newenvironment{Abstract}[1][Abstract]{%
      \begin{center}%
        \bfseries #1%
      \end{center}%
      \quotation%
    }{%
      \endquotation%
    }
    
%\usepackage{natbib}
%\bibliographystyle{ksfh_nat}
  
\usepackage{array}
\usepackage{fancyhdr}
\usepackage{longtable}
\usepackage{lettrine}
\usepackage{hyperref}

\hypersetup{
  colorlinks = true,      % Colours links instead of ugly boxes
  urlcolor = blue,        % Colour for external hyperlinks
  linkcolor = blue,       % Colour of internal links
  citecolor = red         % Colour of citations
}

\pagestyle{fancy}
 \makeindex
\lhead{Luther Ely Cottage}
\rhead{page \thepage}

\graphicspath{{../images/}}

\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}

<xsl:text disable-output-escaping="yes">
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}} % Define new column type for left-aligned paragraphs
</xsl:text>
        
\title{Luther Cottage History}
\author{Luther Ely} 
\date{1984}

\newcommand{\quotes}[1]{``#1''}

\newcommand*{\thead}[1]{\multicolumn{1}{c}{\bfseries #1}}

\begin{document}
	\nocite{*}
	\maketitle
	\tableofcontents
	<xsl:apply-templates/>
    \printindex 
\end{document}
</xsl:template>

    <xsl:template match="wtm:p"> \par <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="wtm:esc" xml:space="preserve">
<xsl:value-of select="concat('\', text())"/>
    </xsl:template>

    <xsl:template match="wtm:chapter"> \chapter{<xsl:value-of select="@title"/>}
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="wtm:recipe"> \section*{<xsl:apply-templates select="wtm:title"/>}
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="wtm:title[ancestor::wtm:recipe]"> \index{<xsl:apply-templates/>}
            \index{<xsl:value-of select="ancestor::wtm:recipe/@category"/>!<xsl:apply-templates/>}
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="wtm:ingredients"> \begin{itemize} \itemsep0em \setlength\itemsep{-0.5em}
        <xsl:apply-templates/> \end{itemize} </xsl:template>

    <xsl:template match="wtm:steps"> \begin{enumerate} \itemsep0em \setlength\itemsep{-0.5em}
        <xsl:apply-templates/> \end{enumerate} </xsl:template>

    <xsl:template match="wtm:step | wtm:ingredient"> \item <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="wtm:tableofcontents"> \tableofcontents </xsl:template>

    <xsl:template match="mods:note">\footnote{<xsl:apply-templates/>} </xsl:template>

    <xsl:template match="wtm:metadata">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="wtm:image"> \begin{figure*}[h] <xsl:apply-templates/> \centering
            <xsl:value-of select="concat('\includegraphics[width=0.75\textwidth]{', @src, '}')"/>
            \label{<xsl:value-of select="generate-id()"/>} <xsl:if test="normalize-space(@id)">
                \label{<xsl:value-of select="@id"/>} </xsl:if> \end{figure*} </xsl:template>

    <xsl:template match="wtm:caption"> \caption{<xsl:apply-templates/>} </xsl:template>

    <xsl:template match="wtm:ref[@class = 'sketch' and @refid]">
        <xsl:apply-templates/>
        <xsl:value-of select="concat(', page~\pageref{', @refid, '}')"/>
    </xsl:template>

    <xsl:template match="wtm:comment"> \par <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="wtm:span"> \textbf{<xsl:apply-templates/>} </xsl:template>

    <xsl:template match="wtm:p[@class = 'title']"> \section*{<xsl:apply-templates/>} </xsl:template>

    <xsl:template match="wtm:table[@latex and count(descendant::wtm:tr) &gt; 20]" priority="2">
        <xsl:value-of select="concat('\begin{longtable}{', @latex, '}')"/>
        <xsl:apply-templates select="wtm:caption"/>
        <xsl:apply-templates select="wtm:thead"/> \endfirsthead <xsl:apply-templates
            select="wtm:caption"/>
        <xsl:apply-templates select="wtm:thead"/> \endhead <xsl:apply-templates select="wtm:tbody"/>
        \end{longtable} </xsl:template>

    <xsl:template match="wtm:table[@id = 'biotanical']"> \begin{table}{llll} <xsl:apply-templates/>
        \end{table} </xsl:template>

    <xsl:template match="wtm:thead"> \hline <xsl:apply-templates/> \hline </xsl:template>

    <xsl:template match="wtm:tbody[ancestor::wtm:table[@id = 'biotanical']]">
        <xsl:apply-templates>
            <xsl:sort select="lower-case(wtm:td[1])" data-type="text" order="ascending"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="wtm:caption[ancestor::wtm:table]">
        <xsl:variable name="cols" select="count(ancestor::wtm:table//wtm:tr[1]/wtm:td)"/>
        <xsl:value-of select="concat('\multicolumn{', $cols, '}{c}{')"/><xsl:apply-templates/>}
        \\[5pt] </xsl:template>

    <xsl:template match="wtm:tr">
        <xsl:apply-templates/> \\ </xsl:template>

    <xsl:template match="wtm:td | wtm:th">
        <xsl:apply-templates/>
        <xsl:text disable-output-escaping="yes"><![CDATA[&]]></xsl:text>
    </xsl:template>

    <xsl:template match="wtm:td[1][ancestor::wtm:table[@id = 'biotanical']]" priority="2">
        \textit{<xsl:apply-templates/>}
        <xsl:text disable-output-escaping="yes"><![CDATA[&]]></xsl:text>
    </xsl:template>

    <xsl:template match="wtm:td[last()] | wtm:th[last()]" priority="2">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="wtm:printindex"> \printindex </xsl:template>

    <xsl:template match="wtm:rights"> { \vspace*{65mm} \thispagestyle{empty} \footnotesize\itshape
        \setlength{\parskip}{\baselineskip} \setlength{\parindent}{0pt} \vspace*{10mm} Generated:
        \today at~\currenttime.} </xsl:template>

    <xsl:template match="wtm:td[2][ancestor::wtm:tr[@profile]]">
        <xsl:variable name="url" select="concat($plantprofile, '/', ancestor::wtm:tr/@profile)"/>
        <xsl:value-of select="concat('\href{', $url, '}')"/> {<xsl:apply-templates/>}
        <xsl:text disable-output-escaping="yes"><![CDATA[&]]></xsl:text>
    </xsl:template>

    <xsl:template match="*[@class = 'maintitle']"> \chapter{<xsl:apply-templates/>} </xsl:template>

    <xsl:template match="mods:abstract"> \begin{Abstract} <xsl:apply-templates/> \end{Abstract} </xsl:template>
    <xsl:template match="mods:abstract[@displayLabel]"><xsl:value-of select="concat('\begin{Abstract}[',@displayLabel,']')"/> <xsl:apply-templates/> \end{Abstract} </xsl:template>

    <xsl:template match="wtm:itemize"> \begin{itemize} <xsl:apply-templates/> \end{itemize} </xsl:template>

    <xsl:template match="wtm:item"> \item <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="wtm:span[@class='first']">
        <xsl:variable name="ftext"><xsl:apply-templates/></xsl:variable>
        \lettrine{<xsl:value-of select="substring($ftext,1,1)"/>}{<xsl:value-of select="substring($ftext,2, string-length($ftext)-1)"/>} 
    </xsl:template>

<xsl:template match="wtm:esc">
    \<xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>
