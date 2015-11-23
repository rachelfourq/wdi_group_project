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

    qString = ' khan academy'  + params[:query].to_s 
    qString2 = ' coursera ' + params[:query].to_s

    def searchFunction(qString)

      opts = Trollop::options do
        opt :q, 'Search Term', :type => String, :default => qString
        opt :max_results, 'Max results', :type => :int, :default => 6
      end
      client, youtube = get_service

      begin

        search_response = client.execute!(
          :api_method => youtube.search.list,
          :parameters => {
            :part => 'snippet',
            :q => opts[:q],
            :maxResults => opts[:max_results]
          }
        )

        videos = []
        channels = []
        playlists = []
        
        search_response.data.items.each do |search_result|
          case search_result.id.kind
            when 'youtube#video'
              # titles << "#{search_result.snippet.title}"
              # videos << "#{search_result.id.videoId}"
              videoObject = VideoInfo.new("http://www.youtube.com/watch?v=" + "#{search_result.id.videoId}")
              videos << videoObject
          end
        end

        return videos
        
      rescue Google::APIClient::TransmissionError => e
        puts e.result.body
      end
    end

    @response = searchFunction(qString)
    # @anotherResponse = searchFunction(qString2)
  end

  def new
    lesson = Lesson.new
    lesson.video_id = params[:video][:id]
    lesson.user_id = params[:video][:user_id]
    lesson.save
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
end

