<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions" 
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="#all" version="2.0">
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
  <!-- 
       reduce (fold-left):
       takes 
       - a function "pointer" 
         (an element that triggers a template with the parameters prev and curr)
       - the start value of prev
       - a list of elements
       for each element the function is called 
       with the current element and the return value of the previous call,
       finally the last result is returned.
  -->
  <xsl:template name="reduce">
    <xsl:param name="func" as="element()"/>
    <xsl:param name="prev"/>
    <xsl:param name="list" as="element()*"/>
    <xsl:choose>
      <!-- empty list: return previous value -->
      <xsl:when test="count($list) = 0">
        <xsl:copy-of select="$prev"/>
      </xsl:when>
      <!-- recure with previous value from the function call 
           and the reduced list -->
      <xsl:otherwise>
        <xsl:call-template name="reduce">
          <xsl:with-param name="func" select="$func"/>
          <!-- call function on the first element -->
          <xsl:with-param name="prev">
            <xsl:apply-templates select="$func">
              <xsl:with-param name="prev" select="$prev"/>
              <xsl:with-param name="curr" select="$list[1]"/>
            </xsl:apply-templates>
          </xsl:with-param>
          <!-- skip first element -->
          <xsl:with-param name="list" select="$list[position() > 1]"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>