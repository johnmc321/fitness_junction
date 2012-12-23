class ActivitiesController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy

  require 'nokogiri'

	def show
    john = Nokogiri::XML(File.read("training2.xml"))

    @test_trackpoint = john.xpath('//xmlns:trkpt')


    @test_trackpoint.each do |test_trkpt|

      @lat_test = test_trkpt.xpath('@lat_test').to_s.to_f
      @lon_test = test_trkpt.xpath('@lon_test').to_s.to_f


    end

    @test = john.xpath("//TotalTimeSeconds")
    @test1 = john.xpath("//Name")
    @test2 = john.xpath("//DistanceMeters")

   
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

  private

    def correct_user
      @activity = current_user.activities.find_by_id(params[:id])
      redirect_to root_url if @activity.nil?
    end
end
