class CoursesController < ApplicationController
	def index
	end

	def new
		@course = Course.new
  	end

  	def create
  		@course = Course.new(params[:course])
	    	if @course.save
		      	flash[:success] = "new course created!" # uses a key called success because there is a class by the same name defined in the Bootstrap CSS (which makes it appear in green)
		      	redirect_to action: "show"
	    	else
	      		render 'new'
	    	end
	end


	 def upload
	    # ref: http://stackoverflow.com/questions/2521053/how-to-read-a-user-uploaded-file-without-saving-it-to-the-database

	    file_data = params[:file] # file received from upload form
	    map_course = Nokogiri::XML(File.read(file_data.path)) # creates Nokogiri document for parsing purposes
	    map_course.remove_namespaces! 


	    @trkpt_elements = map_course.xpath("//trkpt") # uses Xpath to select all the trkpt elements from the document...
	    @trkpt_attribute_values = @trkpt_elements.map do |n| #... and maps each value from those elements
	      n.values
	    end

	    @ele = map_course.xpath("//ele")
		@elevations = @ele.map do |e|
			e.text
		end


		@course = Course.new

		@trkpt_attribute_values.each do |long, lat| # @trkpt_attribute_values is an array of arrays
			@course.trackpoints.build(:longitude => long, :latitude => lat) # here the trackpoints for the new course are created using the values from the @trkpt_attribute_values array
			@course.save
		end
  	end

	def show
		@course = Course.find(params[:id])
		
		@course_polylines =[]
		@course_trackpoints = []

		@course.trackpoints.each do |c| # create an array of hashes to stoe the lat & lon attributes from the trackpoint model
			@course_trackpoints << { :lng => c[:longitude], :lat => c[:latitude]}
		end
				
		@course_polylines << @course_trackpoints # passes the values into the @course_polylines variable
		@course_polylines = @course_polylines.to_json # converts to json for use with the gmaps4rails gem
		
		@markers = [@course_trackpoints[0], @course_trackpoints[-1]] # select the first & last trackpoints for use as markers for the start & finish of the course
		@markers = @markers.to_json

		respond_to do |format|
			format.html
			format.json { render json: @course}
		end

	end
end
