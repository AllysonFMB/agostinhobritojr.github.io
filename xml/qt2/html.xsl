<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:db="http://docbook.org/ns/docbook"
  xmlns:ng="http://docbook.org/docbook-ng"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xslthl="http://xslthl.sf.net"
  exclude-result-prefixes="db ng xlink xslthl"
  version='1.0'>
  
  <!-- First, load the official release -->
  
  <!--xsl:import href="/usr/share/xml/docbook/stylesheet/docbook-xsl/html/chunk.xsl"/>
  <xsl:import href="/usr/share/xml/docbook/stylesheet/docbook-xsl/html/highlight.xsl"/-->
  <xsl:import href="/usr/share/xml/docbook/stylesheet/docbook-xsl/html/docbook.xsl"/>
  <xsl:import href="/usr/share/xml/docbook/stylesheet/docbook-xsl/html/chunk-common.xsl"/>
  <xsl:import href="/usr/share/xml/docbook/stylesheet/docbook-xsl/html/highlight.xsl"/>
  <xsl:include href="/usr/share/xml/docbook/stylesheet/docbook-xsl/html/chunk-code.xsl"/>
  <!--xsl:include href="mytitlepages.xsl"/-->
  <xsl:param name="fop1.extensions">1</xsl:param>
  <xsl:param name="base.dir">qt/</xsl:param>
  <xsl:param name="html.stylesheet">estilo.css</xsl:param>

  <!-- Now start setting custom values, overwriting the defaults -->
  <!-- A few examples follow -->
  <xsl:variable name="default-classsynopsis-language">cpp</xsl:variable>
  
  <xsl:param name="draft.watermark.image">draft.png</xsl:param>
  <xsl:param name="list.block.spacing">space-before.minimum</xsl:param>
  <xsl:param name="double.sided" select="1" />
  <xsl:param name="chunk.section.depth" select="0" />
  <xsl:param name="section.autolabel" select="1" />
  <xsl:param name="section.label.includes.component.label" select="1" />
  <xsl:param name="body.font.master">10</xsl:param>
  <xsl:param name="body.font.size">10</xsl:param>
  <xsl:param name="use.svg" select="1"/> 
  <!--   xsl:param name="use.svg.frag" select="1"/> -->
  <!-- xsl:param name="use.embed.for.svg" select="1"/ -->
  <xsl:param name="use.id.as.filename" select="1"/>
  <xsl:param name="use.extensions" select="1"/>
  <xsl:param name="tex.math.in.alt"></xsl:param>
  <xsl:param name="graphicsize.extension" select="1"/>
  <xsl:param name="linenumbering.everyNth">1</xsl:param>
  <xsl:param name="xref.with.number.and.title" select="0"></xsl:param>
  <xsl:param name="highlight.source" select="1"></xsl:param>
  <xsl:param name="callout.graphics.extension">.svg</xsl:param>
  <xsl:param name="callouts.extension" select="1"></xsl:param>  
  <xsl:param name="textinsert.extension" select="1"/>
  <xsl:param name="callout.icon.size">3pt</xsl:param>
  <!--xsl:param name="callout.graphics" select="0"></xsl:param-->
  <xsl:param name="highlight.default.language">cpp</xsl:param>
  <xsl:param name="highlight.xslthl.config">file:////usr/share/xml/docbook/stylesheet/docbook-xsl/highlighting/xslthl-config.xml</xsl:param>
  <xsl:param name="generate.division.figure.lot" select="1" /> 
  <xsl:param name="admon.graphics" select="1"/>

  <xsl:template match="mediaobject/imageobject/imagedata">
    <div class="graphic">
      <xsl:call-template name="Image"/>
    </div>
  </xsl:template>

<!--xsl:template name="user.head.content">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <script type="text/x-mathjax-config">
    MathJax.Hub.Config({
    extensions: ["tex2jax.js"],
    jax: ["input/TeX","output/SVG"],
    tex2jax: {inlineMath: [["$","$"],["\\(","\\)"]]}
    });
  </script>
  <script type="text/javascript" src="/mathjax/MathJax.js"></script>
</xsl:template-->

<xsl:template name="user.head.content">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <script type="text/x-mathjax-config">
    MathJax.Hub.Config({
    extensions: ["tex2jax.js"],
    jax: ["input/TeX","output/HTML-CSS"],
    tex2jax: {inlineMath: [["$","$"],["\\(","\\)"]]}
    });
  </script>
  <script type="text/javascript" src="http://www.dca.ufrn.br/~ambj/mathjax/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
</xsl:template>

<xsl:template match="area" mode="xref-to">
  <xsl:param name="referrer"/>
  <xsl:param name="xrefstyle"/>
  <xsl:variable name="position"><xsl:value-of select="count(preceding-sibling::*)+1"/></xsl:variable>
  <img src="{$callout.graphics.path}{$position}.{$callout.graphics.extension}" alt="{$position}"/>
</xsl:template>

<xsl:param name="local.l10n.xml" select="document('')"/>
<l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"> 
  <l:l10n language="pt_br"> 
    <l:context name="xref-number-and-title"> 
      <l:template name="figure" text="%n"/> 
    </l:context>    
    <l:context name="xref-to">
      <l:template name="figure" text=" (fig. %p)"/>
    </l:context>
  </l:l10n>
</l:i18n>
  <xsl:template name="Image" match="inlinemediaobject/imageobject/imagedata">
    <xsl:variable name="altText">
      <xsl:choose>
        <xsl:when test="boolean(@fileref)">
          <!-- If there is a fileref attribute, use it directly -->
          <xsl:value-of select="@fileref"/>
        </xsl:when>
        <xsl:otherwise>
          <!-- Otherwise, there is an entityref attribute that takes an entity -->
          <xsl:value-of select="@entityref"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="srcURL">
      <xsl:choose>
        <xsl:when test="boolean(@fileref)">
          <!-- If there is a fileref attribute, use it directly -->
          <xsl:value-of select="@fileref"/>
        </xsl:when>
        <xsl:otherwise>
          <!-- Otherwise, there is an entityref attribute that takes an entity -->
          <!-- Compute the relative URI of the graphic file -->
          <xsl:call-template name="SubstringAfterLast">
            <xsl:with-param name="string" select="unparsed-entity-uri(@entityref)"/>
            <xsl:with-param name="token" select="'/'"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:apply-templates select="../../@xml:id"/>
    <xsl:apply-templates select="../@xml:id"/>
    <xsl:apply-templates select="@xml:id"/>
    <!-- If this is an SVG file, use the 'object' element -->
    <xsl:choose>
      <xsl:when test="substring-after(@fileref,'.')='svg' or substring-after(@fileref,'.')='svgz'">
        <object type="image/svg+xml" data="{$srcURL}">
          <xsl:call-template name="dimensions" />
          <xsl:value-of select="$altText"/>
        </object>
      </xsl:when>
      <xsl:otherwise>
        <imgbufa alt="{$altText}" src="{$srcURL}">
          <xsl:call-template name="dimensions" />
        </imgbufa>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Template to insert width and height attributes as appropriate -->
  <xsl:template name="dimensions">
    <!-- In order of priority, use this source info to determine width and height:
         1. @contentwidth/@contentdepth if at least one is not a percentage
         2. nothing if one is a percentage or @scale is specified or @scalefit='0'
         (HTML has no way to scale relative to intrinsic image dimensions)
         3. @width/@depth
         4. set width="100%" if @scalefit='1'
         5. nothing
         When depths and widths are given in CSS units (e.g. "6in"), compute
         pixels assuming 96dpi. When in unrecognized units, ignore attribute. -->
    <xsl:variable name="pixelWidth"> <!-- 0 means don't include width attribute -->
    <xsl:choose>
      <xsl:when test="@contentwidth or @contentdepth">
        <xsl:choose>
          <xsl:when test="not(@contentwidth)">0</xsl:when>
          <xsl:when test="contains(@contentwidth,'%')">0</xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="ConvertToPixels">
              <xsl:with-param name="length" select="@contentwidth"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="@scale or @scalefit='0'">
        <xsl:choose>
          <xsl:when test="not(@scale)">0</xsl:when>
          <xsl:when test="contains(@scale,'%')">
            <xsl:value-of select="@scale"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="ConvertToPixels">
              <xsl:with-param name="scale" select="@scale"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="@width or @depth">
        <xsl:choose>
          <xsl:when test="not(@width)">0</xsl:when>
          <xsl:when test="contains(@width,'%')">
            <xsl:value-of select="@width"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="ConvertToPixels">
              <xsl:with-param name="length" select="@width"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="@scalefit='1'">100%</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="pixelHeight"> <!-- 0 means don't include height attribute -->
  <xsl:choose>
    <xsl:when test="@contentwidth or @contentdepth">
      <xsl:choose>
        <xsl:when test="not(@contentdepth)">0</xsl:when>
        <xsl:when test="contains(@contentdepth,'%')">0</xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="ConvertToPixels">
            <xsl:with-param name="length" select="@contentdepth"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:when test="@scale or @scalefit='0'">
        <xsl:choose>
          <xsl:when test="not(@scale)">0</xsl:when>
          <xsl:when test="contains(@scale,'%')">
            <xsl:value-of select="@scale"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="ConvertToPixels">
              <xsl:with-param name="scale" select="@scale"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
    </xsl:when>
    <xsl:when test="@width or @depth">
      <xsl:choose>
        <xsl:when test="not(@depth)">0</xsl:when>
        <xsl:when test="contains(@depth,'%')">
          <xsl:value-of select="@depth"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="ConvertToPixels">
            <xsl:with-param name="length" select="@depth"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>0</xsl:otherwise>
  </xsl:choose>
</xsl:variable>
<xsl:if test="not($pixelWidth=0)">
  <xsl:attribute name="width">
    <xsl:value-of select="$pixelWidth"/>
  </xsl:attribute>
</xsl:if>
<xsl:if test="not($pixelHeight=0)">
  <xsl:attribute name="height">
    <xsl:value-of select="$pixelHeight"/>
  </xsl:attribute>
</xsl:if>
</xsl:template>
<!-- Utility function to find the substring after the last occurrence of a token -->
<xsl:template name="SubstringAfterLast">
  <xsl:param name="string"/>
  <xsl:param name="token"/>
  <xsl:choose>
    <xsl:when test="contains($string,$token)">
      <xsl:call-template name="SubstringAfterLast">
        <xsl:with-param name="string" select="substring-after($string,$token)"/>
        <xsl:with-param name="token" select="$token"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$string"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="user.footer.navigation">
  <div class="navheader"><hr/><table width="100%"><tr><td align="center">
    <xsl:apply-templates select="//copyright[1]" mode="titlepage.mode"/>
  </td></tr></table></div>
</xsl:template>

<!-- selects the programlisting's first node, if it is a text node, and if it has a 
following sibling (which means it is not the only node) -->
<xsl:template match="programlisting/node()[1][self::text()][following-sibling::node()]">
  <!--xsl:message>got here left</xsl:message-->
  <xsl:call-template name="trim-left">
    <xsl:with-param name="contents" select="."/>
  </xsl:call-template>
</xsl:template>

<!-- selects the programlisting's last node, if it is a text node, and if it has a 
preceding sibling (which means it is not the only node) -->
<xsl:template match="programlisting/node()[position() = last()][self::text()][preceding-sibling::node()]">
  <!--xsl:message>got here right</xsl:message-->
  <xsl:call-template name="trim-right">
    <xsl:with-param name="contents" select="."/>
  </xsl:call-template>
</xsl:template>

<!-- selects the programlistings first node that is also the last node, if it is a 
text node -->
<xsl:template match="programlisting/node()[position() = 1 and position() = last()][self::text()]"  priority="1">
  <!--xsl:message>got here both</xsl:message-->
  <xsl:call-template name="trim.text">
    <xsl:with-param name="contents" select="."/>
  </xsl:call-template>
</xsl:template>

<!-- Utility function to convert lengths to pixels -->
<xsl:template name="ConvertToPixels">
  <xsl:param name="length"/>
  <xsl:variable name="pixels" select="number(substring-before($length,'px'))"/>
  <xsl:variable name="inches" select="number(substring-before($length,'in'))"/>
  <xsl:variable name="cms" select="number(substring-before($length,'cm'))"/>
  <xsl:variable name="mms" select="number(substring-before($length,'mm'))"/>
  <xsl:variable name="pts" select="number(substring-before($length,'pt'))"/>
  <xsl:variable name="picas" select="number(substring-before($length,'pc'))"/>
  <xsl:variable name="ems" select="number(substring-before($length,'em'))"/>
  <xsl:choose>
    <xsl:when test="boolean(number($length))"> <!-- Note: boolean(NaN)=false -->
    <xsl:value-of select="$length"/>
  </xsl:when>
  <xsl:when test="boolean($pixels)">
    <xsl:value-of select="$pixels"/>
  </xsl:when>
  <xsl:when test="boolean($inches)">
    <xsl:value-of select="96 * $inches"/>
  </xsl:when>
  <xsl:when test="boolean($cms)">
    <xsl:value-of select="(96 * $cms) div 2.54"/>
  </xsl:when>
  <xsl:when test="boolean($mms)">
    <xsl:value-of select="(96 * $mms) div 25.4"/>
  </xsl:when>
  <xsl:when test="boolean($pts)">
    <xsl:value-of select="(96 * $pts) div 72"/>
  </xsl:when>
  <xsl:when test="boolean($picas)">
    <xsl:value-of select="(96 * $picas) div 6"/>
  </xsl:when>
  <xsl:when test="boolean($ems)">
    <xsl:value-of select="(96 * $ems) div 6"/>
  </xsl:when>
  <xsl:otherwise>0</xsl:otherwise>
</xsl:choose>
</xsl:template>
</xsl:stylesheet>

