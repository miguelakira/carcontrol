class Parceiro < ActiveRecord::Base
  attr_accessible :carros, :celular, :cidade_destino, :cidade_id, :cidade_origem, :observacao, :contato, 
  		:estado_destino, :estado_id, :estado_origem, :localizacao, :nome, :telefone, :cnpj, :email, :cpf
  has_one :pagamento
  has_many :cars
  has_many :historicos

  validates	:nome, 
  			:presence => { :message => "- O nome nao pode ser deixada em branco!" }
  			
end
