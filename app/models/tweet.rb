class Tweet < ActiveRecord::Base
  attr_accessible :tweet_text

  belongs_to :user

  validates :tweet_text, presence: true, length: {maximum: 140}
  validates :user_id, presence: true

  default_scope order: 'tweets.created_at DESC'

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end
