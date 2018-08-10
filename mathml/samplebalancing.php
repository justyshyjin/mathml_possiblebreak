<?php
    // Brackets Balancing

$barray = ['[','{','[','(',')',']','}','{','(','[','{','}',']',')','}',']'];
$error = array();
$result = array();

if(count($barray%2)!=1){
    $error['status'] = 1;
    $result[]= 0;
    $error['message'] = 'Brackets not enclosed properly';
}else{

        $br = $value;
        $totbrack = count($barray);
        $numbrack = $totbrack/2;

    for($i=0;$i<$totbrack;$i++){
        $sindex = $i;
        $findex = ($totbrack-1) - $i;

        echo $barray[$sindex]."->".$barray[$findex]."<br>";

        // if($barray[$sindex]=='{' && $barray[$findex]=='}'){
        //     $result[]= 1;
        // }elseif($barray[$sindex]=='[' && $barray[$findex]==']'){
        //     $result[]= 1;
        // }elseif($barray[$sindex]=='(' && $barray[$findex]==')'){
        //     $result[]= 1;
        // }else{
        //     $result[]= 0;
        // }

    }

}

// $result = in_array('0',$result);
// if($result==1)
//     echo "Brackets not balanced";
// else
//     echo "Brackets Balancing properly";

?>