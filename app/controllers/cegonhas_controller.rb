class CegonhasController < ApplicationController
  # GET /cegonhas
  # GET /cegonhas.json
  def index
    @cegonhas = Cegonha.search(params[:search], params[:search_by]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 5, :page => params[:page])
    @cars = Car.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cegonhas }
    end
  end

  # GET /cegonhas/1
  # GET /cegonhas/1.json
  def show
    @cegonha = Cegonha.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cegonha }
    end
  end

  # GET /cegonhas/new
  # GET /cegonhas/new.json
  def new
    @cegonha = Cegonha.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cegonha }
    end
  end

  # GET /cegonhas/1/edit
  def edit
    @cegonha = Cegonha.find(params[:id])
  end

  # POST /cegonhas
  # POST /cegonhas.json
  def create
    @cegonha = Cegonha.new(params[:cegonha])
    @cegonha.carros = 0

    respond_to do |format|
      if @cegonha.save
        format.html { redirect_to @cegonha, notice: 'Cegonha was successfully created.' }
        format.json { render json: @cegonha, status: :created, location: @cegonha }
      else
        format.html { render action: "new" }
        format.json { render json: @cegonha.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cegonhas/1
  # PUT /cegonhas/1.json
  def update
    @cegonha = Cegonha.find(params[:id])
    @cegonha.carros = @cegonha.cars.count
    respond_to do |format|
      if @cegonha.update_attributes(params[:cegonha])
        format.html { redirect_to @cegonha, notice: 'Cegonha was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cegonha.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cegonhas/1
  # DELETE /cegonhas/1.json
  def destroy
    @cegonha = Cegonha.find(params[:id])
    @cegonha.destroy

    respond_to do |format|
      format.html { redirect_to cegonhas_url }
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
