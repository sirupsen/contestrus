class Task < ActiveRecord::Base
  belongs_to :competition
  has_many :groups, class_name: TestGroup
  has_many :test_cases
  has_many :submissions

  serialize :restrictions, Hash

  def self.solved
    joins(:submissions).where(:submissions => { status: ["Passed", "Partial"] })
  end

  def passed?(user)
    user.submissions.where(task_id: self.id, status: ["Passed", "Partial"]).any?
  end

  def points
    groups.sum(:points)
  end

  # Returns the number of distinct users who've solved a certain task.
  def times_solved
    User.all.inject(0) { |sum, user| sum + (self.passed?(user) ? 1 : 0) }
  end
end
