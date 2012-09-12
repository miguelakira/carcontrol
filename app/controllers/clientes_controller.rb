#encoding: UTF-8
class ClientesController < ApplicationController
  layout "cliente"
  def index
  end

  def show
    cliente = Comprador.find_by_cpf(params[:comprador_cpf])
    if cliente.nil?
        @mensagem = "<p><h1>CPF não encontrado.</h1></p> <p><b>Por favor verifique se todos os dados estão corretos ou entre em contato com a Transroyal.</b></p>"
    else        
        @cars = cliente.cars
        @mensagem = "<p><h1>Bem-vindo, #{cliente.nome}.</h1></p>"
    end
  end
end
