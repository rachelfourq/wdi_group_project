require 'rest-client'

class MainController < ApplicationController

  def index
response = RestClient.get 'http://www.khanacademy.org/api/v1/topic/math'
    results = response.body.to_json
    # render :json => response
    @results = JSON.parse(response)["children"]
    # [children][0]
    
  end

end
