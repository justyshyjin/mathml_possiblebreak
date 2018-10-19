<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version='2.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:mml="http://www.w3.org/1998/Math/MathML">
  <xsl:output method="xml" indent="yes"/>
    <xsl:template match="*">
        <xsl:element name="{name()}">
          <xsl:apply-templates select="@*"/>
          <xsl:apply-templates select="node()"/>
        </xsl:element>
      </xsl:template>

      <xsl:template match="@*">
        <xsl:attribute name="{name()}"><xsl:value-of select="(.)" /></xsl:attribute>
      </xsl:template>

        <xsl:template match="*:mfenced">
            <xsl:element name="mrow">
                <xsl:attribute name="meaning"><xsl:text>fenced</xsl:text></xsl:attribute>
                <xsl:choose>
                    <xsl:when test="@open or @open='[' or @open='' or @open='{'">
                        <mo>
                            <xsl:attribute name="meaning">
                                <xsl:text>open</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="@open"></xsl:value-of>
                        </mo>
                    </xsl:when>
                    <xsl:otherwise>
                        <mo>(</mo>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="@separators and @separators!=''">
                      <xsl:variable name="separator" select="@separators"/>
                      <xsl:for-each select="*">
                        <xsl:apply-templates select="."/>
                        <xsl:text>&#10;</xsl:text>
                        <xsl:if test="following-sibling::*">
                          <xsl:choose>
                            <xsl:when test="position() &lt;= string-length($separator)">
                              <mo><xsl:value-of select="substring($separator,position(),1)"/></mo>
                            </xsl:when>
                            <xsl:when test="position() &gt; string-length($separator)">
                              <mo><xsl:value-of select="substring($separator,string-length($separator),1)"/></mo>
                            </xsl:when>
                          </xsl:choose>
                          <xsl:text>&#10;</xsl:text>
                        </xsl:if>
                      </xsl:for-each>
                    </xsl:when>
                    <xsl:when test="@separators=''">
                      <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:for-each select="*">
                        <xsl:apply-templates select="."/>
                        <xsl:text>&#10;</xsl:text>
                        <xsl:if test="following-sibling::*">
                          <mo>,</mo>
                          <xsl:text>&#10;</xsl:text>
                        </xsl:if>
                      </xsl:for-each>
                    </xsl:otherwise>
                  </xsl:choose>
                <xsl:choose>
                    <xsl:when test="@close or @close=']' or @close='' or @close='}'">
                        <mo>
                            <xsl:attribute name="meaning">
                                <xsl:text>close</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="@close"></xsl:value-of>
                        </mo>
                    </xsl:when>
                    <xsl:otherwise>
                        <mo>)</mo>
                    </xsl:otherwise>
                </xsl:choose>

            </xsl:element>
        </xsl:template>

        <xsl:template match="*:mfrac">
            <xsl:choose>
                <xsl:when test="@linethickness='0pt'">
                <mtable>
                    <xsl:for-each select="*">
                        <mtr>
                            <mtd>
                            <xsl:apply-templates select="node()"/>
                            </mtd>
                        </mtr>
                    </xsl:for-each>
                </mtable>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="{name()}">
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="node()"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:template>

        <xsl:template match="*:math/mrow">
            <xsl:choose>
                <xsl:when test="following-sibling::mrow">
                    <xsl:element name="{name()}">
                        <xsl:apply-templates select="node()"/>
                        <xsl:apply-templates select="following-sibling::mrow/node()"/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <!--    <xsl:apply-templates select="node()"/> -->
                </xsl:otherwise>
            </xsl:choose>
        </xsl:template>

        <xsl:template match="*:mo[matches(.,'[&#x2005;&#x00A0;&#x2000;&#x2001;&#x2002;&#x2003;&#x2004;&#x2006;&#x2007;&#x2008;&#x2009;&#x202F;&#x205F;&#x3000;&#x200B;&#x200C;&#x200D;&#x2060;&#xFEFF;]')]|*:mi[matches(.,'[&#x2005;&#x00A0;&#x2000;&#x2001;&#x2002;&#x2003;&#x2004;&#x2006;&#x2007;&#x2008;&#x2009;&#x202F;&#x205F;&#x3000;&#x200B;&#x200C;&#x200D;&#x2060;&#xFEFF;]')]|*:mtext[matches(.,'[&#x2005;&#x00A0;&#x2000;&#x2001;&#x2002;&#x2003;&#x2004;&#x2006;&#x2007;&#x2008;&#x2009;&#x202F;&#x205F;&#x3000;&#x200B;&#x200C;&#x200D;&#x2060;&#xFEFF;]')]">
        <xsl:variable name="eleName" select="name()"/>
        <mrow>
          <xsl:analyze-string select="." regex="&#x2003;">
        <xsl:matching-substring>
          <mspace>
            <xsl:attribute name="width"><xsl:text>1em</xsl:text></xsl:attribute>
          </mspace>
        </xsl:matching-substring>
      </xsl:analyze-string>
      <xsl:analyze-string select="." regex="&#x2005;">
            <xsl:matching-substring>
              <mspace>
            <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
              </mspace>
            </xsl:matching-substring>
      </xsl:analyze-string>
      <xsl:analyze-string select="." regex="&#x00A0;">
            <xsl:matching-substring>
              <mspace>
            <xsl:attribute name="width"><xsl:text>.50em</xsl:text></xsl:attribute>
              </mspace>
            </xsl:matching-substring>
      </xsl:analyze-string>
      <xsl:analyze-string select="." regex="&#x2000;">
            <xsl:matching-substring>
              <mspace>
            <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
              </mspace>
            </xsl:matching-substring>
      </xsl:analyze-string>
      <xsl:analyze-string select="." regex="&#x2001;">
            <xsl:matching-substring>
              <mspace>
            <xsl:attribute name="width"><xsl:text>1em</xsl:text></xsl:attribute>
              </mspace>
            </xsl:matching-substring>
      </xsl:analyze-string>
      <xsl:analyze-string select="." regex="&#x2002;">
            <xsl:matching-substring>
              <mspace>
            <xsl:attribute name="width"><xsl:text>.50em</xsl:text></xsl:attribute>
              </mspace>
            </xsl:matching-substring>
      </xsl:analyze-string>
      <xsl:analyze-string select="." regex="&#x2004;">
            <xsl:matching-substring>
              <mspace>
            <xsl:attribute name="width"><xsl:text>.33em</xsl:text></xsl:attribute>
              </mspace>
            </xsl:matching-substring>
      </xsl:analyze-string>
      <xsl:analyze-string select="." regex="&#x2006;">
            <xsl:matching-substring>
              <mspace>
            <xsl:attribute name="width"><xsl:text>.16em</xsl:text></xsl:attribute>
              </mspace>
            </xsl:matching-substring>
      </xsl:analyze-string>
      <xsl:analyze-string select="." regex="&#x2007;">
            <xsl:matching-substring>
              <mspace>
            <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
              </mspace>
            </xsl:matching-substring>
      </xsl:analyze-string>
      <xsl:analyze-string select="." regex="&#x2008;">
            <xsl:matching-substring>
              <mspace>
            <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
              </mspace>
            </xsl:matching-substring>
      </xsl:analyze-string>
      <xsl:analyze-string select="." regex="&#x2009;">
            <xsl:matching-substring>
              <mspace>
            <xsl:attribute name="width"><xsl:text>.2em</xsl:text></xsl:attribute>
              </mspace>
            </xsl:matching-substring>
      </xsl:analyze-string>
      <xsl:analyze-string select="." regex="&#x202F;">
            <xsl:matching-substring>
              <mspace>
            <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
              </mspace>
            </xsl:matching-substring>
      </xsl:analyze-string>
      <xsl:analyze-string select="." regex="&#x205F;">
            <xsl:matching-substring>
              <mspace>
            <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
              </mspace>
            </xsl:matching-substring>
      </xsl:analyze-string>
      <xsl:analyze-string select="." regex="&#x3000;">
            <xsl:matching-substring>
              <mspace>
            <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
              </mspace>
            </xsl:matching-substring>
      </xsl:analyze-string>
      <xsl:analyze-string select="." regex="&#x200B;">
            <xsl:matching-substring>
              <mspace>
            <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
              </mspace>
            </xsl:matching-substring>
      </xsl:analyze-string>
      <xsl:analyze-string select="." regex="&#x200C;">
            <xsl:matching-substring>
              <mspace>
            <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
              </mspace>
            </xsl:matching-substring>
      </xsl:analyze-string>
      <xsl:analyze-string select="." regex="&#x200D;">
            <xsl:matching-substring>
              <mspace>
            <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
              </mspace>
            </xsl:matching-substring>
      </xsl:analyze-string>
      <xsl:analyze-string select="." regex="&#x2060;">
            <xsl:matching-substring>
              <mspace>
            <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
              </mspace>
            </xsl:matching-substring>
      </xsl:analyze-string>
      <xsl:analyze-string select="." regex="&#xFEFF;">
            <xsl:matching-substring>
              <mspace>
            <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
              </mspace>
            </xsl:matching-substring>
      </xsl:analyze-string>
      <xsl:analyze-string select="." regex="&#x2005;">
            <xsl:matching-substring>
              <mspace>
            <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
              </mspace>
            </xsl:matching-substring>
      </xsl:analyze-string>
        </mrow>
      </xsl:template>

      <xsl:template match="*:munderover|*:msub|*:msup|*:msubsup|*:munder|*:mover|*:mmultiscripts">
            <xsl:variable name="embellishedValue" select="normalize-space(*[1])"/>
            <xsl:element name="{name()}">
                <xsl:attribute name="meaning"><xsl:text>bigop</xsl:text></xsl:attribute>
                <xsl:attribute name="embellished">
                    <xsl:value-of select="$embellishedValue"/>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:template>

        <xsl:template match="*:mo">
            <xsl:element name="{name()}">
                <xsl:choose>
                    <xsl:when test="parent::mrow[parent::munderover] or parent::munderover">
                        <xsl:attribute name="meaning">
                            <xsl:choose>
                                <xsl:when test="(parent::mrow and count(../preceding-sibling::*) = 0) or (contains(name(),'^(mo)$') and count(preceding-sibling::*) = 0)">
                                    <xsl:text>bigop</xsl:text>
                                </xsl:when>
                                <xsl:otherwise><xsl:text>operator</xsl:text></xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:when>
                    <xsl:when test="parent::mrow[parent::msubsup] or parent::msubsup">
                        <xsl:attribute name="meaning">
                            <xsl:text>operator</xsl:text>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:when>
                    <!-- <xsl:otherwise>
                         <xsl:apply-templates/>
                    </xsl:otherwise> -->
                </xsl:choose>
            </xsl:element>
            <xsl:choose>
              <xsl:when test="node()='{' or node()='('">
                      <xsl:element name="mrow">
                        <xsl:attribute name="meaning"><xsl:text>fenced</xsl:text></xsl:attribute>
                        <xsl:element name="{name()}">
                          <xsl:attribute name="meaning">
                              <xsl:text>open</xsl:text>
                          </xsl:attribute>
                          <xsl:value-of select="node()"></xsl:value-of>
                        </xsl:element>
                      </xsl:element>
                    </xsl:when>
            </xsl:choose>
        </xsl:template>

      <!-- <xsl:template match="munderover">
        <xsl:variable name="moperator">
          <xsl:value-of select="mo"/>
        </xsl:variable>
        <xsl:element name="{name()}">
          <xsl:attribute name="meaning"><xsl:text>bigop</xsl:text></xsl:attribute>
          <xsl:attribute name="embellished"><xsl:value-of select="$moperator"/></xsl:attribute>
          <xsl:if test="mo">
            <xsl:element name="mo">
              <xsl:attribute name="meaning">
                  <xsl:text>bigop</xsl:text>
              </xsl:attribute>
              <xsl:value-of select="$moperator"/>
            </xsl:element>
          </xsl:if>
            <xsl:if test="mrow">
              <xsl:element name="mrow">
              <xsl:for-each select="*">
                <xsl:choose>
                  <xsl:when test="mo[.='=']">
                    <mo meaning="operator">
                      <xsl:value-of select="mo"/>
                    </mo>
                  </xsl:when>
                  <xsl:otherwise>
                      <xsl:apply-templates/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:for-each>
          </xsl:element>
          </xsl:if
          >

        </xsl:element>
      </xsl:template> -->


</xsl:stylesheet>