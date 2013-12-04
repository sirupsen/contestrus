require "comedy"

class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  belongs_to :competition

  validates :source, presence: true
  validates :path, presence: true, if: :source
  validates :language, presence: true, if: :source

  serialize :body

  scope :passed, -> { where(:passed => true) }
  scope :for_task, ->(task) { where(task: task) }
  scope :during_competition, -> { where("submissions.competition_id IS NOT NULL") }

  before_validation :set_language
  def set_language
    self.language ||= Language.find_by_extension(extension).try(:key)
  end

  after_create :queue_evaluation, on: :create
  def queue_evaluation
    Comedy << EvaluationJob.new(self.id)
  end

  before_create :set_competition, on: :create
  def set_competition
    self.competition = task.competition if task.competition.open?
  end

  # Returns the amount of points for an IOI-style task submission.
  def points
    raise "Not an IOI style task." unless task.scoring == "ioi"
    total  = body.count.to_f
    raise "Task has no tests." unless total > 0

    passed = body.count { |test| test[:status] == "Correct" }
    ((passed / total) * 100).round
  end

  private
  def extension
    path.split(".").last if path
  end
end
