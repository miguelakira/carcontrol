class CegonhasController < ApplicationController
  # GET /cegonhas
  # GET /cegonhas.json
  before_filter :authenticate_user!

  def index
    @cegonhas = Cegonha.search(params[:search], params[:search_by]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 30, :page => params[:page])
    @cegonhas.empty? ? @mensagem = "Nenhuma Cegonha Cadastrada" : @mensagem = "Cegonhas Cadastradas"
    @cars = Car.all

    @cegonhas.each do |ceg|
      if ceg.nome.nil?
        ceg.nome = ceg.motorista.nome
        ceg.save
      end

    end

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
    @editar_localizacao = params[:editar_localizacao]
    @cegonha.build_motorista



    if params[:cegonha_contratada]
      @cegonha.build_empresa
      @cegonha.build_pagamento
      
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cegonha }
    end
  end

  # GET /cegonhas/1/edit
  def edit
    @editar_localizacao = params[:editar_localizacao]
    @cegonha = Cegonha.find(params[:id])

    # pega um array com todas as cidades dos estados atualmente no banco, pra encher os forms.
    @locais_atual = Cidade.find(:all, :conditions => {:estado_id => @cegonha.estado_id})
    @destinos_atual = Cidade.find(:all, :conditions => {:estado_id => @cegonha.estado_destino})
    @origens_atual = Cidade.find(:all, :conditions => {:estado_id => @cegonha.estado_origem})
    # pega o nome das cidades atualmente no banco (origem, destino e atual)
    unless @cegonha.cidade_id.nil?
      @cidade_atual = Cidade.find(@cegonha.cidade_id).text 
      @cidade_origem = Cidade.find(@cegonha.cidade_origem).text
      @cidade_destino = Cidade.find(@cegonha.cidade_destino).text
    end
  end

  # POST /cegonhas
  # POST /cegonhas.json
  def create
    @cegonha = Cegonha.new(params[:cegonha])
    @cegonha.carros = 0

    if !(params[:cegonha][:pagamento_attributes]).nil?
      
      converter_string_to_bigdecimal(@cegonha, params[:cegonha][:pagamento_attributes])
    end

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
        if params[:editar_localizacao]
          redirect_to edit_cegonha_path(@cegonha, :editar_localizacao => true, :cegonha => @cegonha)   and return
        end
        format.html { redirect_to @cegonha, notice: 'Cegonha foi criada com sucesso.' }
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
    
    if defined?(params[:cegonha][:pagamento_attributes])
      if !(params[:cegonha][:pagamento_attributes]).nil?
        converter_string_to_bigdecimal(@cegonha, params[:cegonha][:pagamento_attributes])
      end
    end
    if params[:salvar_localizacao]
      @cegonha.estado_id = params[:estado_id]
      @cegonha.estado_origem = params[:estado_origem]
      @cegonha.estado_destino = params[:estado_destino]
      
      # atençao! Ele vai pegar a cidade pelo nome, e nao separa por estado - pode ser
      # que se futuramente queira-se comprar a cidade pelo ID, pode dar erro (pegar cidade com mesmo nome mas
      # de estados diferentes )
      cidade_atual = Cidade.find_by_text(params[:cidade_id]).id
      cidade_origem = Cidade.find_by_text(params[:cidade_origem]).id
      cidade_destino = Cidade.find_by_text(params[:cidade_destino]).id
      
      @cegonha.cidade_id = cidade_atual
      @cegonha.cidade_origem = cidade_origem
      @cegonha.cidade_destino = cidade_destino
      
      # altera a localizacao de todos os carros que estao na cegonha
      unless @cegonha.cars.nil?
        @cegonha.cars.each do |car|
          car.estado_id = @cegonha.estado_id
          car.cidade_id = @cegonha.cidade_id
          car.localizacao = "#{params[:cidade_id]}, #{Estado.find(params[:estado_id]).sigla}"  
          car.save
        end
      end
      
      @cegonha.localizacao = "#{params[:cidade_id]}, #{Estado.find(params[:estado_id]).sigla}"  
    end

    respond_to do |format|
      if @cegonha.update_attributes(params[:cegonha])
        # se chegou no destino, todos os carros saem da cegonha e o status deles muda para descarregados.
        chegou_no_destino?(@cegonha)
        contagem_carros_cegonha()
        status_de_carro_na_cegonha(@cegonha) 

        if params[:editar_localizacao]
          flash[:notice] = 'Dados atualizados com sucesso!'
          redirect_to :action => :edit, :cegonha => @cegonha, :editar_localizacao => true  and return
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

  def generate_pdf
    @cegonha = Cegonha.find(params[:id])

    flash[:notice] = "PDF gerado na data #{Time.now.strftime('%d/%m/%Y')}"
    
    filename = "#{Rails.root}/public/Relatorio_#{@cegonha.placa}_#{Time.now.strftime('%d_%m_%Y')}.pdf"
    html = render_to_string(:template => "/cegonhas/show.pdf.erb", :layout => false,:content_type => "text/html", :charset => "utf-8")
    kit = PDFKit.new(html, :disable_javascript => true )
    kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/to_pdf.css"
    pdf = kit.to_pdf
    file = kit.to_file(filename)
    send_file filename, :type => 'application/pdf'
    File.delete(filename)
  end

private 
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"  
  end  

  def sort_column  
    Cegonha.column_names.include?(params[:sort]) ? params[:sort] : "placa"  
  end  

  def for_sectionid
      @subsections = Cidade.find( :all, :conditions => [" estado_id = ?", params[:id]]  ).sort_by{ |k| k['nome'] }    
      respond_to do |format|
        format.json  { render :json => @subsections }      
      end
  end

 # se chegou no destino, tira os carros da cegonha e fecha o historico
 def chegou_no_destino?(cegonha)
    if cegonha.cidade_destino == cegonha.cidade_id && cegonha.estado_destino == cegonha.estado_id
      cegonha.cars.each do |car|
        car.ativo = 2
        car.cegonha = nil
        car.save
      end
    end
  end

end
