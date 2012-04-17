class StatusPagamento < ActiveRecord::Base
  attr_accessible :status
  has_many :cars
end
