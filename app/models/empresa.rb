class Empresa < ActiveRecord::Base
  attr_accessible :car_id, :celular, :cnpj, :contato, :created_at, :email, :nome, :telefone, :updated_at
  has_many :cars
  accepts_nested_attributes_for :cars


  validates :nome,
        :presence => true

  validates :cnpj,
        :presence => true

  before_save :transforma_nome_em_minuscula, :transforma_email_em_minuscula, :sanitiza_documentos

  after_find :capitaliza_nome

  def transforma_nome_em_minuscula
    self.nome.downcase!
  end

  def transforma_email_em_minuscula
    if self.email
      self.email.downcase!
    end
  end

  #limpa pontuaçao de documentos
  # RG - 41.065.522-5 vira 410655225
  def sanitiza_documentos
    self.cnpj.gsub!(/[^[:alnum:]]/, '')
  end

  def capitaliza_nome
    self.nome = self.nome.titleize
    self.contato = self.contato.titleize
  end

end
