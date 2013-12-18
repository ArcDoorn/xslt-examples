<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions" 
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="#all" version="2.0">
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
  <xsl:template match="/">
    <children>
      <xsl:for-each-group select="/person/person/person/person" group-by="@sex">
        <xsl:element name="{if (current-grouping-key()='female') then 'girls' else 'boys'}">
          <xsl:for-each select="current-group()">
            <child>
              <name>
                <xsl:value-of select="@name"/>
              </name>
            </child>        
          </xsl:for-each>
        </xsl:element>
      </xsl:for-each-group>
    </children>
  </xsl:template>
</xsl:stylesheet>