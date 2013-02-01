class Pagamento < ActiveRecord::Base
  attr_accessible :car_id, :data_pagamento, :forma_pagamento, :observacao, :valor, :pagamentos_attributes,
      :comprador_id, :empresa_id
  belongs_to :car
  belongs_to :cegonha
  belongs_to :cliente
  belongs_to :empresa
  belongs_to :parceiro

  before_save :verifica_comprador_ou_empresa_id
  after_save :apaga_se_valor_for_nulo_ou_zero

  def verifica_comprador_ou_empresa_id
    if self.car
      if self.car.comprador_id
        self.comprador_id = self.car.comprador_id
      elsif self.car.empresa_id
        self.empresa_id = self.car.empresa_id
      elsif self.car.parceiro_id
        self.parceiro_id = self.car.parceiro_id
      end
    end
  end

  def apaga_se_valor_for_nulo_ou_zero
    if self.valor.nil? || self.valor == 0
      self.destroy
    end
  end

end
