class FinanceirosController < ApplicationController
  def index
  	
  end

  def show
  	if params[:comprador_cnpj]
  		@empresa = Empresa.find_by_cnpj(params[:comprador_cnpj])
  		@cars_cnpj = @empresa.cars
  		
  		@cars_ativos = @cars_cnpj.reject {|c| c.ativo == 0}
  		@cars_inativos = @cars_cnpj.reject {|c| c.ativo != 0}

  	elsif params[:comprador_cpf]
  		@cliente = Comprador.find_by_cpf(params[:comprador_cpf])
  		@cars_cpf = @cliente.cars
  		
  		@cars_ativos = @cars_cpf.reject {|c| c.ativo == 0}
  		@cars_inativos = @cars_cpf.reject {|c| c.ativo != 0}
  	end

  	unless @cars_ativos.nil?
  		@valor_total = 0
      @valor_pago = 0
  		@cars_ativos.each do |car|
  			@valor_total += car.pagamento.valor_total unless car.pagamento.valor_total.nil?
        @valor_pago += car.pagamento.valor_pago unless car.pagamento.valor_pago.nil?
  		end
    end	
  end

end
