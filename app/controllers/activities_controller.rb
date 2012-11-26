class ActivitiesController < ApplicationController

  require 'nokogiri'

	def show
    john = Nokogiri::XML(File.read("training.xml"))

    @test = john.xpath("//TotalTimeSeconds")
    @test1 = john.xpath("//Name")
    @test2 = john.xpath("//DistanceMeters")

   
  end

  def new
  	@activity = Activity.new
  end

  def create
  	@activity = Activity.new(params[:activity])
    if @activity.save
      flash[:success] = "Activity Added!" # uses a key called success because there is a class by the same name defined in the Bootstrap CSS (which makes it appear in green)
      redirect_to @activity
    else
      render 'new'
    end
  end
end
