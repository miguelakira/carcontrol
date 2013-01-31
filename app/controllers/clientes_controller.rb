#encoding: UTF-8
class ClientesController < ApplicationController
  layout "cliente"
  def index
    if user_signed_in?
      redirect_to :controller => :cars, :action => :index
    end
  end

  def show
    if params[:comprador_cnpj]
      @empresa = Empresa.find_by_cnpj(params[:comprador_cnpj])
      unless @empresa.nil?
        @mensagem = "<p><h1>Dados do cliente #{@empresa.nome}</h1></p>"
        @cars_cnpj = @empresa.cars

        @cars_ativos = @cars_cnpj.reject {|c| c.ativo == 0}
        @cars_inativos = @cars_cnpj.reject {|c| c.ativo != 0}
        @cars_nao_pagos = @cars_cnpj.reject {|c| c.status_pagamento_id == 3 }
        @cars_pagos = @cars_cnpj.reject {|c| c.status_pagamento_id != 3 }
      end
    elsif params[:comprador_cpf]
      @cliente = Comprador.find_by_cpf(params[:comprador_cpf])
      unless @cliente.nil?
        @mensagem = "<p><h1>Dados do cliente #{@cliente.nome}</h1></p>"
        @cars_cpf = @cliente.cars

        @cars_ativos = @cars_cpf.reject {|c| c.ativo == 0}
        @cars_inativos = @cars_cpf.reject {|c| c.ativo != 0}
        @cars_nao_pagos = @cars_cpf.reject {|c| c.status_pagamento_id == 3 }
        @cars_pagos = @cars_cpf.reject {|c| c.status_pagamento_id != 3 }
      end
    end

    unless @cars_ativos.nil?
      @valor_total = 0
      @valor_pago = 0

      unless @cars_ativos.nil?
        @cars_ativos.each do |car|
          @valor_total += car.debito.valor_total unless car.debito.valor_total.nil?
          @valor_pago += car.debito.valor_pago unless car.debito.valor_pago.nil?
        end
      end
    @saldo_devedor = @valor_total - @valor_pago
    end
  end
end
