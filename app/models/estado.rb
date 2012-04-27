class Estado < ActiveRecord::Base
  attr_accessible :nome, :sigla

  has_many :cidades
end
