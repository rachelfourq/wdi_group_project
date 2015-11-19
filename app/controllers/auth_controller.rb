class AuthController < ApplicationController
  def callback
    provider_user = request.env['omniauth.auth']
    # render json: provider_user
    user = User.find_or_create_by(provider_id: provider_user['uid'], provider: params[:provider]) do |u|
      #define what you want to find by in the parens
      u.provider_hash = provider_user['credentials']['token']
      u.name = provider_user['info']['name']
      u.email = provider_user['info']['email']
    end

    session[:user_id] = user.id
    redirect_to root_path
  end

  def failure
    
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
end
