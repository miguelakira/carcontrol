#encoding: UTF-8
class Cegonha < ActiveRecord::Base
  attr_accessible :carros, :comentario, :destino, :localizacao, :origem, :placa, :motorista_attributes, :pagamento_attributes,
    :empresa_attributes, :observacao, :empresa_id, :motorista_id, :rotas, :nome_rota
  has_one :pagamento
  has_many :cars
  has_many :historicos
  belongs_to :empresa
  belongs_to :motorista
  accepts_nested_attributes_for :empresa, :motorista, :pagamento

  validates	:placa, 
  			:presence => { :message => "- A placa não pode ser deixada em branco!" },
  			:uniqueness => { :message => "- A placa já existe no banco de dados. É preciso que seja única." }

  before_save :check_rotas

  def check_rotas
    if rotas.nil?
      rotas = 1
    end

  end
  
  def get_nome_rota
    if cidade_origem and estado_origem and estado_destino and cidade_destino
      nome_rota = "#{Cidade.find(cidade_origem).text}, #{Estado.find(estado_origem).sigla} -  #{Cidade.find(cidade_destino).text}, #{Estado.find(estado_destino).sigla}"
      return nome_rota
    end
  end

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