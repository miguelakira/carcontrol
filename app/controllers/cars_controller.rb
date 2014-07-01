class CarsController < ApplicationController
  # GET /cars
  # GET /cars.json
  before_filter :authenticate_user!

  def index
    # para o sidebar
    @car = Car.find(params[:car_id]) if params[:car_id]
    @cars = Car.order(:data_compra).where("ativo != #{VEHICLE_STATUS.index 'DELIVERED'}")
    @cars.empty? ? @mensagem = "Nenhum Cliente Cadastrado" : @mensagem = "Clientes Ativos"

    @column_class = @car ? 'large-10 columns' : 'large12'

    respond_to do |format|
      format.html
      format.json { render json: @cars }
    end
  end

  def inativos
    # para o sidebar
    @car = Car.find(params[:car_id]) if params[:car_id]
    @column_class = @car ? 'large-10 columns' : 'large12'
    
    @cars = Car.order(:data_compra).where("ativo = #{VEHICLE_STATUS.index 'DELIVERED'}")
    @cars.empty? ? @mensagem = "Nenhum Cliente Finalizado" : @mensagem = "Clientes Finalizados"

    respond_to do |format|
      format.html
      format.json { render json: @cars }
    end
  end

  def show
    @car = Car.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @car }
    end
  end

  def new
    gon.compradores = Comprador.all
    gon.empresas = Empresa.all
    
    @car = Car.new
    @cegonhas = Cegonha.all
    @parceiros = Parceiro.all
    @status_pagamentos = StatusPagamento.all
    
    params[:pessoa_juridica] ? @car.build_empresa : @car.build_comprador

    @car.build_debito
    @car.pagamentos.build
    
    respond_to do |format|
      format.html
      format.json { render json: @car }
    end
  end

  def create
    @car = Car.new(params[:car])
    @status_pagamentos = StatusPagamento.all
    @car.ativo = params[:ativo] unless params[:ativo].nil?

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
        redirect_to edit_car_path(@car, :edit_location => true, :car => @car)  and return if params[:edit_location]
        format.html { redirect_to @car, notice: 'Compra gerada com sucesso' }
        format.json { render json: @car, status: :created, location: @car }
      else
        format.html { render action: "new" }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
      gon.compradores = Comprador.all
      gon.empresas = Empresa.all

      @car = Car.find(params[:id])

      @status_pagamentos = StatusPagamento.all
      @cegonhas = Cegonha.all
      @parceiros = Parceiro.all
  end

  def limited_edit
    @car = Car.find(params[:id])
    @status_pagamentos = StatusPagamento.all

    respond_to do |format|
      if @car.update_attributes(params[:car])
          format.html { redirect_to @car, notice: 'Dados atualizados com sucesso.' }
          format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @car = Car.find(params[:id])
    @car.ativo = params[:ativo] unless params[:ativo].nil?

    # saving car information
    if (params[:save_and_return] || params[:edit_location])
      respond_to do |format|
        if @car.update_attributes(params[:car]) 
          format.html { redirect_to @car, notice: 'Dados atualizados com sucesso.' } if params[:save_and_return]
          format.html { redirect_to :action => :edit, :car => @car, :edit_location => true, notice: 'Dados atualizados com sucesso.' } if params[:edit_location]
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @car.errors, status: :unprocessable_entity }
        end
      end

    # saving location information
    elsif params[:location_saved]
      if !@car.estado_origem.nil?
        @car.cegonha_id = nil
      end
      respond_to do |format|
        if @car.update_attributes(params[:car])
          format.html { redirect_to @car, notice: 'Dados atualizados com sucesso.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @car.errors, status: :unprocessable_entity }
        end
      end
    end
  end

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

    #File.delete(filename)
  end
end
