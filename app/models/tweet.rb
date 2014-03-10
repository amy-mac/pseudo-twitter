class Tweet < ActiveRecord::Base
  attr_accessible :tweet_text

  belongs_to :user

  validates :tweet_text, presence: true, length: {maximum: 140}
  validates :user_id, presence: true
end
