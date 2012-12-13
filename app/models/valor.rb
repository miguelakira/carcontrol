class Valor < ActiveRecord::Base
  attr_accessible :comprador_id, :empresa_id, :pago
  belongs_to :comprador
  belongs_to :empresa

end
