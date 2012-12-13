#encoding: UTF-8
class Comprador < ActiveRecord::Base
  attr_accessible :celular, :email, :rg, :cpf, :telefone, :nome, :car_id, :observacao
  has_many :cars
  has_many :contatos
  has_many :pagamentos
  has_one :debito

  accepts_nested_attributes_for :cars, :pagamentos, :debito


  validates :nome,
  			:presence => { :message => "- O nome do comprador não pode ser deixado em branco." }

  validates :cpf,
        :presence => { :message => "- O CPF do comprador não pode ser deixaod em branco." },
        :uniqueness => { :message => "- CPF já existente." }

  before_save :transforma_nome_em_minuscula, :transforma_email_em_minuscula, :sanitiza_documentos, :split_nomes

  after_find :capitaliza_nome

  def transforma_nome_em_minuscula
  	self.nome.downcase!
  end

  def transforma_email_em_minuscula
  	if self.email
  		self.email.downcase!
  	end
  end

  def devedor?
    devedor = cars.select { |c| c.pagamento.saldo_devedor > 0}
    devedor.empty? ? false : true
  end

  def split_nomes
    self.firstname, self.middlename, self.lastname = nil
    nome_array = nome.split
    self.firstname = nome_array.first
    self.lastname = nome_array.last
    nome_array.pop; nome_array.shift
    self. middlename = nome_array.join(" ") unless nome_array.empty?
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

