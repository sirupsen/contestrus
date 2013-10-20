class Task < ActiveRecord::Base
  belongs_to :competition
  has_many :test_cases
  has_many :submissions

  serialize :restrictions, Hash

  def self.solved
    joins(:submissions)
  end

  def passed?(user)
    user.submissions.where(task_id: self.id, passed: true).any?
  end

  # Returns the number of distinct users who've solved a certain task.
  def times_solved
    User.all.inject(0) { |sum, user| sum + (self.passed?(user) ? 1 : 0) }
  end
end
