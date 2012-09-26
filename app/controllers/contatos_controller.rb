class ContatosController < ApplicationController
  # GET /contatos
  # GET /contatos.json


  # GET /contatos/1
  # GET /contatos/1.json

  # GET /contatos/new
  # GET /contatos/new.json
  def new
    @contato = Contato.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contato }
    end
  end

  # GET /contatos/1/edit
  def edit
    @contato = Contato.find(params[:id])
  end

  # POST /contatos
  # POST /contatos.json
  def create
    @contato = Contato.new(params[:contato])

    respond_to do |format|
      if @contato.save
        format.html { redirect_to @contato, notice: 'Contato was successfully created.' }
        format.json { render json: @contato, status: :created, location: @contato }
      else
        format.html { render action: "new" }
        format.json { render json: @contato.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contatos/1
  # PUT /contatos/1.json
  def update
    @contato = Contato.find(params[:id])

    respond_to do |format|
      if @contato.update_attributes(params[:contato])
        format.html { redirect_to @contato, notice: 'Contato was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contato.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contatos/1
  # DELETE /contatos/1.json
  def destroy
    @contato = Contato.find(params[:id])
    @contato.destroy

    respond_to do |format|
      format.html { redirect_to contatos_url }
      format.json { head :no_content }
    end
  end
end
