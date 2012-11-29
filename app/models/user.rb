# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password
  has_many :activities, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed # specifies the followed column in the relationships table as the source of the followed_users array
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  # callback methods
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
  			format: {with: VALID_EMAIL_REGEX}, 
  			uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 } # don't need to explicitly validate presence of password as this is done auotmatically by has_secure_password
  validates :password_confirmation, presence: true


def feed
    # This is preliminary. See "Following users" for the full implementation.
    Activity.where("user_id = ?", id)
  end

   def following?(other_user)
    relationships.find_by_followed_id(other_user.id) # takes in a user, called other_user, and checks to see if a followed user with that id exists in the database
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id) # the follow! method calls create! through the relationships association to create the following relationship
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  private
      # use the urlsafe_base64 method from the SecureRandom Ruby library module  to create the token
      def create_remember_token
        self.remember_token = SecureRandom.urlsafe_base64
      end
end
