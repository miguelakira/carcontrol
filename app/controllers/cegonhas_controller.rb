class CegonhasController < ApplicationController
  before_filter :authenticate_user!

  def index
    @cegonhas = Cegonha.all
    @cegonhas.empty? ? @mensagem = "Nenhuma Cegonha Cadastrada" : @mensagem = "Cegonhas Cadastradas"
    @cars = Car.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cegonhas }
    end
  end

  def show
    @cegonha = Cegonha.find(params[:id])
    @versions = PaperTrail::Version.order('created_at DESC')
    @grid = set_grid(@cegonha)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cegonha }
    end
  end

  def new
    gon.motoristas = Motorista.all
    gon.empresas = Empresa.all
    
    @cegonha = Cegonha.new
    @grid = set_grid(@cegonha)

    @cegonha.build_motorista

    if params[:hired_freighterq]
      @cegonha.build_empresa
      @cegonha.build_debito
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cegonha }
    end
  end
  
  def edit
    gon.motoristas = Motorista.all
    gon.empresas = Empresa.all

    @editar_localizacao = params[:edit_location]
    @cegonha = Cegonha.find(params[:id])
    
    @grid = set_grid(@cegonha)
  end

  def create
    @cegonha = Cegonha.new(params[:cegonha])
    @cegonha.carros = 0

    if @cegonha.motorista
      motoristas = Motorista.all
      motorista_existente = motoristas.collect{|motorista| if motorista.cpf == @cegonha.motorista.cpf; motorista; end}
      motorista_existente.delete(nil)
      if !motorista_existente.empty?
        @cegonha.motorista = Motorista.find(motorista_existente[0][:id])
        @cegonha.motorista.update_attributes(params[:cegonha][:motorista_attributes])
      end
    end
    
    if @cegonha.empresa
      empresas = Empresa.all
      empresa_existente = empresas.collect{|empresa| if empresa.cnpj == @cegonha.empresa.cnpj; empresa; end}
      empresa_existente.delete(nil)
      if !empresa_existente.empty?
        @cegonha.empresa = Empresa.find(empresa_existente[0][:id])
        @cegonha.empresa.update_attributes(params[:cegonha][:empresa_attributes])
      end
    end

    respond_to do |format|
      if @cegonha.save
        if params[:edit_location]
          redirect_to edit_cegonha_path(@cegonha, :edit_location => true, :cegonha => @cegonha) and return
        end
        format.html { redirect_to @cegonha, notice: 'Cegonha foi criada com sucesso.' }
        format.json { render json: @cegonha, status: :created, location: @cegonha }
      else
        format.html { render action: "new" }
        format.json { render json: @cegonha.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @cegonha = Cegonha.find(params[:id])
    @cegonha.carros = @cegonha.cars.count

    respond_to do |format|
      if @cegonha.update_attributes(params[:cegonha])
        if params[:saved_location]
          if checar_logistica_carros(@cegonha.id)
            redirect_to logistica_cegonha_path(@cegonha) and return
          else
            format.html { redirect_to @cegonha, notice: 'Dados da cegonha atualizados com sucesso.' }
          end
        elsif params[:edit_location]
          flash[:notice] = 'Dados atualizados com sucesso!'
          redirect_to :action => :edit, :cegonha => @cegonha, :edit_location => true  and return
        else
          format.html { redirect_to @cegonha, notice: 'Dados da cegonha atualizados com sucesso.' }
          format.json { head :no_content }
        end
      else
          format.html { render action: "edit" }
          format.json { render json: @cegonha.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cegonha = Cegonha.find(params[:id])
    @cegonha.destroy

    respond_to do |format|
      format.html { redirect_to cegonhas_url }
      format.json { head :no_content }
    end
  end

  def generate_pdf
    @cegonha = Cegonha.find(params[:id])

    flash[:notice] = "PDF gerado na data #{Time.now.strftime('%d/%m/%Y')}"

    filename = "#{Rails.root}/public/Relatorio_#{@cegonha.placa}_#{Time.now.strftime('%d_%m_%Y')}.pdf"
    html = render_to_string(:template => "/cegonhas/show.pdf.erb", :layout => false,:content_type => "text/html", :charset => "utf-8")
    kit = PDFKit.new(html, :disable_javascript => true )
    kit.stylesheets << "#{Rails.root}/app/assets/to_pdf.css"
    pdf = kit.to_pdf
    file = kit.to_file(filename)
    send_file filename, :type => 'application/pdf'
  end

  # quando o destino do carro == atualizacao atual da cegonha
  # vai perguntar qual carro vai ficar em logistica e qual carro vai aguardar retirada
  # todos os carros com destino == atualizacao da cegonha vao sair da cegonha.
  def logistica
    @cegonha = Cegonha.find(params[:id])
    @cars = @cegonha.cars.select {|car| car.cidade_destino == @cegonha.cidade_id and car.estado_destino == @cegonha.estado_id }

    #unless @cars.nil?
    #  @cars.each do |car|
    #    car.historicos.last.update_attributes(:data_saida => Time.now, :localizacao_saida => car.cegonha.localizacao)
    #    car.ativo = 2
    #    car.cegonha = nil
    #    car.save
    #  end
    #end
  end

  def logistica_save
    @cegonha = Cegonha.find(params[:id])
    cars_logistica = Car.find_all_by_id(params[:finalizados])
    all_cars = Car.find_all_by_id(params[:cars])
    all_cars -= cars_logistica

    unless cars_logistica.empty?
      cars_logistica.each do |car|
        car.historicos.last.update_attributes(:data_saida => Time.now, :localizacao_saida => car.cegonha.localizacao)
        car.ativo = 6
        car.cegonha = nil
        car.save
      end
    end

    unless all_cars.empty?
      all_cars.each do |car|
        car.historicos.last.update_attributes(:data_saida => Time.now, :localizacao_saida => car.cegonha.localizacao)
        car.ativo = 2
        car.cegonha = nil
        car.save
      end
    end
    redirect_to @cegonha
  end

 # checa a logistica dos carros
 # se destino do carro == localizacao atual da cegonha, perguntar se ele chegou ao destino
 # ou se vai embarcar em outra cegonha
  def checar_logistica_carros(cegonha_id)
    cegonha = Cegonha.find(cegonha_id)
    cars = cegonha.cars.select {|car| car.cidade_destino == cegonha.cidade_id and car.estado_destino == cegonha.estado_id }
    if cars.empty? or cars.nil?
      return false
    else
      return true
    end
  end

  def set_grid(cegonha)
    cegonha.empresa ? 'large-4 columns' : 'large-6 columns'
  end
end
