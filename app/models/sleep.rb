class Sleep < ApplicationRecord
  belongs_to :user

  validates :sleep_start, presence: true
  validates :sleep_end, presence: true, on: :update
  validates :duration, presence: true, on: :update

  scope :has_active_session, -> { where(sleep_end: nil) }
  scope :previous_week, -> do 
    # oh my, this is why I love ruby
    where(created_at: 1.week.ago..Time.now)
  end

  scope :sorted_by_duration, -> (sort_by = :desc) { order(duration: sort_by) }

  def duration_in_minutes
    duration * 60
  end
end
