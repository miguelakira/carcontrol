class Contato < ActiveRecord::Base
  attr_accessible :cidade_id, :comprador_id, :email, :especie, :estado_id, :nome, :telefone
  belongs_to :comprador


end
