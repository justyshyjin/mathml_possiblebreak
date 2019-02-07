<?php
error_reporting(E_ALL);
ini_set('display_errors', TRUE);
ini_set('display_startup_errors', TRUE);
	
 // var_dump(extension_loaded ('zip'));
 require_once "vendor/autoload.php";
 use PhpOffice\PhpSpreadsheet\IOFactory;
 
        $tmpfname = "newexcel.xlsx"; 
        
        $excelReader = IOFactory::createReaderForFile($tmpfname);
        $excelObj = $excelReader->load($tmpfname);
        $worksheet = $excelObj->getSheet(0);
        $lastRow = $worksheet->getHighestRow();
        $lastColumn = $worksheet->getHighestColumn();
        $menu = $submenu = $sno = $videodesc = $mop = $link = $duration =array();
        $jsonoutput = array();
        $i=$m=$sm=0;
        for ($row = 1; $row <= $lastRow; $row++) {
                  
            $a = $worksheet->getCell('A'.$row)->getValue();
            $b = $worksheet->getCell('B'.$row)->getValue();
            $c = $worksheet->getCell('C'.$row)->getValue();
            $d = $worksheet->getCell('D'.$row)->getValue();
            $e = $worksheet->getCell('E'.$row)->getValue();
            $f = $worksheet->getCell('F'.$row)->getValue();
            
            if($a=='' && $b=='' && $c=='' && $d!=''){
                $menu=$d;
                
            }
            if($b!='' && $b!='Function'){
                $submenu=$b;
            }
            if($a!='' ){
                if($a == 'S.No'){
                    
                }
                else{
                    
                    $jsonoutput[$menu]['AR'][$submenu][$a]=['Video Description'=>$c,' Manufacturing/Operations'=>$d,'Link'=>$e,'Video Duration'=>$f];
                }
            }
           

        }

   echo "<pre>"; print_r($jsonoutput); 
// echo json_encode($jsonoutput);

?>