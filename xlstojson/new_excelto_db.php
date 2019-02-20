<?php
error_reporting(E_ALL);
ini_set('display_errors', TRUE);
ini_set('display_startup_errors', TRUE);
// ini_set('memory_limit', '-1');  
 
 require_once "vendor/autoload.php";
 require "dbconfig.php";
 use PhpOffice\PhpSpreadsheet\IOFactory;
 
        $tmpfname = "T-Matrix of MIQ Videos.xlsx"; 
        
        $excelReader = IOFactory::createReaderForFile($tmpfname);
        $excelObj = $excelReader->load($tmpfname);
        $no_worksheet = $excelObj->getSheetCount();
        
        // $worksheetByname = $excelObj->getSheetByName('AR');
         $output =array();
        for($sheet = 0;$sheet<$no_worksheet;$sheet++)
        { 
            
            $worksheet_name = $excelObj->getSheetNames();
            
            $worksheet = $excelObj->getSheet($sheet);
            
            $lastRow = $worksheet->getHighestDataRow(); 
            $lastColumn = $worksheet->getHighestDataColumn();
            $menu = $submenu = array();
            $jsonoutput = array();
            $cat = '';
            if($sheet == 0){
                $firstRow = 3;    
            }else{
                $firstRow = 1;
            }
            
            for ($row = $firstRow; $row <= $lastRow; $row++) {
                      
                $a = trim($worksheet->getCell('A'.$row)->getValue());
                $b = trim($worksheet->getCell('B'.$row)->getValue());
                $c = trim($worksheet->getCell('C'.$row)->getValue());
                $d = trim($worksheet->getCell('D'.$row)->getValue());
                $e = trim($worksheet->getCell('E'.$row)->getValue());
                $f = trim($worksheet->getCell('F'.$row)->getValue());
                
                if($sheet > 0){ 
                    if($a=='' && $b=='' && $c=='' && $d!=''){
                        $menu=$d;
                    }
                    if($b!='' && $b!='Function'){
                        $submenu=$b;
                    }
                    if($a!='' && $c!='' && $d!=''){
                        if($a == 'S.No'){
                                        }
                        else{ 

                            $cat = $worksheet_name[$sheet];
                            $dur = gmdate("H:i:s", round($f*86400));

                            $query = $conn->prepare("CALL EXCELTODB(:menu,:submenu,:cat,:sno,:title,:desc,:link,:dur)");
                            $query->execute([
                                'menu'=>$menu,
                                'submenu'=>$submenu,
                                'cat'=>$cat,
                                'sno'=>$a,
                                'title'=>$d,
                                'desc'=>$c,
                                'link'=>$e,
                                'dur'=>$dur,
                            ]);

                                    
                            $jsonoutput[$menu][$submenu][$cat][$a]=['Video Description'=>$c,$submenu=>$d,'Link'=>$e,'Video Duration'=>$dur];
                            
                    

                        }
                    }
                   
                }else{
                    if($c!=''){
                        $submenu=$c;
                    }
                    if($b!=''){
                        $menu=$b;
                    }

                if($submenu!='' && $submenu!='Total Number of Videos' && $submenu!='Total Number of Hours' && $submenu!='Total Number of Technical Videos'){

                    $query = $conn->prepare("CALL EXCELMENUTODB(:menu,:submenu)");
                     $query->execute([
                                'menu'=>$menu,
                                'submenu'=>$submenu,
                            ]);

                    $jsonoutput[$menu][]=$submenu;
                        }
                    }
            }

            $output[] = $jsonoutput;
            
        }
echo "<pre>"; print_r($output);


   
// echo json_encode($outputfromat);

?>