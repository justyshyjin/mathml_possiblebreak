<!doctype html>

<html>
   <head>
      <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
      <title>MathML Examples</title>
      <style type="text/css">
         .mrows{
            text-align: center;
         }
         .test{
          width:150px;
         }
      </style>
      <script type="text/x-mathjax-config">
         MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});
      </script>
      <script src='https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/latest.js?config=TeX-MML-AM_CHTML' async></script>

   </head>
   <body>
      <div class="test">
         $y = {a^2b}({x^3+{c}})
         {x+\sqrt{a^4+7\over{2b}}}+{a^2b}({x^3+{c}})$
      </div></br>
      <div>
      <math xmlns="http://www.w3.org/1998/Math/MathML">
        <mrow>
         <mfrac bevelled="">
            <mrow>
            <mo>(</mo>
               <mtable>
                  <mtr>
                     <mtd>
                        <mi>a</mi>
                     </mtd>
                     <mtd>
                        <mi>b</mi>
                     </mtd>
                  </mtr>
                  <mtr>
                     <mtd>
                        <mi>c</mi>
                     </mtd>
                     <mtd>
                        <mi>d</mi>
                     </mtd>
                  </mtr>
               </mtable>
            <mo>)</mo>

</mrow>
 <mrow>
             <mo>(</mo>
            <mtable columnspacing="10px" align="axis 3">
               <mtr>
                  <mtd>
                     <mi>x</mi>
                  </mtd>
               </mtr>
               <mtr>
                  <mtd>
                     <mi>y</mi>
                  </mtd>
               </mtr>
            </mtable>
             <mo>)</mo>
</mrow>
      </mfrac>
      <mrow>
          <mi>x</mi>
          <mo>+</mo>
          <mi>y</mi>
      </mrow>
    </mrow>
      </math>
   </div></br>

   <div>
      <math>
         <mrow>
           <mi> x </mi>
           <mo> + </mo>
           <mphantom>
             <mi> y </mi>
             <mo> + </mo>
           </mphantom>
           <mi> z </mi>
         </mrow>
      </math>
   </div></br>
   <div>
      <math>
          <mtext> Theorem of Pythagoras </mtext>
         <msqrt>
   <msup>
    <mi>x</mi>
    <mn>7</mn>
 </msup>
  </msqrt>
      </math>
   </div>
</br>
<div>
   <math>
   <semantics>
   <mrow>
      <msup>
         <mi>x</mi>
         <mn>2</mn>
      </msup>
      <mi>y</mi>
   </mrow>

          <!-- Content MathML -->
    <annotation-xml encoding="MathML-Content">
      <apply>
        <plus/>
        <apply>
          <power/>
          <ci>x</ci>
          <cn type="integer">2</cn>
        </apply>
        <ci>y</ci>
      </apply>
    </annotation-xml>
      </semantics>
   </math>
   </div></br>
<div>
   <math>
     <semantics>
  <mrow>
    <mrow>
      <mi>sin</mi>
      <mo>&#x2061;<!--FUNCTION APPLICATION--></mo>
      <mfenced><mi>x</mi></mfenced>
    </mrow>
    <mo>+</mo>
    <mn>5</mn>
  </mrow>
  <annotation encoding="application/x-tex">
    \sin x + 5
  </annotation>
  <annotation-xml encoding="application/openmath+xml">
    <OMA xmlns="http://www.openmath.org/OpenMath">
      <OMS cd="arith1" name="plus"/>
      <OMA><OMS cd="transc1" name="sin"/><OMV name="x"/></OMA>
      <OMI>5</OMI>
    </OMA>
  </annotation-xml>
</semantics>
   </math>
</div></br>
<div>
   <math>
     <semantics>
  <annotation encoding="application/x-tex">
      x^{2} + y
    </annotation>
</semantics>
   </math>
</div>
 </body>
</html>