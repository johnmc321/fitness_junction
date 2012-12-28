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


	def map_course
		map_course = = Nokogiri::XML(File.read("training2.xml"))
		map_course.remove_namespaces!
		@trackp = map_course.xpath("//trkpt")

	end
	def show
		@course = Course.find(params[:id])
		@course_polylines =[]
		@course_trackpoints = []
		@course.trackpoints.each do |t|
			@course_trackpoints << { :lng => t[:longitude], :lat => t[:latitude]}
		end

		@course_polylines << @course_trackpoints
		@course_polylines = @course_polylines.to_json
		respond_to do |format|
			format.html
			format.json { render json: @course}
		end

	end
end
