class Pagamento < ActiveRecord::Base
  attr_accessible :car_id, :data_pagamento, :forma_pagamento, :observacao, :valor_pago, :valor_total,
  		:taxa_despacho, :taxa_plataforma, :desconto, :valor_frete, :taxa_plataforma_origem, :taxa_plataforma_destino,
      :taxa_balsa, :comprador_id, :empresa_id

  belongs_to :car
  belongs_to :cegonha
  belongs_to :cliente
  belongs_to :empresa

  before_save :calcula_saldo_devedor, :calcula_valor_total
  after_find :verifica_se_pertence_a_comprador

  # codigo pra ajustar pagamentos legados que pertenciam ao carro, nao ao comprador
  def verifica_se_pertence_a_comprador
    if comprador_id.nil? and empresa_id.nil?
      if car.empresa
        self.update_attributes(:empresa_id => car.empresa.id)
      elsif car.comprador
        self.update_attributes(:comprador_id => car.comprador.id)
      end
    end
  end



  def calcula_saldo_devedor
    if self.valor_total.nil?
      self.valor_total = 0
    end
    if self.valor_frete.nil?
      self.valor_frete = 0
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
    if self.taxa_plataforma_origem.nil?
      self.taxa_plataforma_origem = 0
    end
    if self.taxa_plataforma_destino.nil?
      self.taxa_plataforma_destino = 0
    end
    if self.taxa_balsa.nil?
      self.taxa_balsa= 0
    end

    self.saldo_devedor = self.valor_frete + self.taxa_despacho + self.taxa_plataforma - self.desconto - self.valor_pago + self.taxa_plataforma_destino + self.taxa_plataforma_origem + self.taxa_balsa

  end

  # valor total sem descontos ou pagamentos
  def calcula_valor_total
    self.valor_total = self.valor_frete + self.taxa_despacho + self.taxa_plataforma + self.taxa_plataforma_origem + self.taxa_plataforma_destino + self.taxa_balsa
  end


end
