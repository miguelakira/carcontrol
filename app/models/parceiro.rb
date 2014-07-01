class Parceiro < ActiveRecord::Base
  attr_accessible :carros, :celular, :cidade_destino, :cidade_id, :cidade_origem, :observacao, :contato,
  		:estado_destino, :estado_id, :estado_origem, :localizacao, :nome, :telefone, :cnpj, :email, :cpf,
      :pagamentos_attributes, :debito_attributes, :cars_attributes
  
  has_many :debitos, :through => :cars
  has_many :cars
  has_many :historicos
  has_many :pagamentos
  has_many :compradores
  has_many :empresas


  accepts_nested_attributes_for :cars, :pagamentos, :compradores, :debitos

  validates	:nome, :presence => { :message => "- O nome nao pode ser deixada em branco!" }

  before_save :capitaliza_nome
  after_update :activate_cars

  def capitaliza_nome
    if self.nome
      self.nome = self.nome.titleize
    end
  end

  def active_cars
    self.cars.reject {|c| c.ativo == VEHICLE_STATUS.index('DELIVERED')}
  end 
  
  def total_freight
    self.cars.map {|car| car.debito.valor_total}.inject(0, &:+)
  end

    def activate_cars
    unless self.cars.nil?
      self.cars.each do |car|
        car.ativo = "#{VEHICLE_STATUS.index 'ON_TRANSIT'}"
        car.save
      end
    end
  end


end
