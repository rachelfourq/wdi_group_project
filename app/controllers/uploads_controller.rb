class UploadsController < ApplicationController
  before_action :current_user

  def index
  end

  def new
  end

  def create
  	uploaded_path = params[:upload][:picture].path
  	cloud_file = Cloudinary::Uploader.upload(uploaded_path)

  	if (File.exists?(uploaded_path))
  		File.delete(uploaded_path)
  	end
    user = User.find_or_create_by(id: @current_user.id)

  	user.cloud_id = cloud_file['public_id']
    user.save

    @url = cloud_file['public_id']

 

  	redirect_to root_url
  end

end
