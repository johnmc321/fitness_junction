class Trackpoint < ActiveRecord::Base
  attr_accessible :gmaps, :latitude, :longitude
  acts_as_gmappable :process_geocoding => false

  def gmaps4rails_address
  "#{latitude}, #{longitude}"
end  
end
