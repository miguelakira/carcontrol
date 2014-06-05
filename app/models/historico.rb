class Historico < ActiveRecord::Base
  attr_accessible :ativo, :data_saida, :data_entrada, :rota, :cegonha_id, :car_id, :localizacao_saida, 
  		:localizacao_entrada, :nome_rota, :rota, :parceiro_id
  belongs_to :cegonha
  belongs_to :car

end
