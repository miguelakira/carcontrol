class Motorista < ActiveRecord::Base
  attr_accessible :cegonha_id, :celular, :cpf, :email, :nome, :rg, :telefone, :observacao, :cegonha_id
  has_many :cegonhas
  accepts_nested_attributes_for :cegonhas

  before_save :transforma_nome_em_minuscula
  after_find :capitaliza_nome

  def transforma_nome_em_minuscula
    self.nome.downcase!
  end

  def capitaliza_nome
    self.nome = self.nome.titleize unless self.nome.nil?
  end

end
