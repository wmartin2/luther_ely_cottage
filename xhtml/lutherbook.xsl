<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:kml="http://www.opengis.net/kml/2.2"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:m="http://www.w3.org/1998/Math/MathML"
    xmlns:opf="http://www.idpf.org/2007/opf" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:mods="http://www.loc.gov/mods/v3" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:wtm="http://wtm.cornell.edu" xmlns:xi="http://www.w3.org/2001/XInclude"
    xmlns:bibtex="http://bibtexml.sf.net/" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xhtml="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xs wtm" version="2.0">

    <xsl:param name="imgdir" select="'Images/'"/>
    <xsl:param name="plantprofile" select="'https://plants.usda.gov/plant-profile/'"/>

    <xsl:key name="id" match="*[@id]" use="@id"/>
    <xsl:key name="refid" match="*[@refid]" use="@refid"/>

    <xsl:strip-space elements="*"/>

    <xsl:output method="html" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

    <xsl:variable name="indexxxx">
        <div class="index">
            <ul>
                <li>
                    <xhtml:a href="#luthertop">[Top]</xhtml:a>
                </li>
                <xsl:for-each select="//mods:titleInfo[@class = 'maintitle']">
                    <li>
                        <a href="{concat('#',generate-id())}">
                            <xsl:apply-templates/>
                        </a>
                        <xsl:for-each
                            select="ancestor::wtm:botantical/descendant::wtm:table[@id = 'botanical']">
                            <ul>
                                <li>
                                    <a href="{concat('#',@id)}">Botanical Table</a>
                                </li>
                            </ul>
                        </xsl:for-each>
                    </li>
                </xsl:for-each>
                <li>
                    <a href="#footnotes">[Footnotes]</a>
                </li>
            </ul>
        </div>
    </xsl:variable>

    <!-- IdentityTransform -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="/" xml:space="preserve">
       <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>Luther Ely Cottage</title>
                <link href="css/lutherbook.css" rel="stylesheet" type="text/css"/>
                <!--link href="css/jquery.tablesorter.min.js" rel="stylesheet" type="text/css"/-->
                <script src="js/jquery-3.7.1.min.js"/>
                <script src="js/lutherbook.js"/>
                
   
                <link rel="stylesheet" type="text/css" href="css/theme.blue.css"/>
    <link rel="stylesheet" type="text/css" href="css/theme.dark.min.css"/>
    <link rel="stylesheet" type="text/css" href="css/theme.default.min.css"/>
    <link rel="stylesheet" type="text/css" href="css/theme.dropbox.min.css"/>
    <link rel="stylesheet" type="text/css" href="css/theme.green.min.css"/>
    <link rel="stylesheet" type="text/css" href="css//theme.grey.min.css"/>
    <link rel="stylesheet" type="text/css" href="css/theme.ice.min.css"/>
    <link rel="stylesheet" type="text/css" href="css/theme.blackice.min.css"/>
    <link rel="stylesheet" type="text/css" href="css/theme.bootstrap_4.min.css"/>
    <link rel="stylesheet" href="lightGallery-master/dist/css/lightgallery-bundle.css"/>               
    <script src="lightGallery-master/dist/lightgallery.umd.js"/>
    <script src="lightGallery-master/dist/plugins/zoom/lg-zoom.min.js"/>
    <script src="lightGallery-master/dist/plugins/thumbnail/lg-thumbnail.umd.js"/>
    <script src="lightGallery-master/dist/plugins/fullscreen/lg-fullscreen.min.js"/>
    <script src="lightGallery-master/dist/plugins/autoplay/lg-autoplay.min.js"/>
    <script src="lightGallery-master/dist/plugins/rotate/lg-rotate.min.js"/>
    <script src="lightGallery-master/dist/plugins/share/lg-share.min.js"/>
    <script src="js/click-tap-image/dist/js/image-zoom.min.js"/>
                
    <script src="js/jquery.tablesorter.js"/>
    <script src="js/jquery.tablesorter.widgets.js"/>
  
                
                
    <!--script src="addons/pager/jquery.tablesorter.pager.js"/-->
            </head>
            <body>
             
             <xhtml:a id="luthertop"/>
             <div id="floatMenu">
                <ul>
                <li>
                    <xhtml:a href="#luthertop">[Top]</xhtml:a>
                </li>
                <xsl:apply-templates select="//mods:titleInfo[@class = 'maintitle'] | //wtm:menu" mode="index"/>
                </ul>
             </div>
                
              <script type="text/javascript">
                  <![CDATA[
                  $(document).ready(function() {
                  $("#botanical").tablesorter({});
                  var name = "#floatMenu";
                  var menuYloc = null;
                  $(window).scroll(function () {
                    var offset = menuYloc+$(document).scrollTop()+"px";
                    $(name).animate({top:offset},{duration:500,queue:false});
                });
                                
                
                $(".recipe_index").on('submit', function(event) {
                   event.preventDefault(); // Prevents the default form submission
                   
                   var selectedValue = $(this).find('option:selected').val();
                   console.log("Selected Value: " + selectedValue);

                   const myid = $(this).find(":selected").val();
                   console.log(myid);
                   const element = document.getElementById(myid);
                   if (element) {
                      element.scrollIntoView({ behavior: 'smooth' }); // Smooth scrolling
                   }
                   
                   $(".recipe_index select").val(selectedValue);                   
                 });
                
    // Your code to execute after the DOM is ready
    console.log("DOM is ready!");
});  
]]>
              </script>
                
                <xsl:apply-templates/>
                
                <xsl:call-template name="wtm:footnotes"/>

            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="mods:titleInfo" mode="index">
        <li>
            <xhtml:a href="{concat('#',generate-id())}"><xsl:apply-templates/></xhtml:a>
        </li>
    </xsl:template>
    
    <xsl:template match="wtm:menu" mode="index">
        <li>
            <xhtml:a href="{concat('#',generate-id())}"><xsl:apply-templates/></xhtml:a>
        </li>
    </xsl:template>
    
    <xsl:template match="wtm:menu">
        <a id="{generate-id()}"/>
    </xsl:template>
    
    <xsl:template match="wtm:p">
        <p>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="wtm:chapter">
        <div class="{local-name()}">
            <h1>
                <xsl:value-of select="@title"/>
            </h1>
            <xsl:apply-templates/>
        </div>
    </xsl:template>



    <xsl:template match="wtm:tbody[ancestor::wtm:table[@id = 'botanical']]" priority="2">
        <xsl:element name="{local-name()}" namespace="http://www.w3.org/1999/xhtml">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates>
                <xsl:sort select="lower-case(wtm:td[1])" data-type="text" order="ascending"/>
            </xsl:apply-templates>
        </xsl:element>
    </xsl:template>

    <xsl:template match="wtm:table | wtm:tr | wtm:td | wtm:th | wtm:thead | wtm:tbody">
        <xsl:element name="{local-name()}" namespace="http://www.w3.org/1999/xhtml">
            <!-- Copies all attributes -->
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="wtm:td[ancestor::wtm:tr[@profile]][1]">
        <xsl:variable name="link" select="concat($plantprofile, ancestor::wtm:tr/@profile)"/>
        <td>
            <a href="{concat($link,'?target=&quot;_blank&quot;')}">
                <xsl:apply-templates/>
            </a>
        </td>
    </xsl:template>


    <xsl:template match="wtm:caption[parent::wtm:image]">
        <figcaption id="{generate-id()}">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
            <xsl:for-each select="key('refid', parent::wtm:image/@id)">
                <a href="{concat('#', generate-id())}">*</a>
            </xsl:for-each>
        </figcaption>
    </xsl:template>

    <xsl:template match="wtm:caption[parent::wtm:table]">
        <caption id="{generate-id()}">
            <xsl:apply-templates/>
        </caption>
    </xsl:template>


    <xsl:template match="wtm:image">

        <figure id="{generate-id()}" class="{concat(local-name(), ' imageZoom')}">
            <img src="{concat($imgdir,@src,'.jpg')}" class="imageZoom">
                <xsl:copy-of select="@*[name(.) != 'src']"/>
            </img>
            <xsl:apply-templates/>
        </figure>


    </xsl:template>

    <xsl:template match="wtm:recipes">
        <div class="{local-name()}" id="{generate-id()}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="wtm:recipe">
        <div class="{local-name()}">
            <a id="{generate-id()}"/>
            <xsl:call-template name="recipe_index"/>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="wtm:title">
        <p class="title" id="{generate-id()}">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="wtm:title" mode="plain">
        <p class="title_plain">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="wtm:ingredents">
        <div class="{local-name()}">
            <ul>
                <xsl:apply-templates/>
            </ul>
        </div>
    </xsl:template>

    <xsl:template match="wtm:steps">
        <div class="{local-name()}">
            <ol>
                <xsl:apply-templates/>
            </ol>
        </div>
    </xsl:template>

    <xsl:template match="wtm:step | wtm:ingredient">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="wtm:recipe_indexxxx">
        <div class="{local-name()}">
            <a id="{generate-id()}"/>
            <ul>
                <xsl:for-each select="ancestor::wtm:recipes/wtm:recipe">
                    <li>
                        <a href="{concat('#',generate-id())}">
                            <xsl:apply-templates select="wtm:title" mode="plain"/>
                        </a>
                    </li>
                </xsl:for-each>
                <xsl:apply-templates/>
            </ul>
        </div>
    </xsl:template>

    <xsl:template name="recipe_index">
        <form method="post" class="recipe_index">
            <label for="recipes">Select your favorite recipe:</label>
            <select id="recipes" name="favorite_receipes" size="3">
                <xsl:for-each select="//wtm:title[parent::wtm:recipe]">
                    <xsl:sort select="text()"/>
                    <option>
                        <xsl:attribute name="value" select="generate-id()"/>
                        <xsl:apply-templates/>
                    </option>
                </xsl:for-each>
            </select>
            <br/>
            <input type="submit" value="Submit"/>
        </form>
    </xsl:template>


    <xsl:template match="wtm:ref">
        <a id="{generate-id()}" href="{concat('#',generate-id(key('id',@refid)))}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <xsl:template match="mods:note">
        <a class="summary" id="{concat('s',generate-id())}" href="{concat('#', generate-id())}">
            <span class="footnote_number">
                <xsl:number count="mods:note" level="any" format="[1]"/>
            </span>
        </a>
    </xsl:template>

    <xsl:template match="mods:note" mode="footnote">
        <div class="{local-name()}">
            <p>
                <a id="{generate-id()}" href="{concat('#s', generate-id())}">
                    <span class="footnote_number">
                        <xsl:number count="mods:note" level="any" format="[1]"/>
                    </span>
                </a>
                <xsl:apply-templates/>
            </p>
        </div>
    </xsl:template>

    <xsl:template name="wtm:footnotes">
        <a id="footnotes"/>
        <h1>Footnotes</h1>
        <xsl:apply-templates select="//mods:note" mode="footnote"/>
    </xsl:template>

    <xsl:template match="wtm:metadata">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="mods:mods">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="wtm:printindex">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="wtm:div | wtm:a">
        <xsl:element name="{local-name()}" namespace="http://www.w3.org/1999/xhtml">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="wtm:insert_menu">
        <div class="{local-name()}" id="{generate-id()}">
            <ul>
                <xsl:apply-templates select="//*[@menu]" mode="menu"/>
            </ul>
        </div>
    </xsl:template>

    <xsl:template match="*[@menu]" mode="menu">
        <li>
            <a href="{concat('#', generate-id())}">
                <xsl:value-of select="@menu"/>
            </a>
        </li>
    </xsl:template>

    <xsl:template match="wtm:plant[@profile]">
        <a href="{concat($plantprofile,@profile)}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <xsl:template match="mods:abstract">
        <div class="{local-name()}">
            <p class="{local-name()}">Abstract</p>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="mods:abstract[@displaylabel]">
        <div class="{local-name()}">
            <p>Abstract</p>
            <div class="{local-name()}">
                <p>
                    <xsl:value-of select="@displaylabel"/>
                </p>
                <xsl:apply-templates/>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="wtm:itemize">
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>

    <xsl:template match="wtm:item">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="mods:titleInfo">
        <div class="{local-name()}">
            <a id="{generate-id()}"/>
            <h1>
                <xsl:apply-templates/>
            </h1>
        </div>
    </xsl:template>

    <xsl:template match="mods:nonSort | mods:title">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="wtm:lutherbook | wtm:history | wtm:lothistory | wtm:botantical">
        <div class="{local-name()}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="mods:titleInfoxxx[@class = 'maintitle']">
        <a id="{generate-id()}"/>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="wtm:page">
        <xsl:comment><xsl:value-of select="concat(local-name(), @n)"/></xsl:comment>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="wtm:group">
        <div class="{local-name()}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="wtm:ingredients">
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>

    <xsl:template match="wtm:*[@id = 'earlysettlersgallery']">
        <div id="{@id}">
            <xsl:call-template name="dynamic-gallery-test">
                <xsl:with-param name="images" select="child::wtm:image"/>
                <xsl:with-param name="options" select="'autoplay: true, pause: 5000'"/>
                <xsl:with-param name="plugins"
                    select="'[lgZoom, lgThumbnail, lgZoom, lgFullscreen, lgRotate, lgShare]'"/>
            </xsl:call-template>
        </div>
    </xsl:template>

    <xsl:template name="dynamic-gallery-test">
        <xsl:param name="buttonimg"/>
        <xsl:param name="images"/>
        <xsl:param name="options" select="'pager:true, autoplay:true, pause: 5000'"/>
        <xsl:param name="plugins" select="'[lgThumbnail, lgZoom, lgFullscreen, lgRotate, lgShare]'"/>

        <xsl:variable name="buttonid" select="concat(generate-id(), '_button')"/>

        <button type="button" id="{$buttonid}">Open Slideshow <xsl:apply-templates
                select="$images[1]" mode="thumbnail"/>
        </button>

        <script>
            $(document).ready(function () {
            
            //lightGallery($("#dynamic-gallery-demo-div"));
            
            const $dynamicGallery = document.getElementById('<xsl:value-of select="$buttonid"/>');
            const dynamicGallery = lightGallery($dynamicGallery, {
            licenseKey: '0000-0000-000-0000',
            plugins: <xsl:value-of select="$plugins"/>,
            dynamic: true,
            // Turn off hash plugin in case if you are using it
            // as we don't want to change the url on slide change
            dynamicEl:[
            <xsl:apply-templates select="$images" mode="dynamic"/>
            ],
            hash: false,
            // Do not allow users to close the gallery
            closable: true,
            // Add maximize icon to enlarge the gallery
            showMaximizeIcon: true,
            <xsl:value-of select="$options"/>,
  
            // Append caption inside the slide item
            // to apply some animation for the captions (Optional)
            // appendSubHtmlTo: '.lg-item',
            // Delay slide transition to complete captions animations
            // before navigating to different slides (Optional)
            // You can find caption animation demo on the captions demo page
            slideDelay: 400
            });
            $dynamicGallery.addEventListener('click', function () {
            dynamicGallery.openGallery();
            });
            });
            
        </script>

    </xsl:template>


    <xsl:template match="wtm:image" mode="thumbnail">
        <xsl:param name="useimgdir" select="$imgdir"/>
        <img src="{concat($useimgdir,@src,'.jpg')}"/>
    </xsl:template>

    <xsl:template match="wtm:image" mode="dynamic">
        <xsl:param name="useimgdir" select="$imgdir"/>
        <xsl:variable name="src" select="concat($useimgdir, @src, '.jpg')"/>
        <xsl:variable name="thumb" select="$src"/>
        <xsl:variable name="full" select="$src"/>
        <xsl:variable name="description" select="'[description goes here]'"/> {src: "<xsl:value-of
            select="$src"/>", thumb: "<xsl:value-of select="$thumb"/>", subHtml:`<div
            class="lg-sub-html lightGallery-captions"><xsl:value-of select="@description"/></div>`}, </xsl:template>

    <xsl:template match="wtm:table[@id = 'botanical']" priority="2">
        <xsl:variable name="myid" select="@id"/>
        
        <xsl:element name="{local-name()}" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="id" select="$myid"/>
            <xsl:copy-of select="@* except (@id)" />
            
            <script type="text/javascript">
                $(document).ready(function () {
                $("<xsl:value-of select="concat('#',$myid)"/>").tablesorter({
                });
                console.log("DOM is ready!");
                });
            </script>
            
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
