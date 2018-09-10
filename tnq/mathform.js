$(document).ready(function(){

    var alltag= document.getElementById("main");

    document.getElementById('mathml').value=alltag.innerHTML;



    if(alltag.getElementsByTagName("mfenced")[0]){

        var mfenced = alltag.getElementsByTagName("mfenced")[0];
        var open = mfenced.getAttribute("open");
        var close = mfenced.getAttribute("close");

        var newrow = document.createElement('mrow');
        newrow.setAttribute("meaning", "fenced");
        var newfenceattr ='';
        if(open==='['){
            var newopen=document.createElement('mo');
            newopen.setAttribute('meaning','open');
            newopen.innerHTML='[';
            newfenceattr+=newopen.outerHTML;
        }
        var childtag = mfenced.children;

        for (var i = 0; i <= childtag.length; i++) {
            //newfenceattr+=childtag[i].outerHTML;
        }

        if(close===']'){
            var newclose=document.createElement('mo');
            newclose.setAttribute('meaning','close');
            newclose.innerHTML=']';
            newfenceattr+=newclose.outerHTML;
        }
        newrow.append(newfenceattr);
        document.getElementById('mathml1').innerHTML=newrow.outerHTML;
    }
    else{

    }


    console.log(childtag);

});