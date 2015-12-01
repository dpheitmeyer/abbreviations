<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Harvard Abbreviations</title>
                <link rel="stylesheet" href="css/screen.css"/>
            </head>
            <body>
                <h1>Harvard Abbreviations</h1>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="data">
        <div>
            <xsl:for-each-group select="entry" group-by="substring(normalize-space(abbreviation/text()), 1, 1)">
                <a href="#{current-grouping-key()}">
                    <xsl:value-of select="current-grouping-key()"/>
                </a>
                <xsl:if test="position() ne last()">
                    <xsl:text> | </xsl:text>
                </xsl:if>
            </xsl:for-each-group>
        </div>
        <form method="get" action="new">
            <p style="text-align: right;">
                <button>Add Abbreviation</button>
            </p>
        </form>
        <xsl:for-each-group select="entry" group-by="substring(normalize-space(abbreviation/text()), 1, 1)">
            <h2 id="{current-grouping-key()}">
                <xsl:value-of select="current-grouping-key()"/>
            </h2>
            <dl>
                <xsl:apply-templates select="current-group()"/>
            </dl>
        </xsl:for-each-group>
    </xsl:template>
    <xsl:template match="entry">
        <dt>
            <xsl:choose>
                <xsl:when test="string-length(normalize-space(url)) &gt; 0">
                    <a href="{normalize-space(url)}">
                        <xsl:value-of select="abbreviation"/>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="abbreviation"/>
                </xsl:otherwise>
            </xsl:choose>
        </dt>
        <dd>
            <xsl:value-of select="description"/>
        </dd>
    </xsl:template>
</xsl:stylesheet>