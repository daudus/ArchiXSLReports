<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:archimate="http://www.archimatetool.com/archimate">
	<xsl:output indent="yes"  method="html" encoding="utf-8"/>
	
	<xsl:template match="/">
		<html>
		  <head>
		    <title>Application portfolio report: <xsl:value-of select="archimate:model/@name"/></title>
		  </head>
		  <body>
		    <h1>Application portfolio report: <xsl:value-of select="archimate:model/@name"/></h1>
		    
		    <table width="100%" border="1">
		    	<thead>
		    		<tr>
		    			<th>Application Name</th>
		    			<th>Descripiton</th>
		    			<th>Delivery Type</th>
		    		</tr>
		    	</thead>
		    	<tbody>
					<xsl:apply-templates select="//element[@name='30001*AA:Application Landscape']/child[@xsi:type='archimate:DiagramObject']">
					</xsl:apply-templates>
				</tbody>	
		    </table>
		  </body>
		</html>
	</xsl:template>
	
	<xsl:template match="child[@xsi:type='archimate:DiagramObject']">
		<xsl:variable name="idElement" select="@archimateElement"/>
		<xsl:variable name="element" select="//folder[@name='Application']//element[@xsi:type='archimate:ApplicationComponent'][@id=$idElement]"/>
		<tr>
			<td>
				<xsl:value-of select="$element/@name"/>
			</td>
			<td>
				<xsl:value-of select="$element/documentation"/>
			</td>
			<td>
				<xsl:apply-templates select="$element/property[@key='EA_DeliveryType']"/>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="property">
		<xsl:value-of select="@value"/>
	</xsl:template>

</xsl:stylesheet>