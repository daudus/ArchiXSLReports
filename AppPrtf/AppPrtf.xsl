<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
							  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
							  xmlns:archimate="http://www.archimatetool.com/archimate"
							  xmlns:date="http://exslt.org/dates-and-times">
	<xsl:output indent="yes"  method="html" encoding="utf-8"/>
	
	<xsl:variable name="DIAGRAM">TEMP</xsl:variable>
	<xsl:variable name="INNERELEMENTS">yes</xsl:variable>
	
	<xsl:template match="/">

		<html>
		  <head>
		    <title>Application portfolio report: <xsl:value-of select="archimate:model/@name"/></title>
		  </head>
		  <body>
		    <h1>Application portfolio report: <xsl:value-of select="archimate:model/@name"/>.</h1>
		    <h2>Timestamp: <xsl:value-of select="date:date-time()"/></h2>
		    <table width="100%" border="1">
		    	<thead>
		    		<tr>
		    			<th>Order</th>
		    			<th>Application Name</th>
		    			<th>Descripiton</th>
		    			<th>Delivery Type</th>
		    			<th>Criticality</th>
		    			<th>System Type</th>
		    		</tr>
		    	</thead>
		    	<tbody>
					<xsl:apply-templates select="//element[@name=$DIAGRAM]/child[@xsi:type='archimate:DiagramObject']">
					</xsl:apply-templates>
				</tbody>	
		    </table>
		  </body>
		</html>
	</xsl:template>
	
	<xsl:template match="child[@xsi:type='archimate:DiagramObject']">
		<xsl:variable name="idElement" select="@archimateElement"/>
		<xsl:variable name="element" select="//folder[@name='Application']//element[@xsi:type='archimate:ApplicationComponent'][@id=$idElement]"/>
		<xsl:variable name="orderElement">
			<xsl:number value="position()" format="1"/>
		</xsl:variable>
		<tr>
			<td>
				<xsl:value-of select="format-number($orderElement, '###')"/>
			</td>
			<td>
				<xsl:value-of select="$element/@name"/>
			</td>
			<td>
				<xsl:value-of select="$element/documentation"/>
			</td>
			<td>
				<xsl:apply-templates select="$element/property[@key='EA_DeliveryType']"/>
			</td>
			<td>
				<xsl:apply-templates select="$element/property[@key='EA_BusinessCriticality']"/>
			</td>
			<td>
				<xsl:apply-templates select="$element/property[@key='EA_SystemType']"/>
			</td>
		</tr>
		<xsl:if test="$INNERELEMENTS = 'yes'">
			<xsl:apply-templates select="child[@xsi:type='archimate:DiagramObject']">
						</xsl:apply-templates>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="property">
		<xsl:value-of select="@value"/>
	</xsl:template>

</xsl:stylesheet>