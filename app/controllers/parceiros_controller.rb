class ParceirosController < ApplicationController
    before_filter :authenticate_user!

  def index
	@parceiros = Parceiro.all
    @parceiros.empty? ? @mensagem = "Nenhum Parceiro Cadastrado" : @mensagem = "Parceiros Cadastrados"
  end

  def new
    gon.parceiros = Parceiro.all
    @parceiro = Parceiro.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @parceiro }
    end
  end

  def create
    @parceiro = Parceiro.new(params[:parceiro])

	  respond_to do |format|
  	  if @parceiro.save
  	    format.html { redirect_to @parceiro, notice: 'Parceiro foi criada com sucesso.' }
  	    format.json { render json: @parceiro, status: :created, location: @parceiro }
  	  else
  	    format.html { render action: "new" }
  	    format.json { render json: @parceiro.errors, status: :unprocessable_entity }
  	  end
	  end
  end

  def show
  	@parceiro = Parceiro.find(params[:id])

    unless @parceiro.cars.nil?
      @cars_cpf = @parceiro.cars
      @cars_ativos = @parceiro.cars.reject {|c| c.ativo == 0}
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @parceiro }
    end
  end


  def edit
    gon.parceiros = Parceiro.all
    @parceiro = Parceiro.find(params[:id])
  end

  def update
    @parceiro = Parceiro.find(params[:id])

    respond_to do |format|
      if @parceiro.update_attributes(params[:parceiro])

        if params[:editar_localizacao]
          flash[:notice] = 'Dados atualizados com sucesso!'
          redirect_to :action => :edit, :parceiro => @parceiro, :editar_localizacao => true  and return
        else
          format.html { redirect_to @parceiro, notice: 'Dados do parceiro atualizados com sucesso.' }
          format.json { head :no_content }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @parceiro.errors, status: :unprocessable_entity }
      end
    end
  end
end
