class FinanceirosController < ApplicationController
  def index
  	
  end

  def show
  	if params[:comprador_cnpj]
  		@empresa = Empresa.find_by_cnpj(params[:comprador_cnpj])
  		@cars_cnpj = @empresa.cars
  		
  		@cars_ativos = @cars_cnpj.reject {|c| c.ativo == 0}
  		@cars_inativos = @cars_cnpj.reject {|c| c.ativo != 0}
      @cars_nao_pagos = @cars_cnpj.reject {|c| c.status_pagamento_id == 3 }

  	elsif params[:comprador_cpf]
  		@cliente = Comprador.find_by_cpf(params[:comprador_cpf])
  		@cars_cpf = @cliente.cars
  		
  		@cars_ativos = @cars_cpf.reject {|c| c.ativo == 0}
  		@cars_inativos = @cars_cpf.reject {|c| c.ativo != 0}
      @cars_nao_pagos = @cars_cpf.reject {|c| c.status_pagamento_id == 3 }
  	end

  	unless @cars_ativos.nil?
  		@valor_total = 0
      @valor_pago = 0

  		@cars_ativos.each do |car|
  			@valor_total += car.pagamento.valor_total unless car.pagamento.valor_total.nil?
        @valor_pago += car.pagamento.valor_pago unless car.pagamento.valor_pago.nil?
  		end
      @saldo_devedor = @valor_total - @valor_pago
    end

    WickedPdf.new.pdf_from_string(
    render_to_string(:pdf => "#{Rails.root}/public/invoice",:template => 'financeiros/show_pdf.erb'))
   	
  end

def generate_pdf
  html = render_to_string(
        :template => "/financeiros/show.html.erb", 
        :layout => false, 
        :content_type => "text/html", 
        :charset => "utf-8")

  kit = PDFKit.new(html, :disable_javascript => true )
  file = kit.to_file("#{Rails.root}/public/relatorio_financeiro_#{Time.now.strftime('%d_%m_%Y')}.pdf")
  
end

end
