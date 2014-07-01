class Debito < ActiveRecord::Base
  attr_accessible :car_id, :data_pagamento, :forma_pagamento, :observacao, :valor_pago, :valor_total,
  		:taxa_despacho, :taxa_plataforma, :desconto, :valor_frete, :taxa_plataforma_origem, :taxa_plataforma_destino,
      :taxa_balsa

  belongs_to :car
  belongs_to :cegonha
  belongs_to :cliente
  belongs_to :empresa
  belongs_to :parceiro

  before_save :calcula_valor_total

    # valor total sem descontos ou pagamentos
  def calcula_valor_total
    self.valor_total = sum_total_values(
                            valor_frete,
                            taxa_plataforma,
                            taxa_plataforma_origem,
                            taxa_plataforma_destino,
                            taxa_balsa
                        )
    self.valor_total -= BigDecimal.new(desconto.to_s)
  end

  def sum_total_values(*args)
    args.sum { |v| BigDecimal.new(v.to_s) }
  end

  def desconto=(num)
    self[:desconto] = convert_string_to_bigdecimal(num)
  end

  def valor_frete=(num)
    self[:valor_frete] = convert_string_to_bigdecimal(num)
  end

  def taxa_despacho=(num)
    self[:taxa_despacho] = convert_string_to_bigdecimal(num)
  end

  def taxa_plataforma=(num)
    self[:taxa_plataforma] = convert_string_to_bigdecimal(num)
  end

  def taxa_plataforma_destino=(num)
    self[:taxa_plataforma_destino] = convert_string_to_bigdecimal(num)
  end

  def taxa_plataforma_origem=(num)
    self[:taxa_plataforma_origem] = convert_string_to_bigdecimal(num)
  end

  def taxa_balsa=(num)
    self[:taxa_balsa] = convert_string_to_bigdecimal(num)
  end

  def convert_string_to_bigdecimal(num)
    if num.is_a?(String)
      num.gsub!('.', '')
      num.gsub!(',','.')
      return num
    end
  end

end
