class ParceirosController < ApplicationController
  def index
	@parceiros = Parceiro.all
    @parceiros.empty? ? @mensagem = "Nenhum Parceiro Cadastrado" : @mensagem = "Parceiros Cadastrados"
  end

   def new
    @parceiro = Parceiro.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @parceiro }
    end
  end

   def create
    @parceiro = Parceiro.new(params[:parceiro])
    @parceiro.carros = 0

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

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cegonha }
    end
  end
end
