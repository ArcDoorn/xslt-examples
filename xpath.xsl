<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions" 
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="#all" version="2.0">
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
  <xsl:template match="/">
    <xsl:variable name="var.elements" as="element()+">

      <!-- Sequences ....................................................-->

      <example active=""> 
        List of items: <xsl:value-of select="1, 2, 3" separator=";_"/>
      </example>


      <example active=""> 
        Filtering: <xsl:value-of select="(1, 2, 3, 4, 5, 6)[. mod 2 = 0]" separator=";_"/>
      </example>


      <example active=""> 
        Range: <xsl:value-of select="1 to 10" separator=";_"/>
      </example>


      <example active=""> 
        Mapping: <xsl:value-of select="for $i in /person/person return $i/@name" separator=";_"/>
      </example>


      <example active=""> 
        Equality: <xsl:value-of select="'bob' = ('alice', 'bob', 'eve')"/>
      </example>


      <example active=""> 
        Logical Or: <xsl:value-of select="some $i in 1 to 10 satisfies $i * $i &lt; 3"/>
      </example>


      <example active=""> 
        Logical And:<xsl:value-of select="every $i in 1 to 10 satisfies $i * $i &gt; 3"/>
      </example>


      <example active="">
        Unique values: <xsl:value-of separator=";_"
                         select="fn:distinct-values((1, 'a', 'a', 'b', 'a', 'c', 'b'))"/>
      </example>


      <!-- External documents ..............................................-->

      <example active=""> 
        Import a Document: <xsl:value-of select="fn:document('doc.xml')/books/book[1]/@title"/>
      </example>


      <!-- Regular expressions .............................................-->

      <example active=""> 
        RE Matching: <xsl:value-of select="matches('0551/521 18 18', '^[\d./+\-( )]+$')"/>
      </example>


      <example active=""> 
        RE Replacement: <xsl:value-of select="replace('Sebastian Panknin',           
                                                '([a-zA-Z])[a-zA-Z]+\s+([a-zA-Z]+)', '$2, $1.')"/>
      </example>


      <example active=""> 
        RE Split: <xsl:value-of select="tokenize('file://usr/bin/zsh', '/+')" separator=";_"/>
      </example>


      <!-- Axis for accessing nodes ...................................................-->
      <example active=""> 
   Axis Example:
     <xsl:value-of select="/person/person[1]/person[2]/@name"/>
   * Ancestors:
     <xsl:value-of select="/person/person[1]/person[2]/ancestor::person/@name" separator=";_"/>
   * Parent:
     <xsl:value-of select="/person/person[1]/person[2]/parent::person/@name" separator=";_"/>
   * Children:
     <xsl:value-of select="/person/person[1]/person[2]/child::person/@name" separator=";_"/>
   * Descandants:
     <xsl:value-of select="/person/person[1]/person[2]/descendant::person/@name" separator=";_"/>
   * Following:
     <xsl:value-of select="/person/person[1]/person[2]/following::person/@name" separator=";_"/>
   * Followng Siblings:
     <xsl:value-of select="/person/person[1]/person[2]/following-sibling::person/@name" separator=";_"/>
   * Preceding:
     <xsl:value-of select="/person/person[1]/person[2]/preceding::person/@name" separator=";_"/>
   * Preceding Siblings:
     <xsl:value-of select="/person/person[1]/person[2]/preceding-sibling::person/@name" separator=";_"/>
      </example>

      <!-- Debugging: Comments, Types, Trace and Error ..........................-->

      <example active=""> 
        Comments in X-Path:  <xsl:value-of select="1 + 2 (: a very simple example :)"/>
      </example>


      <example active=""> 
        <xsl:variable select="'2018-12-12'" as="xs:string" name="var.talk"/>
        Type check: <xsl:value-of select="if ($var.talk castable as xs:date) then 
                                             $var.talk cast as xs:date else 'bad date'"/>
      </example>



      <example active=""> 
        <!-- Trace messages: <xsl:value-of select="trace(1 + 2, 'Testing a sum')"/> -->
      </example>


      <example active="">  
        <!-- Throw errors: <xsl:value-of select="error(xs:QName('SebastiansError'), 'My own Error')"/> -->
      </example>

    </xsl:variable>
    <examples>
      <xsl:text>

      </xsl:text>
      <xsl:copy-of select="$var.elements[@active!='']"/>      
      <xsl:text>

</xsl:text>
    </examples>
  </xsl:template>
</xsl:stylesheet>