class ActivitiesController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy

  require 'nokogiri'

	def show
    john = Nokogiri::XML(File.read("training3.xml"))
    # @test_trackpoint = []
    # @trackpoints = @john.xpath('//xmlns:trkpt')


    # @test_trackpoint.each do |test_trkpt|

     # @lat_test = test_trkpt.xpath('@lat_test').to_s.to_f
     # @lon_test = test_trkpt.xpath('@lon_test').to_s.to_f


    # end
    john.remove_namespaces!
    @yo = john.xpath("//trkpt")
    @yoyo = @yo.map do |n|
      n.values
    end

    @addresses = john.css('trkpt').map do |trkpt|
  trkpt.xpath( './/text()' ).map{ |node| node.text }
end
    @test = john.xpath("//desc")
    @test1 = john.xpath("//name")
    @test2 = john.xpath("//DistanceMeters")
    @trackp = john.xpath("//@lon")
    @lattrackp = john.xpath("//@lat")
    @two_together = @trackp.zip(@lattrackp)  #john.xpath("//[@lon and @lat]")
    # @trackp_lon = john.xpath("//lon")
  end

  def new
  	@activity = Activity.new
  end

  def create
  	@activity = current_user.activities.build(params[:activity])
    if @activity.save
      flash[:success] = "Activity Added!" # uses a key called success because there is a class by the same name defined in the Bootstrap CSS (which makes it appear in green)
      redirect_to user_path(current_user)
    else
      render 'new'
    end
  end

  def destroy
     @activity.destroy
    redirect_to user_path(current_user)
  end

  def upload
    # ref: http://stackoverflow.com/questions/2521053/how-to-read-a-user-uploaded-file-without-saving-it-to-the-database
    file_data = params[:file]
      if file_data.respond_to?(:read)
        xml_contents = file_data.read
      elsif file_data.respond_to?(:path)
        xml_contents = File.read(file_data.path)
      else
        logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
      end

      @joe = file_data
      @jim = file_data.original_filename
      @jean = xml_contents
  end


  private

    def correct_user
      @activity = current_user.activities.find_by_id(params[:id])
      redirect_to root_url if @activity.nil?
    end
end
