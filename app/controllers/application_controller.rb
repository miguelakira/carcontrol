class ApplicationController < ActionController::Base
  protect_from_forgery

  def contagem_carros(terceiros)
    # faz update da contagem de carros da cegonha ou dos parceiros
    
    terceiros.each do |terceiro|
      terceiro.carros = terceiro.cars.count
      terceiro.save
    end
  end

  def ativar_status_de_carro_com_terceiros(terceiro)
    unless terceiro.cars.nil?
      terceiro.cars.each do |car|
        car.ativo = 1
        car.save
      end
    end
  end

  def converter_string_to_bigdecimal(veiculo, valores)
    unless valores[:valor_frete].empty?
      valores[:valor_frete].gsub!('.', '')
      valores[:valor_frete].gsub!(',','.')
      veiculo.pagamento.valor_total = BigDecimal(valores[:valor_frete])
    end
    unless valores[:valor_pago].empty?
      valores[:valor_pago].gsub!('.', '')
      valores[:valor_pago].gsub!(',','.')
      veiculo.pagamento.valor_pago = BigDecimal(valores[:valor_pago])
    end

    unless valores[:taxa_despacho].empty?
      valores[:taxa_despacho].gsub!('.', '')
      valores[:taxa_despacho].gsub!(',','.')
      veiculo.pagamento.taxa_despacho = BigDecimal(valores[:taxa_despacho])
    end

    unless valores[:taxa_plataforma].empty?
      valores[:taxa_plataforma].gsub!('.', '')
      valores[:taxa_plataforma].gsub!(',','.')
      veiculo.pagamento.taxa_plataforma = BigDecimal(valores[:taxa_plataforma])
    end

    unless valores[:desconto].empty?
      valores[:desconto].gsub!('.', '')
      valores[:desconto].gsub!(',','.')
      veiculo.pagamento.desconto = BigDecimal(valores[:desconto])
    end


  end
end
