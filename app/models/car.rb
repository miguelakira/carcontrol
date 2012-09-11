#encoding: UTF-8
class Car < ActiveRecord::Base
  attr_accessible :localizacao, :modelo, :placa, :rota_id, :status_pagamento_id, :ativo, :estado_id, :cidade_id, :data_compra,
        :data_prevista, :cegonha_id, :comprador_attributes, :empresa_attributes, :pagamento_attributes, :observacao

        
  belongs_to :status_pagamento
  belongs_to :cegonha
  belongs_to :comprador
  belongs_to :empresa
  belongs_to :parceiro
  has_one :pagamento
  has_one :historico
  accepts_nested_attributes_for :comprador, :empresa, :pagamento, :parceiro

  validates	:placa, 
  			:presence => { :message => "- A placa não pode ser deixada em branco!" },
  			:uniqueness => { :message => "- A placa já existe no banco de dados. É necessário que ela seja única" }
  
  validates :modelo,
  			:presence => { :message => "- O modelo do carro não pode ser deixado em branco!" }

  validates :status_pagamento_id, :car_not_paid => true  
  
  before_save :transforma_placa_em_maiuscula, :transforma_modelo_em_minuscula, :eliminar_da_cegonha_caso_inativo, :ajusta_nome,
      :atualiza_historico
  after_find :capitaliza_modelo

  # se o carro foi pra cegonha, insere no historico
  def atualiza_historico
    # entrou na cegonha (nil -> ceg)
    if Car.find(id).cegonha.nil? and cegonha
      historico = Historico.new(:car_id => id, :cegonha_id => cegonha.id, :data_entrada => Time.now)
      historico.localizacao_entrada = "#{Cidade.find_by_id(cidade_origem).text}, #{Estado.find(estado_origem).sigla}" unless cidade_origem.nil?
      cegonha.historicos << historico
    # de cegonha para cegonha (ceg -> ceg)  
    elsif Car.find(id).cegonha and cegonha
      if !changed.grep('cegonha_id').empty?
        # finaliza o historico antigo e inicia outro na nova cegonha
        historico_update = Car.find(id).cegonha.historicos.find_all_by_car_id(id).last
        historico_update.data_saida = Time.now
        historico_update.localizacao_saida = localizacao
        historico_update.save
        historico = nil
        historico = Historico.new(:car_id => id, :cegonha_id => cegonha.id, :data_entrada => Time.now, :localizacao_entrada => localizacao)
        cegonha.historicos << historico
      end
    # sai da cegonha (ceg -> nil)
    elsif Car.find(id).cegonha and cegonha.nil?
      # esse if é para proteger de carros inseridos no sistema antes do registro dos historicos das cegonhas
      if Car.find(id).cegonha.historicos.find_by_car_id(id).nil?
        
        historico = Historico.new(:car_id => id, :cegonha_id => Car.find(id).cegonha.id, :data_saida => Time.now)
        historico.localizacao_saida = localizacao
        Car.find(id).cegonha.historicos << historico
      else

        historico_update = Car.find(id).cegonha.historicos.find_all_by_car_id(id).last
        historico_update.data_saida = Time.now
        historico_update.localizacao_saida = localizacao
        historico = nil
        historico_update.save
      end
    end
  end

  def verifica_localizacao_historico
    if historico and !cidade_origem.nil?
      historico.localizacao_entrada = "#{Cidade.find_by_id(cidade_origem).text}, #{Estado.find(estado_origem).sigla}"
      historico.save
    end

  end
  
  def ajusta_nome
    if self.nome.nil?
      if self.comprador
        self.nome = self.comprador.nome
      elsif self.empresa
        self.nome = self.empresa.nome
      end
    end
  end

  def eliminar_da_cegonha_caso_inativo
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
