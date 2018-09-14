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

        for(var i=0; i<=totalTag;i++){
            if(alltag.getElementsByTagName('math')[i]){
                var newmath = document.createElement('math');
            }

            if(alltag.getElementsByTagName('mfenced')[i]){

                var mfenced=alltag.getElementsByTagName('mfenced')[i];
                var open = mfenced.getAttribute("open");
                var close = mfenced.getAttribute("close");
                var separator = mfenced.getAttribute("separators");

                var newrow = document.createElement('mrow');
                    newrow.setAttribute("meaning", "fenced");

                newopen=document.createElement('mo');
                newopen.setAttribute('meaning','open');

                if(open==='(' || open ==null){
                    newOpen=moCreation('(','meaning','open');
                }else{
                    newOpen=moCreation(open,'meaning','open');
                }
                newrow.append(newOpen);
                var newseparator = childtag='';
                childtag = mfenced.children;

                for (j = 0; j < childtag.length; j++) {

                    newrow.append(childtag[j].outerHTML);
                    if(j!=childtag.length-1 && separator!=""){
                        newseparator = document.createElement('mo');

                        if(separator==null){
                            newseparator.innerText=',';
                        }else{
                            if(separator.charAt(j))
                                newseparator.innerText=separator.charAt(j);
                            else
                                newseparator.innerText=separator.slice(-1);
                        }
                        newrow.append(newseparator);
                    }
                }

                if(close===')' || close ==null || close == ''){
                    newClose = moCreation(')','meaning','close');
                }else{
                    newClose = moCreation(close,'meaning','close');
                }
                newrow.append(newClose);
                mrewritten += newrow.outerHTML;
            }


            if(alltag.getElementsByTagName('mo')[i]){
                var motext = alltag.getElementsByTagName('mo')[i];
                   mrewritten+=motext.outerHTML;
            }

            // if(alltag.getElementsByTagName('mi')[i]){
            //     var mitext = alltag.getElementsByTagName('mi')[i];
            //        mrewritten+=mitext.outerHTML;
            // }

            if(alltag.getElementsByTagName('mfrac')[i]){

            }

        }
        newmath.innerHTML=mrewritten;
        document.getElementById('mathml1').innerHTML=newmath.outerHTML;
    }

});


function moCreation(inText, attr='', attrVal=''){
    var newMo = document.createElement('mo');
    if(attr!='' && attrVal!='')
    newMo.setAttribute(attr,attrVal);
    newMo.innerText=inText;

    return newMo;
}