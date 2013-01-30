class CompradoresController < ApplicationController
  # GET /compradores
  # GET /compradores.json
  before_filter :authenticate_user!

  def index
    @compradores = Comprador.all
    @empresas = Empresa.all
    @compradores.empty? ? @mensagem_compradores = "Nenhum Cliente Cadastrado" : @mensagem_compradores = "Clientes Cadastrados"
    @empresas.empty? ? @mensagem_empresas = "Nenhuma Empresa Cadastrada" : @mensagem_empresas = "Empresas Cadastradas"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @compradores }
    end
  end

  # GET /compradores/1
  # GET /compradores/1.json
  def show
    @comprador = Comprador.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comprador }
    end
  end

  # GET /compradores/new
  # GET /compradores/new.json
  def new
    @comprador = Comprador.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comprador }
    end
  end

  # GET /compradores/1/edit
  def edit
    @comprador = Comprador.find(params[:id])
  end

  # POST /compradores
  # POST /compradores.json
  def create
    @comprador = Comprador.new(params[:comprador])

    respond_to do |format|
      if @comprador.save
        format.html { redirect_to @comprador, notice: 'Comprador was successfully created.' }
        format.json { render json: @comprador, status: :created, location: @comprador }
      else
        format.html { render action: "new" }
        format.json { render json: @comprador.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /compradores/1
  # PUT /compradores/1.json
  def update
    @comprador = Comprador.find(params[:id])

    # ajusta o valor da string do valor do pagamento pra bigdecimal
    converter_string_to_bigdecimal(@comprador, params[:comprador][:pagamentos_attributes]['0'])

    respond_to do |format|
      if @comprador.update_attributes(params[:comprador])
        format.html { redirect_to @comprador, notice: 'Comprador was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comprador.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compradores/1
  # DELETE /compradores/1.json
  def destroy
    @comprador = Comprador.find(params[:id])
    @comprador.destroy

    respond_to do |format|
      format.html { redirect_to compradores_url }
      format.json { head :no_content }
    end
  end
end
