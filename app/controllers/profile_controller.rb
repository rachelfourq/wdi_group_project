class ProfileController < ApplicationController
  before_action :current_user	
  def index	
  	@upload = Upload.new
    @uploads = Upload.last(10).reverse
  end
end
