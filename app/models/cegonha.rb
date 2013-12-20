#encoding: UTF-8
class Cegonha < ActiveRecord::Base
  attr_accessible :carros, :comentario, :destino, :localizacao, :origem, :placa, :motorista_attributes, :pagamento_attributes,
    :empresa_attributes, :observacao, :empresa_id, :motorista_id, :rotas, :nome_rota
  has_one :pagamento
  has_many :cars
  has_many :historicos
  belongs_to :empresa
  belongs_to :motorista
  accepts_nested_attributes_for :empresa, :motorista, :pagamento

  validates	:placa,
    :presence => { :message => "- A placa não pode ser deixada em branco!" },
    :uniqueness => { :message => "- A placa já existe no banco de dados. É preciso que seja única." }

  before_save :check_routes, :salva_nome_do_motorista

  after_save :unload_cars_if_arrived_at_destination

  def check_routes
    if rotas.nil?
      rotas = 1
    end
  end

  def salva_nome_do_motorista
    if self.nome.nil?
      self.nome = self.motorista.nome
    end
  end

  def route_name
    if cidade_origem and estado_origem and estado_destino and cidade_destino
      return "#{Cidade.find(cidade_origem).text}, #{Estado.find(estado_origem).sigla} -  #{Cidade.find(cidade_destino).text}, #{Estado.find(estado_destino).sigla}"
    end
  end

   def total_freight
     cars.map {|car| car.debito.valor_total}.inject(0, &:+)
   end

 # se chegou no destino, tira os carros da cegonha e fecha o historico
  def unload_cars_if_arrived_at_destination
    if (cidade_destino == cidade_id && estado_destino == estado_id)
      cars.each do |car|
        # protege contra codigo legado antes do historico
        if car.historicos.empty?
            car.historicos.create(:cegonha_id => car.cegonha.id)
        end
        #saiu da cegonha
        car.historicos.last.update_attributes(:data_saida => Time.now, :localizacao_saida => localizacao)
        # verifica se o carro descarregado chegou no destino ou se vai embarcar em outra cegonha/parceiro (logistica)
        if car.cidade_destino == cidade_destino and car.estado_destino == estado_destino
          car.ativo = VEHICLE_STATUS.index('UNLOADED')
        else
          car.ativo = VEHICLE_STATUS.index('IN_LOGISTICS')
        end
        car.cegonha = nil
        car.save

      end
      self.rotas += 1
      self.cidade_origem = nil
      self.cidade_destino = nil
      self.estado_origem = nil
      self.estado_destino = nil
      self.save
    end
  end

end
