class Activity < ActiveRecord::Base
  attr_accessible :name, :upload, :type
  has_attached_file :upload # not sure about this
end
