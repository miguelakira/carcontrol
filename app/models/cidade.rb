class Cidade < ActiveRecord::Base
  attr_accessible :capital, :estado_id, :text

  belongs_to :estado
end
