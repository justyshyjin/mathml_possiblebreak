<?php
error_reporting(E_ALL);
ini_set('display_errors', TRUE);
ini_set('display_startup_errors', TRUE);
    
 
 require_once "vendor/autoload.php";
 require "dbconfig.php";
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
                      
                $a = trim($worksheet->getCell('A'.$row)->getValue());
                $b = trim($worksheet->getCell('B'.$row)->getValue());
                $c = trim($worksheet->getCell('C'.$row)->getValue());
                $d = trim($worksheet->getCell('D'.$row)->getValue());
                $e = trim($worksheet->getCell('E'.$row)->getValue());
                $f = trim($worksheet->getCell('F'.$row)->getValue());
                
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
                            
                            
                                $cquery = "select * from category where c_name = '".$menu."'"; 

                                $cat_stmt = $conn->query($cquery);
                                $mrow_count = $cat_stmt->rowCount();
                                $mquery = $cat_stmt->fetch();

                                if($mrow_count>0){
                                   $c_id = $mquery['c_id'];
                                }else{
                                    $cins = $conn->prepare("Insert into category (c_name) values(:menu)");
                                    $cins->execute(['menu'=>$menu]);
                                    $c_id = $conn->lastInsertId();
                                }

                                $scquery = "select * from sub_category where c_id= $c_id and sc_name = '".$submenu."'"; 

                                $scat_stmt = $conn->query($scquery);
                                $smrow_count = $scat_stmt->rowCount();
                                $smquery = $scat_stmt->fetch();

                                if($smrow_count>0){
                                   $sc_id = $smquery['sc_id'];
                                }else{
                                    $scins = $conn->prepare("Insert into sub_category (c_id,sc_name) values(:c_id,:submenu)");
                                    $scins->execute([
                                        'c_id'=>$c_id,
                                        'submenu'=>$submenu,
                                    ]);
                                    $sc_id = $conn->lastInsertId();
                                }

                            $jsonoutput[$menu][$submenu][$cat][$a]=['Video Description'=>$c,$submenu=>$d,'Link'=>$e,'Video Duration'=>$f];
                        
                

                    }
                }
               

            }

            $output[] = $jsonoutput;
            
        }
echo "<pre>"; print_r($output);


   
// echo json_encode($outputfromat);

?>