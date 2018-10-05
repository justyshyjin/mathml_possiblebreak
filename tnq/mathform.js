// /"use strict";
$(document).ready(function(){

    var alltag= document.getElementById("main");
    var convert =document.getElementById("mathmlnorm");
    document.getElementById('mathml').value=alltag.innerHTML;

    document.getElementById('mathml').addEventListener('keyup',function(e){
        alltag.innerHTML=this.value;
    });

    var don,sep,sdon;
    var newrow,newParent,newrows,childElement,childlen,subChildElement,newOpen,newClose;
    var open,close,mfenced,separator,frac;
    var spaces = ['U+00A0', 'U+2000', 'U+2001','U+2002', 'U+2003', 'U+2004', 'U+2005', 'U+2006',
'U+2007', 'U+2008', 'U+2009', 'U+200A', 'U+202F', 'U+205F', 'U+3000', 'U+200B',
'U+200C', 'U+200D', 'U+2060', 'U+FEFF'];

    convert.onclick= function(){

        var totalTag =alltag.getElementsByTagName("*").length;
        var childRewritten = alltag.children.length;

        sep=don=sdon=0;
        newrow=newParent=newrows='';
        childElement = '';
        subChildElement =childlen='';

        for(var i=0; i<totalTag;i++){

            var newElement = alltag.getElementsByTagName("*")[i];

            if(newElement.parentElement.id=="main"){
                newParent = document.createElement('math');
                sdon++;
            }

            if(newElement.parentElement.localName=="math"){

                if(newElement.localName=="mfenced"){
                    mfenced=newElement;
                    open = mfenced.getAttribute("open");
                    close = mfenced.getAttribute("close");
                    separator = mfenced.getAttribute("separators");
                        childlen = mfenced.children.length;
                    newrow = document.createElement('mrow');
                        newrow.setAttribute("meaning", "fenced");
                        childElement = newrow;
                }
                if(newElement.localName=="mi" || newElement.localName=="mo"){

                    //if(newElement.innerText.match('&#x')){
                        console.log(newElement.innerHTML);
                    //}
                    childElement = newElement;
                    newParent.append(childElement.outerHTML);
                }
                if(newElement.localName=="mfrac"){
                    frac = newElement;
                    let thickness = frac.getAttribute("linethickness");
                    if(thickness !="0pt"){
                        newParent.append(frac.outerHTML);
                    }else{
                        var mFractable = document.createElement('mtable');
                        childElement = mFractable;
                    }

                }

                if(newElement.localName=="mrow" && newElement.previousElementSibling.localName!="mrow"){
                    if(newElement.nextElementSibling!=null && newElement.nextElementSibling.localName=="mrow"){
                        newrows = document.createElement('mrow');
                        childElement = newrows;
                    }else{
                        childElement =null;
                    }


                }

            }
            else{

                if(newElement.parentElement.localName=="mfenced"){

                    if(newElement.previousElementSibling==null){
                        if(open ==null || open==''){
                            newOpen=moCreation('(','meaning','open');
                        }else{
                            newOpen=moCreation(open,'meaning','open');
                        }
                            subChildElement=newOpen.outerHTML;
                            subChildElement+=newElement.outerHTML;
                            if(separator!='')
                                subChildElement+=moSeparator(separator,sep).outerHTML;

                    }else if(newElement.nextElementSibling==null){
                        if(close ==null || close == ''){
                            newClose = moCreation(')','meaning','close');
                        }else{
                            newClose = moCreation(close,'meaning','close');
                        }
                        subChildElement=newElement.outerHTML;
                        subChildElement+=newClose.outerHTML;
                    }else{
                        subChildElement=newElement.outerHTML;
                        if(separator!='')
                            subChildElement+=moSeparator(separator,sep).outerHTML;
                    }
                    sep++;
                    newrow.append(subChildElement);

                    if(don==mfenced.children.length-1){
                        newParent.append(childElement);
                        don=0;
                    }
                    don++;

                }
                if(newElement.parentElement.localName=="mfrac" && mFractable){

                    let newtd=document.createElement("mtd");
                    let newtr=document.createElement("mtr");
                    let newtdVal = newElement;
                    newtd.innerHTML=newtdVal.outerHTML;
                    newtr.append(newtd);
                    subChildElement=newtr;
                    mFractable.append(subChildElement);

                    if(don==frac.children.length-1){
                        newParent.append(mFractable);
                        don=0;
                    }
                    don++;
                }


                if(newElement.parentElement.localName=="mrow"){
                    let siblingRow =newElement.parentElement.nextElementSibling;
                    subChildElement = newElement.outerHTML;

                    if(childElement){
                        childElement.append(subChildElement);
                    }
                    else{
                        newParent.append(subChildElement);
                    }
                    if(don == newElement.parentElement.children.length-1 && siblingRow.localName!='mrow' || siblingRow ==null){
                        if(childElement)
                        newParent.append(childElement);
                        don=0;
                   }
                   don++;
                }

            }


         }

        document.getElementById('mathml1').innerHTML=newParent.outerHTML;


    }

});


function moCreation(inText, attr='', attrVal=''){
    let newMo = document.createElement('mo');
    if(attr!='' && attrVal!='')
    newMo.setAttribute(attr,attrVal);
    newMo.innerText=inText;

    return newMo;
}

function moSeparator(separators=null,pos){
    let newseparator,separator;

    if(separators==null){
        newseparator= ',';
    }else{
        if(separators.charAt(pos)!='')
            newseparator= separators.charAt(pos);
        else
            newseparator= separators.slice(-1);
    }

    separator=moCreation(newseparator);

    return separator;

}

function uniTohtm(unicod){
    let str;
    str=unicod.replace('&#x','U+');
    str=str.replace(/;/g,'');
    return str;
}

//console.log(entityForSymbolInContainer(''));

function entityForSymbolInContainer(selector) {
    var code = $(selector).text().charCodeAt(0);
    var codeHex = code.toString(16).toUpperCase();
    while (codeHex.length < 4) {
        codeHex = "0" + codeHex;
    }

    return "&#x" + codeHex + ";";
}

function convertCharRefs(string) {
    return string
        .replace(/&#(\d+);/g, function(match, num) {
            var hex = parseInt(num).toString(16);
            while (hex.length < 4) hex = '0' + hex;
            return "\\u" + hex;
        })
        .replace(/&#x([A-Za-z0-9]+);/g, function(match, hex) {
            while (hex.length < 4) hex = '0' + hex;
            return "\\u" + hex;
        });
}


// test xml

var xhttp = new XMLHttpRequest();
xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        myFunction(this);
    }
};
xhttp.open("GET", "docXml.xml", true);
xhttp.send();

function myFunction(xml) {
    var don,sep,sdon;
    var newrow,newParent,newrows,childElement,childlen,subChildElement,newOpen,newClose;
    var open,close,mfenced,separator,frac;
    var  i, xmlDoc;
    xmlDoc = xml.responseXML;

    var totalTag =xmlDoc.getElementsByTagName("*").length;
    var alltag=xmlDoc.getElementsByTagName("math")[0];

    sep=don=sdon=0;
    newrow=newParent=newrows='';
    childElement = '';
    subChildElement =childlen='';

    for (i = 0; i < totalTag; i++) {

            var newElement = xmlDoc.getElementsByTagName("*")[i];
            //console.log(newElement.parentElement)
            if(newElement.parentElement==null){
                newParent = document.createElement('math');
                sdon++;
            }else{
                 if(newElement.parentElement.localName=="math"){

                if(newElement.localName=="mfenced"){
                    mfenced=newElement;
                    open = mfenced.getAttribute("open");
                    close = mfenced.getAttribute("close");
                    separator = mfenced.getAttribute("separators");
                        childlen = mfenced.children.length;
                    newrow = document.createElement('mrow');
                        newrow.setAttribute("meaning", "fenced");
                        childElement = newrow;
                }
                if(newElement.localName=="mi" || newElement.localName=="mo"){

                    //if(newElement.innerText.match('&#x')){
                        console.log(newElement.textContent0);
                   // }
                    childElement = newElement;
                    newParent.append(childElement.outerHTML);
                }
                if(newElement.localName=="mfrac"){
                    frac = newElement;
                    let thickness = frac.getAttribute("linethickness");
                    if(thickness !="0pt"){
                        newParent.append(frac.outerHTML);
                    }else{
                        var mFractable = document.createElement('mtable');
                        childElement = mFractable;
                    }

                }

                if(newElement.localName=="mrow" && newElement.previousElementSibling.localName!="mrow"){
                    if(newElement.nextElementSibling!=null && newElement.nextElementSibling.localName=="mrow"){
                        newrows = document.createElement('mrow');
                        childElement = newrows;
                    }else{
                        childElement =null;
                    }


                }

             }
             else{

                if(newElement.parentElement.localName=="mfenced"){

                    if(newElement.previousElementSibling==null){
                        if(open ==null || open==''){
                            newOpen=moCreation('(','meaning','open');
                        }else{
                            newOpen=moCreation(open,'meaning','open');
                        }
                            subChildElement=newOpen.outerHTML;
                            subChildElement+=newElement.outerHTML;
                            if(separator!='')
                                subChildElement+=moSeparator(separator,sep).outerHTML;

                    }else if(newElement.nextElementSibling==null){
                        if(close ==null || close == ''){
                            newClose = moCreation(')','meaning','close');
                        }else{
                            newClose = moCreation(close,'meaning','close');
                        }
                        subChildElement=newElement.outerHTML;
                        subChildElement+=newClose.outerHTML;
                    }else{
                        subChildElement=newElement.outerHTML;
                        if(separator!='')
                            subChildElement+=moSeparator(separator,sep).outerHTML;
                    }
                    sep++;
                    newrow.append(subChildElement);

                    if(don==mfenced.children.length-1){
                        newParent.append(childElement);
                        don=0;
                    }
                    don++;

                }
                if(newElement.parentElement.localName=="mfrac" && mFractable){

                    let newtd=document.createElement("mtd");
                    let newtr=document.createElement("mtr");
                    let newtdVal = newElement;
                    newtd.innerHTML=newtdVal.outerHTML;
                    newtr.append(newtd);
                    subChildElement=newtr;
                    mFractable.append(subChildElement);

                    if(don==frac.children.length-1){
                        newParent.append(mFractable);
                        don=0;
                    }
                    don++;
                }


                if(newElement.parentElement.localName=="mrow"){
                    let siblingRow =newElement.parentElement.nextElementSibling;
                    subChildElement = newElement.outerHTML;

                    if(childElement){
                        childElement.append(subChildElement);
                    }
                    else{
                        newParent.append(subChildElement);
                    }
                    if(don == newElement.parentElement.children.length-1 && siblingRow.localName!='mrow' || siblingRow ==null){
                        if(childElement)
                        newParent.append(childElement);
                        don=0;
                   }
                   don++;
                }

             }


            }


         }
    document.getElementById("mathml1").innerHTML = newParent.outerHTML;
}