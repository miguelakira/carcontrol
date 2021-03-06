#encoding: UTF-8
class Empresa < ActiveRecord::Base
  attr_accessible :car_id, :celular, :cnpj, :contato, :created_at, :email, :nome, :telefone, :updated_at, :parceiro_id,
      :observacao, :pagamentos_attributes

  belongs_to :parceiro
  has_many :cars
  has_many :cegonhas
  has_many :pagamentos
  accepts_nested_attributes_for :cars, :cegonhas, :pagamentos


  validates :nome,
        :presence => { :message => "- O nome da empresa não pode ser deixada em branco!" }

  validates :cnpj,
        :presence => { :message => "- O CNPJ da empresa não pode ser deixada em branco!" },
        :format => { :with => /^[0-9]{2}.[0-9]{3}.[0-9]{3}\/[0-9]{4}-[0-9]{2}$/, :message => "Verificar se o CPF possui apenas 14 números" }


  before_save :transforma_nome_em_minuscula, :transforma_email_em_minuscula

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

  def active_cars
    self.cars.reject {|c| c.ativo == VEHICLE_STATUS.index('DELIVERED')}
  end



end
