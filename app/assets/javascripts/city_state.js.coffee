jQuery ->
  cidades = $('#car_cidade_id').html()
  $('#car_estado_id').change ->
    estado = $('#car_estado_id :selected').text()
    escaped_estado = estado.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cidades).filter("optgroup[label=#{escaped_estado}]").html()
    if options
      $('#car_cidade_id').html(options)
    else
      $('#car_cidade_id').empty()

  cidades_origem = $('#car_cidade_origem').html()
  $('#car_estado_origem').change ->
    estado = $('#car_estado_origem :selected').text()
    escaped_estado = estado.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cidades_origem).filter("optgroup[label=#{escaped_estado}]").html()
    if options
      $('#car_cidade_origem').html(options)
    else
      $('#car_cidade_origem').empty()

  cidades_destino = $('#car_cidade_destino').html()
  $('#car_estado_destino').change ->
    estado = $('#car_estado_destino :selected').text()
    escaped_estado = estado.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cidades_destino).filter("optgroup[label=#{escaped_estado}]").html()
    if options
      $('#car_cidade_destino').html(options)
    else
      $('#car_cidade_destino').empty()

  cegonha_cidades = $('#cegonha_cidade_id').html()
  $('#cegonha_estado_id').change ->
    estado = $('#cegonha_estado_id :selected').text()
    escaped_estado = estado.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cegonha_cidades).filter("optgroup[label=#{escaped_estado}]").html()
    if options
      $('#cegonha_cidade_id').html(options)
    else
      $('#cegonha_cidade_id').empty()

  cegonha_cidades_origem = $('#cegonha_cidade_origem').html()
  $('#cegonha_estado_origem').change ->
    estado = $('#cegonha_estado_origem :selected').text()
    escaped_estado = estado.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cegonha_cidades_origem).filter("optgroup[label=#{escaped_estado}]").html()
    if options
      $('#cegonha_cidade_origem').html(options)
    else
      $('#cegonha_cidade_origem').empty()

  cegonha_cidades_destino = $('#cegonha_cidade_destino').html()
  $('#cegonha_estado_destino').change ->
    estado = $('#cegonha_estado_destino :selected').text()
    escaped_estado = estado.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(cegonha_cidades_destino).filter("optgroup[label=#{escaped_estado}]").html()
    if options
      $('#cegonha_cidade_destino').html(options)
    else
      $('#cegonha_cidade_destino').empty()