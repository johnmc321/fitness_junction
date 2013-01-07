class Course < ActiveRecord::Base
  attr_accessible :activity_id, :latitude, :longitude, :gmaps
  acts_as_gmappable :process_geocoding => false
  belongs_to :activity
  has_many :trackpoints, dependent: :destroy

  def gmaps4rails_address
  "#{latitude}, #{longitude}"
end 


# test to see if start & finish markers could be customised in appearance, taken from https://github.com/apneadiving/Google-Maps-for-Rails/wiki/Markers
# not working as of 07/01/13
	def gmaps4rails_marker_picture
  {
    "rich_marker" =>  "<div class='my-marker'>It works!<img height='30' width='30' src='http://farm4.static.flickr.com/3212/3012579547_097e27ced9_m.jpg'/></div>"
  }
end
end
