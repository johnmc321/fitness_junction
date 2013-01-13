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

	 def upload
    # ref: http://stackoverflow.com/questions/2521053/how-to-read-a-user-uploaded-file-without-saving-it-to-the-database
    file_data = params[:file]
    map_course = Nokogiri::XML(File.read(file_data.path))
    map_course.remove_namespaces!


    @maybe = map_course.xpath("//trkpt")
    @maybemaybe = @maybe.map do |n|
      n.values
    end

    @course = Course.new


  
		@maybemaybe.each do |long, lat|
			@course.trackpoints.build(:longitude => long, :latitude => lat)
			@course.save
		end
  end

	def show
		@course = Course.find(params[:id])
		#map_course = Nokogiri::XML(File.read("training3.xml"))
		#map_course.remove_namespaces!
		#@longitude_points = []
		#@latitude_points = []
		#@markers =[]
		#@first_array = []
		#@last_array = []
		#@joined_array = []
		#@longitude_points = map_course.xpath("//@lon")
		#@latitude_points = map_course.xpath("//@lat")
		#@longitude_points = @longitude_points
		#@latitude_points = @latitude_points


#@maybe = map_course.xpath("//trkpt")
  #  @maybemaybe = @maybe.map do |n|
    #  n.values
   # end
   			# http://stackoverflow.com/questions/8618058/displaying-a-polygon-with-gmaps4rails?rq=1

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
		@course.trackpoints.each do |c|
			@course_trackpoints << { :lng => c[:longitude], :lat => c[:latitude]}
		end
		#@markers << { :lng => @maybemaybe[0], :lat => @maybemaybe[-1]}
		
		@course_polylines << @course_trackpoints
		@course_polylines = @course_polylines.to_json
		#@first_array = @course_polylines[0]
		#@last_array = @course_polylines[-1]

		#@hash1 = { :lng => @first_array[0], :lat => @first_array[1]}
		#@hash2 = { :lng => @last_array[0], :lat => @last_array[1]}

		#@markers = [{ :title => "start", :lng => @first_array[0], :lat => @first_array[1]},{ :title => "finish", :lng => @last_array[0], :lat => @last_array[1]}]

		#@markers = @markers.to_json

		#@joined_array << @first_array
		#@joined_array << @last_array
		#@joined_array = @joined_array.to_json

		respond_to do |format|
			format.html
			format.json { render json: @course}
		end

	end
end
