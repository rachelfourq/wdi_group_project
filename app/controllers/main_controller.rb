class MainController < ApplicationController
  def index
  	response = Unirest.get "https://devru-instructables.p.mashape.com/list?limit=20&offset=0&sort=recent&type=id",
  headers:{
    "X-Mashape-Key" => "qNv5DeZglHmshdK7jNeqX3Y33WKpp1US0vpjsnLNyYfawqaTfR",
    "Accept" => "application/json"
  }
  @results = JSON.parse(response)
  end

end
