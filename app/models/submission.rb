require "comedy"

class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  validates :source, presence: true
  validates :path, presence: true

  validates :language, presence: true

  serialize :body

  scope :passed, -> { where(:passed => true) }

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
    self.language ||= Language.find_by_extension(extension).try(:key)
  end

  after_create :queue_evaluation, on: :create
  def queue_evaluation
    Comedy << EvaluationJob.new(self.id)
  end

  private
  def extension
    path.split(".").last if path
  end
end
