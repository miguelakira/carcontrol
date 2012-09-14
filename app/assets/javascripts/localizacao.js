function ClearOptions(sel){
  //while (sel.options.length>0) sel.options[0]=null;
  sel.options.length=0;
}
function PopulateSelect(sel,optsArray){
  for (var i=0,len=optsArray.length;i<len;i++) sel.options[i]=optsArray[i];
}
function UpdateOptions(sel, elem_id){
  var destSel = document.getElementById(elem_id);
  ClearOptions(destSel);
  if (sel.value=="_xx_") return;
  var opts = [];
  var srcObjs = availVals[sel.value];
  for (var i=0,len=srcObjs.length;i<len;i++) opts[i]=new Option(srcObjs[i].text,srcObjs[i].value!=null?srcObjs[i].value:srcObjs[i].text);
  PopulateSelect(destSel,opts);
}


