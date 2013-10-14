class Submission < ActiveRecord::Base
  Extensions = {
    "rb" => "ruby",
    "go" => "go"
  }

  belongs_to :user
  belongs_to :task

  has_many :evaluations

  attr_accessor :path

  validates :source, presence: true
  validates :path, presence: true

  validate :path_file_extension
  def path_file_extension
    unless language_from_path
      errors.add :path, "unknown file extension, valid languages are #{Extensions.values.inspect}"
    end
  end

  before_create :set_language
  def set_language
    self.lang = language_from_path
  end

  after_create :queue_evaluation
  def queue_evaluation
    EvaluationJob.new(self.id).delay.perform
  end

  # Every evaluation has to pass because programs must be deterministic and not
  # rely on randomness to do better or worse.
  def passed?
    evaluations.any? && evaluations.all?(&:passed?)
  end

  private
  def language_from_path
    @path && Extensions[@path.split(".").last]
  end
end
