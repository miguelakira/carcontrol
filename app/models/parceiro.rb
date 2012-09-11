class Parceiro < ActiveRecord::Base
  attr_accessible :carros, :celular, :cidade_destino, :cidade_id, :cidade_origem, :comentario, :contato, :estado_destino, :estado_id, :estado_origem, :localizacao, :nome, :telefone
  has_one :pagamento
  has_many :cars
  has_many :historicos

  validates	:nome, 
  			:presence => { :message => "- O nome não pode ser deixada em branco!" }
  			
end
