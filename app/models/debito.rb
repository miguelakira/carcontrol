class Debito < ActiveRecord::Base
  attr_accessible :car_id, :data_pagamento, :forma_pagamento, :observacao, :valor_pago, :valor_total,
  		:taxa_despacho, :taxa_plataforma, :desconto, :valor_frete, :taxa_plataforma_origem, :taxa_plataforma_destino,
      :taxa_balsa

  belongs_to :car
  belongs_to :cegonha
  belongs_to :cliente
  belongs_to :empresa

  before_save :calcula_valor_total

    # valor total sem descontos ou pagamentos
  def calcula_valor_total
    self.valor_total = self.valor_frete + self.taxa_despacho + self.taxa_plataforma + self.taxa_plataforma_origem + self.taxa_plataforma_destino + self.taxa_balsa
  end
end
