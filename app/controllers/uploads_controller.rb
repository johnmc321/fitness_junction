class UploadsController < ApplicationController
  def new
  	@upload = Upload.new
  end

  def index
  	@uploads = Upload.all
  end

  def show
  	@upload = Upload.find(params[:id])
  end


  def create
  	@upload = Upload.new(params[:upload])
    if @upload.save
      flash[:success] = "Uploaded!" # uses a key called success because there is a class by the same name defined in the Bootstrap CSS (which makes it appear in green)
      redirect_to @upload
    else
      render 'new'
    end
  end
end
