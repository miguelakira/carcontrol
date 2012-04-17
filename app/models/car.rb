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



end
