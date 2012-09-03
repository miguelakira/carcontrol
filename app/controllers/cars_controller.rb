class CarsController < ApplicationController
  # GET /cars
  # GET /cars.json
  before_filter :authenticate_user!

  def index
    
    #if params[:sort] == "nome"
     # ativo = true
     # @cars = sort_by_comprador(ativo)
    if params[:sort] == 'status_pagamento'
      ativo = [1,2,3,4,5]
      @cars = sort_by_status_pagamento(ativo)
    elsif params[:sort] == 'saldo_total'
      ativo = [1,2,3,4,5]
      @cars = sort_by_saldo_total(ativo)
    else
      
      #@cars = Car.search(params[:search], params[:search_by]).order(:data_compra, :created_at).paginate(:per_page => 30, :page => params[:page]).where(:ativo => [1,2,3,4,5])
      if params[:search].nil?
        @cars = Car.search(params[:search], params[:search_by]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 30, :page => params[:page]).where(:ativo => [1,2,3,4,5])    
        @cars.empty? ? @mensagem = "Nenhum Cliente Cadastrado" : @mensagem = "Clientes Ativos"
      else
        
        @cars = Car.search(params[:search], params[:search_by]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 30, :page => params[:page]).where(:ativo => [1,2,3,4,5,0])  
        @cars.empty? ? @mensagem = "Nenhum Resultado Encontrado na Busca" : @mensagem = "Resultado da Busca"
      end 
    
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cars }
    end
  end

  def inativos
    

    if params[:sort] == "saldo_total"
      ativo = false
      @cars = sort_by_saldo_total(ativo)
    elsif params[:sort] == 'status_pagamento'
      ativo = false
      @cars = sort_by_status_pagamento(ativo)
    else
      
    @cars = Car.search(params[:search], params[:search_by]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 30, :page => params[:page]).where(:ativo => 0)
    @cars.empty? ? @mensagem = "Nenhum Cliente Finalizado" : @mensagem = "Clientes Finalizados"
    #@cars = Car.search(params[:search], params[:search_by]).order(:updated_at).paginate(:per_page => 30, :page => params[:page]).where(:ativo => 0)

    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cars }
    end
  end

  def sort_by_saldo_total(ativo)
    
    Car.paginate(
      :per_page => 30, 
      :page => params[:page], 
      :joins => :pagamento,
      :order => "valor_total #{sort_direction}",
      :conditions => {:ativo => ativo})
  end

  def sort_by_status_pagamento(ativo)
    Car.paginate(
      :per_page => 30, 
      :page => params[:page], 
      :joins => :status_pagamento, 
      :order => "value #{sort_direction}",
      :conditions => {:ativo => ativo})
  end

  def update_city_menu
    @estado = Estado.find(params[:search][:estado])
    render :layout => false
  end 

  # GET /cars/1
  # GET /cars/1.json
  def show
    @car = Car.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @car }
    end
  end

  # GET /cars/new
  # GET /cars/new.json
  def new
    @car = Car.new
    if params[:pessoa_juridica]
      @car.build_empresa
    else
      @car.build_comprador
    end
    @car.build_pagamento
    @status_pagamentos = StatusPagamento.all
    @editar_localizacao = params[:editar_localizacao]
    @cegonhas = Cegonha.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @car }
    end
  end

  # GET /cars/1/edit
  def edit
    @editar_localizacao = params[:editar_localizacao]
    @car = Car.find(params[:id])
    @status_pagamentos = StatusPagamento.all
    @cegonhas = Cegonha.all
    # pega um array com todas as cidades dos estados atualmente no banco, pra encher os forms.
    @locais_atual = Cidade.find(:all, :conditions => {:estado_id => @car.estado_id})
    @destinos_atual = Cidade.find(:all, :conditions => {:estado_id => @car.estado_destino})
    @origens_atual = Cidade.find(:all, :conditions => {:estado_id => @car.estado_origem})
    # pega o nome das cidades atualmente no banco (origem, destino e atual)
    
    @cidade_atual = Cidade.find(@car.cidade_id).text unless @car.cidade_id.nil?
    @cidade_origem = Cidade.find(@car.cidade_origem).text unless @car.cidade_origem.nil?
    @cidade_destino = Cidade.find(@car.cidade_destino).text unless @car.cidade_destino.nil?
  end

  def limited_edit
    @car = Car.find(params[:id])
    @status_pagamentos = StatusPagamento.all
    if defined?(params[:car][:pagamento_attributes])
      converter_string_to_bigdecimal(@car, params[:car][:pagamento_attributes])
    end
    respond_to do |format|
      if @car.update_attributes(params[:car])
        # faz update da contagem de carros da cegonha
          format.html { redirect_to @car, notice: 'Dados atualizados com sucesso.' }
          format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /POST
  # cars /cars.json
  def create
    @car = Car.new(params[:car])
    @status_pagamentos = StatusPagamento.all
    @car.ativo = params[:ativo] unless params[:ativo].nil?
    # vai ajustar o formato para converter pra BigDecimal
    converter_string_to_bigdecimal(@car, params[:car][:pagamento_attributes])
    if @car.comprador
      compradores = Comprador.all
      comprador_existente = compradores.collect{|comprador| if comprador.cpf == @car.comprador.cpf; comprador; end}
      comprador_existente.delete(nil)
      
      if !comprador_existente.empty?
        @car.comprador = Comprador.find(comprador_existente[0][:id])
        @car.comprador.update_attributes(params[:car][:comprador_attributes])
      end  

    elsif @car.empresa
      empresas = Empresa.all
      empresa_existente = empresas.collect{|empresa| if empresa.cnpj == @car.empresa.cnpj; empresa; end}
      empresa_existente.delete(nil)
      if !empresa_existente.empty?
        @car.empresa = Empresa.find(empresa_existente[0][:id])
        @car.empresa.update_attributes(params[:car][:empresa_attributes])
      end  
    end
    
    
      respond_to do |format|
      if @car.save
        # faz update da contagem de carros da cegonha
       contagem_carros_cegonha()
       status_de_carro_na_cegonha(@car.cegonha) unless @car.cegonha.nil?
        if params[:editar_localizacao]
          # se ao criar o carro, ele foi inserido na cegonha, pega a localizacao atual dela
          if @car.cegonha
            @car.update_attributes(:localizacao => @car.cegonha.localizacao, :cidade_id => @car.cegonha.cidade_id, :estado_id => @car.cegonha.estado_id)
          end
          redirect_to edit_car_path(@car, :editar_localizacao => true, :car => @car)   and return
        end
        format.html { redirect_to @car, notice: 'Compra gerada com sucesso' }
        format.json { render json: @car, status: :created, location: @car }
      else
        format.html { render action: "new" }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cars/1
  # PUT /cars/1.json
  def update
    @car = Car.find(params[:id])
    @car.ativo = params[:ativo] unless params[:ativo].nil?
    # vai ajustar o formato para converter pra BigDecimal
    
    if defined?(params[:car][:pagamento_attributes])
      converter_string_to_bigdecimal(@car, params[:car][:pagamento_attributes])
    end
    if params[:salvar_localizacao]
      if !@car.estado_origem.nil?
        @car.cegonha_id = nil
      end
      @car.estado_id = params[:estado_id]
      @car.estado_origem = params[:estado_origem]
      @car.estado_destino = params[:estado_destino]
      
      # atençao! Ele vai pegar a cidade pelo nome, e nao separa por estado - pode ser
      # que se futuramente queira-se comprar a cidade pelo ID, pode dar erro (pegar cidade com mesmo nome mas
      # de estados diferentes )
      cidade_atual = Cidade.find_by_text(params[:cidade_id]).id unless !params[:cidade_id].present?
      cidade_origem = Cidade.find_by_text(params[:cidade_origem]).id unless !params[:cidade_origem].present?
      cidade_destino = Cidade.find_by_text(params[:cidade_destino]).id unless !params[:cidade_destino].present?
      
      @car.cidade_id = cidade_atual
      @car.cidade_origem = cidade_origem
      @car.cidade_destino = cidade_destino
      if params[:cidade_id].present? and params[:estado_id].present?
        @car.localizacao = "#{params[:cidade_id]}, #{Estado.find(params[:estado_id]).sigla}" 
      else
        @car.localizacao = nil
      end
      
    end
       
    
    
    # se o carro ja esta na cegonha e a cegonha foi mudada
    if @car.cegonha
      if params[:car]
        if @car.cegonha.id != params[:car][:cegonha_id]
          @car.update_attributes(:localizacao => Cegonha.find(params[:car][:cegonha_id]).localizacao, :cidade_id => Cegonha.find(params[:car][:cegonha_id]).cidade_id, :estado_id => Cegonha.find(params[:car][:cegonha_id]).estado_id) unless params[:car][:cegonha_id].empty?
        end
      end
    end
    #se o carro nao estava na cegonha e foi colocado em uma
    if !@car.cegonha
      if params[:car]
        
        @car.update_attributes(:localizacao => Cegonha.find(params[:car][:cegonha_id]).localizacao, :cidade_id => Cegonha.find(params[:car][:cegonha_id]).cidade_id, :estado_id => Cegonha.find(params[:car][:cegonha_id]).estado_id, :ativo => 1) unless params[:car][:cegonha_id].empty?
      end
    end

    respond_to do |format|
      if @car.update_attributes(params[:car])
        # faz update da contagem de carros da cegonha
        cegonhas = Cegonha.all
        cegonhas.each do |cegonha|
          cegonha.carros = cegonha.cars.count
          cegonha.save
        end
        if params[:editar_localizacao]
          flash[:notice] = 'Dados atualizados com sucesso!'
          redirect_to :action => :edit, :car => @car, :editar_localizacao => true  and return
        else
          format.html { redirect_to @car, notice: 'Dados atualizados com sucesso.' }
          format.json { head :no_content }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car = Car.find(params[:id])
    @car.destroy

    respond_to do |format|
      format.html { redirect_to cars_url }
      format.json { head :no_content }
    end
  end

  def generate_pdf
    @car = Car.find(params[:id])

    flash[:notice] = "PDF gerado na data #{Time.now.strftime('%d/%m/%Y')}"
    
    filename = "#{Rails.root}/public/Relatorio_#{@car.placa}_#{Time.now.strftime('%d_%m_%Y')}.pdf"
    html = render_to_string(:template => "/cars/show.pdf.erb", :layout => false,:content_type => "text/html", :charset => "utf-8")
    kit = PDFKit.new(html, :disable_javascript => true )
    kit.stylesheets << "#{Rails.root}/app/assets/to_pdf.css"
    pdf = kit.to_pdf
    file = kit.to_file(filename)
    send_file filename, :type => 'application/pdf'
    File.delete(filename)
  end

  private 
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"  
  end  

  def sort_column  
    Car.column_names.include?(params[:sort]) ? params[:sort] : "data_compra, id"  
  end  

  def for_sectionid
      @subsections = Cidade.find( :all, :conditions => [" estado_id = ?", params[:id]]  ).sort_by{ |k| k['nome'] }    
      respond_to do |format|
        format.json  { render :json => @subsections }      
      end
  end


 

end