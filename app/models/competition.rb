class Competition < ActiveRecord::Base
  validates :name, presence: true

  validates :start_at, presence: true, if: :end_at
  validates :end_at, presence: true, if: :start_at

  has_many :tasks
  has_many :submissions, through: :tasks
  has_many :participating_users, through: :submissions, source: :user

  # Returns a range for which this contest is running.
  def open?(time = Time.now)
    !end_at || ongoing?(time)
  end
  alias_method :ongoing?, :open?

  def ongoing?(time = Time.now)
    (start_at..end_at).cover?(time)
  end

  # Returns whether this competition is always open, which it is if end_at or
  # start_at is not set.
  def always_open?
    !end_at
  end

  def leaderboard
    submissions.passed.group_by { |submission|
      submission.user
    }.sort_by { |user, submissions|
      [submissions.uniq(&:task_id).count, submissions.average(&:created_at)]
    }.reverse
     .map { |user, _|
      user
    }
  end

  # Returns true if a user has submitted to a contest.
  def participating?(user)
    submissions.where(user_id: user.id).any?
  end
end
