<?php
error_reporting(E_ALL);
ini_set('display_errors', TRUE);
ini_set('display_startup_errors', TRUE);
    
 // var_dump(extension_loaded ('zip'));
 require_once "vendor/autoload.php";
 use PhpOffice\PhpSpreadsheet\IOFactory;
 
        $tmpfname = "spreadsheet.xlsx"; 
        
        $excelReader = IOFactory::createReaderForFile($tmpfname);
        $excelObj = $excelReader->load($tmpfname);
        $no_worksheet = $excelObj->getSheetCount();
        
        // $worksheetByname = $excelObj->getSheetByName('AR');
         $output =array();
        for($sheet =1;$sheet<$no_worksheet;$sheet++)
        {
            $worksheet_name = $excelObj->getSheetNames();
            
            $worksheet = $excelObj->getSheet($sheet);
            
            $lastRow = $worksheet->getHighestRow();
            $lastColumn = $worksheet->getHighestColumn();
            $menu = $submenu = array();
            $jsonoutput = array();
            $cat = '';
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
                        $cat = $worksheet_name[$sheet];
                        
                            $jsonoutput[$menu][$submenu][$cat][$a]=['Video Description'=>$c,' Manufacturing/Operations'=>$d,'Link'=>$e,'Video Duration'=>$f];    
                        
                    }
                }
               

            }
            $output[] = $jsonoutput;
            
            
        }
   echo "<pre>"; print_r($output); 
// echo json_encode($jsonoutput);

?>