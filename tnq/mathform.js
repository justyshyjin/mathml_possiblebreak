$(document).ready(function(){

    var alltag= document.getElementById("main");
    var convert =document.getElementById("mathmlnorm");
    document.getElementById('mathml').value=alltag.innerHTML;

    document.getElementById('mathml').addEventListener('keyup',function(e){
        alltag.innerHTML=this.value;
    });

    convert.onclick= function(){
        if(alltag.getElementsByTagName("mfenced")[0]){

            var mfenced = alltag.getElementsByTagName("mfenced")[0];
            var open = mfenced.getAttribute("open");
            var close = mfenced.getAttribute("close");
            var separator = mfenced.getAttribute("separators");

            var newrow = document.createElement('mrow');
                newrow.setAttribute("meaning", "fenced");
            var newfenceattr = newOpen = newClose= newseparator = childtag='';

            newopen=document.createElement('mo');
            newopen.setAttribute('meaning','open');

            if(open==='(' || open ==null){
                newOpen=moCreation('meaning','open','(');
            }else{
                newOpen=moCreation('meaning','open',open);
            }
            newrow.append(newOpen);

            childtag = mfenced.children;

            for (i = 0; i < childtag.length; i++) {

                newrow.append(childtag[i].outerHTML);
                if(i!=childtag.length-1 && separator!=""){
                    newseparator = document.createElement('mo');

                    if(separator==null){
                        newseparator.innerText=',';
                    }else{
                        if(separator[i])
                            newseparator.innerText=separator[i];
                        else
                            newseparator.innerText=separator.slice(-1);
                    }
                    newrow.append(newseparator);
                }
            }

            if(close===')' || close ==null || close == ''){
                newClose = moCreation('meaning','close',')');
            }else{
                newClose = moCreation('meaning','close',close);
            }
            newrow.append(newClose);

            document.getElementById('mathml1').innerHTML=newrow.outerHTML;
        }else{
            document.getElementById('mathml1').innerHTML='';
        }
    }

});


function moCreation(attr, attrVal ,inText){
    var newMo = document.createElement('mo');
    newMo.setAttribute(attr,attrVal);
    newMo.innerText=inText;
    return newMo;
}