<?php
    //Normolizing the mathml tags - Algorithm 1
?>


<!DOCTYPE html>
<html>
<head>
    <title></title>
    <style type="text/css">
        textarea{
            width:400px;
            height: 300px;
        }
        button{
            position: relative;
            bottom: 150px;
        }

    </style>
    <script src="jquery.min.js"></script>
    <script type="text/javascript" src="mathform.js"></script>
</head>
<body>
    <div id="container">
        <div id="main" style="display: none;">
            <mfenced open="[" close="]" separators="+">
                <mi>a</mi>
                <mi>b</mi>
                <mi>c</mi>
                <mi>d</mi>
            </mfenced>
        </div>
        <div class="editor">
            <textarea id="mathml"></textarea>
            <button id="mathmlnorm">>></button>
            <textarea id="mathml1"></textarea><br>

        </div>
        <div class="norma">
            <label class="normath">
                <math xmlns = "http://www.w3.org/1998/Math/MathML">

                </math>
            </label>
        </div>
    </div>
</body>
</html>