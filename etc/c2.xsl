<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output indent="yes" omit-xml-declaration="no"
                media-type="application/xml; charset=UTF-8" encoding="utf-8" />

  <xsl:variable name="title.field"><xsl:value-of select="//str[@name = 'carrot.title']" /></xsl:variable>
  <xsl:variable name="snippet.field"><xsl:value-of select="string(/response/lst[@name = 'responseHeader']/lst[@name = 'params']/str[@name = 'carrot.snippet'])" /></xsl:variable>
  <xsl:variable name="url.field"><xsl:value-of select="string(/response/lst[@name = 'responseHeader']/lst[@name = 'params']/str[@name = 'carrot.url'])" /></xsl:variable>

  <xsl:template match="/">
    <searchresult>
      <xsl:apply-templates select="response/result/doc" />
      <xsl:apply-templates select="response/arr[@name = 'clusters']/lst" />
    </searchresult>
  </xsl:template>

  <xsl:template match="doc">
    <document id="{str[@name = 'id']}">
      <title><xsl:value-of select="str[@name = $title.field]" /></title>
      <snippet><xsl:value-of select="str[@name = $snippet.field]" /></snippet>
      <url><xsl:value-of select="str[@name = $url.field]" /></url>
    </document>
  </xsl:template>

  <xsl:template match="arr[@name = 'clusters']/lst">
    <group id="{generate-id(.)}" score="{double[@name = 'score']}">
      <title>
        <xsl:apply-templates select="arr[@name = 'labels']/str" />
      </title>
      <xsl:apply-templates select="arr[@name = 'docs']/str" />
      <xsl:apply-templates select="arr[@name = 'clusters']/lst" />
    </group>
  </xsl:template>

  <xsl:template match="arr[@name = 'labels']/str">
    <phrase>
      <xsl:apply-templates />
    </phrase>
  </xsl:template>

  <xsl:template match="arr[@name = 'docs']/str">
    <document refid="{.}" />
  </xsl:template>
</xsl:stylesheet>

