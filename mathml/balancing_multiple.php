<?php
    // Brace Balancing

$barray = ['[','{','[','(',')',']','}','{','(','[','{','}',']',')','}',']'];

$result = array();
$bracesCount = array_count_values($barray);

if(count($barray%2)!=1){
    $result[]= 0;
}else{
    if($bracesCount['{'] == $bracesCount['}'] && $bracesCount['['] == $bracesCount[']'] && $bracesCount['('] == $bracesCount['(']){

        $totbrack = count($barray)-1;

        for($i=0;$i<$totbrack;$i++){


        }

    }else{

        $result[]= 0;

    }
}

print_r(array_keys($barray,')'));
$result = in_array('0',$result);
if($result==1)
    echo "Brackets not balanced";
else
    echo "Brackets Balancing properly";

?>