class Historico < ActiveRecord::Base
  attr_accessible :ativo, :data_saida, :data_entrada, :rota, :cegonha_id, :car_id, :localizacao_saida, 
  		:localizacao_entrada, :nome_rota, :rota
  belongs_to :cegonha
  belongs_to :historico
  belongs_to :car

end
