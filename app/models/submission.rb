require "comedy_worker"

class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  belongs_to :language

  has_many :evaluations

  validates :source, presence: true
  validates :path, presence: true

  validates :language, presence: true

  # Validates that the submission was performed within the duration of the
  # contest.
  validate :contest_expirement
  def contest_expirement
    unless task.competition.open?
      errors.add :base, "Competition is no longer open"
    end
  end

  before_validation :set_language
  def set_language
    self.language ||= language_from_path
  end

  after_create :queue_evaluation, on: :create
  def queue_evaluation
    ComedyWorker.perform EvaluationJob.new(self.id)
  end

  # Every evaluation has to pass because programs must be deterministic and not
  # rely on randomness to do better or worse.
  def passed?
    evaluations.any? && evaluations.all?(&:passed?)
  end

  private
  def language_from_path
    Language.find_by_extension(extension)
  end

  def extension
    path.split(".").last if path
  end
end
