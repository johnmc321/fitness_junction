class Upload < ActiveRecord::Base
  attr_accessible :name
  has_attached_file :name, :url => "public/uploads/:basename.:extension"
  validates_attachment_presence :name 
end
