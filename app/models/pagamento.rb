class Pagamento < ActiveRecord::Base
  attr_accessible :car_id, :data_pagamento, :forma_pagamento, :observacao, :valor, :pagamentos_attributes,
      :comprador_id, :empresa_id
  belongs_to :car
  belongs_to :cegonha
  belongs_to :cliente
  belongs_to :empresa
  belongs_to :parceiro

  before_save :verifica_comprador_ou_empresa_id, :verifica_saldo
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

def verifica_saldo
  unless self.valor.nil? || self.valor == 0
    saldo_devedor = 0
    saldo_credor = 0
    if self.comprador_id
      pagamentos = Comprador.find(self.comprador_id).pagamentos
      pagamentos.each do |pagamento|
        saldo_credor += pagamento.valor
      end
      cars = Comprador.find(self.comprador_id).cars
      cars.each do |car|
        saldo_devedor = car.debito.valor_total - car.debito.desconto
      end
    elsif self.empresa_id
      pagamentos = Empresa.find(self.empresa_id).pagamentos
      pagamentos.each do |pagamento|
        saldo_credor += pagamento.valor
      end
      cars = Empresa.find(self.empresa_id).cars
      cars.each do |car|
        saldo_devedor = car.debito.valor_total - car.debito.desconto
      end
    end
    self.saldo = saldo_devedor - (saldo_credor + self.valor)
  end
end

  def apaga_se_valor_for_nulo_ou_zero
    if self.valor.nil? || self.valor == 0
      self.destroy
    end
  end

end
