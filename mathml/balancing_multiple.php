<?php
    // Brace Balancing

$barray = ['[','{','[','(',')',']','}','{','(','[','{','}',']',')','}',']'];

echo "The brackets given are <pre>"; print_r($barray); echo "</pre>";

$result = array();
$bracesCount = array_count_values($barray);

if(count($barray%2)!=1){
    $result[]= 0;
}else{
    if($bracesCount['{'] == $bracesCount['}'] && $bracesCount['['] == $bracesCount[']'] && $bracesCount['('] == $bracesCount['(']){

        $totbrack = count($barray);

    foreach ($barray as $key => $value) {

        $sbrace = $pbrace = $cbrace = $scbrace = $pcbrace = $ccbrace = $br= 0;
        for($i=$key;$i<$totbrack;$i++){

            if($value == '['){
                if($barray[$i] == '['){
                    ++$sbrace;
                }

                if($barray[$i] == ']' && $sbrace > 0){
                    ++$scbrace;
                }

            }

            if($value == '{'){
                if($barray[$i] == '{'){
                    ++$pbrace;
                }
                if($barray[$i] == '}' && $pbrace > 0){
                    ++$pcbrace;
                }
            }

            if($value == '('){
            if($barray[$i] == '('){
                ++$cbrace;
            }
            if($barray[$i] == ')' && $cbrace > 0){
                ++$ccbrace;
            }
            }


            if((($sbrace == $scbrace) && $sbrace>0) || (($pbrace == $pcbrace) && $pbrace>0) || (($cbrace == $ccbrace) && $cbrace>0)){
                    $br=1;
                    $brace_close[$key] = $i;
                    unset($barray[$i]);
                    if($sbrace == $scbrace){
                        unset($sbrace);
                        unset($scbrace);
                    }
                    if($pbrace == $pcbrace){
                        unset($pbrace);
                        unset($pcbrace);
                    }
                    if($cbrace == $ccbrace){
                        unset($cbrace);
                        unset($ccbrace);
                    }

               }
               if($br==1) break;

        }


    }
    foreach ($brace_close as $open => $close) {

        for($j=$open;$j<$close;$j++){
            if(array_key_exists($j, $brace_close)){
                if($brace_close[$j]>$close){
                    $result[]=0;
                }
            }

        }
    }

    }else{

        $result[]= 0;

    }

}


$result = in_array('0',$result);
if($result==1)
    echo "Brackets not balanced";
else
    echo "Brackets Balancing properly";

?>