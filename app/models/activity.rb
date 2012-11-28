class Activity < ActiveRecord::Base
  attr_accessible :name, :upload, :activity_type
  belongs_to :user

  validates :name, presence: true
  validates :user_id, presence: true
  has_attached_file :upload # not sure about this
  # specifying the sort order of the activities in descending order, from newest to oldest
  default_scope order: 'activities.created_at DESC'
end
