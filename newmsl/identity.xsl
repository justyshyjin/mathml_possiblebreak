<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ce="http://www.elsevier.com/xml/common/dtd"
                xmlns:sb="http://www.elsevier.com/xml/common/struct-bib/dtd"
                xmlns:xlink="http://www.w3.org/1999/xlink"
		xmlns:mml="http://www.w3.org/1998/Math/MathML"
		xmlns:cja="http://www.elsevier.com/xml/cja/dtd"
		xmlns:ja="http://www.elsevier.com/xml/ja/dtd"
		xmlns:mrw="http://www.elsevier.com/xml/mrw/dtd"
		xmlns:ca="http://www.elsevier.com/xml/common/cals/dtd"
		xmlns:tb="http://www.elsevier.com/xml/common/table/dtd"
		xmlns:hs="http://www.elsevier.com/xml/ehs-book/dtd"
		xmlns:bk="http://www.elsevier.com/xml/bk/dtd"
		xmlns:si="http://www.elsevier.com/xml/si/dtd"
		xmlns:vt="http://www.elsevier.com/xml/apps/qc/v"
		xmlns:epb="http://www.elsevier.com/xml/epb/dtd"
		xmlns:ef="http://www.elsevier.com/xml/ef/dtd"
		xmlns:sa="http://www.elsevier.com/xml/common/struct-aff/dtd"
		exclude-result-prefixes="ce sb xlink mml cja ja ca tb hs bk mrw si epb ef"
                version='2.0'>
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
                        <mml:mo>
                            <xsl:attribute name="meaning">
                                <xsl:text>open</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="@open"></xsl:value-of>
                        </mml:mo>
                    </xsl:when>
                    <xsl:otherwise>
                        <mml:mo>(</mml:mo>
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
                              <mml:mo><xsl:value-of select="substring($separator,position(),1)"/></mml:mo>
                            </xsl:when>
                            <xsl:when test="position() &gt; string-length($separator)">
                            <mml:mo><xsl:value-of select="substring($separator,string-length($separator),1)"/></mml:mo>
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
                          <mml:mo>,</mml:mo>
                          <xsl:text>&#10;</xsl:text>
                        </xsl:if>
                      </xsl:for-each>
                    </xsl:otherwise>
                  </xsl:choose>
                <xsl:choose>
                    <xsl:when test="@close or @close=']' or @close='' or @close='}'">
                        <mml:mo>
                            <xsl:attribute name="meaning">
                                <xsl:text>close</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="@close"></xsl:value-of>
                        </mml:mo>
                    </xsl:when>
                    <xsl:otherwise>
                        <mml:mo>)</mml:mo>
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
                                <xsl:copy-of select="."/>
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
          <mml:mrow>
            <xsl:analyze-string select="." regex="&#x2003;">
              <xsl:matching-substring>
		<mspace>
		  <xsl:attribute name="width"><xsl:text>1em</xsl:text></xsl:attribute>
		</mspace>
              </xsl:matching-substring>
              <xsl:non-matching-substring>
		<xsl:analyze-string select="." regex="&#x2005;">
		  <xsl:matching-substring>
		    <mspace>
		      <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
		    </mspace>
		  </xsl:matching-substring>
		  <xsl:non-matching-substring>
		    <xsl:analyze-string select="." regex="&#x00A0;">
		      <xsl:matching-substring>
			<mspace>
			  <xsl:attribute name="width"><xsl:text>1em</xsl:text></xsl:attribute>
			</mspace>
		      </xsl:matching-substring>
		      <xsl:non-matching-substring>
			<xsl:analyze-string select="." regex="&#x2000;">
			  <xsl:matching-substring>
			    <mspace>
			      <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
			    </mspace>
			  </xsl:matching-substring>
			  <xsl:non-matching-substring>
			    <xsl:analyze-string select="." regex="&#x2001;">
			      <xsl:matching-substring>
				<mspace>
				  <xsl:attribute name="width"><xsl:text>1em</xsl:text></xsl:attribute>
				</mspace>
			      </xsl:matching-substring>
			      <xsl:non-matching-substring>
				<xsl:analyze-string select="." regex="&#x2002;">
				  <xsl:matching-substring>
				    <mspace>
				      <xsl:attribute name="width"><xsl:text>.50em</xsl:text></xsl:attribute>
				    </mspace>
				  </xsl:matching-substring>
				  <xsl:non-matching-substring>
				    <xsl:analyze-string select="." regex="&#x2004;">
				      <xsl:matching-substring>
					<mspace>
					  <xsl:attribute name="width"><xsl:text>.33em</xsl:text></xsl:attribute>
					</mspace>
				      </xsl:matching-substring>
				      <xsl:non-matching-substring>
					<xsl:analyze-string select="." regex="&#x2006;">
					  <xsl:matching-substring>
					    <mspace>
					      <xsl:attribute name="width"><xsl:text>.16em</xsl:text></xsl:attribute>
					    </mspace>
					  </xsl:matching-substring>
					  <xsl:non-matching-substring>
					    <xsl:analyze-string select="." regex="&#x2007;">
					      <xsl:matching-substring>
						<mspace>
						  <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
						</mspace>
					      </xsl:matching-substring>
					      <xsl:non-matching-substring>
						<xsl:analyze-string select="." regex="&#x2008;">
						  <xsl:matching-substring>
						    <mspace>
						      <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
						    </mspace>
						  </xsl:matching-substring>
						  <xsl:non-matching-substring>
						    <xsl:analyze-string select="." regex="&#x2009;">
						      <xsl:matching-substring>
							<mspace>
							  <xsl:attribute name="width"><xsl:text>.2em</xsl:text></xsl:attribute>
							</mspace>
						      </xsl:matching-substring>
						      <xsl:non-matching-substring>
							<xsl:analyze-string select="." regex="&#x202F;">
							  <xsl:matching-substring>
							    <mspace>
							      <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
							    </mspace>
							  </xsl:matching-substring>
							  <xsl:non-matching-substring>
							    <xsl:analyze-string select="." regex="&#x205F;">
							      <xsl:matching-substring>
								<mspace>
								  <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
								</mspace>
							      </xsl:matching-substring>
							      <xsl:non-matching-substring>
								<xsl:analyze-string select="." regex="&#x3000;">
								  <xsl:matching-substring>
								    <mspace>
								      <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
								    </mspace>
								  </xsl:matching-substring>
								  <xsl:non-matching-substring>
								    <xsl:analyze-string select="." regex="&#x200B;">
								      <xsl:matching-substring>
									<mspace>
									  <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
									</mspace>
								      </xsl:matching-substring>
								      <xsl:non-matching-substring>
									<xsl:analyze-string select="." regex="&#x200C;">
									  <xsl:matching-substring>
									    <mspace>
									      <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
									    </mspace>
									  </xsl:matching-substring>
									  <xsl:non-matching-substring>
									    <xsl:analyze-string select="." regex="&#x200D;">
									      <xsl:matching-substring>
										<mspace>
										  <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
										</mspace>
									      </xsl:matching-substring>
									      <xsl:non-matching-substring>
										<xsl:analyze-string select="." regex="&#x2060;">
										  <xsl:matching-substring>
										    <mspace>
										      <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
										    </mspace>
										  </xsl:matching-substring>
										  <xsl:non-matching-substring>
										    <xsl:analyze-string select="." regex="&#xFEFF;">
										      <xsl:matching-substring>
											<mspace>
											  <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
											</mspace>
										      </xsl:matching-substring>
										      <xsl:non-matching-substring>
											<xsl:analyze-string select="." regex="&#x2005;">
											  <xsl:matching-substring>
											    <mspace>
											      <xsl:attribute name="width"><xsl:text>.25em</xsl:text></xsl:attribute>
											    </mspace>
											  </xsl:matching-substring>
											  <xsl:non-matching-substring>
											    <xsl:element name="{$eleName}">
											      <xsl:value-of select="."/>
											    </xsl:element>
											  </xsl:non-matching-substring>
											</xsl:analyze-string>
										      </xsl:non-matching-substring>
										    </xsl:analyze-string>
										  </xsl:non-matching-substring>
										</xsl:analyze-string>
									      </xsl:non-matching-substring>
									    </xsl:analyze-string>
									  </xsl:non-matching-substring>
									</xsl:analyze-string>
								      </xsl:non-matching-substring>
								    </xsl:analyze-string>
								  </xsl:non-matching-substring>
								</xsl:analyze-string>
							      </xsl:non-matching-substring>
							    </xsl:analyze-string>
							  </xsl:non-matching-substring>
							</xsl:analyze-string>
						      </xsl:non-matching-substring>
						    </xsl:analyze-string>
						  </xsl:non-matching-substring>
						</xsl:analyze-string>
					      </xsl:non-matching-substring>
					    </xsl:analyze-string>
					  </xsl:non-matching-substring>
					</xsl:analyze-string>
				      </xsl:non-matching-substring>
				    </xsl:analyze-string>
				  </xsl:non-matching-substring>
				</xsl:analyze-string>
			      </xsl:non-matching-substring>
			    </xsl:analyze-string>
			  </xsl:non-matching-substring>
			</xsl:analyze-string>
		      </xsl:non-matching-substring>
		    </xsl:analyze-string>
		  </xsl:non-matching-substring>
		</xsl:analyze-string>
              </xsl:non-matching-substring>
	    </xsl:analyze-string>
          </mml:mrow>
	</xsl:template>

	<xsl:template match="*:munderover|*:msub|*:msup|*:msubsup|*:munder|*:mover|*:mmultiscripts">
          <xsl:variable name="embellishedValue" select="normalize-space(*[1])"/>
          <xsl:element name="{name()}">
            <xsl:choose>
              <xsl:when test="$embellishedValue='&#x2140;' or $embellishedValue='&#x220F;' or $embellishedValue='&#x2211;' or  $embellishedValue='&#x2A04;' or $embellishedValue='&#x2210;' or $embellishedValue='&#x2A05;' or $embellishedValue='&#x22C0;' or  $embellishedValue='&#x2A06;' or $embellishedValue='&#x22C1;' or $embellishedValue='&#x2A07;' or $embellishedValue='&#x22C2;' or  $embellishedValue='&#x2A08;' or $embellishedValue='&#x22C3;' or $embellishedValue='&#x2A09;' or $embellishedValue='&#x2A00;' or  $embellishedValue='&#x2A0A;' or $embellishedValue='&#x2A01;' or $embellishedValue='&#x2A0B;' or $embellishedValue='&#x2A02;' or  $embellishedValue='&#x2AFC;' or $embellishedValue='&#x2A03;' or $embellishedValue='&#x2AFF;'">
                <xsl:attribute name="meaning"><xsl:text>bigop</xsl:text></xsl:attribute>
              </xsl:when>
              <xsl:when test="$embellishedValue='&#x222B;' or $embellishedValue='&#x222C;' or $embellishedValue='&#x222D;' or  $embellishedValue='&#x2A04;' or $embellishedValue='&#x222E;' or $embellishedValue='&#x2A10;' or $embellishedValue='&#x222F;' or  $embellishedValue='&#x2A11;' or $embellishedValue='&#x2230;' or $embellishedValue='&#x2A12;' or $embellishedValue='&#x2231;' or  $embellishedValue='&#x2A13;' or $embellishedValue='&#x2232;' or $embellishedValue='&#x2A14;' or $embellishedValue='&#x2233;' or  $embellishedValue='&#x2A15;' or $embellishedValue='&#x2A0C;' or $embellishedValue='&#x2A16;' or $embellishedValue='&#x2A0D;' or  $embellishedValue='&#x2A17;' or $embellishedValue='&#x2A0E;' or $embellishedValue='&#x2A18;' or $embellishedValue='&#x2A19;' or  $embellishedValue='&#x2A1B;' or $embellishedValue='&#x2A1A;' or $embellishedValue='&#x2A1C;'">
                <xsl:attribute name="meaning"><xsl:text>integral</xsl:text></xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="meaning"><xsl:text>operator</xsl:text></xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:attribute name="embellished">
              <xsl:value-of select="$embellishedValue"/>
            </xsl:attribute>
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:template>
	
        <xsl:template match="*:mo">
          <xsl:choose>
            <xsl:when test="@meaning and matches(@meaning,'^(operator)$')">

        <xsl:choose>
            <xsl:when test="matches(.,'^(\{)$') and (count(following-sibling::*[matches(.,'^(\{)$')]) + count(preceding-sibling::*[matches(.,'^(\{)$')])) = (count(following-sibling::*[matches(.,'^(\})$')]) + count(preceding-sibling::*[matches(.,'^(\})$')])) - 1">

            <xsl:choose>
                <xsl:when test="(parent::*:mrow and count(preceding-sibling::*) != 0) or not(parent::*:mrow)">
                    <xsl:call-template name="mrowStartFenced"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="optrElementRetain"/>
                </xsl:otherwise>
            </xsl:choose>
            </xsl:when>
            <xsl:when test="matches(.,'^(\})$') and (count(following-sibling::*[matches(.,'^(\})$')]) + count(preceding-sibling::*[matches(.,'^(\})$')])) = (count(following-sibling::*[matches(.,'^(\{)$')]) + count(preceding-sibling::*[matches(.,'^(\{)$')])) - 1">
            <xsl:choose>
                <xsl:when test="(parent::*:mrow and count(following-sibling::*) != 0) or not(parent::*:mrow)">
                    <xsl:call-template name="mrowEndFenced"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="optrElementRetain"/>
                </xsl:otherwise>
            </xsl:choose>
            </xsl:when>

            <xsl:when test="matches(.,'^(\()$') and (count(following-sibling::*[matches(.,'^(\()$')]) + count(preceding-sibling::*[matches(.,'^(\()$')])) = (count(following-sibling::*[matches(.,'^(\))$')]) + count(preceding-sibling::*[matches(.,'^(\))$')])) - 1">
            <xsl:choose>
                <xsl:when test="(parent::*:mrow and count(preceding-sibling::*) != 0) or not(parent::*:mrow)">
                    <xsl:call-template name="mrowStartFenced"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="optrElementRetain"/>
                </xsl:otherwise>
            </xsl:choose>
            </xsl:when>
            <xsl:when test="matches(.,'^(\))$') and (count(following-sibling::*[matches(.,'^(\))$')]) + count(preceding-sibling::*[matches(.,'^(\))$')])) = (count(following-sibling::*[matches(.,'^(\()$')]) + count(preceding-sibling::*[matches(.,'^(\()$')])) - 1">
            <xsl:choose>
                <xsl:when test="(parent::*:mrow and count(following-sibling::*) != 0) or not(parent::*:mrow)">
                    <xsl:call-template name="mrowEndFenced"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="optrElementRetain"/>
                </xsl:otherwise>
            </xsl:choose>
            </xsl:when>

            <xsl:when test="matches(.,'^(\[)$') and (count(following-sibling::*[matches(.,'^(\[)$')]) + count(preceding-sibling::*[matches(.,'^(\[)$')])) = (count(following-sibling::*[matches(.,'^(\])$')]) + count(preceding-sibling::*[matches(.,'^(\])$')])) - 1">
            <xsl:choose>
                <xsl:when test="(parent::*:mrow and count(preceding-sibling::*) != 0) or not(parent::*:mrow)">
                    <xsl:call-template name="mrowStartFenced"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="optrElementRetain"/>
                </xsl:otherwise>
            </xsl:choose>
            </xsl:when>
            <xsl:when test="matches(.,'^(\])$') and (count(following-sibling::*[matches(.,'^(\])$')]) + count(preceding-sibling::*[matches(.,'^(\])$')])) = (count(following-sibling::*[matches(.,'^(\[)$')]) + count(preceding-sibling::*[matches(.,'^(\[)$')])) - 1">
            <xsl:choose>
                <xsl:when test="(parent::*:mrow and count(following-sibling::*) != 0) or not(parent::*:mrow)">
                    <xsl:call-template name="mrowEndFenced"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="optrElementRetain"/>
                </xsl:otherwise>
            </xsl:choose>
            </xsl:when>

            <xsl:otherwise>
                <xsl:call-template name="optrElementRetain"/>
            </xsl:otherwise>

        </xsl:choose>

            </xsl:when>
<!--
          <xsl:when test="@meaning='operator'">
              <xsl:choose>
                  <xsl:when test=".='{' or .='(' or .='['">
                     <xsl:text disable-output-escaping="yes">&lt;mml:mrow meaning="fenced"&gt;&#10;</xsl:text>
                    <xsl:element name="{name()}">
                      <xsl:attribute name="meaning">
                        <xsl:text>open</xsl:text>
                      </xsl:attribute>
                      <xsl:value-of select="node()"/>
                    </xsl:element>
                  </xsl:when>
                  <xsl:when test=".='}' or .=')' or .=']'">
                     <xsl:element name="{name()}">
                      <xsl:attribute name="meaning">
                        <xsl:text>close</xsl:text>
                      </xsl:attribute>
                      <xsl:value-of select="node()"/>
                    </xsl:element>
                    <xsl:text disable-output-escaping="yes">&#10;&lt;/mml:mrow&gt;</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                      <xsl:element name="{name()}">
                        <xsl:attribute name="meaning">
                          <xsl:value-of select="@meaning"/>
                        </xsl:attribute>
                        <xsl:value-of select="."/>
                      </xsl:element>
                  </xsl:otherwise>
              </xsl:choose>
          </xsl:when>
-->
          <xsl:when test="@stretchy='false'">
            <xsl:element name="{name()}">
              <xsl:attribute name="stretchy"><xsl:value-of select="@stretchy" /></xsl:attribute>
            <xsl:apply-templates/>
          </xsl:element>
          </xsl:when>
          <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="parent::*:mrow[parent::*:munderover] or parent::*:munderover">
                      <xsl:element name="{name()}">
                        <xsl:attribute name="meaning">
                            <xsl:choose>
                                <xsl:when test="(parent::*:mrow and count(../preceding-sibling::*) = 0) or (matches(local-name(),'^(mo)$') and count(preceding-sibling::*) = 0)">
                                    <xsl:text>bigop</xsl:text>
                                </xsl:when>
                                <xsl:otherwise><xsl:text>operator</xsl:text></xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                      </xsl:element>
                    </xsl:when>
                    <xsl:when test="parent::*:mrow[parent::*:msubsup] or parent::*:msubsup">
                      <xsl:element name="{name()}">
                        <xsl:attribute name="meaning">
                            <xsl:text>operator</xsl:text>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                      </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:element name="{name()}">
                          <xsl:apply-templates select="@*"/>
                          <xsl:apply-templates select="node()"/>
                      </xsl:element>
                  </xsl:otherwise>
                </xsl:choose>

          </xsl:otherwise>
          </xsl:choose>
        </xsl:template>

    <xsl:template name="mrowStartFenced">
        <xsl:text disable-output-escaping="yes">&lt;mml:mrow meaning="fenced"&gt;&#10;</xsl:text>
        <xsl:element name="{name()}">
            <xsl:attribute name="meaning">
                <xsl:text>open</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template name="mrowEndFenced">
        <xsl:element name="{name()}">
            <xsl:attribute name="meaning">
                <xsl:text>close</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="node()"/>
        </xsl:element>
        <xsl:text disable-output-escaping="yes">&#10;&lt;/mml:mrow&gt;</xsl:text>
    </xsl:template>

    <xsl:template name="optrElementRetain">
        <xsl:element name="{name()}">
            <xsl:attribute name="meaning">
                <xsl:value-of select="@meaning"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>
