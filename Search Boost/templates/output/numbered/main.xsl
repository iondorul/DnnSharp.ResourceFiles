﻿<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:tokens="sb:tokens"
                xmlns:html="sb:html">
    
<xsl:import href="../../.common/social-sharing.xsl"/>
<xsl:output method="html" />
<xsl:template match="/search">

    <!-- Example of using tokens in the template -->
    <!-- <xsl:value-of select="tokens:Replace('[QueryString:MyTest]')" /> -->
            
    <div class = "sb-numbered" >
        <div class = "avtsb_title_big">
            Displaying results <b><xsl:value-of select="summary/first_result" /> - <xsl:value-of select="summary/last_result" /></b>
        </div>

		<xsl:if test="summary/current-facets/cat"> 
			<div class="sb-pnlcurrentfacets">
				Filtering by 
				<xsl:for-each select = "summary/current-facets/cat">
					<a class="sb-facet">
						<xsl:attribute name="href"><xsl:value-of select="url" /></xsl:attribute>
						<xsl:value-of select="name" /></a>&#160;
				</xsl:for-each>
				(<a class="sb-facet"><xsl:attribute name="href"><xsl:value-of select="summary/current-facets/clearurl" /></xsl:attribute>Clear Filters</a>)
			</div>
		</xsl:if>
			
		<xsl:if test="summary/facets/cat != ''">
			<div class="sb-pnlfacets">
			<xsl:for-each select = "summary/facets/cat">
				<a class="sb-facet">
					<xsl:attribute name="href"><xsl:value-of select="url" /></xsl:attribute>
					<xsl:value-of select="name" /> (<xsl:value-of select="count" />)</a>&#160;
			</xsl:for-each>
			</div>
		</xsl:if>
		
		<ol class="sb-results">
        <xsl:attribute name="start"><xsl:value-of select="/search/summary/first_result" /></xsl:attribute>
        <xsl:for-each select = "results/result">
            <li class = "avtsb_result">
			
				<!-- <xsl:value-of select="data/field[@name='data1']" /> -->
			
                <a class = "avtsb_title">
                    <xsl:if test="target">
                        <xsl:attribute name="target"><xsl:value-of select="target" /></xsl:attribute>
                    </xsl:if>
                    <xsl:attribute name="href"><xsl:value-of select="url" /></xsl:attribute>
                    <!-- <xsl:value-of select="substring(title,19)" disable-output-escaping="yes" /> -->
                    <xsl:attribute name="onclick">window.location = '<xsl:value-of select="urlfwd" />'; return false;</xsl:attribute>
                    <xsl:value-of select="title" disable-output-escaping="yes" />
                </a>

				<div class = "avtsb_url">
                    <xsl:value-of select="plainurl" />
                </div>
                <div class = "avtsb_desc">
                    <xsl:value-of select="description" disable-output-escaping="yes" />
                </div>
				<div style="clear: both;"></div>

				<xsl:if test="count(/search/summary/social/*) > 0">
					<div style="float: left; margin: 0 6px 0 0;">
					<xsl:call-template name="social-sharing">
					  <xsl:with-param name="title"><xsl:value-of select="html:stripHtml(title)" disable-output-escaping="yes" /></xsl:with-param>
					  <xsl:with-param name="desc"><xsl:value-of select="description" disable-output-escaping="yes" /></xsl:with-param>
					  <xsl:with-param name="url"><xsl:value-of select="url" /></xsl:with-param>
					</xsl:call-template>
					</div>
				</xsl:if>
				
				<xsl:if test="/search/summary/morelikethis">
				<div style="float: left; margin: 4px 0 0 0;">
					<a>
						<xsl:attribute name="href"><xsl:value-of select="/search/summary/morelikethis/baseurl" />&amp;sb-mlt=<xsl:value-of select="docid" /></xsl:attribute>
						More like this
					</a>
				</div>
				</xsl:if>
				
				<div style="clear: both;"></div>

            </li>
        </xsl:for-each>
		</ol>

        <xsl:if test = "summary/pagecount &gt; 1">
            <div class = "avtsb_pager">
				<xsl:if test="summary/pages/more-before-first">
					...
				</xsl:if>
				<xsl:for-each select = "summary/pages/p">
					<xsl:choose>
						<xsl:when test = "/search/summary/activepage = @ipage">
							<span class = "avtsbSelPage"><xsl:value-of select = "@ipage"/></span>
						</xsl:when>
						<xsl:otherwise>
							<a class = "avtsbPageLink">
								<xsl:attribute name="href"><xsl:value-of select="." /></xsl:attribute>
								<xsl:value-of select = "@ipage"/>
							</a>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				<xsl:if test="summary/pages/more-after-last">
					...
				</xsl:if>
            </div>
        </xsl:if>
     
        <div class =" avtsb_comment">
        Your search for <b><xsl:value-of select="summary/term" disable-output-escaping="yes" /></b> generated <b><xsl:value-of select="summary/resultcount" /></b> results in <xsl:value-of select="summary/execution_time" /> seconds.
        </div>
    </div>
</xsl:template>
    
    
</xsl:stylesheet>