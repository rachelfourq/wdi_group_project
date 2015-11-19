require 'restclient'
class MainController < ApplicationController

  def index
      response = Restclient.get "http://api-explorer.khanacademy.org/group/api/v1",
	  headers:{
	    "Accept" => "application/json"
	  }
	  # puts response.body.to_s

	  render :json => response
  end

end
