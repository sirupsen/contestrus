class Competition < ActiveRecord::Base
  validates :name, presence: true

  validates :start_at, presence: true, if: :end_at
  validates :end_at, presence: true, if: :start_at

  has_many :tasks

  # Returns a range for which this contest is running.
  def open?(time = Time.now)
    !end_at || (start_at..end_at).cover?(time)
  end
end
