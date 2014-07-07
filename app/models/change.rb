class Change < ActiveRecord::Base
  attr_accessible :current_cars, :current_location, :tracking_id, :previous_location

  default_scope order('created_at DESC')
  belongs_to :tracking

  def previous_city
    previous_location ? Cidade.find(previous_location).try(:text) : ""
  end

  def current_city
    Cidade.find(current_location).try(:text)
  end

  def previous_state
    previous_location ? Cidade.find(previous_location).try(:estado).sigla : ""
  end

  def current_state
  Cidade.find(current_location).try(:estado).sigla
  end

end
