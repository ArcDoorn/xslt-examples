<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions" 
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="#all" version="2.0">
  <xsl:output method="text" indent="yes" encoding="UTF-8"/>
  <!--
      Main template to start things going.
  -->
  <xsl:template match="/">
    <xsl:text>

    </xsl:text>
    <xsl:apply-templates select="*">
      <xsl:with-param name="bundleVariable" select="'bundle'" tunnel="yes"/>
    </xsl:apply-templates>
    <xsl:text>

    </xsl:text>
  </xsl:template>

  <!--
      Eat empty text
  -->
  <xsl:template match="text()[matches(., '^\s+$')]"/>

  <!--
      Render object-elements as JSON objects
  -->
  <xsl:template match="object">
    <xsl:text>{</xsl:text>
    <xsl:apply-templates select="*" mode="attribute"/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <!-- Attributes .........................-->

  <!--
      basic attribute template
  -->
  <xsl:template match="*" mode="attribute">
    <xsl:value-of select="name()"/>
    <xsl:text>: </xsl:text>
    <xsl:apply-templates select="*|text()"/>
    <xsl:if test="position()!=last()">, </xsl:if>
  </xsl:template>
  <!--
      text attribute
  -->
  <xsl:template match="text" mode="attribute">
    <xsl:value-of select="name()"/>
    <xsl:text>: '</xsl:text>
    <xsl:apply-templates select="*|text()"/>
    <xsl:text>'</xsl:text>
    <xsl:if test="position()!=last()">, </xsl:if>
  </xsl:template>
  <!--
      text attribute
  -->
  <xsl:template match="i18ntext" mode="attribute">
    <xsl:param name="bundleVariable" tunnel="yes"/>
    <xsl:value-of select="name()"/>
    <xsl:text>: </xsl:text>
    <xsl:value-of select="$bundleVariable"/>
    <xsl:text>.getMsg('</xsl:text>
    <xsl:apply-templates select="*|text()"/>
    <xsl:text>')</xsl:text>
    <xsl:if test="position()!=last()">, </xsl:if>
  </xsl:template>

</xsl:stylesheet>