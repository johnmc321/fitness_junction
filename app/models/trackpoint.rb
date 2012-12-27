class Trackpoint < ActiveRecord::Base
  attr_accessible :gmaps, :latitude, :longitude, :course_id
  acts_as_gmappable :process_geocoding => false
  belongs_to :course

  def gmaps4rails_address
  "#{latitude}, #{longitude}"
end  
end
