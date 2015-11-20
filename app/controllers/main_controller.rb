require 'rest-client'

class MainController < ApplicationController
  def index
    @lessons = Lesson.search(params[:search])
    @upload = Upload.new
    @uploads = Upload.last(10).reverse
  end
end
