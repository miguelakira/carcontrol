class Car < ActiveRecord::Base
  attr_accessible :comprador_id, :localizacao, :modelo, :placa, :rota_id
  has_one :status_pagamento
  has_one :comprador
  accepts_nested_attributes_for :comprador

end
