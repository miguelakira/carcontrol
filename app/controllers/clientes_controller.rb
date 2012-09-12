class ClientesController < ApplicationController
  layout "cliente"
  def index
  end

  def show
    @cars = Comprador.find_by_cpf(params[:comprador_cpf]).cars
  end
end
