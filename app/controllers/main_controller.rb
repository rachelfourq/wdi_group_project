require 'rest-client'

class MainController < ApplicationController
  before_action :current_user

  def index
    q = 'language'
response = RestClient.get 'http://www.khanacademy.org/api/v1/topic/' + q + '/videos'
    @results = response.body.to_json
    # render :json => response
    @results = JSON.parse(response)
    # [children][0]

  end

end
