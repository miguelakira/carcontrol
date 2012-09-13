#encoding: UTF-8
class ClientesController < ApplicationController
  layout "cliente"
  def index
    if user_signed_in? 
      redirect_to :controller => :cars, :action => :index
    end
  end

  def show
    @cliente = Comprador.find_by_cpf(params[:comprador_cpf])

    if @cliente.nil?
        @mensagem = "<p><h1>CPF não encontrado.</h1></p> <p><b>Por favor verifique se todos os dados estão corretos ou entre em contato com a Transroyal.</b></p>"
    else        
      @cars = @cliente.cars
      @mensagem = "<p><h1>Bem-vindo, #{@cliente.nome}.</h1></p>"

      @cars_ativos = @cars.reject {|c| c.ativo == 0}
      @cars_inativos = @cars.reject {|c| c.ativo != 0}
      @cars_nao_pagos = @cars.reject {|c| c.status_pagamento_id == 3 }
      @cars_pagos = @cars.reject {|c| c.status_pagamento_id != 3 }

      unless @cars_ativos.nil?
        @valor_total = 0
        @valor_pago = 0

        unless @cars.nil?
          @cars.each do |car|
            @valor_total += car.pagamento.valor_total unless car.pagamento.valor_total.nil?
            @valor_pago += car.pagamento.valor_pago unless car.pagamento.valor_pago.nil?
          end
        end
      @saldo_devedor = @valor_total - @valor_pago
      end
    end
  end
end