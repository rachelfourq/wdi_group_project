class ProfileController < ApplicationController
  before_action :current_user	
  def index	
  	@upload = Upload.new
    @uploads = Upload.last
  
    response = Lesson.all

    @response = []
    response.each do |item|
    	videoObject = VideoInfo.new("http://www.youtube.com/watch?v=" +  item.video_id.to_s)
    	@response << videoObject
    end
  
    end 
  def destroy
  	c = Lesson.find_by video_id: params[:id]
    c.delete
    redirect_to profile_index_path
  end
end
