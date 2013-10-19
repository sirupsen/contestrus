class Task < ActiveRecord::Base
  belongs_to :competition
  has_many :test_cases
  has_many :submissions

  serialize :restrictions, Hash

  def passed?(user)
    user.submissions.where(task_id: self.id).any? { |s| s.passed? } 
  end

  # Returns the number of distinct users who've solved a certain task.
  def times_solved
    User.all.inject(0) { |sum, user| sum + (self.passed?(user) ? 1 : 0) }
  end
end
