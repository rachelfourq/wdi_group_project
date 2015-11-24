class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
    @upload = Upload.new
    @uploads = Upload.last(10).reverse

  end
end
