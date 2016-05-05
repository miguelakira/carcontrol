class ApplicationController < ActionController::Base
  protect_from_forgery
  # before_filter :redirect_to_disabled


  private
  # def redirect_to_disabled
  #   redirect_to root_path
  # end

end
