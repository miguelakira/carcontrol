class ApplicationController < ActionController::Base
  protect_from_forgery

  def contagem_carros_cegonha
    # faz update da contagem de carros da cegonha
    cegonhas = Cegonha.all
    cegonhas.each do |cegonha|
      cegonha.carros = cegonha.cars.count
      cegonha.save
    end
  end

   def converter_string_to_bigdecimal(veiculo, valores)
      valores[:valor_total].gsub!('.', '')
      valores[:valor_total].gsub!(',','.')
      veiculo.pagamento.valor_total = BigDecimal(valores[:valor_total])

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
