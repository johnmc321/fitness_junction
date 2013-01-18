class TrackpointsController < ApplicationController
	def index
  		@trackpoints = Trackpoint.all
	end

	def new
  		@trackpoint = Trackpoint.new
  	end

  	def create
	  	@trackpoint = Trackpoint.new(params[:trackpoint])
	    	if @trackpoint.save
		      	flash[:success] = "new trackpoint!" # uses a key called success because there is a class by the same name defined in the Bootstrap CSS (which makes it appear in green)
		      	redirect_to action: "index"
	    	else
	      		render 'new'
	    	end
	end

	def show
		@trackpoint = Trackpoint.find(params[:id])
	end
end
