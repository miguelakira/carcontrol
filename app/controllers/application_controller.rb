class ApplicationController < ActionController::Base
  protect_from_forgery

  def contagem_carros(terceiros)
    # faz update da contagem de carros da cegonha ou dos parceiros

    terceiros.each do |terceiro|
      terceiro.carros = terceiro.cars.count
      terceiro.save
    end
  end

  def ativar_status_de_carro_com_terceiros(id, nome_terceiro)
    terceiro = eval(nome_terceiro).find(id)
    unless terceiro.cars.nil?
      terceiro.cars.each do |car|
        car.ativo = 1
        car.save
      end
    end
  end

# recipiente pode ser cegonha ou parceiro
 def atualiza_historico_cegonha(car)
  #caso seja carro de parceiro, nao faz nada
  if car.parceiro.nil?
    # protege contra codigo legado antes do historico
    if car.cegonha
      if car.historicos.empty?
        car.historicos.create(:cegonha_id => car.cegonha.id, :nome_rota => car.cegonha.get_nome_rota, :rota => car.cegonha.rotas)
      end
    end
    # entrou na cegonha
    if !car.cegonha
      if params[:car]
        if !params[:car][:cegonha_id].empty? and !car.parceiro
          cegonha = Cegonha.find(params[:car][:cegonha_id])
          cegonha.historicos.new(:car_id => car.id, :data_entrada => Time.now, :localizacao_entrada => cegonha.localizacao, :rota => cegonha.rotas, :nome_rota => cegonha.get_nome_rota)
          cegonha.save
        end
      end
    end

    #mudou de cegonha
    if car.cegonha
      if params[:car]
        if !params[:car][:cegonha_id].empty?
          if params[:car][:cegonha_id].to_i != car.cegonha.id
            car.historicos.last.update_attributes(:data_saida => Time.now, :localizacao_saida => car.cegonha.localizacao)
            cegonha = Cegonha.find(params[:car][:cegonha_id])
            cegonha.historicos.new(:car_id => car.id, :data_entrada => Time.now, :localizacao_entrada => cegonha.localizacao, :rota => cegonha.rotas, :nome_rota => cegonha.get_nome_rota)
            cegonha.save
          end
        end
      end
    end

    #saiu de cegonha ou foi criado direto na cegonha
    if car.cegonha
      #saiu da cegonha
      if params[:car]
        if params[:car][:cegonha_id].empty?
          car.historicos.last.update_attributes(:data_saida => Time.now, :localizacao_saida => car.cegonha.localizacao)
        end
      else
        car.historicos.last.update_attributes(:data_entrada => Time.now, :localizacao_entrada => car.cegonha.localizacao, :rota => car.cegonha.rotas, :nome_rota => car.cegonha.get_nome_rota)
      end
    end
  end
  end


def atualiza_historico_parceiro(car)

    # protege contra codigo legado antes do historico
    if car.parceiro
      if car.historicos.empty?
        car.historicos.create(:parceiro_id => car.parceiro.id)
      end
    end
    # entrou na cegonha
    if !car.parceiro
      if params[:car]
        if !params[:car][:parceiro_id].empty?
          parceiro = Parceiro.find(params[:car][:parceiro_id])
          parceiro.historicos.new(:car_id => car.id, :data_entrada => Time.now, :localizacao_entrada => car.localizacao)
          parceiro.save
        end
      end
    end

    #mudou de parceiro
    if car.parceiro
      if params[:car]
        if !params[:car][:parceiro_id].empty?
          if params[:car][:parceiro_id].to_i != car.parceiro.id
            car.historicos.last.update_attributes(:data_saida => Time.now, :localizacao_saida => car.localizacao)
            parceiro = Parceiro.find(params[:car][:parceiro_id])
            parceiro.historicos.new(:car_id => car.id, :data_entrada => Time.now, :localizacao_entrada => car.localizacao)
            parceiro.save
          end
        end
      end
    end

    #saiu de parceiro ou foi criado direto na parceiro
    if car.parceiro
      #saiu da parceiro
      if params[:car]
        if params[:car][:parceiro_id].empty? and params[:car][:cegonha_id].empty?
          car.historicos.last.update_attributes(:data_saida => Time.now, :localizacao_saida => car.localizacao)
        # saiu do parceiro e entrou na cegonha
        elsif params[:car][:parceiro_id].empty? and !params[:car][:cegonha_id].empty?
          car.historicos.last.update_attributes(:data_saida => Time.now, :localizacao_saida => car.localizacao)
          cegonha = Cegonha.find(params[:car][:cegonha_id])
          cegonha.historicos.new(:car_id => car.id, :data_entrada => Time.now, :localizacao_entrada => cegonha.localizacao, :rota => cegonha.rotas, :nome_rota => cegonha.get_nome_rota)
          cegonha.save
        end
      else
        car.historicos.last.update_attributes(:data_entrada => Time.now, :localizacao_entrada => car.localizacao)
      end
    end
  end



  def converter_string_to_bigdecimal(veiculo, valores)


if valores[:valor_frete]

    unless valores[:valor_frete].empty?
      valores[:valor_frete].gsub!('.', '')
      valores[:valor_frete].gsub!(',','.')
      veiculo.debito.valor_total = BigDecimal(valores[:valor_frete])
    end
  end
  if valores[:valor_pago]

    unless valores[:valor_pago].empty?
      valores[:valor_pago].gsub!('.', '')
      valores[:valor_pago].gsub!(',','.')
      veiculo.debito.valor_pago = BigDecimal(valores[:valor_pago])
    end
  end

if valores[:valor_despacho]
    unless valores[:taxa_despacho].empty?
      valores[:taxa_despacho].gsub!('.', '')
      valores[:taxa_despacho].gsub!(',','.')
      veiculo.debito.taxa_despacho = BigDecimal(valores[:taxa_despacho])
    end
end

if valores[:taxa_plataforma]
    unless valores[:taxa_plataforma].empty?
      valores[:taxa_plataforma].gsub!('.', '')
      valores[:taxa_plataforma].gsub!(',','.')
      veiculo.debito.taxa_plataforma = BigDecimal(valores[:taxa_plataforma])
    end
  end

if valores[:desconto]

    unless valores[:desconto].empty?
      valores[:desconto].gsub!('.', '')
      valores[:desconto].gsub!(',','.')
      veiculo.debito.desconto = BigDecimal(valores[:desconto])
    end
  end

if valores[:valor]

    unless valores[:valor].empty?
      valores[:valor].gsub!('.', '')
      valores[:valor].gsub!(',','.')

      veiculo.pagamentos.last.valor = BigDecimal(valores[:valor])
    end
  end
  end
end
