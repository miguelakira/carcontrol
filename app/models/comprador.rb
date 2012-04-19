class Comprador < ActiveRecord::Base
  attr_accessible :celular, :email, :rg, :telefone, :firstname, :middlename, :lastname, :car_id
  belongs_to :car

  validates :firstname,
  			:presence => true

  validates :lastname,
  			:presence => true

  validates :rg,
  			:presence => true

  before_save :transforma_nome_em_minuscula, :transforma_email_em_minuscula, :sanitiza_documentos
  after_find :capitaliza_nome

  def transforma_nome_em_minuscula
  	self.firstname.downcase!
  	self.lastname.downcase!
  	if self.middlename
  		self.middlename.downcase!
  	end
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
  	self.firstname.capitalize!
  	self.lastname.capitalize!
  	if self.middlename
  		self.middlename = self.middlename.titleize
  	end
  end

end
