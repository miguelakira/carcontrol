class FinanceirosController < ApplicationController
  before_filter :authenticate_user!

  def index

  end

  def show

   	if params[:comprador_cnpj]
  		@empresa = Empresa.find_by_cnpj(params[:comprador_cnpj])
  		unless @empresa.nil?
        @cars_cnpj = @empresa.cars

    		@cars_ativos = @cars_cnpj.reject {|c| c.ativo == 0}
    		@cars_inativos = @cars_cnpj.reject {|c| c.ativo != 0}
        @cars_nao_pagos = @cars_cnpj.reject {|c| c.status_pagamento_id == 3 }
        @cars_pagos = @cars_cnpj.reject {|c| c.status_pagamento_id != 3 }
      end
  	elsif params[:comprador_cpf]
  		@cliente = Comprador.find_by_cpf(params[:comprador_cpf])
  		unless @cliente.nil?
        @cars_cpf = @cliente.cars

    		@cars_ativos = @cars_cpf.reject {|c| c.ativo == 0}
    		@cars_inativos = @cars_cpf.reject {|c| c.ativo != 0}
        @cars_nao_pagos = @cars_cpf.reject {|c| c.status_pagamento_id == 3 }
        @cars_pagos = @cars_cpf.reject {|c| c.status_pagamento_id != 3 }
      end
  	else
      if params[:parceiro_cpf]
        @parceiro = Parceiro.find_by_cpf(params[:parceiro_cpf])
      elsif params[:parceiro_cnpj]
        @parceiro = Parceiro.find_by_cnpj(params[:parceiro_cnpj])
      end
      unless @parceiro.nil?
        @cars_parceiro = @parceiro.cars

        @cars_ativos = @cars_parceiro.reject {|c| c.ativo == 0}
        @cars_inativos = @cars_parceiro.reject {|c| c.ativo != 0}
        @cars_nao_pagos = @cars_parceiro.reject {|c| c.status_pagamento_id == 3 }
        @cars_pagos = @cars_parceiro.reject {|c| c.status_pagamento_id != 3 }
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

  def generate_pdf
    if params[:comprador_cnpj]
      @empresa = Empresa.find(params[:comprador_cnpj])
      @cars_cnpj = @empresa.cars

      @cars_ativos = @cars_cnpj.reject {|c| c.ativo == 0}
      @cars_inativos = @cars_cnpj.reject {|c| c.ativo != 0}
      @cars_nao_pagos = @cars_cnpj.reject {|c| c.status_pagamento_id == 3 }
      @cars_pagos = @cars_cnpj.reject {|c| c.status_pagamento_id != 3 }
      cnpj = @empresa.cnpj

    elsif params[:comprador_cpf]
      @cliente = Comprador.find(params[:comprador_cpf])
      @cars_cpf = @cliente.cars

      @cars_ativos = @cars_cpf.reject {|c| c.ativo == 0}
      @cars_inativos = @cars_cpf.reject {|c| c.ativo != 0}
      @cars_nao_pagos = @cars_cpf.reject {|c| c.status_pagamento_id == 3 }
      @cars_pagos = @cars_cpf.reject {|c| c.status_pagamento_id != 3 }
      cpf = @cliente.cpf
    end

    unless @cars_ativos.nil?
      @valor_total = 0
      @valor_pago = 0

      @cars_ativos.each do |car|
        @valor_total += car.debito.valor_total unless car.debito.valor_total.nil?
        @valor_pago += car.debito.valor_pago unless car.debito.valor_pago.nil?
      end
      @saldo_devedor = @valor_total - @valor_pago
    end
    flash[:notice] = "PDF gerado na data #{Time.now.strftime('%d/%m/%Y')}"

    if @cliente
      filename = "#{Rails.root}/public/Relatorio_#{@cliente.firstname.gsub(/[^\w\s]/, '')}_#{Time.now.strftime('%d_%m_%Y')}.pdf"
    elsif @empresa
      filename = "#{Rails.root}/public/Relatorio_#{@empresa.nome.gsub(/[^\w\s]/, '')}_#{Time.now.strftime('%d_%m_%Y')}.pdf"
    end
    if @cliente
      html = render_to_string(:template => "/financeiros/show_cliente.pdf.erb", :layout => false,:content_type => "text/html", :charset => "utf-8")
    elsif @empresa
      html = render_to_string(:template => "/financeiros/show_empresa.pdf.erb", :layout => false,:content_type => "text/html", :charset => "utf-8")
    end
    kit = PDFKit.new(html, :disable_javascript => true )
    kit.stylesheets << "#{Rails.root}/app/assets/to_pdf.css"
    pdf = kit.to_pdf
    file = kit.to_file(filename)
    send_file filename, :type => 'application/pdf'
    File.delete(filename)


  end

end
