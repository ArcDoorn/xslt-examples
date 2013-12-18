<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions" 
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="#all" version="2.0">
  <xsl:import href="reduce.xsl"/>
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
  <xsl:template match="/">
    <sums>
      <sum description="variable">
        <!--
            two steps:
            - put the products in a variable
            - sum them
        -->
        <xsl:variable name="var.weightedValues" as="xs:double*">
          <xsl:for-each select="/measurements/measurement">
            <xsl:value-of select="value * weight"/>
          </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="sum($var.weightedValues)"/>
      </sum>



      <sum description="xpath">
        <!--
            same calculation as one xpath using for
        -->
        <xsl:value-of select="sum(for $m in /measurements/measurement 
                              return $m/value * $m/weight)"/>
      </sum>




      <sum description="templates">
        <!-- 
             recursive template
        -->
        <xsl:call-template name="recSum">
          <xsl:with-param name="measurements" select="/measurements/measurement"/>
        </xsl:call-template>
      </sum>



      <sum description="reduce">
        <!--
            imported reduce/fold-left function (higher order function)
            - template for the calculation
            - start value
            - list of elements
        -->
        <xsl:call-template name="reduce">
          <xsl:with-param name="func" as="element()">
            <WeightSum/> <!-- this refers to the template below -->
          </xsl:with-param>
          <xsl:with-param name="prev" select="0"/>
          <xsl:with-param name="list" select="/measurements/measurement"/>
        </xsl:call-template>
      </sum>
    </sums>
  </xsl:template>

  <!--
      recursive template for the calculation.
  -->
  <xsl:template name="recSum">
    <xsl:param name="measurements" as="element()*"/>
    <xsl:param name="prev" as="xs:double" select="0"/>
    <xsl:choose>
      <xsl:when test="count($measurements) = 0">
        <xsl:value-of select="$prev"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="recSum">
          <xsl:with-param name="measurements" select="$measurements[position() > 1]"/>
          <xsl:with-param name="prev" 
                          select="$prev + 
                                  $measurements[1]/value *  $measurements[1]/weight"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--
      template to be used in the reduce
  -->
  <xsl:template match="WeightSum">
    <xsl:param name="prev" as="xs:double" />
    <xsl:param name="curr" as="element()" />
    <xsl:value-of select="$prev + $curr/value * $curr/weight"/>
  </xsl:template>
</xsl:stylesheet>