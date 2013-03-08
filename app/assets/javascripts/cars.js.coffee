jQuery ->
        $('#cars').dataTable
          bJQueryUI: true
          sPaginationType: "full_numbers"
          aLengthMenu: [ 10, 30, 50, 100 ],
          iDisplayLength: 30
          oLanguage:
            sInfo: "Exibindo _START_ à _END_ de _TOTAL_ entradas"
            sInfoEmpty: "Exibindo 0 à 0 de 0 entradas"
            sInfoFiltered: "(filtrado de um total de _MAX_ entradas)"
            sLengthMenu: "Exibir _MENU_ entradas"
            sLoadingRecords: "Carregando..."
            sProcessing: "Processando..."
            sSearch: "Buscar:"
            sZeroRecords: "Não foi encontrado nenhum resultado para sua busca. Verifique se você digitou corretamente, incluindo as pontuações. <br>
            (ex: Para placa: DFQ-1324 ao invés de DFQ1234 e para CPF, 331.644.333-45 ao invés de 33164433345)"
            oPaginate:
              sFirst: "Início"
              sNext: "Próximo"
              sLast: "Final"
              sPrevious: "Anterior"
              sEmptyTable: "Nenhum dado disponível na tabela"

