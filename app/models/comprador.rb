class Comprador < ActiveRecord::Base
  attr_accessible :celular, :email, :rg, :cpf, :telefone, :nome, :car_id
  has_many :cars
  accepts_nested_attributes_for :cars


  validates :nome,
  			:presence => true

  validates :rg,
  			:presence => true

  validates :cpf,
        :presence => true,
        :uniqueness => true

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
  	self.rg.gsub!(/[^[:alnum:]]/, '')
  end

  def capitaliza_nome
    self.nome = self.nome.titleize unless self.nome.nil?
  end

end

