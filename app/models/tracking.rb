class Tracking < ActiveRecord::Base
  attr_accessible :active, :cegonha_id, :destination, :end_date, :origin, :start_date

  belongs_to :cegonha
  has_many :changes
end
