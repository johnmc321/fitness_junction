class Course < ActiveRecord::Base
  attr_accessible :activity_id
  belongs_to :activity
  has_many :trackpoints, dependent: :destroy
end
