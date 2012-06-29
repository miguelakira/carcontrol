class Car < ActiveRecord::Base
  attr_accessible :localizacao, :modelo, :placa, :rota_id, :status_pagamento_id, :ativo, :estado_id, :cidade_id, :data_compra,
        :data_prevista, :cegonha_id, :comprador_attributes, :empresa_attributes, :pagamento_attributes, :observacao
  belongs_to :status_pagamento
  belongs_to :cegonha
  belongs_to :comprador
  belongs_to :empresa
  has_one :pagamento
  accepts_nested_attributes_for :comprador, :empresa, :pagamento
  


  validates	:placa, 
  			:presence => true, 
  			:uniqueness => true
  
  validates :modelo,
  			:presence => true

  
  before_save :transforma_placa_em_maiuscula, :transforma_modelo_em_minuscula, :ver_se_pertence_a_cegonha
  after_find :capitaliza_modelo



  def ver_se_pertence_a_cegonha
    if self.ativo == 0
      self.cegonha = nil
    end
  end

  def self.search(search, search_by)
    if search
      if search_by == 'placa'
        search.gsub!(/[^[:alnum:]]/, '')
        search.insert(3, '-')
        where{{placa.like => "%#{search}%"}}
      elsif search_by == 'comprador'
        search = search.split(" ")
        joins(:comprador).where{(comprador.firstname.like_any search) | (comprador.middlename.like_any search) | (comprador.lastname.like_any search)}
      end
    else
      scoped
    end
  end

  def transforma_placa_em_maiuscula
  	self.placa.upcase!
  end

  def transforma_modelo_em_minuscula
  	self.modelo.downcase!
  end  

  def capitaliza_modelo
  	self.modelo = self.modelo.titleize
  end



=begin
  define_index do 
  	indexes placa
  	indexes modelo, :sortable => true
  	indexes localizacao, :sortable => true

  end
=end
end
