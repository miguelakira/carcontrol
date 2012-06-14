class Motorista < ActiveRecord::Base
  attr_accessible :cegonha_id, :celular, :cpf, :email, :nome, :rg, :telefone
  belongs_to :cegonha
end
