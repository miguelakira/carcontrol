#encoding: UTF-8
class Comprador < ActiveRecord::Base
  attr_accessible :celular, :email, :rg, :cpf, :telefone, :nome, :car_id, :observacao, :parente, :telefone_parente, :parceiro_id
          :pagamentos_attributes
  has_many :cars
  has_many :contatos
  has_many :pagamentos
  has_one :debito
  belongs_to :parceiro

  accepts_nested_attributes_for :cars, :pagamentos, :debito, :parceiro


  validates :nome,
  			:presence => { :message => "- O nome do comprador não pode ser deixado em branco." }

  validates :cpf,
        :presence => { :message => "- O CPF do comprador não pode ser deixaod em branco." },
        :uniqueness => { :message => "- CPF já existente." }

  before_save :downcase_name, :downcase_email, :sanitize_documents, :split_names

  after_find :titleize_name

  def downcase_name
    self.nome.downcase!
  end

  def downcase_email
    self.email.downcase!
  end

  def has_debts?
    devedor = self.cars.select { |c| c.pagamento.saldo_devedor > 0}
    devedor.empty? ? false : true
  end

  def split_names
    self.firstname, self.middlename, self.lastname = nil
    nome_array = nome.split
    self.firstname = nome_array.first
    self.lastname = nome_array.last
    nome_array.pop; nome_array.shift
    self. middlename = nome_array.join(" ") unless nome_array.empty?
  end

  #limpa pontuaçao de documentos
  # RG - 41.065.522-5 vira 410655225
  def sanitize_documents
  	self.rg.gsub!(/[^[:alnum:]]/, '')
  end

  def titleize_name
    self.nome = self.nome.titleize unless self.nome.nil?
  end

  def carros_ativos
    self.cars.reject {|c| c.ativo == 0}.count
  end

  def total_debt
    self.cars.map {|car| car.pagamento.valor_total}.inject(0, &:+)
  end

end

