$(document).ready(function(){

    var alltag= document.getElementById("main");
    var convert =document.getElementById("mathmlnorm");
    document.getElementById('mathml').value=alltag.innerHTML;

    document.getElementById('mathml').addEventListener('keyup',function(e){
        alltag.innerHTML=this.value;
    });

    convert.onclick= function(){

        var totalTag =alltag.getElementsByTagName("*").length;
        var newOpen = newClose= mrewritten=newmath='';
        var sep = don=sdon=0;
        var childRewritten = alltag.children.length;
        var newrow=newParent=newrows='';
        var childElement = '';
        var subChildElement =childlen='';
        for(var i=0; i<totalTag;i++){

            var newElement = alltag.getElementsByTagName("*")[i];

            if(newElement.parentElement.id=="main"){
                newParent = document.createElement('math');
                sdon++;
            }

            if(newElement.parentElement.localName=="math"){

                if(newElement.localName=="mfenced"){
                    var mfenced=newElement;
                    var open = mfenced.getAttribute("open");
                    var close = mfenced.getAttribute("close");
                    var separator = mfenced.getAttribute("separators");
                        childlen = mfenced.children.length;
                    newrow = document.createElement('mrow');
                        newrow.setAttribute("meaning", "fenced");
                        childElement = newrow;
                }
                if(newElement.localName=="mi" || newElement.localName=="mo"){
                    childElement = newElement;
                    newParent.append(childElement.outerHTML);
                }
                if(newElement.localName=="mfrac"){
                    var frac = newElement;
                    var thickness = frac.getAttribute("linethickness");
                    if(thickness !="0pt"){
                        newParent.append(frac.outerHTML);
                    }else{
                        var mFractable = document.createElement('mtable');
                        childElement = mFractable;
                    }

                }

                if(newElement.localName=="mrow" && newElement.previousElementSibling.localName!="mrow"){

                    newrows = document.createElement('mrow');
                        childElement = newrows;
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

                    var newtd=document.createElement("mtd");
                    var newtr=document.createElement("mtr");
                    var newtdVal = newElement;
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
                    var siblingRow =newElement.parentElement.nextElementSibling;
                    subChildElement = newElement.outerHTML;
                    if(childElement!='')
                        childElement.append(subChildElement);
                    else
                        newParent.append(subChildElement);

                    if(don == newElement.parentElement.children.length-1 && siblingRow.localName!='mrow' || siblingRow ==null){
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
    var newMo = document.createElement('mo');
    if(attr!='' && attrVal!='')
    newMo.setAttribute(attr,attrVal);
    newMo.innerText=inText;

    return newMo;
}

function moSeparator(separators=null,pos){
    var newseparator=separator='';

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