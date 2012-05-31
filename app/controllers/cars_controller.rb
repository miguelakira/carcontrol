class CarsController < ApplicationController
  # GET /cars
  # GET /cars.json
  before_filter :authenticate_user!

  def index
    
    if params[:sort] == "firstname"
      ativo = true
      @cars = sort_by_comprador(ativo)
    elsif params[:sort] == 'status_pagamento'
      ativo = true
      @cars = sort_by_status_pagamento(ativo)
    else
      
      @cars = Car.search(params[:search], params[:search_by]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 5, :page => params[:page]).where(:ativo => [1,2,3])
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cars }
    end
  end

  def inativos
    if params[:sort] == "firstname"
      ativo = false
      @cars = sort_by_comprador(ativo)
    elsif params[:sort] == 'status_pagamento'
      ativo = false
      @cars = sort_by_status_pagamento(ativo)
    else
      
      @cars = Car.search(params[:search], params[:search_by]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 5, :page => params[:page]).where(:ativo => 0)

    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cars }
    end
  end

  def sort_by_comprador(ativo)
    
    Car.paginate(
      :per_page => 5, 
      :page => params[:page], 
      :joins => :comprador, 
      :order => "firstname #{sort_direction}",
      :conditions => {:ativo => ativo})
  end

  def sort_by_status_pagamento(ativo)
    Car.paginate(
      :per_page => 5, 
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
    @car.build_comprador
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
  end

  # POST /POST
  # cars /cars.json
  def create
    
    @car = Car.new(params[:car])
    @status_pagamentos = StatusPagamento.all
    @car.ativo = params[:ativo] unless params[:ativo].nil?
    #@cidades = Cidade.all
    #@car.estado_id = params[:estado_id]
    #cidade = Cidade.find_by_text(params[:cidade_id]).id unless params[:cidade_id].nil?
    #@car.cidade_id = cidade
    #@car.localizacao = "#{params[:cidade_id]}, #{Estado.find(params[:estado_id]).sigla}"

    respond_to do |format|
      if @car.save
        # faz update da contagem de carros da cegonha
        cegonhas = Cegonha.all
        cegonhas.each do |cegonha|
          cegonha.carros = cegonha.cars.count
          cegonha.save
        end

        

        if params[:editar_localizacao]
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
    if params[:salvar_localizacao]
      @car.estado_id = params[:estado_id]
      @car.estado_origem = params[:estado_origem]
      @car.estado_destino = params[:estado_destino]
      
      # atençao! Ele vai pegar a cidade pelo nome, e nao separa por estado - pode ser
      # que se futuramente queira-se comprar a cidade pelo ID, pode dar erro (pegar cidade com mesmo nome mas
      # de estados diferentes )
      cidade_atual = Cidade.find_by_text(params[:cidade_id]).id
      cidade_origem = Cidade.find_by_text(params[:cidade_origem]).id
      cidade_destino = Cidade.find_by_text(params[:cidade_destino]).id
      
      @car.cidade_id = cidade_atual
      @car.cidade_origem = cidade_origem
      @car.cidade_destino = cidade_destino
      @car.localizacao = "#{params[:cidade_id]}, #{Estado.find(params[:estado_id]).sigla}"  
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

  private 
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"  
  end  

  def sort_column  
    Car.column_names.include?(params[:sort]) ? params[:sort] : "placa"  
  end  

  def for_sectionid
      @subsections = Cidade.find( :all, :conditions => [" estado_id = ?", params[:id]]  ).sort_by{ |k| k['nome'] }    
      respond_to do |format|
        format.json  { render :json => @subsections }      
      end
  end
end