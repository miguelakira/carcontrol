class UsersController < ApplicationController
  def index
    @admins = User.find(:all, :conditions => {:admin => true})
    @users = User.find(:all, :conditions => {:admin => false})
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
          format.html { redirect_to users_path, notice: 'Dados atualizados com sucesso.' }
          format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end 
  end
end