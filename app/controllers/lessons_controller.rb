class LessonsController < ApplicationController
  def edit
  	@lesson = Lesson.find params[:id]
  end

  def index
  	    q = 'language'
response = RestClient.get 'http://www.khanacademy.org/api/v1/topic/' + q + '/videos'
    @results = response.body.to_json
    # render :json => response
    @results = JSON.parse(response)
  end

  def new
  	@lesson = Lessons.new

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

