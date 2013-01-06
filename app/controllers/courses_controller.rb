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


	#def map_course
	#	map_course = Nokogiri::XML(File.read("training2.xml"))
	#	map_course.remove_namespaces!
	#	@longitude_points = map_course.xpath("//@lon")
	#	@latitude_points = map_course.xpath("//@lat")

	#end
	def show
		@course = Course.find(params[:id])
		map_course = Nokogiri::XML(File.read("training2.xml"))
		map_course.remove_namespaces!
		#@longitude_points = []
		#@latitude_points = []
		@longitude_points = map_course.xpath("//@lon")
		@latitude_points = map_course.xpath("//@lat")
		@longitude_points = @longitude_points
		@latitude_points = @latitude_points


@maybe = map_course.xpath("//trkpt")
    @maybemaybe = @maybe.map do |n|
      n.values
    end


		#@course.trackpoints.create(:longitude => @longitude_points, :latitude => @latitude_points)
		@course_polylines =[]
		@course_trackpoints = []

		#@longitude_points.each do |t|
		#	@course_trackpoints << { :lng => t.value } # ?? need to pass each pair of long & lat together separated by a comma??
		#end

# @course.trackpoints.each do |t|
		#	@course_trackpoints << { :lng => t[:longitude], :lat => t[:latitude]}
		
		#@latitude_points.each do |u|
		#	@course_trackpoints << { :lat => u.value}
		#end
		@maybemaybe.each do |long, lat|
			@course_trackpoints << { :lng => long, :lat => lat}
		end
		#@course_trackpoints << { :lng => @longitude_points[0].value, :lat => @latitude_points[0].value}
		@course_polylines << @course_trackpoints
		@course_polylines = @course_polylines.to_json
		respond_to do |format|
			format.html
			format.json { render json: @course}
		end

	end
end
