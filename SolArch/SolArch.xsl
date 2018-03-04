<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
							  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
							  xmlns:archimate="http://www.archimatetool.com/archimate"
							  xmlns:date="http://exslt.org/dates-and-times">
	<xsl:output indent="yes"  method="html" encoding="utf-8"/>

	<xsl:variable name="SOLARCH">RA Performance Management: Solution Architecture</xsl:variable> 	
	<xsl:template match="/">
		<html>
		  <head>
		    <title>Solution architecture report: <xsl:value-of select="$SOLARCH"/></title>
		  </head>
		  <body>
		    <h1>Solution architecture report: <xsl:value-of select="$SOLARCH"/></h1>
		    <h2>Timestamp: <xsl:value-of select="date:date-time()"/></h2>
		    
		    <table width="100%" border="1">
		    	<thead>
		    		<tr>
		    			<th>Layer</th>
		    			<th>Element Type</th>
		    			<th>Element Name</th>
		    			<th>Descripiton</th>
		    			<th>tbd</th>
		    		</tr>
		    	</thead>
		    	<tbody>
					<xsl:apply-templates select="//element[@name=$SOLARCH]"/>
				</tbody>	
		    </table>
		  </body>
		</html>
	</xsl:template>
	
	<xsl:template match="element[@xsi:type='archimate:ArchimateDiagramModel']">
		<xsl:apply-templates select="descendant::child[@xsi:type='archimate:DiagramObject']"/>
	</xsl:template>
	
	<xsl:template match="child[@xsi:type='archimate:DiagramObject']">
		<xsl:variable name="archimateElement" select="@archimateElement"/>
		<xsl:apply-templates select="//element[@id=$archimateElement]"/>
	</xsl:template>
	
	<xsl:template match="element">
		<xsl:variable name="layer" select="ancestor::node()[@type]"/>
		<tr>
			<td>
				<xsl:value-of select="$layer/@name"/>
			</td>
			<td>
				<xsl:value-of select="@xsi:type"/>
			</td>
			<td>
				<xsl:value-of select="@name"/>
			</td>
			<td>
				<xsl:value-of select="documentation"/>
			</td>
			<td>
				<xsl:apply-templates select="property"/>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="property">
		<xsl:value-of select="@value"/>
	</xsl:template>

</xsl:stylesheet>