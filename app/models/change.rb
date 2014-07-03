class Change < ActiveRecord::Base
  attr_accessible :current_cars, :current_location, :tracking_id, :previous_location

  default_scope order('created_at DESC')
  belongs_to :tracking
end
