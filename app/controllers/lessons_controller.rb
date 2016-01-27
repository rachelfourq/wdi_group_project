require 'google/api_client'
require 'trollop'

class LessonsController < ApplicationController
  before_action :current_user

  def edit
  	@lesson = Lesson.find params[:id]
  end

  def index
    # for database purposes
    @lesson = Lesson.new

    require 'rubygems'
    gem 'google-api-client', '>0.7'
    require 'google/api_client'
    require 'trollop'

# this gets service for the youtube API to work ?
    def get_service
      client = Google::APIClient.new(
        :key => ENV['YOUTUBE_KEY'],
        :authorization => nil,
        :application_name => $BrushUp,
        :application_version => '1.0.0'
      )
      youtube = client.discovered_api('youtube', 'v3')

      return client, youtube
    end
    
    search_string = params[:query].to_s

    if search_string.downcase == 'math' || 'science' || 'history'
      qString = ' khan academy'  + search_string 
      qString2 = ' coursera ' + search_string

      @response = searchFunction(qString)
      @anotherResponse = searchFunction(qString2)
    elsif search_string.downcase == 'photography' || 'art'
      qstring = 'creativelive ' + search_string
      @response = searchFunction(qString)
    else 
      qstring = 'basics ' + search_string 
      @response = searchFunction(qString)
    end
  end

  def new
    lesson = Lesson.find_or_create_by(video_id: params[:video][:id])
    lesson.video_id = params[:video][:id]
    lesson.user_id = params[:video][:user_id]
    lesson.save
    redirect_to lessons_path
  end

  def show
  	@lesson = Lesson.find params[:id]
  end

  def update
    c = Lesson.find params[:id]
    c.update lesson_params
    redirect_to lessons_path
  end

  def create
    Lesson.create lesson_params
    redirect_to lessons_path
  end

  def destroy
    c = Lesson.find params[:id]
    c.delete
    redirect_to lessons_path
  end

  private

  def lesson_params
    params.require(:lesson).permit(:title, :description)
  end

  def searchFunction(qString)
    client, youtube = get_service

    begin
      search_response = client.execute!(
        :api_method => youtube.search.list,
        :parameters => {
          :part => 'snippet',
          :q => qString,
          :maxResults => 6
        }
      )

      videos = []
      channels = []
      playlists = []
      
      search_response.data.items.each do |search_result|
        case search_result.id.kind
          when 'youtube#video'
            videoObject = VideoInfo.new("http://www.youtube.com/watch?v=" + "#{search_result.id.videoId}")
            videos << videoObject
        end
      end

      return videos
      
    rescue Google::APIClient::TransmissionError => e
    end
  end
end

