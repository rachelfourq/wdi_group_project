class ProfileController < ApplicationController
  def index
  	@upload = Upload.new
    @uploads = Upload.last(10).reverse
  end
end
