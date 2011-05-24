<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output indent="yes" omit-xml-declaration="no"
                media-type="application/xml; charset=UTF-8" encoding="utf-8" />

  <xsl:template match="/">
    <searchresult>
      <xsl:apply-templates select="response//lst[@name = 'facet_fields']/lst[1]" />
    </searchresult>
  </xsl:template>

  <xsl:template match="lst[@name = 'facet_fields']/lst/int">
    <group id="{generate-id(.)}" score="{.}">
      <title>
        <phrase><xsl:apply-templates select="@name" /></phrase>
      </title>
    </group>
  </xsl:template>
</xsl:stylesheet>

