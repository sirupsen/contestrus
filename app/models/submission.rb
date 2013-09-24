class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  has_many :evaluations

  validates :source, presence: true

  after_create :queue_evaluation
  def queue_evaluation
    BackgroundJob << EvaluationJob.new(self.id)
  end

  # Every evaluation has to pass because programs must be deterministic and not
  # rely on randomness to do better or worse.
  def passed?
    evaluations.all?(&:passed?)
  end
end
