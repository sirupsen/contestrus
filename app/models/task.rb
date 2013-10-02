class Task < ActiveRecord::Base
  belongs_to :competition
  has_many :test_cases
  has_many :submissions

  serialize :restrictions, Hash

  def passed?(user)
    user.submissions.where(task_id: self.id).any? { |s|
      s.passed?
    }
  end
end
