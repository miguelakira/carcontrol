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
     self.cars.map {|car| car.pagamento.valor_total}.inject(0, &:+)
   end

end
