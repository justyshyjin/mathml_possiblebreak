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
        
        for ($row = 1; $row <= $lastRow; $row++) {
                  
            $a = $worksheet->getCell('A'.$row)->getValue();
            $b = $worksheet->getCell('B'.$row)->getValue();
            $c = $worksheet->getCell('C'.$row)->getValue();
            $d = $worksheet->getCell('D'.$row)->getValue();
            $e = $worksheet->getCell('E'.$row)->getValue();
            $f = $worksheet->getCell('F'.$row)->getValue();
            
            if($row == 1 && $d!=''){
                $menu[]=$d;
            }elseif($b!='' && $b!='Function'){
                $submenu[]=$b;
            }elseif($a!='' && $a!='S.No'){
                $sno[]=$a;
            }

        }

    
echo json_encode($sno);

?>