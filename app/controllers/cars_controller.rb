class CarsController < ApplicationController
  # GET /cars
  # GET /cars.json
  before_filter :authenticate_user!

  def index
    if params[:sort] == "firstname"
      @cars = sort_by_comprador
    elsif params[:sort] == 'status_pagamento'
      @cars = sort_by_status_pagamento
    else
      
      @cars = Car.search(params[:search], params[:search_by]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 5, :page => params[:page])
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cars }
    end
  end

  def sort_by_comprador
    Car.paginate(
      :per_page => 5, 
      :page => params[:page], 
      :joins => :comprador, 
      :order => "firstname #{sort_direction}")
  end

  def sort_by_status_pagamento
    Car.paginate(
      :per_page => 5, 
      :page => params[:page], 
      :joins => :status_pagamento, 
      :order => "value #{sort_direction}")
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
    @cidades = Cidade.all
    @status_pagamentos = StatusPagamento.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @car }
    end
  end

  # GET /cars/1/edit
  def edit
    @car = Car.find(params[:id])
    @status_pagamentos = StatusPagamento.all


  end

  # POST /cars
  # POST /cars.json
  def create
    
    @car = Car.new(params[:car])
    @status_pagamentos = StatusPagamento.all
    @cidades = Cidade.all
    raise @cidades.inspect
    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
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

    respond_to do |format|
      if @car.update_attributes(params[:car])
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { head :no_content }
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

  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"  
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