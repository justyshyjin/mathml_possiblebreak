<?php
error_reporting(E_ALL);
ini_set('display_errors', TRUE);
ini_set('display_startup_errors', TRUE);
    
 
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
                        
                            $jsonoutput[$menu][$submenu][$cat][$a]=['Video Description'=>$c,$submenu=>$d,'Link'=>$e,'Video Duration'=>$f];
                        
                    }
                }
               

            }

            $output[] = $jsonoutput;
            
        }

$outputfromat= $json = array();
$count = count($output);

for($i=0;$i<$count;$i++){
    foreach($output[$i] as $mkey => $mvalue){

        foreach ($mvalue as $skey => $svalue) {

            foreach ($svalue as $ckey => $cvalue) {
               
                 if($mkey=='Automotive'){ 

                if($skey == 'Manufacturing/Operations'){
                    $outputfromat['Automotive']['Manufacturing/Operations'][$ckey] =  $cvalue;
                }

                if($skey == 'Quality'){
                    $outputfromat['Automotive']['Quality'][$ckey] = $cvalue;
                }

                if($skey == 'Sales & Marketing'){
                    $outputfromat['Automotive']['Sales & Marketing'][$ckey] =  $cvalue;
                }

                if($skey == 'Supply Chain'){
                    $outputfromat['Automotive']['Supply Chain'][$ckey] = $cvalue;
                }

                if($skey == 'Finance & Accounts'){
                    $outputfromat['Automotive']['Finance & Accounts'][$ckey] = $cvalue;
                }

                if($skey == 'Product Development'){
                    $outputfromat['Automotive']['Product Development'][$ckey] = $cvalue;
                }

                if($skey == 'Safety'){
                    $outputfromat['Automotive']['Safety'][$ckey] = $cvalue;
                }

                if($skey == 'HR'){
                    $outputfromat['Automotive']['HR'][$ckey] = $cvalue;
                }

                if($skey == 'After Sales Service'){
                    $outputfromat['Automotive']['After Sales Service'][$ckey] = $cvalue;
                }
                
                
            }

            if($mkey=='Farm Equipment'){ 
            
                if($skey == 'Manufacturing/Operations'){
                    $outputfromat['Farm Equipment']['Manufacturing/Operations'][$ckey] =  $cvalue;
                }

                if($skey == 'Quality'){
                    $outputfromat['Farm Equipment']['Quality'][$ckey] = $cvalue;
                }

                if($skey == 'Sales & Marketing'){
                    $outputfromat['Farm Equipment']['Sales & Marketing'][$ckey] =  $cvalue;
                }

                if($skey == 'Supply Chain'){
                    $outputfromat['Farm Equipment']['Supply Chain'][$ckey] = $cvalue;
                }

                if($skey == 'Finance & Accounts'){
                    $outputfromat['Farm Equipment']['Finance & Accounts'][$ckey] = $cvalue;
                }

                if($skey == 'Product Development'){
                    $outputfromat['Farm Equipment']['Product Development'][$ckey] = $cvalue;
                }

                if($skey == 'Safety'){
                    $outputfromat['Farm Equipment']['Safety'][$ckey] = $cvalue;
                }

                if($skey == 'HR'){
                    $outputfromat['Farm Equipment']['HR'][$ckey] = $cvalue;
                }

                if($skey == 'After Sales Service'){
                    $outputfromat['Farm Equipment']['After Sales Service'][$ckey] = $cvalue;
                }
                
                
            }

            if($mkey=='Financial Services'){ 

                if($skey == 'Operations'){
                    $outputfromat['Financial Services']['Manufacturing/Operations'][$ckey] =  $cvalue;
                }

                if($skey == 'Quality'){
                    $outputfromat['Farm Equipment']['Quality'][$ckey] = $cvalue;
                }

                if($skey == 'Sales & Marketing'){
                    $outputfromat['Financial Services']['Sales & Marketing'][$ckey] =  $cvalue;
                }

                if($skey == 'Supply Chain'){
                    $outputfromat['Financial Services']['Supply Chain'][$ckey] = $cvalue;
                }

                if($skey == 'Finance & Accounts'){
                    $outputfromat['Financial Services']['Finance & Accounts'][$ckey] = $cvalue;
                }

                if($skey == 'Product Development'){
                    $outputfromat['Financial Services']['Product Development'][$ckey] = $cvalue;
                }

                if($skey == 'Safety'){
                    $outputfromat['Financial Services']['Safety'][$ckey] = $cvalue;
                }

                if($skey == 'HR'){
                    $outputfromat['Financial Services']['HR'][$ckey] = $cvalue;
                }

                if($skey == 'After Sales Service'){
                    $outputfromat['Financial Services']['After Sales Service'][$ckey] = $cvalue;
                }
                
                
            }

            if($mkey=='Logistics'){ 
            
                if($skey == 'Operations'){
                    $outputfromat['Logistics']['Manufacturing/Operations'][$ckey] =  $cvalue;
                }

                if($skey == 'Quality'){
                    $outputfromat['Logistics']['Quality'][$ckey] = $cvalue;
                }

                if($skey == 'Sales & Marketing'){
                    $outputfromat['Logistics']['Sales & Marketing'][$ckey] =  $cvalue;
                }

                if($skey == 'Supply Chain'){
                    $outputfromat['Logistics']['Supply Chain'][$ckey] = $cvalue;
                }

                if($skey == 'Finance & Accounts'){
                    $outputfromat['Logistics']['Finance & Accounts'][$ckey] = $cvalue;
                }

                if($skey == 'Product Development'){
                    $outputfromat['Logistics']['Product Development'][$ckey] = $cvalue;
                }

                if($skey == 'Safety'){
                    $outputfromat['Logistics']['Safety'][$ckey] = $cvalue;
                }

                if($skey == 'HR'){
                    $outputfromat['Logistics']['HR'][$ckey] = $cvalue;
                }

                if($skey == 'After Sales Service'){
                    $outputfromat['Logistics']['After Sales Service'][$ckey] = $cvalue;
                }
                
                
            }

            if($mkey=='Real Estate (Mahindra Lifespace Developers Ltd.;
Mahindra World City)'){ 
            
                if($skey == 'Operations'){
                    $outputfromat['Real Estate (Mahindra Lifespace Developers Ltd.;
Mahindra World City)']['Manufacturing/Operations'][$ckey] =  $cvalue;
                }

                if($skey == 'Quality'){
                    $outputfromat['Real Estate (Mahindra Lifespace Developers Ltd.;
Mahindra World City)']['Quality'][$ckey] = $cvalue;
                }

                if($skey == 'Sales & Marketing'){
                    $outputfromat['Real Estate (Mahindra Lifespace Developers Ltd.;
Mahindra World City)']['Sales & Marketing'][$ckey] =  $cvalue;
                }

                if($skey == 'Supply Chain'){
                    $outputfromat['Real Estate (Mahindra Lifespace Developers Ltd.;
Mahindra World City)']['Supply Chain'][$ckey] = $cvalue;
                }

                if($skey == 'Finance & Accounts'){
                    $outputfromat['Real Estate (Mahindra Lifespace Developers Ltd.;
Mahindra World City)']['Finance & Accounts'][$ckey] = $cvalue;
                }

                if($skey == 'Product Development'){
                    $outputfromat['Real Estate (Mahindra Lifespace Developers Ltd.;
Mahindra World City)']['Product Development'][$ckey] = $cvalue;
                }

                if($skey == 'Safety'){
                    $outputfromat['Real Estate (Mahindra Lifespace Developers Ltd.;
Mahindra World City)']['Safety'][$ckey] = $cvalue;
                }

                if($skey == 'HR'){
                    $outputfromat['Real Estate (Mahindra Lifespace Developers Ltd.;
Mahindra World City)']['HR'][$ckey] = $cvalue;
                }

                if($skey == 'After Sales Service'){
                    $outputfromat['Real Estate (Mahindra Lifespace Developers Ltd.;
Mahindra World City)']['After Sales Service'][$ckey] = $cvalue;
                }
                
                
            }

            if($mkey=='Hospitality'){ 
            
                if($skey == 'Operations'){
                    $outputfromat['Hospitality']['Manufacturing/Operations'][$ckey] =  $cvalue;
                }

                if($skey == 'Quality'){
                    $outputfromat['Hospitality']['Quality'][$ckey] = $cvalue;
                }

                if($skey == 'Sales & Marketing'){
                    $outputfromat['Hospitality']['Sales & Marketing'][$ckey] =  $cvalue;
                }

                if($skey == 'Supply Chain'){
                    $outputfromat['Hospitality']['Supply Chain'][$ckey] = $cvalue;
                }

                if($skey == 'Finance & Accounts'){
                    $outputfromat['Hospitality']['Finance & Accounts'][$ckey] = $cvalue;
                }

                if($skey == 'Product Development'){
                    $outputfromat['Hospitality']['Product Development'][$ckey] = $cvalue;
                }

                if($skey == 'Safety'){
                    $outputfromat['Hospitality']['Safety'][$ckey] = $cvalue;
                }

                if($skey == 'HR'){
                    $outputfromat['Hospitality']['HR'][$ckey] = $cvalue;
                }

                if($skey == 'After Sales Service'){
                    $outputfromat['Hospitality']['After Sales Service'][$ckey] = $cvalue;
                }
                
                
            }

            if($mkey=='Agribusiness'){ 

                if($skey == 'Operations'){
                    $outputfromat['Agribusiness']['Manufacturing/Operations'][$ckey] =  $cvalue;
                }

                if($skey == 'Quality'){
                    $outputfromat['Agribusiness']['Quality'][$ckey] = $cvalue;
                }

                if($skey == 'Sales & Marketing'){
                    $outputfromat['Agribusiness']['Sales & Marketing'][$ckey] =  $cvalue;
                }

                if($skey == 'Supply Chain'){
                    $outputfromat['Agribusiness']['Supply Chain'][$ckey] = $cvalue;
                }

                if($skey == 'Finance & Accounts'){
                    $outputfromat['Agribusiness']['Finance & Accounts'][$ckey] = $cvalue;
                }

                if($skey == 'Product Development'){
                    $outputfromat['Agribusiness']['Product Development'][$ckey] = $cvalue;
                }

                if($skey == 'Safety'){
                    $outputfromat['Agribusiness']['Safety'][$ckey] = $cvalue;
                }

                if($skey == 'HR'){
                    $outputfromat['Agribusiness']['HR'][$ckey] = $cvalue;
                }

                if($skey == 'After Sales Service'){
                    $outputfromat['Agribusiness']['After Sales Service'][$ckey] = $cvalue;
                }
                
                
            }

            }

             
        }
        
        
    }
    
   
}
  // echo "<pre>"; print_r($outputfromat);  
echo json_encode($outputfromat);

?>