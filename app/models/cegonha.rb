class Cegonha < ActiveRecord::Base
  attr_accessible :carros, :comentario, :destino, :localizacao, :origem, :placa, :motorista_attributes, :pagamento_attributes,
    :empresa_attributes, :observacao, :empresa_id
  has_one :motorista
  has_one :pagamento
  has_many :cars
  belongs_to :empresa
  accepts_nested_attributes_for :empresa, :motorista, :pagamento

  validates	:placa, 
  			:presence => true, 
  			:uniqueness => true


  def self.search(search, search_by)
    if search
      if search_by == 'placa'
        where{{placa.like => "%#{search}%"}}
      elsif search_by == 'motorista'
        search = search.split(" ")
        joins(:motorista).where{(motorista.firstname.like_any search) | (motorista.middlename.like_any search) | (motorista.lastname.like_any search)}
      end
    else
      scoped
    end
  end
end
