<?php

$barray = ['[','{','[','(',')',']','}','{','[','{','}',']',')','}',']',']'];

echo "The brackets given are <pre>"; print_r($barray); echo "</pre>";

$totbrack = count($barray);

$braces = array();

for($i=0;$i<$totbrack;$i++){

    if($barray[$i]=='[' || $barray[$i]=='{' || $barray[$i]=='('){

        array_push($braces, $barray[$i]);

    }elseif($barray[$i]==']' || $barray[$i]=='}' || $barray[$i]==')'){

        if(!empty($braces)){

            if((end($braces)=='{' && $barray[$i]=='}') || (end($braces)=='[' && $barray[$i]==']') || (end($braces)=='(' && $barray[$i]==')') ){

                array_pop($braces);
            }

        }else{

            echo "Not Balanced";
            exit();

        }

    }

}
//print_r($braces);
if(!empty($braces)){
    echo "Not Balanced";
}else{
    echo "Balanced";
}

?>