class User < ApplicationRecord
  # will add later after the model is created
  # has_many :sleeps
  # has_many :follows
  # has_many :followed_users, through: :follows, source: :followed
  # has_many :followers, through: :follows, source: :follower

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { minimum: 3, maximum: 255 }
end
