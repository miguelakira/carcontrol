class Debito < ActiveRecord::Base
  attr_accessible :car_id,
  :data_pagamento,
  :forma_pagamento,
  :observacao,
  :valor_pago,
  :valor_total,
  		:taxa_despacho,
      :taxa_plataforma,
      :desconto,
      :valor_frete,
      :taxa_plataforma_origem,
      :taxa_plataforma_destino,
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

"car"=>{"comprador_attributes"=>{"cpf"=>"331.644.318-56",
  "nome"=>"miguel akira",
"email"=>"miguel.akira@gmail.com",
"rg"=>"410644225",
"telefone"=>"(43) 3371-1893",
"celular"=>"(43) 8824-4545",
"parente"=>"",
"telefone_parente"=>"",
"observacao"=>""},
"placa"=>"FDK-4478",
"modelo"=>"fiat 500 cult mecânico",
"data_compra(3i)"=>"14",
"data_compra(2i)"=>"2",
"data_compra(1i)"=>"2013",
"data_prevista(3i)"=>"",
"data_prevista(2i)"=>"",
"data_prevista(1i)"=>"",
"status_pagamento_id"=>"1",
"cegonha_id"=>"",
"parceiro_id"=>"",
"observacao"=>"",
"debito_attributes"=>{"valor_frete"=>"",
  "taxa_plataforma"=>" 0.00",
"taxa_plataforma_origem"=>" 0.00",
"taxa_plataforma_destino"=>" 0.00",
"taxa_balsa"=>" 0.00",
"taxa_despacho"=>" 0.00",
"desconto"=>" 0.00",
"observacao"=>""},
"pagamentos_attributes"=>{"0"=>{"forma_pagamento"=>"",
  "valor"=>"",
"data_pagamento(3i)"=>"14",
"data_pagamento(2i)"=>"2",
"data_pagamento(1i)"=>"2013"}}},
"ativo"=>"5",
"editar_localizacao"=>"Salvar e Editar Localização",
"action"=>"create",
"controller"=>"cars"}
  * Rails root: /app
