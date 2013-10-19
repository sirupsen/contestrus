class Competition < ActiveRecord::Base
  validates :name, presence: true

  validates :start_at, presence: true, if: :end_at
  validates :end_at, presence: true, if: :start_at

  has_many :tasks

  # Returns a range for which this contest is running.
  def open?(time = Time.now)
    !end_at || (start_at..end_at).cover?(time)
  end

  # Returns whether this competition is always open, which it is if end_at or
  # start_at is not set.
  def always_open?
    !end_at
  end
end
