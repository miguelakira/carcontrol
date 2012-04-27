class Cidade < ActiveRecord::Base
  attr_accessible :uf

  belongs_to :estado
end
