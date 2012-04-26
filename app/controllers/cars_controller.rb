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
end

def sort_direction  
  %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"  
end  

def sort_column  
  Car.column_names.include?(params[:sort]) ? params[:sort] : "placa"  
end  

def ajusta
  cidades = Cidade.all
  cidades.each do |cidade|
    if cidade.uf == 'AC'
      cidade.uf = 1
      cidade.save
    end
    if cidade.uf == 'AL'
      cidade.uf = 2
      cidade.save
    end
    if cidade.uf == 'AP'
      cidade.uf = 3
      cidade.save
    end
    if cidade.uf == 'AM'
      cidade.uf = 4
      cidade.save
    end
    if cidade.uf == 'BA'
      cidade.uf = 5
      cidade.save
    end
    if cidade.uf == 'CE'
      cidade.uf = 6
      cidade.save
    end
    if cidade.uf == 'DF'
      cidade.uf = 7
      cidade.save
    end
    if cidade.uf == 'ES'
      cidade.uf = 8
      cidade.save
    end
    if cidade.uf == 'GO'
      cidade.uf = 9
      cidade.save
    end
    if cidade.uf == 'MA'
      cidade.uf = 10
      cidade.save
    end
    if cidade.uf == 'MT'
      cidade.uf = 11
      cidade.save
    end
    if cidade.uf == 'MS'
      cidade.uf = 12
      cidade.save
    end
    if cidade.uf == 'MG'
      cidade.uf = 13
      cidade.save
    end
    if cidade.uf == 'PA'
      cidade.uf = 14
      cidade.save
    end
    if cidade.uf == 'PB'
      cidade.uf = 15
      cidade.save
    end
    if cidade.uf == 'PR'
      cidade.uf = 16
      cidade.save
    end
    if cidade.uf == 'PE'
      cidade.uf = 17
      cidade.save
    end
    if cidade.uf == 'PI'
      cidade.uf = 18
      cidade.save
    end
    if cidade.uf == 'RJ'
      cidade.uf = 19
      cidade.save
    end
    if cidade.uf == 'RN'
      cidade.uf = 20
      cidade.save
    end
    if cidade.uf == 'RS'
      cidade.uf = 21
      cidade.save
    end
    if cidade.uf == 'RO'
      cidade.uf = 22
      cidade.save
    end
    if cidade.uf == 'RR'
      cidade.uf = 23
      cidade.save
    end
    if cidade.uf == 'SC'
      cidade.uf = 24
      cidade.save
    end
    if cidade.uf == 'SP'
      cidade.uf = 25
      cidade.save
    end
    if cidade.uf == 'SE'
      cidade.uf = 26
      cidade.save
    end
    if cidade.uf == 'TO'
      cidade.uf = 27
      cidade.save
    end
  end
end