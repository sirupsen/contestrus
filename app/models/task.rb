class Task < ActiveRecord::Base
  belongs_to :competition
  has_many :test_cases

  serialize :restrictions, Hash

  def passed?(user)
    user.submissions.where(task_id: self.id).any? { |s|
      s.passed?
    }
  end
end
