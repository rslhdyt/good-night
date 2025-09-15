class User < ApplicationRecord
  has_many :followings, class_name: "Follow", foreign_key: :follower_id
  has_many :followers, class_name: "Follow", foreign_key: :followed_id
  
  has_many :following_users, through: :followings, source: :followed
  has_many :follower_users, through: :followers, source: :follower

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { minimum: 3, maximum: 255 }
end
