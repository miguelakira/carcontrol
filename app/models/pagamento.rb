class Pagamento < ActiveRecord::Base
  attr_accessible :car_id, :data_pagamento, :forma_pagamento, :observacao, :valor
  belongs_to :car
  belongs_to :cegonha
  belongs_to :cliente
  belongs_to :empresa



end
