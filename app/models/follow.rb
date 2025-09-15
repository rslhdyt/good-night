class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  has_many :sleeps, through: :followed

  validates :follower_id, presence: true
  validates :followed_id, presence: true
  validates :followed_id, uniqueness: { scope: :follower_id }  
  validate :cannot_follow_self

  private

  def cannot_follow_self
    if follower_id == followed_id
      errors.add(:followed_id, "is the same as follower_id")
    end
  end
end
