class Motorista < ActiveRecord::Base
  attr_accessible :cegonha_id, :celular, :cpf, :email, :nome, :rg, :telefone, :observacao, :cegonha_id
  has_many :cegonhas
  accepts_nested_attributes_for :cegonhas

end
