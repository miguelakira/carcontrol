class StatusPagamento < ActiveRecord::Base
  attr_accessible :status
  belongs_to :car
end
