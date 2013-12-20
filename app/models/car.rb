#encoding: UTF-8
class Car < ActiveRecord::Base
  attr_accessible :localizacao, :modelo, :placa, :rota_id, :status_pagamento_id, :ativo, :estado_id, :cidade_id, :data_compra,
        :data_prevista, :cegonha_id, :comprador_attributes, :empresa_attributes, :debito_attributes, :observacao,
        :parceiro_id, :pagamentos_attributes

  belongs_to :status_pagamento
  belongs_to :cegonha
  belongs_to :comprador
  belongs_to :empresa
  belongs_to :parceiro
  has_one :debito
  has_many :historicos
  has_many :pagamentos
  accepts_nested_attributes_for :comprador, :empresa, :debito, :parceiro, :pagamentos

  validates	:placa,
  			:presence => { :message => "- A placa não pode ser deixada em branco!" },
  			:uniqueness => { :message => "- A placa já existe no banco de dados. É necessário que ela seja única" }

  validates :modelo,
  			:presence => { :message => "- O modelo do carro não pode ser deixado em branco!" }

  validates :status_pagamento_id, :car_not_paid => true

  before_save :license_plate_uppercase, :car_model_downcase, :remove_from_carrier_if_delivered, 
    :person_or_company_name

  after_find :titleize_model, :check_payments


  def person_or_company_name
    if self.nome.nil?
      if self.comprador
        self.nome = self.comprador.nome
      elsif self.empresa
        self.nome = self.empresa.nome
      end
    end
  end

  def remove_from_carrier_if_delivered
    if self.is_delivered?
      self.cegonha = nil
    end
  end

  def self.search(search, search_by)
    if search
      if search_by == 'placa'
        search.gsub!(/[^[:alnum:]]/, '')
        search.insert(3, '-')
        where{{placa.like => "%#{search}%"}}
      elsif search_by == 'cliente'
        search = search.split(" ")
        joins(:comprador).where{(comprador.firstname.like_any search) | (comprador.middlename.like_any search) | (comprador.lastname.like_any search)}
      elsif search_by == 'empresa'
        search = search.split(" ")
        search.collect! {|s| s + "%"} # coloca '%' no final pra procurar por nomes incompletos - 'jul' acha 'juliano' e 'julio'
        joins(:empresa).where{(empresa.nome.like_any search)}
      end
    else
      scoped
    end
  end

  def license_plate_uppercase
  	self.placa.upcase!
  end

  def car_model_downcase
  	self.modelo.downcase!
  end

  def titleize_model
  	self.modelo = self.modelo.titleize
  end

  def check_payments
    if self.pagamentos.empty?
      self.pagamentos.new(:valor => 0)
    end
  end

  def is_delivered?
    self.ativo == VEHICLE_STATUS.index('DELIVERED')
  end
end
