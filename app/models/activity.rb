class Activity < ActiveRecord::Base
  attr_accessible :name, :upload, :activity_type, :location, :duration, :distance, :date
  belongs_to :user

  validates :name, :activity_type, :location, :duration, :distance, :date, presence: true
  validates :user_id, presence: true
  has_attached_file :upload # not sure about this
  # specifying the sort order of the activities in descending order, from newest to oldest
  default_scope order: 'activities.created_at DESC'

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
end
