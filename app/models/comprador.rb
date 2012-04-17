class Comprador < ActiveRecord::Base
  attr_accessible :celular, :email, :rg, :telefone, :firstname, :middlename, :lastname, :car_id
  belongs_to :car

  validates :firstname,
  			:presence => true

  validates :lastname,
  			:presence => true

  validates :rg,
  			:presence => true
end
