require 'google/api_client'
require 'trollop'

class LessonsController < ApplicationController


  def edit
  	@lesson = Lesson.find params[:id]
  end

  def index
  end

  def new
  	# response = RestClient.get 'http://www.khanacademy.org/api/v1/topic/' + params[:query] + '/videos'
   #  @results = JSON.parse(response)

   #!/usr/bin/ruby

  require 'rubygems'
  gem 'google-api-client', '>0.7'
  require 'google/api_client'
  require 'trollop'

  
# Set DEVELOPER_KEY to the API key value from the APIs & auth > Credentials
# tab of
# Google Developers Console <https://console.developers.google.com/>
# Please ensure that you have enabled the YouTube Data API for your project.
  
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


  opts = Trollop::options do
    opt :q, 'Search Term', :type => String, :default => qString
    opt :max_results, 'Max results', :type => :int, :default => 6
  end

  client, youtube = get_service

    begin
      # Call the search.list method to retrieve results matching the specified
      # query term.
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
      # titles = []

      # Add each result to the appropriate list, and then display the lists of
      # matching videos, channels, and playlists.
      search_response.data.items.each do |search_result|
        case search_result.id.kind
          when 'youtube#video'
            # titles << "#{search_result.snippet.title}"
            # videos << "#{search_result.id.videoId}"
            videoObject = VideoInfo.new("http://www.youtube.com/watch?v=" + "#{search_result.id.videoId}")
            videos << videoObject
        end
      end

    
      @response = videos
      
   
      # puts "Channels:\n", channels, "\n"
      # puts "Playlists:\n", playlists, "\n"
    rescue Google::APIClient::TransmissionError => e
      puts e.result.body
    end


  # render json: response
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

