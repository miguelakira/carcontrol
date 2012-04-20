class StatusPagamento < ActiveRecord::Base
  attr_accessible :status, :value
  has_many :cars
end
