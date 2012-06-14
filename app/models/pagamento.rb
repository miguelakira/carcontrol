class Pagamento < ActiveRecord::Base
  attr_accessible :car_id, :data_pagamento, :forma_pagamento, :parcelas, :valor_entrada, :valor_pago, :valor_total
  belongs_to :car

  

  
end
