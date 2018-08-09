<?php
    // Brackets Balancing
//error_reporting(E_ALL);
$barray = ['{','(','[',']',')','}'];
$error = array();
$result = array();

if(count($barray%2)!=1){
    $error['status'] = 0;
    $error['message'] = 'Brackets not enclosed properly';
}else{

    $sindexp = array_search('{',$barray);
    $findexp = array_search('}',$barray);
    $sindexb = array_search('(',$barray);
    $findexb = array_search(')',$barray);
    $sindexs = array_search('[',$barray);
    $findexs = array_search(']',$barray);

    foreach ($barray as $key => $value) {
        $br = $value;
        $sindex=$findex='';
         switch ($br) {
             case '{':

                if($sindexp < $findexp){

                if((($sindexb < $sindexp && $findexb < $findexp) || ($sindexb > $sindexp && $findexb > $findexp)) || ($sindexs < $sindexp && $findexs < $findexp) || ($sindexs > $sindexp && $findexs > $findexp)){
                    $result[]= '0';
                    $error['status']=0;
                    $error['message']='Brackets enclosing mismatch';
                }else{
                    $result[]= '1';
                }

                }else{
                     $result[]= '0';
                     $error['status']=0;
                     $error['message']='Brackets enclosing mismatch';
                 }
                 break;
            case '(':

                if($sindexb < $findexb){

                if((($sindexp < $sindexb && $findexp < $findexb) || ($sindexp > $sindexp && $findexp > $findexb)) || ($sindexs < $sindexb && $findexs < $findexb) || ($sindexs > $sindexb && $findexs > $findexb)){
                    $result[]= '0';
                    $error['status']=0;
                    $error['message']='Brackets enclosing mismatch';
                }else{
                    $result[]= '1';
                }

                }else{
                     $result[]= '0';
                     $error['status']=0;
                     $error['message']='Brackets enclosing mismatch';
                 }
                 break;
            case '[':

                if($sindexs < $findexs){

                if((($sindexp < $sindexs && $findexp < $findexs) || ($sindexp > $sindexs && $findexp > $findexs)) || ($sindexb < $sindexs && $findexb < $findexs) || ($sindexb > $sindexs && $findexb > $findexs)){
                    $result[]= '0';
                    $error['status']=0;
                    $error['message']='Brackets enclosing mismatch';
                }else{
                    $result[]= '1';
                }

                }else{
                     $result[]= '0';
                     $error['status']=0;
                     $error['message']='Brackets enclosing mismatch';
                 }
                 break;
                 default:
                 break;
         }
    }
}
$result = in_array('0',$result);
if($result==1)
    echo "Brackets not balanced";
else
    echo "Brackets Balancing properly";

?>