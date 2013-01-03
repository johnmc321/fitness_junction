class Course < ActiveRecord::Base
  attr_accessible :activity_id, :latitude, :longitude, :gmaps
  acts_as_gmappable :process_geocoding => false
  belongs_to :activity
  has_many :trackpoints, dependent: :destroy

  def gmaps4rails_address
  "#{latitude}, #{longitude}"
end 
end
