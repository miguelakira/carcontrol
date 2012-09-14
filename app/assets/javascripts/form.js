// Avisa que é possível escolher somente parceiro ou cegonha, não ambos
function parceiroOrCegonhaNotBoth(changedSelect, selectId) {
    
  //alert(changedSelect.options[changedSelect.selectedIndex].value);
   var otherSelect = document.getElementById(selectId);
    if(changedSelect.options[changedSelect.selectedIndex].value != ''){
      if(otherSelect.selectedIndex != 0) {
      var answer = confirm("Só é possível escolher Cegonha ou Parceiro, mas não ambos. Ao selecionar esta opção, vocẽ irá remover o carro do outro");
          if(answer) { 
            otherSelect.selectedIndex = 0;
          }
          else {
            changedSelect.selectedIndex = 0;
          }
      }
    }
    
}

