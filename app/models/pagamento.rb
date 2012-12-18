class Pagamento < ActiveRecord::Base
  attr_accessible :car_id, :data_pagamento, :forma_pagamento, :observacao, :valor, :pagamentos_attributes,
      :comprador_id, :empresa_id
  belongs_to :car
  belongs_to :cegonha
  belongs_to :cliente
  belongs_to :empresa

  before_save :verifica_comprador_ou_empresa_id

  def verifica_comprador_ou_empresa_id

    if self.car.comprador_id
      self.comprador_id = self.car.comprador_id

    elsif self.car.empresa_id
      self.empresa_id = self.car.empresa_id
    end

  end

end
