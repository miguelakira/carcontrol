class EmpresasController < ApplicationController

  before_filter :authenticate_user!



  def show
    @empresa = Empresa.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comprador }
    end
  end

    # GET /compradores/1/edit
  def edit
    @empresa = Empresa.find(params[:id])
  end

  # POST /compradores
  # POST /compradores.json

  # PUT /compradores/1
  # PUT /compradores/1.json
  def update
    @empresa = Empresa.find(params[:id])

    respond_to do |format|
      if @empresa.update_attributes(params[:empresa])
        format.html { redirect_to @empresa, notice: 'empresa was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compradores/1
  # DELETE /compradores/1.json

end
