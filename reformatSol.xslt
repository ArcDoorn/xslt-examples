<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions" 
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="#all" version="2.0">
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
  <xsl:template match="/">
    <xsl:variable name="var.tree">
      <xsl:apply-templates select="*"/>
    </xsl:variable>
    <html>
      <body>
	<xsl:for-each-group select="$var.tree//person" group-by="@sex">
	  <xsl:for-each select="current-group()">
	    <p>
	      <xsl:value-of select="@name"/>
	      <xsl:if test=".//@name = 'Sebastian' and @sex = 'female'">
		<xsl:choose>
		  <xsl:when test="@generation=0">
		    (Uroma)
		  </xsl:when>
		  <xsl:when test="@generation=1">
		    (Oma)
		  </xsl:when>
		  <xsl:when test="@generation=2">
		    (Mama)
		  </xsl:when>
		</xsl:choose>
	      </xsl:if>
	      <xsl:copy-of select="note"/>
	    </p>
	  </xsl:for-each>
	</xsl:for-each-group>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="*">
    <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template match="person">
    <xsl:param name="generation" select="0"/>
    <xsl:copy>
      <xsl:attribute name="generation" select="$generation"/>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates select="*">
	<xsl:with-param name="generation" select="$generation + 1"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
