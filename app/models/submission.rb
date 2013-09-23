class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  has_many :evaluations

  validates :source, presence: true

  after_create :queue_evaluation

  def queue_evaluation
    BackgroundJob << EvaluationJob.new(self.id)
  end
end
