class Pagamento < ActiveRecord::Base
  attr_accessible :car_id, :data_pagamento, :forma_pagamento, :observacao, :valor_pago, :valor_total, 
  		:taxa_despacho, :taxa_plataforma, :desconto, :valor_frete
  belongs_to :car
  belongs_to :cegonha

  before_save :calcula_saldo_devedor, :calcula_valor_total

  def calcula_saldo_devedor
    if self.valor_total.nil?
      self.valor_total = 0
    end
    if self.taxa_despacho.nil?
 		  self.taxa_despacho = 0
  	end
  	if self.taxa_plataforma.nil?
  		self.taxa_plataforma = 0
  	end
    if self.desconto.nil?
  		self.desconto = 0
  	end
  	if self.valor_pago.nil?
  		self.valor_pago = 0
  	end

  	self.saldo_devedor = self.valor_frete + self.taxa_despacho + self.taxa_plataforma - self.desconto - self.valor_pago
  end

  def calcula_valor_total
    self.valor_total = self.valor_frete + self.taxa_despacho + self.taxa_plataforma
  end


end
