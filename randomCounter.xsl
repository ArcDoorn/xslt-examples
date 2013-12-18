<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions" 
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:math="java.lang.Math"
                exclude-result-prefixes="#all" version="2.0">
  <xsl:import href="reduce.xsl"/>
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <!--
      generate a value list
  -->
  <xsl:template match="/">
    <values>
      <xsl:call-template name="reduce">
        <!-- reference to the counter template -->
        <xsl:with-param name="func" as="element()">
          <Counter/> 
        </xsl:with-param>

        <!-- first value -->
        <xsl:with-param name="prev">
          <values>
            <value>0</value>
          </values>
        </xsl:with-param>

        <!-- steps to be summed -->
        <xsl:with-param name="list" as="element()*">
          <xsl:for-each select="1 to 10">
            <step>
              <!-- call Java random (use saxon -ext:on) -->
              <xsl:value-of select="floor(math:random() * 10)"/>
            </step>
          </xsl:for-each>
        </xsl:with-param>
      </xsl:call-template>
    </values>
  </xsl:template>

  <!--
      add another value, with the given step size
  -->
  <xsl:template match="Counter">
    <xsl:param name="prev"/>
    <xsl:param name="curr" as="element()"/>
    <values>
      <xsl:copy-of select="$prev/values/*"/>
      <value>
        <xsl:value-of select="$prev/values/value[last()]/text() + $curr/text()"/>
      </value>
    </values>
  </xsl:template>
</xsl:stylesheet>