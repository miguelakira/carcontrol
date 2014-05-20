function fillFieldsComprador(oSel)
{
  var oForm = oSel.form;
    if (oSel.value === '') {
      oForm.comprador_nome.value='';
      oForm.comprador_email.value='';
      oForm.comprador_rg.value='';
      oForm.comprador_cpf.value='';
      oForm.comprador_telefone.value='';
      oForm.comprador_celular.value='';
      oForm.comprador_observacao.value='';
      oForm.comprador_telefone_parente.value='';
      oForm.comprador_parente.value='';
    }

  for (var i = 0; i < gon.compradores.length; i++) {
    if (oSel.value === gon.compradores[i].cpf) {
      oForm.comprador_nome.value = gon.compradores[i].nome;
      oForm.comprador_email.value = gon.compradores[i].email;
      oForm.comprador_rg.value = gon.compradores[i].rg;
      oForm.comprador_cpf.value = gon.compradores[i].cpf;
      oForm.comprador_telefone.value = gon.compradores[i].telefone;
      oForm.comprador_celular.value = gon.compradores[i].celular;
      oForm.comprador_telefone_parente.value = gon.compradores[i].telefone_parente;
      oForm.comprador_parente.value = gon.compradores[i].parente;
      oForm.comprador_observacao.value =  gon.compradores[i].observacao;
      oForm.comprador_observacao.value =  gon.compradores[i].observacao ;
    }
  }
}

function fillFieldsEmpresa(oSel) {
  var oForm = oSel.form;
  if (oSel.value === '') {
    oForm.empresa_nome.value = '';
    oForm.empresa_email.value = '';
    oForm.empresa_contato.value = '';
    oForm.empresa_cnpj.value = '';
    oForm.empresa_telefone.value = '';
    oForm.empresa_celular.value = '';
    oForm.empresa_observacao.value = '';
  }

  for (var i = 0; i < gon.empresas.length; i++) {
    if (oSel.value === gon.empresas[i].cnpj) {
      oForm.empresa_nome.value = gon.empresas[i].nome;
      oForm.empresa_email.value = gon.empresas[i].email;
      oForm.empresa_contato.value = gon.empresas[i].contato;
      oForm.empresa_cnpj.value = gon.empresas[i].cnpj;
      oForm.empresa_telefone.value = gon.empresas[i].telefone;
      oForm.empresa_celular.value = gon.empresas[i].celular;
      oForm.empresa_observacao.value = gon.empresas[i].observacao;
    }
  }
}