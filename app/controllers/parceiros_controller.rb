class ParceirosController < ApplicationController
    before_filter :authenticate_user!

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

    unless @parceiro.cars.nil?
      @cars_cpf = @parceiro.cars
      @cars_ativos = @parceiro.cars.reject {|c| c.ativo == 0}
    end

    unless @cars_ativos.nil?
      @valor_total = 0
      @valor_pago = 0
      unless @cars_ativos.nil?
        @cars_ativos.each do |car|
          @valor_total += car.pagamento.valor_total unless car.pagamento.valor_total.nil?
          @valor_pago += car.pagamento.valor_pago unless car.pagamento.valor_pago.nil?
        end
      end
    @saldo_devedor = @valor_total - @valor_pago
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @parceiro }
    end
  end
  

  def edit
    @parceiro = Parceiro.find(params[:id])
    
  end

  def update
    @parceiro = Parceiro.find(params[:id])
    @parceiro.carros = @parceiro.cars.count
    
    respond_to do |format|
      if @parceiro.update_attributes(params[:parceiro])
        # se chegou no destino, todos os carros saem da parceiro e o status deles muda para descarregados.
        contagem_carros(Parceiro.all)
        ativar_status_de_carro_com_terceiros(@parceiro.id, @parceiro.class.to_s) 

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
