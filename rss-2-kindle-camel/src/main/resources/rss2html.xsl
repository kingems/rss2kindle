<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:content="http://purl.org/rss/1.0/modules/content/"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:epub="http://www.idpf.org/2007/ops">

    <xsl:output method="html" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
                <title>
                    <xsl:value-of select="//rss/channel/title"/>
                </title>
            </head>
<!--
            <nav epub:type="toc">
                <ol>
                    <xsl:for-each select="//rss/channel/item">
                        <li><a href="#{link}"><xsl:value-of select="title"/></a></li>
                    </xsl:for-each>
                </ol>
            </nav>
-->
            <body>
                <div id="toc">
                    <h2>
                        Table of Contents
                    </h2>
                    <ol>
                        <xsl:for-each select="//rss/channel/item">
                            <li><a href="#{link}"><xsl:value-of select="title"/></a></li>
                        </xsl:for-each>
                    </ol>
                </div>
                <xsl:for-each select="//rss/channel/item">
                    <xsl:call-template name="item"/>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="item">
        <h2 id="{link}"><xsl:value-of select="title"/></h2>
        <xsl:choose>
            <xsl:when test="count(content:encoded)=0">
                <p>
                    <xsl:value-of select="description" disable-output-escaping="yes"/>
                </p>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:value-of select="content:encoded" disable-output-escaping="yes"/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>