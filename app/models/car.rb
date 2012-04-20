class Car < ActiveRecord::Base
  attr_accessible :localizacao, :modelo, :placa, :rota_id, :status_pagamento_id, :comprador_attributes
  belongs_to :status_pagamento
  has_one :comprador
  accepts_nested_attributes_for :comprador

  validates	:placa, 
  			:presence => true, 
  			:uniqueness => true
  
  validates :modelo,
  			:presence => true

  
  before_save :transforma_placa_em_maiuscula, :transforma_modelo_em_minuscula
  after_find :capitaliza_modelo

  def self.search(search)
    if search
      search = "%" + search + "%"
      where{{placa.like => search}}
    else
      scoped
    end
  end

  def transforma_placa_em_maiuscula
  	self.placa.upcase!
  end

  def transforma_modelo_em_minuscula
  	self.modelo.downcase!
  end  

  def capitaliza_modelo
  	self.modelo = self.modelo.titleize
  end

=begin
  define_index do 
  	indexes placa
  	indexes modelo, :sortable => true
  	indexes localizacao, :sortable => true

  end
=end
end
