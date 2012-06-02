class ApplicationController < ActionController::Base
  protect_from_forgery

  def contagem_carros_cegonha
    # faz update da contagem de carros da cegonha
    cegonhas = Cegonha.all
    cegonhas.each do |cegonha|
      cegonha.carros = cegonha.cars.count
      cegonha.save
    end
  end
end
