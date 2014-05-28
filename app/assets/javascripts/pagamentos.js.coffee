# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
        $('#pagamentos').dataTable
          sPaginationType: "foundation"
          aLengthMenu: [ 10, 30, 50, 100 ],
          iDisplayLength: 50
          oLanguage:
            sInfo: "Exibindo _START_ à _END_ de _TOTAL_ entradas"
            sInfoEmpty: "Exibindo 0 à 0 de 0 entradas"
            sInfoFiltered: "(filtrado de um total de _MAX_ entradas)"
            sLengthMenu: "Exibir _MENU_ entradas"
            sLoadingRecords: "Carregando..."
            sProcessing: "Processando..."
            sSearch: "Buscar:"
            sZeroRecords: "Não foi encontrado nenhum resultado para sua busca. Verifique se você digitou corretamente, incluindo as pontuações. <br>
            (ex: 5.000 ao invés de 5000 ou 05/08/2013 ao invés de 5/2/13)"
            oPaginate:
              sFirst: "Início"
              sNext: "Próximo"
              sLast: "Final"
              sPrevious: "Anterior"
              sEmptyTable: "Nenhum dado disponível na tabela"
