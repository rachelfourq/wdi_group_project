class UploadsController < ApplicationController
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
  	myUpload = Upload.create({
  		:title => params[:upload][:title], 
  		:cloud_id => cloud_file['public_id']
  		})
  	myUpload.save
  	redirect_to root_url
  end

end
