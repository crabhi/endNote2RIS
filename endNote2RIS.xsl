<?xml version="1.1" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">

    <xsl:output method="text"/>
    <xsl:strip-space elements="*"/>

    <xsl:variable name="newline">
        <xsl:text>&#13;&#10;</xsl:text>
    </xsl:variable>

    <xsl:template name="tagged">
        <xsl:param name="tag" required="yes"/>
        <xsl:param name="context" select="." required="no"/>

        <xsl:value-of select="$tag"/>
        <xsl:text>  - </xsl:text>
        <xsl:value-of select="$context/text()"/>
        <xsl:value-of select="$newline"/>
    </xsl:template>

    <xsl:template match="record">
        <xsl:call-template name="tagged">
            <xsl:with-param name="tag">TY</xsl:with-param>
            <xsl:with-param name="context">ABSTR</xsl:with-param>
        </xsl:call-template>

        <xsl:apply-templates select="*"/>

        <xsl:value-of select="$newline"/>
        <xsl:call-template name="tagged">
            <xsl:with-param name="tag">ER</xsl:with-param>
            <xsl:with-param name="context">End of Reference</xsl:with-param>
        </xsl:call-template>
        <xsl:value-of select="$newline"/>
    </xsl:template>

    <xsl:template match="author">
        <xsl:call-template name="tagged">
            <xsl:with-param name="tag">AU</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="keyword">
        <xsl:call-template name="tagged">
            <xsl:with-param name="tag">KW</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="title">
        <xsl:call-template name="tagged">
            <xsl:with-param name="tag">TI</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="volume">
        <xsl:call-template name="tagged">
            <xsl:with-param name="tag">VL</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="periodical/full-title">
        <xsl:call-template name="tagged">
            <xsl:with-param name="tag">JO</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="year">
        <xsl:call-template name="tagged">
            <xsl:with-param name="tag">PY</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="web-urls/url">
        <xsl:call-template name="tagged">
            <xsl:with-param name="tag">UR</xsl:with-param>
            <xsl:with-param name="context">
                <xsl:text>&#21;</xsl:text>
                <xsl:value-of select="text()"/>
                <xsl:text>&#23;</xsl:text>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="pdf-urls/url">
        <xsl:call-template name="tagged">
            <xsl:with-param name="tag">L1</xsl:with-param>
            <xsl:with-param name="context">
                <xsl:text>file://E:\Marketa\Register notati\DIZERTACE\refman-clanky\</xsl:text>
                <xsl:value-of select="substring-after(text(), 'internal-pdf://')"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="electronic-resource-num">
        <xsl:call-template name="tagged">
            <xsl:with-param name="tag">DO</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="tagged">
            <xsl:with-param name="tag">M3</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="issue">
        <xsl:call-template name="tagged">
            <xsl:with-param name="tag">IS</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="abstract">
        <xsl:call-template name="tagged">
            <xsl:with-param name="tag">AB</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="pages">
        <xsl:text>SP  - </xsl:text>
        <xsl:variable name="sp">
            <xsl:choose>
                <xsl:when test="contains(text(), '-')"><xsl:value-of select="substring-before(text(), '-')"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="text()"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="$sp"/>
        <xsl:value-of select="$newline"/>

        <xsl:text>EP  - </xsl:text>
        <xsl:variable name="ep">
            <xsl:choose>
                <xsl:when test="contains(text(), '-')"><xsl:value-of select="substring-after(text(), '-')"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="text()"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="number($ep) > number($sp)">
                <xsl:value-of select="$ep"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="spLength" select="string-length($sp)"/>
                <xsl:variable name="epLength" select="string-length($ep)"/>

                <xsl:value-of select="concat(substring($sp, 1, $spLength - $epLength), $ep)"/>
            </xsl:otherwise>
        </xsl:choose>

        <xsl:value-of select="$newline"/>
    </xsl:template>

    <xsl:template match="text()"></xsl:template>
</xsl:stylesheet>
