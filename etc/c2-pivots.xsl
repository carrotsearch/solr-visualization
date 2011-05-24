<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output indent="yes" omit-xml-declaration="no"
                media-type="application/xml; charset=UTF-8" encoding="utf-8" />

  <xsl:variable name="pivots"><xsl:value-of select="//str[@name = 'facet.pivot']" /></xsl:variable>

  <xsl:template match="/">
    <searchresult>
      <xsl:apply-templates select="response/lst[@name = 'facet_counts']/lst[@name = 'facet_pivot']/arr/lst" />
    </searchresult>
  </xsl:template>

  <xsl:template match="arr[@name = $pivots or @name = 'pivot']/lst">
    <group id="{generate-id(.)}" score="{int[@name = 'count']}">
      <title>
        <phrase><xsl:apply-templates select="*[@name = 'value']" /></phrase>
      </title>
      <xsl:apply-templates select="arr[@name = 'pivot']/lst" />
    </group>
  </xsl:template>
</xsl:stylesheet>

