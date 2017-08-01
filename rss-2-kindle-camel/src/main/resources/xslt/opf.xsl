<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:opf="http://www.idpf.org/2007/opf"
                xmlns:asd="http://www.idpf.org/asdfaf"
                xmlns:dc="http://purl.org/metadata/dublin_core"
                xmlns:oebpackage="http://openebook.org/namespaces/oeb-package/1.0/">

    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/">

        <package unique-identifier="uid" xmlns:opf="http://www.idpf.org/2007/opf"
                 xmlns:asd="http://www.idpf.org/asdfaf">
            <metadata>
                <dc-metadata xmlns:dc="http://purl.org/metadata/dublin_core"
                             xmlns:oebpackage="http://openebook.org/namespaces/oeb-package/1.0/">
                    <dc:Title><xsl:value-of select="//rss/channel/title"/></dc:Title>
                    <dc:Language> <xsl:value-of select="//rss/channel/language"/></dc:Language>
                    <dc:Creator> <xsl:value-of select="//rss/channel/link"/></dc:Creator>
                    <dc:Copyrights> <xsl:value-of select="//rss/channel/link"/></dc:Copyrights>
                    <dc:Publisher>Publisher</dc:Publisher>
                    <x-metadata>
                        <!--EmbeddedCover>images/cover.jpg</EmbeddedCover-->
                    </x-metadata>
                </dc-metadata>
            </metadata>
            <manifest>
                <item id="toc" media-type="text/x-oeb1-document" href="toc.html"></item>
                <item id="ncx" media-type="application/x-dtbncx+xml" href="toc.ncx"/>
                <item id="text" media-type="text/x-oeb1-document" href="test_output.html"></item>
                <!--item id="Images" media-type="text/x-oeb1-document" href="Images.html"></item>
                <item id="background" media-type="text/x-oeb1-document" href="background.html"></item-->
            </manifest>
            <spine toc="ncx">
                <itemref idref="toc"/>
                <itemref idref="text"/>
                <!--itemref idref="Images"/>
                <itemref idref="background"/-->
            </spine>
            <guide>
                <reference type="toc" title="Table of Contents" href="toc.html"/>
                <reference type="text" title="Book" href="test_output.html"/>
            </guide>
        </package>
    </xsl:template>
</xsl:stylesheet>