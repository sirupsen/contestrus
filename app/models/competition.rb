class Competition < ActiveRecord::Base
  validates :name, presence: true

  validates :start_at, presence: true, if: :end_at
  validates :end_at, presence: true, if: :start_at

  has_many :tasks
  has_many :submissions
  has_many :participating_users, through: :submissions, source: :user

  def leaderboard
    submissions.reverse.group_by { |submission|
      submission.user
    }.sort_by { |user, submissions|
      if submissions.first.task.scoring == "ioi"
        submissions = submissions
          .group_by(&:task_id)
          .map { |task_id, submissions|
            submissions.max { |e| e.points }
          }.flatten
        [
          submissions.reduce(0) { |sum, e| e.points},
          -submissions.inject(0) { |sum, sub| sum + sub.created_at.to_i }
        ]
      else
        submissions = submissions
          .select(&:passed)
          .uniq(&:task_id)
        [
          submissions.count, 
          -submissions.inject(0) { |sum, sub| sum + sub.created_at.to_i }
        ]
      end
    }.reverse.map { |user, _|
      user
    }
  end

  def visible?(time = Time.now)
    ongoing?(time) || always_open? || expired?(time)
  end

  def expired?(time = Time.now)
    always_open? || time > end_at
  end

  def ongoing?(time = Time.now)
    (start_at..end_at).cover?(time)
  end

  def open?(time = Time.now)
    ongoing?(time) || always_open?
  end

  def always_open?
    !end_at
  end
end
