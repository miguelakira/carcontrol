function fillFieldsComprador(oSel)
{
  var oForm = oSel.form;

  switch (oSel.value)
  {
    case oSel.value:
      if (oSel.value === gon.comprador.cpf) {
        console.log(gon.comprador);
      }
      break;
    default: 
      break;
    }

}
    
//     case '<%= comprador.cpf %>':
//       oForm.comprador_nome.value='<%= comprador.nome%>';
//       oForm.comprador_email.value='<%= comprador.email%>';
//       oForm.comprador_rg.value='<%= comprador.rg%>';
//       oForm.comprador_cpf.value='<%= comprador.cpf%>';
//       oForm.comprador_telefone.value='<%= comprador.telefone%>';
//       oForm.comprador_celular.value='<%= comprador.celular%>';
//       oForm.comprador_telefone_parente.value='<%= comprador.telefone_parente%>';
//       oForm.comprador_parente.value='<%= comprador.parente%>';
//        <% if comprador.observacao.include?("\r\n") %>
//       <% comprador.observacao = comprador.observacao.gsub("\r\n", "   ") %>
//       <% end -%>
//       oForm.comprador_observacao.value= '<%= comprador.observacao %>';

//     break;

//     <%end%>
//     case '':
//       oForm.comprador_nome.value='';
//       oForm.comprador_email.value='';
//       oForm.comprador_rg.value='';
//       oForm.comprador_cpf.value='';
//       oForm.comprador_telefone.value='';
//       oForm.comprador_celular.value='';
//       oForm.comprador_observacao.value='';
//       oForm.comprador_telefone_parente.value='';
//       oForm.comprador_parente.value='';
//       break;
//   }
// }

// function fillFieldsEmpresa(oSel)
// {
//   var oForm = oSel.form;

//   switch (oSel.value)
//   {
//     <% empresas.each do |empresa| %>
//     case '<%= empresa.cnpj %>':
//       oForm.empresa_nome.value='<%= empresa.nome%>';
//       oForm.empresa_email.value='<%= empresa.email%>';
//       oForm.empresa_contato.value='<%= empresa.contato%>';
//       oForm.empresa_cnpj.value='<%= empresa.cnpj%>';
//       oForm.empresa_telefone.value='<%= empresa.telefone%>';
//       oForm.empresa_celular.value='<%= empresa.celular%>';
//       oForm.empresa_observacao.value='<%= empresa.observacao%>';

//     break;

//     <%end%>
//     case '':
//       oForm.empresa_nome.value='';
//       oForm.empresa_email.value='';
//       oForm.empresa_contato.value='';
//       oForm.empresa_cnpj.value='';
//       oForm.empresa_telefone.value='';
//       oForm.empresa_celular.value='';
//       oForm.empresa_observacao.value='';
//       break;
//   }
// }