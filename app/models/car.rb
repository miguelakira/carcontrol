#encoding: UTF-8
class Car < ActiveRecord::Base
  attr_accessible :localizacao, :modelo, :placa, :rota_id, :status_pagamento_id, :ativo, :estado_id, :cidade_id, :data_compra,
        :data_prevista, :cegonha_id, :comprador_attributes, :empresa_attributes, :debito_attributes, :observacao, :parceiro_id,
        :pagamentos_attributes, :estado_origem, :cidade_origem, :estado_destino, :cidade_destino

  belongs_to :status_pagamento
  belongs_to :cegonha
  belongs_to :comprador
  belongs_to :empresa
  belongs_to :parceiro
  has_one :debito
  has_many :historicos
  has_many :pagamentos
  accepts_nested_attributes_for :comprador, :empresa, :debito, :parceiro, :pagamentos

  validates	:placa,
  			:presence => { :message => "- A placa não pode ser deixada em branco!" },
  			:uniqueness => { :message => "- A placa já existe no banco de dados. É necessário que ela seja única" }

  validates :modelo,
  			:presence => { :message => "- O modelo do carro não pode ser deixado em branco!" }

  validates :status_pagamento_id, :car_not_paid => true

  before_save :license_plate_uppercase, :car_model_downcase, :remove_from_carrier_if_delivered,
    :person_or_company_name
  after_save :save_current_location
  after_find :titleize_model, :check_payments
  before_update :remove_car_from_freighter_tracking
  after_update :if_in_freighter_get_its_location, :add_car_to_freighter_tracking

  has_paper_trail :only => [:cidade_id, :estado_id]

  def person_or_company_name
    self.comprador.try(:nome) || self.empresa.try(:nome)
  end

  def remove_from_carrier_if_delivered
    if self.is_delivered?
      self.cegonha = nil
    end
  end

  def license_plate_uppercase
  	self.placa.upcase!
  end

  def car_model_downcase
  	self.modelo.downcase!
  end

  def titleize_model
  	self.modelo = self.modelo.titleize
  end

  def check_payments
    if self.pagamentos.empty?
      self.pagamentos.new(:valor => 0)
    end
  end

  def is_delivered?
    self.ativo == VEHICLE_STATUS.index('DELIVERED')
  end

  def ativo?
    ativo != VEHICLE_STATUS.index('DELIVERED')
  end

  def save_current_location
    unless self.cidade_id.nil? || self.estado_id.nil?
      localizacao = "#{Cidade.find(self.cidade_id).text}, #{Estado.find(self.estado_id).sigla}"
      self.update_column(:localizacao, localizacao)
    end
  end

  def if_in_freighter_get_its_location
    if self.cegonha
      self.update_column(:localizacao, self.cegonha.localizacao)
      self.update_column(:cidade_id, self.cegonha.cidade_id)
      self.update_column(:estado_id, self.cegonha.estado_id)
    end
  end

  def remove_car_from_freighter_tracking
    if self.cegonha != Car.find(self.id).cegonha and !Car.find(self.id).cegonha.nil?
      cegonha = Car.find(self.id).cegonha
      cars = Car.find(self.id).cegonha.cars
      cars.delete(self)
      cegonha.tracking.changes.first.update_column(
        :current_cars, cars.map(&:placa).to_sentence
        )
    end
  end

  def add_car_to_freighter_tracking
    if self.cegonha
      self.cegonha.tracking.changes.first.update_column(:current_cars, Car.find(self.id).cegonha.cars.map(&:placa).to_sentence)
    end
  end

  def owner
    self.comprador ? self.comprador : self.empresa
  end
end
