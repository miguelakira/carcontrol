#encoding: UTF-8
class Cegonha < ActiveRecord::Base
  attr_accessible :carros, :comentario, :destino, :localizacao, :origem, :placa, :motorista_attributes, :pagamento_attributes,
    :empresa_attributes, :observacao, :empresa_id, :motorista_id, :rotas, :nome_rota, :cidade_id, :estado_id,
    :estado_origem, :cidade_origem, :estado_destino, :cidade_destino
  has_one :pagamento
  has_many :cars
  has_many :historicos
  belongs_to :empresa
  belongs_to :motorista
  accepts_nested_attributes_for :empresa, :motorista, :pagamento

  validates	:placa,
    :presence => { :message => "- A placa não pode ser deixada em branco!" },
    :uniqueness => { :message => "- A placa já existe no banco de dados. É preciso que seja única." }

  before_save :check_routes

  after_update :activate_cars, :unload_cars_if_arrived_at_destination, :update_locations

  has_paper_trail :only => [:cidade_id, :estado_id, :origem, :destino]

  def check_routes
    if rotas.nil?
      rotas = 1
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
    if (self.cidade_destino == self.cidade_id)
      cars.each do |car|
        # verifica se o carro descarregado chegou no destino ou se vai embarcar em outra cegonha/parceiro (logistica)

        if car.cidade_destino == self.cidade_destino
          car.ativo = VEHICLE_STATUS.index('UNLOADED')
        else
          car.ativo = VEHICLE_STATUS.index('IN_LOGISTICS')
        end
        car.cegonha = nil
        car.save
      end
      self.update_column(:rotas, self.rotas + 1)
      self.update_column(:cidade_destino, nil)
      self.update_column(:cidade_origem, nil)
    end
  end

  def update_locations
    localizacao = "#{Cidade.find(self.cidade_id).text}, #{Estado.find(self.estado_id).sigla}"
    unless self.cars.nil?
      self.cars.each do |car|
        car.estado_id = self.estado_id
        car.cidade_id = self.cidade_id
        car.localizacao = localizacao
        car.save
      end
    end

    self.update_column(:localizacao, localizacao)
  end

  # all cars in freighters are being transported.
  def activate_cars
    unless self.cars.nil?
      self.cars.each do |car|
        car.ativo = "#{VEHICLE_STATUS.index 'ON_TRANSIT'}"
        car.save
      end
    end
  end

  # check if freighter arrived at a car destination.
  def cars_arrived_at_destination?
    !self.cars.where(:cidade_destino => self.cidade_id).empty?
  end

  def cars_to_be_unloaded
    self.cars.select{ |c| c.cidade_destino == self.cidade_id}
  end

end
