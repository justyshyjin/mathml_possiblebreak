<?php
error_reporting(E_ALL);
ini_set('display_errors', TRUE);
ini_set('display_startup_errors', TRUE);
    
 
 require_once "vendor/autoload.php";
 use PhpOffice\PhpSpreadsheet\IOFactory;
 
        $tmpfname = "spreadsheet.xlsx"; 
        
        $excelReader = IOFactory::createReaderForFile($tmpfname);
        $excelObj = $excelReader->load($tmpfname);
        
            $worksheet = $excelObj->getSheet(0);
            
            $lastRow = $worksheet->getHighestRow();
            $menu = $submenu = array();
            $jsonoutput = array();
            
            for ($row = 3; $row <= $lastRow; $row++) {
                $submenu = '';
                $a = trim($worksheet->getCell('A'.$row)->getValue());
                $b = trim($worksheet->getCell('B'.$row)->getValue());
                $c = trim($worksheet->getCell('C'.$row)->getValue());
                
                if($c!=''){
                    $submenu=$c;
                }
                if($b!=''){
                    $menu=$b;
                }

                if($submenu!='' && $submenu!='Total Number of Videos' && $submenu!='Total Number of Hours')
                    $jsonoutput[$menu][]=$submenu;
         
                }

  // echo "<pre>"; print_r($jsonoutput);  
 echo json_encode($jsonoutput);

?>
