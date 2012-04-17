class Comprador < ActiveRecord::Base
  attr_accessible :celular, :email, :nome, :rg, :telefone, :firstname, :middlename, :lastname, :car_id
  belongs_to :car
end
