require 'rest-client'

class MainController < ApplicationController

  def index
    @upload = Upload.new
    @uploads = Upload.last(10).reverse

  end
end
