# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-scri

jQuery ->
        $('#cars').dataTable
          aaSorting: null
          sPaginationType: "full_numbers"
          oLanguage:
            sInfo: "Exibindo _START_ à _END_ de _TOTAL_ entradas"
            sInfoEmpty: "Exibindo 0 à 0 de 0 entradas"
            sInfoFiltered: "(filtrado de um total de _MAX_ entradas)"
            sLengthMenu: "Exibir _MENU_ entradas"
            sLoadingRecords: "Carregando..."
            sProcessing: "Processando..."
            sSearch: "Buscar:"
            sZeroRecords: "Não foi encontrado nenhum resultado para sua busca."
            oPaginate:
              sFirst: "Início"
              sNext: "Próximo"
              sLast: "Final"
              sPrevious: "Anterior"
              sEmptyTable: "Nenhum dado disponível na tabela"

