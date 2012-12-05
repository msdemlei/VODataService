<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:vr="http://www.ivoa.net/xml/VOResource/v1.0" 
                xmlns:vg="http://www.ivoa.net/xml/VORegistry/v1.0" 
                xmlns:vs="http://www.ivoa.net/xml/VODataService/v1.1" 
                xmlns:cs="http://www.ivoa.net/xml/ConeSearch/v1.0" 
                xmlns:sia="http://www.ivoa.net/xml/SIA/v1.0" 
                xmlns:sn="http://www.ivoa.net/xml/OpenSkyNode/v0.2" 
                xmlns:stc="http://www.ivoa.net/xml/STC/stc-v1.30.xsd" 
                xmlns:vs2="http://www.ivoa.net/xml/VODataService/v1.0" 
                xmlns:xlink="http://www.w3.org/1999/xlink" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:xs="http://www.w3.org/2001/XMLSchema" 
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
                version="1.0">

   <!-- 
     -  Stylesheet to convert VOResource records from VODataService v1.0
     -   to VODataService v1.1
     -->
   <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

   <xsl:preserve-space elements="*"/>

   <!--
     -  If true, insert carriage returns and indentation to produce a neatly 
     -  formatted output.  If false, any spacing between tags in the source
     -  document will be preserved.  
     -->
   <xsl:param name="prettyPrint" select="false()"/>

   <!--
     -  the per-level indentation.  Set this to a sequence of spaces when
     -  pretty printing is turned on.
     -->
   <xsl:param name="indent">
      <xsl:for-each select="/*/*[2]">
         <xsl:call-template name="getindent"/>
      </xsl:for-each>
   </xsl:param>

   <!--
     -  The prefix to prepend to schema files listed in the xsi:schemaLocation
     -  (if used).  The value should include a trailing slash as necessary.
     -  The default is an empty string, which indicates the current working 
     -  directory (where output is used).  Note that the xsi:schemaLocation 
     -  is only set if it is set on the input.
     -->
   <xsl:param name="schemaLocationPrefix"/>

   <!--
     -  Set to 1 if the xsi:schemaLocation should be set or zero if it should
     -  not be.  If not set at all (default), xsi:schemaLocation is only set 
     -  if it is set on the input.
     -->
   <xsl:param name="setSchemaLocation"/>

   <!--
     -  Set to 0 or greater if a default validationLevel should set
     -  as all possible locations.  If greater than -1, the value will 
     -  be the value of the validationLevel.  You must also provide
     -  an ID to the validatedBy parameter below in order for the level
     -  to be set.  
     -->
   <xsl:param name="validationLevel" select="-1"/>

   <!-- 
     -  Set to the IVOA identifier of your validating registry.  This 
     -  must be set for validation levels to be added.  
     -->
   <xsl:param name="validatedBy"/>

   <!--
     -  If set, the updated atribute will be set to this value
     -->
   <xsl:param name="today"/>

   <!--
     -  If set, the output document will have a root element of this
     -  name and a namespace given by $resourceNS and it will contain
     -  the VOResource metadata; all other wrapping elements from the
     -  input will be filtered out. 
     -
     -  the following setting will produce records
     -  that can be inserted directly into a Harvest response record.
     -->
   <xsl:param name="resourceElement">Resource</xsl:param>

   <xsl:template match="/">
      <xsl:apply-templates select="*" />
   </xsl:template>

   <!--
     -  Copy a VODataService type unchanged
     -->
   <xsl:template match="*" priority="-2">
      <xsl:param name="sp"/>
      <xsl:param name="step"/>

      <xsl:variable name="elname">
         <xsl:call-template name="uncapitalize">
            <xsl:with-param name="in" select="local-name()"/>
         </xsl:call-template>
      </xsl:variable>

      <xsl:value-of select="$sp"/>

      <xsl:element name="local-name()">
         <xsl:for-each select="@*">
            <xsl:copy/>
         </xsl:for-each>

         <xsl:apply-templates select="child::node()">
            <xsl:with-param name="sp" select="concat($sp,$step)"/>
            <xsl:with-param name="step" select="$step"/>
         </xsl:apply-templates>

         <xsl:value-of select="$sp"/>
      </xsl:element>

   </xsl:template>



</xsl:stylesheet>
